#!/usr/bin/env bash
# 把调研里出现的 GitHub 项目 fork 到指定账号或组织（macOS / Linux 版，行为对齐 scripts/fork-projects.ps1）
#
# 用法:
#   ./scripts/fork-projects.sh [--owner OWNER] [--projects-file PATH] [--fork-list-file PATH] [--delay-seconds N]
#
# 凭证（按优先级）: GITHUB_TOKEN → GH_TOKEN → `gh auth token`
# 输出: data/fork-results.json（无 BOM 的 UTF-8，2 空格缩进）
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

OWNER=""
PROJECTS_FILE="data/projects.json"
FORK_LIST_FILE="data/forkable-repos.txt"
DELAY_SECONDS="2"
OUT_FILE="data/fork-results.json"

usage() {
  cat <<'EOF'
把调研中出现的 GitHub 仓库 fork 到指定账号或组织。

用法: fork-projects.sh [选项]

选项:
  --owner <owner>          目标账号或组织（默认: 当前凭证对应的账号）
  --projects-file <path>   项目数据文件（默认: data/projects.json）
  --fork-list-file <path>  额外 fork 清单（默认: data/forkable-repos.txt）
  --delay-seconds <n>      每次 fork 之间的间隔秒数（默认: 2）
  -h, --help               显示本帮助

说明:
  - 上游列表 = projects.json 中所有 repo_url + forkable-repos.txt 中的仓库链接，去重排序。
  - 结果写入 data/fork-results.json：status 为 requested / exists_or_unprocessable / failed。
  - 该脚本只记录"是否成功发起 fork"，不会等待 fork 完成；稍后用 GitHub API 可核对实际结果。

凭证:
  GITHUB_TOKEN / GH_TOKEN，或事先执行 `gh auth login`。
EOF
}

die() {
  echo "错误: $*" >&2
  exit 1
}

while [ $# -gt 0 ]; do
  case "$1" in
    --owner)           [ $# -ge 2 ] || die "--owner 需要参数";           OWNER="$2";           shift 2 ;;
    --projects-file)   [ $# -ge 2 ] || die "--projects-file 需要参数";   PROJECTS_FILE="$2";   shift 2 ;;
    --fork-list-file)  [ $# -ge 2 ] || die "--fork-list-file 需要参数";  FORK_LIST_FILE="$2";  shift 2 ;;
    --delay-seconds)   [ $# -ge 2 ] || die "--delay-seconds 需要参数";   DELAY_SECONDS="$2";   shift 2 ;;
    -h|--help)         usage; exit 0 ;;
    *)                 echo "未知参数: $1" >&2; usage >&2; exit 2 ;;
  esac
done

case "$DELAY_SECONDS" in
  ''|*[!0-9]*) die "--delay-seconds 需要非负整数" ;;
esac

command -v curl >/dev/null 2>&1 || die "需要 curl"
command -v python3 >/dev/null 2>&1 || die "需要 python3（用于解析 GitHub API 响应与生成 JSON；macOS 可用 xcode-select --install 安装）"

resolve_token() {
  local token="${GITHUB_TOKEN:-${GH_TOKEN:-}}"
  if [ -z "$token" ] && command -v gh >/dev/null 2>&1; then
    token="$(gh auth token 2>/dev/null || true)"
  fi
  [ -n "$token" ] || die "未找到 GitHub 凭证：请设置 GITHUB_TOKEN / GH_TOKEN，或先执行 gh auth login"
  printf '%s' "$token"
}

API_CODE=""
API_BODY=""
api_request() {
  local method="$1" path="$2" body="${3:-}"
  local tmp code
  tmp="$(mktemp "${TMPDIR:-/tmp}/dsh-gh-api.XXXXXX")"
  if [ -n "$body" ]; then
    code="$(curl -sS -o "$tmp" -w '%{http_code}' -X "$method" \
      -H "Authorization: Bearer $TOKEN" \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      -H "User-Agent: auto-research-landscape-forker" \
      -H "Content-Type: application/json" \
      --data "$body" \
      "https://api.github.com$path")"
  else
    code="$(curl -sS -o "$tmp" -w '%{http_code}' -X "$method" \
      -H "Authorization: Bearer $TOKEN" \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      -H "User-Agent: auto-research-landscape-forker" \
      "https://api.github.com$path")"
  fi
  API_CODE="$code"
  API_BODY="$(cat "$tmp")"
  rm -f "$tmp"
}

json_field() {
  python3 -c '
import json, sys
try:
    data = json.loads(sys.stdin.read())
except Exception:
    print("")
    sys.exit(0)
value = data.get(sys.argv[1]) if isinstance(data, dict) else None
print("" if value is None else value)
' "$1"
}

