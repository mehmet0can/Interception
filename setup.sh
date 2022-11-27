#!/bin/bash

function LineDrawforScreen()
{
	for (( i=0; i<105; i++ ))
	{
		printf "\e[1;37m-\e[0m" 
	}
	echo ""
}

if [[ $(id -u) -eq 0 ]]; then
	LineDrawforScreen
	printf "\e[1;36mUpdate yapılıyor . . .\e[0m\n"
	LineDrawforScreen
	apt update -y
	printf "\e[1;32mUpdate yapıldı.\e[0m\n\n"
	LineDrawforScreen

	LineDrawforScreen
	printf "\e[1;36mGnome-Terminal indiriliyor . . .\e[0m\n\n"
	LineDrawforScreen
	
		if type gnome-terminal 2>/dev/null; then
			printf "\e[1;32mgnome-terminal zaten yüklü\e[0m\n"
			sleep 3
		else
			apt install gnome-terminal -y
			printf "\e[1;32mGnome-Terminal indirildi.\e[0m\n\n" 
			sleep 3
		fi
		
		LineDrawforScreen	   

	printf "\e[1;36mDsniff indiriliyor . . .\e[0m\n\n"
	LineDrawforScreen
	   
		if type dsniff 2>/dev/null; then
			printf "\e[1;32mdsniff zaten yüklü\e[0m\n"
			sleep 3
		else
			apt install dsniff -y
			printf "\e[1;32mdsniff indirildi.\e[0m\n\n"
			sleep 3 
		fi
		
		LineDrawforScreen	   
		
	printf "\e[1;36mBettercap indiriliyor . . .\e[0m\n\n"
	LineDrawforScreen
	   
		if type bettercap 2>/dev/null; then
			printf "\e[1;32mbettercap zaten yüklü\e[0m\n"
			sleep 3
		else
			apt install bettercap -y
			printf "\e[1;32mbettercap indirildi.\e[0m\n\n"
			sleep 3 
		fi
	
		LineDrawforScreen	   
	
	printf "\e[1;36mWireshark indiriliyor . . .\e[0m\n\n"
	LineDrawforScreen
	   
		if type wireshark 2>/dev/null; then
			printf "\e[1;32mwireshark zaten yüklü\e[0m\n"
			sleep 3
		else
			apt install bettercap -y
			printf "\e[1;32mwireshark indirildi.\e[0m\n\n"
			sleep 3 
		fi
		
		LineDrawforScreen    	  
		   
	printf "\e[1;36mScapy python library indiriliyor . . .\e[0m\n\n"
	LineDrawforScreen
	
		if type scapy 2>/dev/null; then
			printf "\e[1;32mscapy zaten yüklü\e[0m\n"
			sleep 3
		else
			pip install scapy
			printf "\e[1;32mscapy indirildi.\e[0m\n\n"
			sleep 3
		fi
		
	clear
	printf "\e[1;32mİndirmeler tamamlandı\e[0m\n\e[1;36minterception\e[0m'a yönlendiriliyorsunuz."
	sleep 10
	clear
	chmod +x Interception.sh
	./Interception.sh							
	
else
	LineDrawforScreen
	printf "\n\e[1;31m\t\t\t\tRoot\e[0m yetkisine sahip değilsiniz\n\t\t\t\t\e[1;31mRoot\e[0m olarak çalıştırınız\n\n"
    	LineDrawforScreen
    	exit
fi
