#!/bin/sh
# ctrl+hjkl dispatcher for herdr: forward the chord into vim/nvim when the
# focused pane is running one, otherwise move herdr's pane focus.
# usage: herdr-nav.sh <left|down|up|right> <ctrl+h|ctrl+j|ctrl+k|ctrl+l>

dir=$1
key=$2
herdr=${HERDR_BIN_PATH:-herdr}
pane=$HERDR_ACTIVE_PANE_ID

[ -n "$dir" ] && [ -n "$key" ] || exit 1

if [ -z "$pane" ]; then
  pane=$("$herdr" pane current 2>/dev/null | jq -r '.result.pane.pane_id // empty')
fi

if [ -z "$pane" ]; then
  "$herdr" pane focus --current --direction "$dir" >/dev/null 2>&1
  exit 0
fi

if "$herdr" pane process-info --pane "$pane" 2>/dev/null \
  | jq -e '[.result.process_info.foreground_processes[] | .name, .argv0]
           | any(test("^(.*/)?g?\\.?(view|n?vim?x?)(-wrapped)?(diff)?$"))' >/dev/null 2>&1
then
  "$herdr" pane send-keys "$pane" "$key" >/dev/null 2>&1
else
  "$herdr" pane focus --pane "$pane" --direction "$dir" >/dev/null 2>&1
fi