TOKEN="$(resolve_token)"

api_request GET /user
[ "$API_CODE" = "200" ] || die "读取账号信息失败 (HTTP $API_CODE): $(printf '%s' "$API_BODY" | json_field message)"
ME="$(printf '%s' "$API_BODY" | json_field login)"
[ -n "$ME" ] || die "无法确定当前账号"

if [ -z "$OWNER" ]; then
  OWNER="$ME"
fi

TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/dsh-fork.XXXXXX")"
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

URLS_FILE="$TMP_DIR/urls.txt"
SLUGS_FILE="$TMP_DIR/slugs.txt"
JSONL_FILE="$TMP_DIR/results.jsonl"
: > "$URLS_FILE"
: > "$JSONL_FILE"

if [ -f "$PROJECTS_FILE" ]; then
  python3 - "$PROJECTS_FILE" >> "$URLS_FILE" <<'PY'
import json, sys
try:
    data = json.load(open(sys.argv[1], encoding="utf-8-sig"))
except Exception as exc:
    sys.stderr.write(f"警告: 无法解析 {sys.argv[1]}: {exc}\n")
    sys.exit(0)
for project in data:
    url = project.get("repo_url") or ""
    if url:
        print(url)
PY
else
  echo "提示: 未找到 $PROJECTS_FILE，跳过" >&2
fi

if [ -f "$FORK_LIST_FILE" ]; then
  grep -E '^https://github\.com/[^/]+/[^/]+/?$' "$FORK_LIST_FILE" >> "$URLS_FILE" || true
else
  echo "提示: 未找到 $FORK_LIST_FILE，跳过" >&2
fi

# 只保留 owner/repo 形式的 slug，去掉结尾斜杠，去重排序
sed -E 's#/+$##; s#^https://github\.com/##' "$URLS_FILE" \
  | grep -E '^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$' \
  | sort -u > "$SLUGS_FILE" || true

TOTAL="$(wc -l < "$SLUGS_FILE" | tr -d ' ')"
[ "$TOTAL" -gt 0 ] || die "没有可 fork 的仓库（检查 $PROJECTS_FILE / $FORK_LIST_FILE）"
echo "共 $TOTAL 个上游仓库，目标: $OWNER"

append_result() {
  python3 - "$1" "$2" "$3" "$4" >> "$JSONL_FILE" <<'PY'
import json, sys
print(json.dumps({
    "upstream": sys.argv[1],
    "status": sys.argv[2],
    "fork_url": sys.argv[3],
    "message": sys.argv[4],
}))
PY
}

if [ "$OWNER" = "$ME" ]; then
  FORK_BODY='{}'
else
  FORK_BODY="$(python3 -c 'import json, sys; print(json.dumps({"organization": sys.argv[1]}))' "$OWNER")"
fi

INDEX=0
while IFS= read -r upstream; do
  [ -n "$upstream" ] || continue
  INDEX=$((INDEX + 1))
  repo_name="${upstream#*/}"
  fallback_url="https://github.com/$OWNER/$repo_name"
  echo "[$INDEX/$TOTAL] fork $upstream -> $OWNER ..."

  api_request POST "/repos/$upstream/forks" "$FORK_BODY"

  case "$API_CODE" in
    202|200)
      fork_url="$(printf '%s' "$API_BODY" | json_field html_url)"
      [ -n "$fork_url" ] || fork_url="$fallback_url"
      append_result "$upstream" "requested" "$fork_url" ""
      ;;
    422)
      append_result "$upstream" "exists_or_unprocessable" "$fallback_url" "$(printf '%s' "$API_BODY" | json_field message)"
      ;;
    *)
      append_result "$upstream" "failed" "$fallback_url" "HTTP $API_CODE: $(printf '%s' "$API_BODY" | json_field message)"
      ;;
  esac

  if [ "$INDEX" -lt "$TOTAL" ] && [ "$DELAY_SECONDS" -gt 0 ]; then
    sleep "$DELAY_SECONDS"
  fi
done < "$SLUGS_FILE"

mkdir -p "$(dirname "$OUT_FILE")"
python3 - "$JSONL_FILE" "$OUT_FILE" <<'PY'
import json, sys
rows = []
with open(sys.argv[1], encoding="utf-8") as handle:
    for line in handle:
        line = line.strip()
        if line:
            rows.append(json.loads(line))
with open(sys.argv[2], "w", encoding="utf-8", newline="\n") as handle:
    json.dump(rows, handle, ensure_ascii=False, indent=2)
    handle.write("\n")
print(f"结果已写入 {sys.argv[2]}（{len(rows)} 条）")
PY
