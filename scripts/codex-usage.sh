#!/bin/bash
# Display Codex CLI remaining rate limits (5h + weekly) for the herdr tab bar.
# Reads the latest rate_limits event Codex writes into its session logs.

CHARS=(▏ ▎ ▍ ▌ ▋ ▊ ▉)

draw_bar() {
    local percent=$1
    local result=""
    for i in 1 2 3 4 5; do
        local seg_start=$(( (i-1) * 20 ))
        local seg_end=$(( i * 20 ))
        if (( percent >= seg_end )); then
            result+="█"
        elif (( percent > seg_start )); then
            result+="${CHARS[$(( (percent - seg_start) * 7 / 20 ))]}"
        else
            result+="░"
        fi
    done
    echo "$result"
}

latest=$(find "$HOME/.codex/sessions" -name '*.jsonl' -mtime -7 -print0 2>/dev/null | xargs -0 ls -t 2>/dev/null | head -1)

if [[ -n "$latest" ]]; then
    read -r used_5h used_7d < <(grep '"rate_limits"' "$latest" | tail -1 | jq -r '
        (.payload.rate_limits // .payload.info.rate_limits) as $r
        | [$r.primary, $r.secondary]
        | map(if . == null or .resets_at < now then 0 else .used_percent end | floor)
        | @tsv' 2>/dev/null)
fi

segment() {
    local remaining=$((100 - ${2:-0}))
    (( remaining < 0 )) && remaining=0
    echo "$1$(draw_bar $remaining) ${remaining}%"
}

echo "$(segment "Codex 5h" "$used_5h") $(segment 7d "$used_7d")"
