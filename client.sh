#!/bin/bash

SERVER_IP="10.65.0.58"
PORT=60000

echo "HELLO" | nc -q 0 $SERVER_IP $PORT
response=$(nc -l -p $PORT)

if [[ "$response" != "OK" ]]; then
  exit 1
fi

while true; do

  echo "Esperant el torn ..."

  # Sacaba el temps despera quan el servidor acaba el torn
  response=$(nc -l -p $PORT)

  # TODO: Gestió de missatges rebuts
  # SERVER_WIN
  # CLIENT_WIN
  # MOVE_CLIENT
  # ...
  if [[ "$response" == "SERVER_WIN" ]]; then
    echo "SERVER_WIN" | nc -q 0 $SERVER_IP $PORT
	break
	fi
  # == TORN CLIENT ==

	if [[ "$response" == "MOVE_CLIENT" ]]; then
      # 4.4 S'envia al client que comença el seu torn
	  echo "Te toca"
	  # 4.5 Es llegeix el moviment del client
	  read -p "Posició del client (1-9): " pos
	  # 4.6 S'actualitza el moviment al tauler
	  board_index=$((pos - 1))
	  BOARD[$board_index]="0"
	  
	  # 4.7 Es comprova si s'ha guanyat (result="WIN" o result="NONE")
	  result=$(check_win)
	  if [[ "$result" == "WIN" ]]; then
	    echo "CLIENT_WIN" | nc -q 0 $SERVER_IP $PORT
		break
	  fi
	  # 4.8 Es printa el tauler
	  print_board
	  # pregunta posició i s'envia al servidor
	  echo "MOVE $pos" | nc -q 0 $SERVER_IP $PORT
	fi


done

exit 0
