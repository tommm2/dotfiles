#!/bin/bash
# Display Claude Code usage for a status bar.
# Only shows for subscription plans (with rate limits), not API billing.

CLAUDE_CACHE="$HOME/.cache/ai-usage/claude.json"

# Horizontal partial blocks, no full block among them: a part-filled cell must
# never render as a full one. Indexed, not a substring: ${str:n:1} slices bytes
# under a non-UTF-8 locale, which the herdr tab bar runs under.
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
            local within=$(( (percent - seg_start) * 7 / 20 ))
            result+="${CHARS[$within]}"
        else
            result+="░"
        fi
    done
    echo "$result"
}

# Only show if subscription plan (has rate limits)
if [[ -f "$CLAUDE_CACHE" ]]; then
    now=$(date +%s)
    updated_at=$(jq -r '.updated_at // 0' "$CLAUDE_CACHE" 2>/dev/null)
    age=$((now - updated_at))

    # Cache must be fresh (< 10 min) and have rate limits
    if (( age < 600 )); then
        read -r rate_5h rate_7d < <(jq -r '[.rate_5h_pct, .rate_7d_pct] | map(if type == "number" and . >= 0 then floor else -1 end) | join(" ")' "$CLAUDE_CACHE" 2>/dev/null)

        segment() {
            local label=$1 pct=$2
            local remaining=$((100 - pct))
            (( remaining < 0 )) && remaining=0
            echo "${label}$(draw_bar $remaining) ${remaining}%"
        }

        usage=""
        if [[ -n "$rate_5h" && "$rate_5h" != "-1" ]]; then
            usage=$(segment "5h" "$rate_5h")
        fi
        if [[ -n "$rate_7d" && "$rate_7d" != "-1" ]]; then
            usage="${usage:+$usage · }$(segment "7d" "$rate_7d")"
        fi
        if [[ -n "$usage" ]]; then
            printf 'Claude Code %s\n' "$usage"
            exit 0
        fi
    fi
fi

# API billing - show nothing
echo ""
