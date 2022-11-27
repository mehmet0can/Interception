#!/bin/bash

	# Kullanıcının root yetkisine sahip olmadan bu dosyayı çalıştırması ileri aşamalarda sorun  
   	# çıkartabileceginden bir erişim kısıtı oluşturdum.

   	function LineDrawforscreen()
   	{
      		for (( i=0; i<105; i++ )) 
      		{
         		printf "-"
      		}
      		echo ""
   	}

   	if [[ $(id -u) -eq 0 ]]; then

    		LineDrawforscreen
    		chmod +x headerdesing.sh
	    	./headerdesing.sh
	    	LineDrawforscreen
	    
	    	printf "dev. and pub. : \e[1;34mMehmet Can Atar\e[0m <| |>  Github : \e[1;34mhttps://github.com/mehmet0can?tab=repositories\e[0m\n" 
	    	printf "version : \e[1;31mBETA 13.1.22\e[0m\n\n"
	    	printf "Welcome to the 'Man in The Middle' attack tool\n"
	    	LineDrawforscreen
	 
	    	printf "(\e[1;32m1\e[0m) \e[1;37mTürkçe\e[0m\n(\e[1;32m2\e[0m) \e[1;37mEnglish\e[0m\n\n"
	    	printf "Kullanılacak dili seçiniz : " 
	    	read SelectedLanguages
	    	LineDrawforscreen
 
	     	case $SelectedLanguages in 
	 
	     	1 )
		# Türkçe
		# Türkçe dosyasını ayrı bir sh uzantılı dosyasının içide koyarak
		# dosyayı ana dosyam olan İnterception.sh içinde çagırdım.
		chmod +x TRcommand.sh
	     	./TRcommand.sh
	     	;;
		
		2 )
		# English
	    	# Putting the English file in a separate sh file I called the 
	     	# file in my main file, Interception.sh.
		chmod +x ENcommand.sh 
		./ENcommand.sh
		;;
	  
	     	* )
	     	echo "Hatalı deger girdiniz"
	     	;;
	 
	     	esac
	
	elif [[ $(id -u) -ne 0 ]]; then
	LineDrawforscreen
	printf "\n\e[1;31m\t\t\t\tRoot\e[0m yetkisine sahip değilsiniz\n\t\t\t\t\e[1;31mRoot\e[0m olarak çalıştırınız\n\n"
	LineDrawforscreen
	exit
   	fi
