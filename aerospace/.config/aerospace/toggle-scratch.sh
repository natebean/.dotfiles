#!/usr/bin/env bash
set -euo pipefail

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

SCRATCH_TITLE="scratch"
PARK_WS="scratchpad"
ALACRITTY_APP="Alacritty"
ALACRITTY_BUNDLE="org.alacritty"

CUR_WS="$(aerospace list-workspaces --focused | head -n 1)"

# focused window BEFORE toggle (id + workspace)
PREV_LINE="$(
  aerospace list-windows --focused --format '%{window-id}\t%{workspace}\n' 2>/dev/null | head -n 1 || true
)"
PREV_WIN_ID="$(echo "${PREV_LINE}" | cut -f1)"
PREV_WIN_WS="$(echo "${PREV_LINE}" | cut -f2)"

# Collect ALL scratch candidates: id, workspace, title, bundle
mapfile -t SCRATCHES < <(
  aerospace list-windows --all \
    --format '%{window-id}\t%{workspace}\t%{window-title}\t%{app-bundle-id}\n' \
  | awk -F'\t' -v t="$SCRATCH_TITLE" -v b="$ALACRITTY_BUNDLE" '
      $4 == b && index(tolower($3), tolower(t)) { print $0 }
    '
)

pick_first_in_ws() {
  local ws="$1"
  for line in "${SCRATCHES[@]:-}"; do
    [[ "$(echo "$line" | cut -f2)" == "$ws" ]] && { echo "$line"; return 0; }
  done
  return 1
}

LINE=""
ACTION=""

# 1) If scratch is on current workspace -> HIDE that one
if LINE="$(pick_first_in_ws "$CUR_WS" 2>/dev/null)"; then
  ACTION="hide"
# 2) Else if scratch is parked -> SHOW that one
elif LINE="$(pick_first_in_ws "$PARK_WS" 2>/dev/null)"; then
  ACTION="show"
# 3) Else if scratch exists elsewhere -> SHOW first one we find
elif [[ ${#SCRATCHES[@]:-0} -gt 0 ]]; then
  LINE="${SCRATCHES[0]}"
  ACTION="show"
else
  # 4) None exist -> launch one (prefer reusing existing app; no -n)
  open -a "${ALACRITTY_APP}" --args --title "${SCRATCH_TITLE}"

  # Wait for it to appear
  for _ in {1..30}; do
    sleep 0.1
    mapfile -t SCRATCHES < <(
      aerospace list-windows --all \
        --format '%{window-id}\t%{workspace}\t%{window-title}\t%{app-bundle-id}\n' \
      | awk -F'\t' -v t="$SCRATCH_TITLE" -v b="$ALACRITTY_BUNDLE" '
          $4 == b && index(tolower($3), tolower(t)) { print $0 }
        '
    )
    [[ ${#SCRATCHES[@]} -gt 0 ]] && break
  done

  if [[ ${#SCRATCHES[@]:-0} -eq 0 ]]; then
    exit 0
  fi

  LINE="${SCRATCHES[0]}"
  ACTION="show"
fi

WIN_ID="$(echo "${LINE}" | cut -f1)"

if [[ "$ACTION" == "hide" ]]; then
  aerospace focus --window-id "${WIN_ID}"
  aerospace move-node-to-workspace "${PARK_WS}"

  # restore focus only if previous window was on the current workspace
  if [[ -n "${PREV_WIN_ID}" && "${PREV_WIN_ID}" != "${WIN_ID}" && "${PREV_WIN_WS}" == "${CUR_WS}" ]]; then
    aerospace focus --window-id "${PREV_WIN_ID}" 2>/dev/null || true
  fi
else
  aerospace focus --window-id "${WIN_ID}"
  aerospace move-node-to-workspace "${CUR_WS}"
  aerospace layout tiling
  aerospace focus --window-id "${WIN_ID}"
fi

