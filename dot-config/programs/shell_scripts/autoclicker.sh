#!/bin/bash
# Toggle an autoclicker driven by ydotool.
#
# Running the script with no autoclicker active starts one; running it again
# stops the active one. Bind it to a single key to get a press-to-toggle clicker.
#
# Usage: autoclicker.sh [-i interval_ms] [-b left|right|middle] [-c count]
#   -i  delay between clicks in milliseconds (default: 100)
#   -b  mouse button to click (default: left)
#   -c  number of clicks then auto-stop (default: 0 = unlimited)

app_name="$(basename "$0")"
app_title="Autoclicker"
pid_file="/tmp/autoclicker.pid"

# --- ydotool needs its daemon and a socket; default matches ydotoold's. ---
export YDOTOOL_SOCKET="${YDOTOOL_SOCKET:-${XDG_RUNTIME_DIR:-/tmp}/.ydotool_socket}"

notify() { notify-send "$app_title" "$1" --app-name="$app_name"; }

# --- Stop an already-running instance, then exit (the toggle "off" path). ---
if [ -f "$pid_file" ]; then
  old_pid="$(cat "$pid_file")"
  if [ -n "$old_pid" ] && kill -0 "$old_pid" 2> /dev/null; then
    kill "$old_pid" 2> /dev/null
    rm -f "$pid_file"
    notify "🛑 Stopped"
    exit 0
  fi
  # Stale pid file (process already gone); clean up and fall through to start.
  rm -f "$pid_file"
fi

# --- Parse options. ---
interval_ms=100
button="left"
count=0

while getopts ":i:b:c:h" opt; do
  case "$opt" in
    i) interval_ms="$OPTARG" ;;
    b) button="$OPTARG" ;;
    c) count="$OPTARG" ;;
    h)
      sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      notify "❌ Invalid option: -$OPTARG"
      exit 1
      ;;
  esac
done

# --- Map the friendly button name to ydotool's press+release bitmask. ---
case "$button" in
  left) click_code="0xC0" ;;
  right) click_code="0xC1" ;;
  middle) click_code="0xC2" ;;
  *)
    notify "❌ Invalid button: $button (use left, right, or middle)"
    exit 1
    ;;
esac

if ! [[ "$interval_ms" =~ ^[0-9]+$ ]] || ! [[ "$count" =~ ^[0-9]+$ ]]; then
  notify "❌ Interval and count must be whole numbers"
  exit 1
fi

if ! command -v ydotool > /dev/null 2>&1; then
  notify "❌ ydotool is not installed"
  exit 1
fi

# --- Make sure the ydotool daemon is up before we try to click. ---
if [ ! -S "$YDOTOOL_SOCKET" ]; then
  if command -v ydotoold > /dev/null 2>&1; then
    ydotoold > /dev/null 2>&1 &
    for _ in $(seq 1 20); do
      [ -S "$YDOTOOL_SOCKET" ] && break
      sleep 0.1
    done
  fi
  if [ ! -S "$YDOTOOL_SOCKET" ]; then
    notify "❌ ydotoold socket not available ($YDOTOOL_SOCKET)"
    exit 1
  fi
fi

# --- Run the click loop detached so the toggle "off" call can find and kill it. ---
sleep_s="$(awk "BEGIN { printf \"%.3f\", $interval_ms / 1000 }")"
setsid bash -c '
  click_code="$1"; sleep_s="$2"; count="$3"
  n=0
  while :; do
    ydotool click "$click_code" || exit 1
    n=$((n + 1))
    [ "$count" -gt 0 ] && [ "$n" -ge "$count" ] && break
    sleep "$sleep_s"
  done
  rm -f "'"$pid_file"'"
' _ "$click_code" "$sleep_s" "$count" &

echo "$!" > "$pid_file"

if [ "$count" -gt 0 ]; then
  notify "▶️ Clicking ${button} ×${count} every ${interval_ms}ms"
else
  notify "▶️ Clicking ${button} every ${interval_ms}ms (run again to stop)"
fi
