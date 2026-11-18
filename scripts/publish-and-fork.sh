#!/usr/bin/env bash
# 一次完成「发布仓库 + fork 调研项目」（macOS / Linux 版，对齐 scripts/publish-and-fork.ps1）
#
# 用法:
#   ./scripts/publish-and-fork.sh [--owner OWNER] [--repo-name NAME] [--private] [--branch BRANCH] [--skip-forks]
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

FORWARD=()
SKIP_FORKS="false"

usage() {
  cat <<'EOF'
先发布本调研仓库，再把调研项目 fork 到同一账号或组织。

用法: publish-and-fork.sh [选项]

选项:
  --repo-name <name>   目标仓库名（默认: auto-research-landscape-2026）
  --owner <owner>      目标账号或组织（默认: 当前凭证对应的账号）
  --private            创建为私有仓库
  --branch <branch>    要推送的分支（默认: main）
  --skip-forks         只发布仓库，不执行 fork
  -h, --help           显示本帮助

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
    --repo-name) [ $# -ge 2 ] || die "--repo-name 需要参数"; FORWARD+=("$1" "$2"); shift 2 ;;
    --owner)     [ $# -ge 2 ] || die "--owner 需要参数";     FORWARD+=("$1" "$2"); shift 2 ;;
    --branch)    [ $# -ge 2 ] || die "--branch 需要参数";    FORWARD+=("$1" "$2"); shift 2 ;;
    --private)   FORWARD+=("$1"); shift ;;
    --skip-forks) SKIP_FORKS="true"; shift ;;
    -h|--help)   usage; exit 0 ;;
    *)           echo "未知参数: $1" >&2; usage >&2; exit 2 ;;
  esac
done

if [ "${#FORWARD[@]}" -gt 0 ]; then
  "$SCRIPT_DIR/publish.sh" "${FORWARD[@]}"
else
  "$SCRIPT_DIR/publish.sh"
fi

if [ "$SKIP_FORKS" = "true" ]; then
  echo "已跳过 fork（--skip-forks）"
  exit 0
fi

# 只把 --owner 透传给 fork 步骤（与 PowerShell 版一致）
FORK_ARGS=()
i=0
while [ "$i" -lt "${#FORWARD[@]}" ]; do
  if [ "${FORWARD[$i]}" = "--owner" ]; then
    FORK_ARGS+=("${FORWARD[$i]}" "${FORWARD[$((i + 1))]}")
    i=$((i + 2))
  else
    i=$((i + 1))
  fi
done

if [ "${#FORK_ARGS[@]}" -gt 0 ]; then
  "$SCRIPT_DIR/fork-projects.sh" "${FORK_ARGS[@]}"
else
  "$SCRIPT_DIR/fork-projects.sh"
fi
