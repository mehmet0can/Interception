#!/bin/bash

function LineDrawfordesingscreen()
{
	for (( i=0; i<105; i++ )) 
      	{
		printf "-"
      	}
	echo ""
}
   
if [[ $(id -u) -eq 0 ]]; then
   
	LineDrawfordesingscreen
	printf "\n\t\t\e[1;37m                           \t       __ \e[0m\n"
	printf "\t\t\e[1;37m                           \t     /^  \ \e[0m\n"
	printf "\t\t\e[1;37m   ____.                   \t     |./\ \    _______\e[0m\n"
	printf "\t\t\e[1;37m  / ___\_    _ ___,_____  \t     \/ / | _/        \ \e[0m\n"
	printf "\t\t\e[1;37m  \___ \ \/\/ / . /  _  \ \t       / /^/           \ \e[0m\n"
	printf "\t\t\e[1;37m  |____/\____/|___|_ | _| \t      /  \/            /\ \e[0m\n"
	printf "\t\t\e[1;37m                           \t     |                  / \e[0m\n" 
	printf "\t\t\e[1;37m                           \t     \                 / \e[0m\n"
	printf "\t\t\e[1;37m                           \t      \_______________/ \e[0m\n\n\n"
	LineDrawfordesingscreen
	printf "Network dinleniyor . . .\n"
   	python3 swan.py
   
elif [[ $(id -u) -ne 0 ]]; then
	
	LineDrawfordesingscreen
	printf "\n\e[1;31m\t\t\t\tRoot\e[0m yetkisine sahip değilsiniz\n\t\t\t\t\e[1;31mRoot\e[0m olarak çalıştırınız\n\n"
   	LineDrawfordesingscreen
   	exit

fi
