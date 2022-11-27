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

   function headerdesing(){

    # \e[1;32m  \e[0m\n kodlaması yeşil renk kodudur
    # diger renkler için '32m' kısmına araştırılarak 33, 34 gibi degerler atanabilir
    # ve eger ki echo ile renkli komut yazıdırılmaya çalışılırsa -e parametresi unutulmamalıdır.
 
    # istege baglı olarak tasarım degiştirilebilir.
 
 
   printf "  \e[1;32m\t\t _        _                            _____ _    _              \e[0m\n"
   printf " \e[1;32m\t\t(_) _ _ _| |__  ____ ____  _____ ____ /  __ \ |__(_) ____  _ _ _ \e[0m\n"
   printf " \e[1;32m\t\t| | '__' |  __|/ __ \ ___\/  ___/  __\|  ___/  __| |/    \| '_' |\e[0m\n"
   printf " \e[1;32m\t\t| | |  | |  |_|  ___| |  '| |___|  ___| |  |  |__| |  ()  | | | |\e[0m\n"
   printf " \e[1;32m\t\t|_|_|  |_|_____\____|_|   \_____\_____|_|  \_____|_|\____/|_| |_|\e[0m\n\n"

   }

   headerdesing

   elif [[ $(id -u) -ne 0 ]]; then
   LineDrawfordesingscreen
   printf "\n\e[1;31m\t\t\t\tRoot\e[0m yetkisine sahip değilsiniz\n\t\t\t\t\e[1;31mRoot\e[0m olarak çalıştırınız\n\n"
   LineDrawfordesingscreen
   exit
   fi
