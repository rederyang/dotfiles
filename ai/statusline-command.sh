#!/usr/bin/env bash
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
dir=$(basename "$cwd")
model=$(echo "$input" | jq -r '.model.display_name // ""')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_hour=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Git branch (skip optional locks to avoid blocking)
branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" -c core.hooksPath=/dev/null symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# Build prompt parts using ANSI colors
# Cyan for directory, blue/red for git, yellow for dirty marker
DIR_COLOR="\033[36m"       # cyan
GIT_LABEL_COLOR="\033[34m" # blue bold
GIT_BRANCH_COLOR="\033[31m"# red
MODEL_COLOR="\033[35m"     # magenta
CTX_COLOR="\033[33m"       # yellow
QUOTA_COLOR="\033[32m"     # green
RESET="\033[0m"

line=""

# Directory
line+=$(printf "${DIR_COLOR}%s${RESET}" "$dir")

# Git info
if [ -n "$branch" ]; then
  dirty=""
  if ! git -C "$cwd" -c core.hooksPath=/dev/null diff --quiet 2>/dev/null || \
     ! git -C "$cwd" -c core.hooksPath=/dev/null diff --cached --quiet 2>/dev/null; then
    dirty=$(printf "\033[33m ✗${RESET}")
  fi
  line+=$(printf "  ${GIT_LABEL_COLOR}git:(${GIT_BRANCH_COLOR}%s${GIT_LABEL_COLOR})${RESET}%s" "$branch" "$dirty")
fi

# Model
if [ -n "$model" ]; then
  line+=$(printf "  ${MODEL_COLOR}%s${RESET}" "$model")
fi

# Context usage
if [ -n "$used" ]; then
  line+=$(printf "  ${CTX_COLOR}ctx:%s%%${RESET}" "$(printf '%.0f' "$used")")
fi

# Rate limit quota (Claude.ai subscription)
quota_parts=""
if [ -n "$five_hour" ]; then
  quota_parts+="5h:$(printf '%.0f' "$five_hour")%"
fi
if [ -n "$seven_day" ]; then
  [ -n "$quota_parts" ] && quota_parts+=" "
  quota_parts+="7d:$(printf '%.0f' "$seven_day")%"
fi
if [ -n "$quota_parts" ]; then
  line+=$(printf "  ${QUOTA_COLOR}quota:%s${RESET}" "$quota_parts")
fi

printf "%b\n" "$line"
