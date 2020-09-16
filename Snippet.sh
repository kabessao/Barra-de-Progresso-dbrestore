# Função para mostrar a BARRA de PROGRESSO
progressoNormal () {
LINHA_TOTAL=$@
PORCENTAGEM=0
while read LINE 
do
	
	#Contador de linha
	[ $PORCENTAGEM -lt 100 ] && var=$((var+1))
	#Quantidade de colunas do terminal
	COLS=$(tput cols)
	#Inicio da BARRA de PROGRESSO
	PROGRESSO="["
	#PORCENTAGEM decorrida
	PORCENTAGEM=$((var * 100 / LINHA_TOTAL))
	#10% da tela é alocada para a mensagem
	TOTAL_MSG=$(( 10 * COLS / 100))
	#Alocando espaço para a BARRA e 10 colunas para a PORCENTAGEM
	BARRA=$((COLS - TOTAL_MSG - 10))
	#Calcula o PROGRESSO a ser desenhado na BARRA
	TOTAL_BAR=$((var * BARRA / LINHA_TOTAL))

	if [ "${LINE:0:2}" = "##" ]; then 
		#Mostrar o erro
		[ "${LINE:34}" = "${lastError:34}" ] && printf "\r%s vezes" $(((errorCount++))) || printf "\n\033[1K$LINE\n" && errorCount=2
		lastError=$LINE
	else 
	#Desenha o PROGRESSO na BARRA
	PROGRESSO+=$(printf "=%.0s" $(seq $((TOTAL_BAR - 2))))">"
	
	#Desenha o restante da BARRA
	[ $PORCENTAGEM -lt 100 ] && PROGRESSO+=$(printf -- "-%.0s"  $(seq $((BARRA - ${#PROGRESSO}))))
	#Final da BARRA
	PROGRESSO+="]"
	
	#Desenha todo o conteudo, alocando e limitando o espaço para a mensagem
	printf "\r%-${TOTAL_MSG}.${TOTAL_MSG}s %-4s%s" "$LINE" "$PORCENTAGEM%" "$PROGRESSO"
	fi
done
echo -e "\n"
}

# Função de BARRA de PROGRESSO. Com o pacman
progressoPacman () {
LINHA_TOTAL=$@
PORCENTAGEM=0
pac="c"
while read LINE 
do
	
	#Troca o sinal do pacman de C para c para C de novo
	if [ "${PORCENTAGEM}" != "$elapsed" ] ;then 
		[ "$pac" = "C" ] && pac=${pac,,} || pac=${pac^^}
 	fi 

	elapsed=${PORCENTAGEM}
	#Contador de linha
	[ $PORCENTAGEM -lt 100 ] && var=$((var+1))
	#Quantidade de colunas do terminal
	COLS=$(tput cols)
	#Inicio da BARRA de PROGRESSO
	PROGRESSO="["
	#PORCENTAGEM decorrida
	PORCENTAGEM=$((var * 100 / LINHA_TOTAL))
	#10% da tela é alocada para a mensagem
	TOTAL_MSG=$(( 10 * COLS / 100))
	#Alocando espaço para a BARRA e 10 colunas para a PORCENTAGEM
	BARRA=$((COLS - TOTAL_MSG - 10))
	#Calcula o PROGRESSO a ser desenhado na BARRA
	TOTAL_BAR=$((var * BARRA / LINHA_TOTAL))

	if [ "${LINE:0:2}" = "##" ]; then 
		#Mostrar o erro
		[ "${LINE:34}" = "${lastError:34}" ] && printf "\r%s vezes" $(((errorCount++))) || printf "\n\033[1K$LINE\n" && errorCount=2
		lastError=$LINE
	else 
	#Desenha o PROGRESSO na BARRA
	PROGRESSO+=$(printf "\u2002%.0s" $(seq $((TOTAL_BAR - 2))))"$pac"
	
	#Desenha o restante da BARRA
	[ $PORCENTAGEM -lt 100 ] && PROGRESSO+=$(printf "·%.0s"  $(seq $((BARRA - ${#PROGRESSO}))))
	#Final da BARRA
	PROGRESSO+="]"
	
	#Desenha todo o conteudo, alocando e limitando o espaço para a mensagem
	printf "\r%-${TOTAL_MSG}.${TOTAL_MSG}s %-4s%s" "$LINE" "$PORCENTAGEM%" "$PROGRESSO"
	fi
done
echo -e "\n"
}
