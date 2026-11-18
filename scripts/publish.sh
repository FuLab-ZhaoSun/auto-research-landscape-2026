#!/usr/bin/env bash
# 把本调研仓库发布到 GitHub（macOS / Linux 版，行为对齐 scripts/publish.ps1）
#
# 用法:
#   ./scripts/publish.sh [--repo-name NAME] [--owner OWNER] [--private] [--branch BRANCH]
#
# 凭证（按优先级）:
#   1. 环境变量 GITHUB_TOKEN
#   2. 环境变量 GH_TOKEN
#   3. `gh auth token`（需先执行 gh auth login）
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

REPO_NAME="auto-research-landscape-2026"
OWNER=""
PRIVATE="false"
BRANCH="main"
DESCRIPTION="Landscape survey of automated research, AI scientist, and automated paper writing projects."

usage() {
  cat <<'EOF'
把本调研仓库发布到 GitHub。

用法: publish.sh [选项]

选项:
  --repo-name <name>   目标仓库名（默认: auto-research-landscape-2026）
  --owner <owner>      目标账号或组织（默认: 当前凭证对应的账号）
  --private            创建为私有仓库
  --branch <branch>    要推送的分支（默认: main）
  -h, --help           显示本帮助

凭证:
  GITHUB_TOKEN / GH_TOKEN，或事先执行 `gh auth login`。
  需要的权限: 创建仓库 + 推送代码（classic token 的 repo scope）。

示例:
  export GITHUB_TOKEN=<token with repo permission>
  ./scripts/publish.sh
  ./scripts/publish.sh --owner my-org --repo-name auto-research-landscape-2026
EOF
}

die() {
  echo "错误: $*" >&2
  exit 1
}

while [ $# -gt 0 ]; do
  case "$1" in
    --repo-name) [ $# -ge 2 ] || die "--repo-name 需要参数"; REPO_NAME="$2"; shift 2 ;;
    --owner)     [ $# -ge 2 ] || die "--owner 需要参数";     OWNER="$2";     shift 2 ;;
    --private)   PRIVATE="true"; shift ;;
    --branch)    [ $# -ge 2 ] || die "--branch 需要参数";    BRANCH="$2";    shift 2 ;;
    -h|--help)   usage; exit 0 ;;
    *)           echo "未知参数: $1" >&2; usage >&2; exit 2 ;;
  esac
done

command -v curl >/dev/null 2>&1 || die "需要 curl"
command -v git  >/dev/null 2>&1 || die "需要 git"
command -v python3 >/dev/null 2>&1 || die "需要 python3（用于解析 GitHub API 响应；macOS 可用 xcode-select --install 安装）"

validate_slug() {
  case "$1" in
    ''|*[!A-Za-z0-9._-]*) die "非法名称 '$1'（只允许字母、数字、点、下划线、连字符）" ;;
  esac
}

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
      -H "User-Agent: auto-research-landscape-publish" \
      -H "Content-Type: application/json" \
      --data "$body" \
      "https://api.github.com$path")"
  else
    code="$(curl -sS -o "$tmp" -w '%{http_code}' -X "$method" \
      -H "Authorization: Bearer $TOKEN" \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      -H "User-Agent: auto-research-landscape-publish" \
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

git rev-parse --git-dir >/dev/null 2>&1 || die "当前目录不是 git 仓库: $REPO_ROOT"

TOKEN="$(resolve_token)"

api_request GET /user
[ "$API_CODE" = "200" ] || die "读取账号信息失败 (HTTP $API_CODE): $(printf '%s' "$API_BODY" | json_field message)"
ME="$(printf '%s' "$API_BODY" | json_field login)"
[ -n "$ME" ] || die "无法确定当前账号"

if [ -z "$OWNER" ]; then
  OWNER="$ME"
fi
validate_slug "$OWNER"
validate_slug "$REPO_NAME"

if [ "$OWNER" = "$ME" ]; then
  CREATE_PATH="/user/repos"
else
  CREATE_PATH="/orgs/$OWNER/repos"
fi

BODY="$(python3 -c '
import json, sys
print(json.dumps({
    "name": sys.argv[1],
    "description": sys.argv[2],
    "private": sys.argv[3] == "true",
    "auto_init": False,
}))
' "$REPO_NAME" "$DESCRIPTION" "$PRIVATE")"

api_request POST "$CREATE_PATH" "$BODY"
case "$API_CODE" in
  201) echo "已创建 GitHub 仓库: $OWNER/$REPO_NAME" ;;
  422) echo "仓库可能已存在，继续: $OWNER/$REPO_NAME" ;;
  *)   die "创建仓库失败 (HTTP $API_CODE): $(printf '%s' "$API_BODY" | json_field message)" ;;
esac

CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
[ "$CURRENT_BRANCH" = "$BRANCH" ] || die "当前分支是 '$CURRENT_BRANCH'，与 --branch '$BRANCH' 不一致；请切换分支或传 --branch '$CURRENT_BRANCH'"

REMOTE_URL="https://github.com/$OWNER/$REPO_NAME.git"
if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE_URL"
else
  git remote add origin "$REMOTE_URL"
fi

BASIC="$(printf 'x-access-token:%s' "$TOKEN" | base64 | tr -d '\n')"
echo "推送到 $REMOTE_URL（分支 $BRANCH）..."
git -c "http.https://github.com/.extraheader=AUTHORIZATION: basic $BASIC" push -u origin "$BRANCH"

echo "已发布: https://github.com/$OWNER/$REPO_NAME"
