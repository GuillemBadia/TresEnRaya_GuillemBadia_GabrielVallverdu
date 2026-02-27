# Configuració general de fonts
UNDERLINE=`tput smul`
NOUNDERLINE=`tput rmul`
BOLD=`tput bold`
NORMAL=`tput sgr0`
ITALIC=`tput sitm`

BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
COLOR_OFF='\033[0m'

# TODO: Per si utilitzeu aquesta versió, la manera de fer crida a la funció:
#   log_info "Connexió amb $CLIENT_IP iniciada."
log_info() {
    # Es mostra per pantalla el missatge a $1 de color ...
    echo -e "${...}[INFO] $1${COLOR_OFF}"
    
    # S'envia un missatge amb la hora al fitxer log
    # (date '+%F %T') mostra la data en format (2026-01-23 18:53:04)
    echo "..." >> "$fitxerlog"
}

# TODO: Per si utilitzeu aquesta versió, la manera de fer crida a la funció:
#   log_error "Capçalera incorrecta."
log_error() {
    # Es mostra per pantalla el missatge a $1 de color ...
    echo -e "${...}[ERROR] $1${COLOR_OFF}"
    
    # S'envia un missatge amb la hora al fitxer log
}

# TODO: Per si utilitzeu aquesta versió, la manera de fer crida a la funció:
#   print_board "${BOARD[*]}" "$SERVER_FORMAT_CHAR" "$CLIENT_FORMAT_CHAR"
print_board() {

	# A través de paràmetres es rep:
	#  1 - Tauler de joc (array)
	#  2 - Format visual per a representar les peces del servidor
	#  2 - Format visual per a representar les peces del client
    BOARD=($1)
    SERVER_FORMAT_CHAR=$2
    CLIENT_FORMAT_CHAR=$3

    SERVER_CHAR='S'
    CLIENT_CHAR='C'

	echo
	# Recorre cada fila
	for i in 0 1 2; do

		# Recorre cada columna
		for j in 0 1 2; do

            # Es calcula la posició de l'array (1 - 9) segons $i i $j
			array_pos=$(($i * 3 + $j))

			# Si la casella conté una 'S', es printarà $SERVER_FORMAT_CHAR
			if [ ${BOARD[array_pos]} = $SERVER_CHAR ]; then
				echo -n -e " $SERVER_FORMAT_CHAR "
			# Si la casella conté una 'C', es printarà $CLIENT_FORMAT_CHAR
			elif [ ${BOARD[array_pos]} = $CLIENT_CHAR ]; then
				echo -n -e " $CLIENT_FORMAT_CHAR "
			# Si la casella encara no conté cap peça, es mostra el contingut de l'array
			else
				echo -n " ${BOARD[array_pos]} "
			fi

			# Es printa "|" entre les columnes 0-1 i 1-2
			if [ $j -lt 2 ]; then
				echo -n "|"
			fi

		done

		echo

		# Es printa "---+---+---" entre les files 0-1 i 1-2
		if [ $i -lt 2 ]; then
			echo "---+---+---"
		fi
	done
	echo

}
