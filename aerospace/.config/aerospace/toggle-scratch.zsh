#!/usr/bin/env zsh
set -u

mkdir -p "$HOME/.config/aerospace"
exec >>"$HOME/.config/aerospace/scratch.log" 2>&1
print -r -- "---- $(date) ----"

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

AERO="$(command -v aerospace 2>/dev/null)"
[[ -z "${AERO}" ]] && AERO="/opt/homebrew/bin/aerospace"

SCRATCH_TITLE="scratch"
PARK_WS="scratchpad"
ALACRITTY_BUNDLE="org.alacritty"

CUR_WS="$("$AERO" list-workspaces --focused 2>/dev/null | head -n 1 | tr -d '[:space:]')"
print -r -- "CUR_WS=${CUR_WS:-<empty>}"

# Focused window before toggle (id|ws)
PREV_LINE="$("$AERO" list-windows --focused --format '%{window-id}|%{workspace}' 2>/dev/null | head -n 1)"
PREV_WIN_ID="${PREV_LINE%%|*}"
PREV_WIN_WS="${PREV_LINE#*|}"
print -r -- "PREV_WIN_ID=${PREV_WIN_ID:-<empty>} PREV_WIN_WS=${PREV_WIN_WS:-<empty>}"

get_scratches() {
  "$AERO" list-windows --all \
    --format '%{window-id}|%{workspace}|%{window-title}|%{app-bundle-id}' 2>/dev/null \
  | awk -F'|' -v t="$SCRATCH_TITLE" -v b="$ALACRITTY_BUNDLE" '
      $4==b && index(tolower($3), tolower(t)) { print }
    '
}

SCRATCH_LINES="$(get_scratches)"
print -r -- "SCRATCH_LINES:"
print -r -- "${SCRATCH_LINES:-<none>}"

if [[ -z "${CUR_WS}" ]]; then
  print -r -- "ERROR: CUR_WS empty; not toggling."
  exit 0
fi

WIN_ID_CUR="$(print -r -- "$SCRATCH_LINES" | awk -F'|' -v ws="$CUR_WS" '$2==ws {print $1; exit}')"
WIN_ID_PARK="$(print -r -- "$SCRATCH_LINES" | awk -F'|' -v ws="$PARK_WS" '$2==ws {print $1; exit}')"
WIN_ID_ANY="$(print -r -- "$SCRATCH_LINES" | head -n 1 | awk -F'|' '{print $1}')"

print -r -- "WIN_ID_CUR=${WIN_ID_CUR:-<none>} WIN_ID_PARK=${WIN_ID_PARK:-<none>} WIN_ID_ANY=${WIN_ID_ANY:-<none>}"

if [[ -n "$WIN_ID_CUR" ]]; then
  print -r -- "ACTION=hide WIN_ID=$WIN_ID_CUR"
  "$AERO" focus --window-id "$WIN_ID_CUR"
  "$AERO" move-node-to-workspace "$PARK_WS"

  if [[ -n "${PREV_WIN_ID:-}" && "$PREV_WIN_ID" != "$WIN_ID_CUR" && "${PREV_WIN_WS:-}" == "$CUR_WS" ]]; then
    print -r -- "RESTORE_FOCUS window-id=$PREV_WIN_ID"
    "$AERO" focus --window-id "$PREV_WIN_ID" 2>/dev/null || true
  fi
else
  WIN_ID="$WIN_ID_PARK"
  [[ -z "$WIN_ID" ]] && WIN_ID="$WIN_ID_ANY"

  if [[ -z "$WIN_ID" ]]; then
    print -r -- "ACTION=launch"
    open -a "Alacritty" --args --title "$SCRATCH_TITLE"

    for _ in {1..60}; do
      sleep 0.1
      SCRATCH_LINES="$(get_scratches)"
      WIN_ID="$(print -r -- "$SCRATCH_LINES" | head -n 1 | awk -F'|' '{print $1}')"
      [[ -n "$WIN_ID" ]] && break
    done

    [[ -z "$WIN_ID" ]] && { print -r -- "ERROR: scratch never appeared"; exit 0; }
  fi

  print -r -- "ACTION=show WIN_ID=$WIN_ID -> workspace $CUR_WS"
  "$AERO" focus --window-id "$WIN_ID"

  # Only move if needed (avoids noop message)
  WIN_WS="$("$AERO" list-windows --all --format '%{window-id}|%{workspace}' \
    | awk -F'|' -v id="$WIN_ID" '$1==id {print $2; exit}')"

  if [[ "$WIN_WS" != "$CUR_WS" ]]; then
    "$AERO" move-node-to-workspace "$CUR_WS"
  fi

  "$AERO" layout tiling
  "$AERO" focus --window-id "$WIN_ID"

fi

