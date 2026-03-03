#!/bin/bash

SERVER_IP="10.65.0.15"
PORT=60000

echo "HELLO" | nc -q 0 $SERVER_IP $PORT
response=$(nc -l -p $PORT)

if [[ "$response" != "OK" ]]; then
  exit 1
fi

while true; do
  response=$(nc -l -p $PORT)

  case "$response" in
    YOUR_TURN)
      read -p "Posició (1-9): " pos
      echo "MOVE $pos" | nc -q 0 $SERVER_IP $PORT
      ;;
    SERVER_MOVE*)
      echo "Servidor ha posat la fitxa"
      ;;
    SERVER_WIN)
      echo "Ha guanyat el servidor!"
      break
      ;;
    CLIENT_WIN)
      echo "Has guanyat!"
      break
      ;;
    DRAW)
      echo "Empat!"
      break
      ;;
  esac

exit 0
