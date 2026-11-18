#!/bin/bash
# Claude Code statusline script
# Displays caveman/ponytail badges and rate-limit usage, and writes usage to a cache for the herdr tab bar

input=$(cat)

# Write to cache for herdr (async, non-blocking)
{
  mkdir -p ~/.cache/ai-usage
  echo "$input" | jq -c '{
    provider: "claude",
    model: .model.display_name,
    context_pct: (.context_window.used_percentage // 0),
    context_size: (.context_window.context_window_size // 0),
    cost_usd: (.cost.total_cost_usd // 0),
    duration_ms: (.cost.total_duration_ms // 0),
    rate_5h_pct: (.rate_limits.five_hour.used_percentage // -1),
    rate_7d_pct: (.rate_limits.seven_day.used_percentage // -1),
    updated_at: now | floor
  }' > ~/.cache/ai-usage/claude.json 2>/dev/null
} &

# Caveman mode badge (per-session mode file, fallback to global flag)
session_id=$(echo "$input" | jq -r '.session_id // ""')
caveman_flag="$HOME/.claude/.caveman-active"
if [[ "$session_id" =~ ^[A-Za-z0-9_-]{1,128}$ && -f "$HOME/.claude/.caveman-sessions/$session_id.mode" ]]; then
  caveman_flag="$HOME/.claude/.caveman-sessions/$session_id.mode"
fi
if [[ -f "$caveman_flag" && ! -L "$caveman_flag" ]]; then
  caveman_mode=$(head -c 64 "$caveman_flag" | tr -cd 'a-z0-9-')
  case "$caveman_mode" in
    full) printf '\033[38;5;172m[CAVEMAN]\033[0m' ;;
    lite|ultra|wenyan-lite|wenyan|wenyan-full|wenyan-ultra|commit|review|compress)
      printf '\033[38;5;172m[CAVEMAN:%s]\033[0m' "$(echo "$caveman_mode" | tr '[:lower:]' '[:upper:]')" ;;
  esac
fi

# Ponytail mode badge (flag written by ponytail SessionStart/UserPromptSubmit hooks)
ponytail_flag="$HOME/.claude/.ponytail-active"
if [[ -f "$ponytail_flag" && ! -L "$ponytail_flag" ]]; then
  ponytail_mode=$(head -n1 "$ponytail_flag" | tr -cd 'a-z')
  [[ -f "$caveman_flag" ]] && printf ' '
  case "$ponytail_mode" in
    ""|full) printf '\033[38;5;108m[PONYTAIL]\033[0m' ;;
    ultra) printf '\033[38;5;173m[PONYTAIL:ULTRA]\033[0m' ;;
    *) printf '\033[38;5;108m[PONYTAIL:%s]\033[0m' "$(echo "$ponytail_mode" | tr '[:lower:]' '[:upper:]')" ;;
  esac
fi

# Rate-limit usage, shown as remaining percent (matches scripts/claude-usage.sh).
# rate_limits is absent on API billing and a window may be missing, so print only what exists.
usage=$(echo "$input" | jq -r '[
  (.rate_limits.five_hour.used_percentage // empty | "5h \(100 - floor)%"),
  (.rate_limits.seven_day.used_percentage // empty | "7d \(100 - floor)%")
] | join(" · ")')
[[ -n "$usage" ]] && printf ' \033[2m%s left\033[0m' "$usage"
