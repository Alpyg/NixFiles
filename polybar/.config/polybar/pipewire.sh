#!/bin/sh

function main() {
  SINK=$(wpctl status | grep -A1 'Sinks' | grep '*')
  SOURCE=$(echo "$SINK" | grep -oP '\K\d+' | head -n 1)
  VOLUME=$(echo "$SINK" | grep -oP '\[vol: \K[0-9.]+' | tr -d '.' | sed 's/^0*//')
  MUTED=$(echo "$SINK" | grep -oP 'MUTED' | tr -d '.')

  case $1 in
    "+")
      if [ "${VOLUME}" -lt 150 ]; then
        wpctl set-volume ${SOURCE} 0.05+
      fi
      ;;
    "-")
      wpctl set-volume ${SOURCE} 0.05-
      ;;
    "mute")
      wpctl set-mute ${SOURCE} toggle
      ;;
  esac

  if [ -n "$MUTED" ]; then
    echo "MUTED"
    exit 0
  elif [ -z "$VOLUME" ]; then
    echo "0%"
  else
    echo "$VOLUME%"
  fi
}

main "$@"
