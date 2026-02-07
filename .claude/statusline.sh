#!/bin/zsh
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

FOLDER="${DIR##*/}"

BRANCH=""
if git -C "$DIR" rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git -C "$DIR" branch --show-current 2>/dev/null)
fi

# Progress bar - solid fill, dotted empty
FILLED=$((PCT * 10 / 100))
EMPTY=$((10 - FILLED))
BAR=""
[ "$FILLED" -gt 0 ] && BAR=$(printf "%${FILLED}s" | tr ' ' '█')
[ "$EMPTY" -gt 0 ] && BAR="${BAR}$(printf "%${EMPTY}s" | tr ' ' '·')"

COST_FMT=$(printf '%.2f' "$COST")

MINS=$((DURATION_MS / 60000))
SECS=$(((DURATION_MS % 60000) / 1000))
if [ "$MINS" -gt 0 ]; then
    TIME="${MINS}m ${SECS}s"
else
    TIME="${SECS}s"
fi

# Nerd Font glyphs
ICON_FOLDER=$'\uf07b'   # nf-fa-folder
ICON_BRANCH=$'\ue0a0'   # nf-pl-branch
ICON_CLOCK=$'\uf017'    # nf-fa-clock_o
ICON_DOLLAR=$'\uf155'   # nf-fa-dollar

LINE="[$MODEL] | $ICON_FOLDER $FOLDER"
[ -n "$BRANCH" ] && LINE="$LINE | $ICON_BRANCH $BRANCH"
LINE="$LINE | $BAR ${PCT}% | $ICON_DOLLAR$COST_FMT | $ICON_CLOCK $TIME"

echo "$LINE"
