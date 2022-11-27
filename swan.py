import sys
from scapy.all import *
import scapy.all as scapy
from scapy.layers.tls.record import TLS


def networkresult(pkts):
	try:
		if pkts.haslayer(TLS):
			if (pkts.sprintf("%TLS.type%")) == "handshake":
				print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t %TLS.type% \t\t TLS \t\t {str(len(pkts[TLS].payload))} \t\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
			elif (pkts.sprintf("%TLS.type%")) == "alert":
				print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t %TLS.type% \t\t\t TLS \t\t {str(len(pkts[TLS].payload))} \t\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
			else:
				print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t %TLS.type% \t TLS \t\t {str(len(pkts[TLS].payload))} \t\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
		
		elif pkts.haslayer(DNS):				
			print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t %DNS.flags% \t\t\t DNS \t\t {str(len(pkts[DNS].payload))} \t\t %IP.src%:%ARP.sport% to %IP.dst%:%ARP.dport%"))
		
		elif pkts.haslayer(ARP):
			print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t %ARP.flags% \t\t\t ARP \t\t {str(len(pkts[ARP].payload))} \t\t %ARP.src%:?? to %ARP.dst%:??"))
		
		elif pkts.haslayer(TCP):
			if pkts[TCP].flags == "U":
				print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t |  Urg  | 32 \t\t TCP \t\t {str(len(pkts[TCP].payload))} \t\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
			elif pkts[TCP].flags == "A":
				print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t |  Ack  | 16 \t\t TCP \t\t {str(len(pkts[TCP].payload))} \t\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
			elif pkts[TCP].flags == "P":
				print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t |  Psh  |  8 \t\t TCP \t\t {str(len(pkts[TCP].payload))} \t\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
			elif pkts[TCP].flags == "R":
				print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t |  Rst  |  4 \t\t TCP \t\t {str(len(pkts[TCP].payload))} \t\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
			elif pkts[TCP].flags == "S":
				print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t |  Syn  |  2 \t\t TCP \t\t {str(len(pkts[TCP].payload))} \t\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
			elif pkts[TCP].flags == "F":
				print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t |  Fın  |  1 \t\t TCP \t\t {str(len(pkts[TCP].payload))} \t\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
			elif pkts[TCP].flags == "SA":
				print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t |Syn/Ack| 18 \t\t TCP \t\t {str(len(pkts[TCP].payload))} \t\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
			elif pkts[TCP].flags == "RA":
				print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t |Rst/Ack| 20 \t\t TCP \t\t {str(len(pkts[TCP].payload))} \t\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
			elif pkts[TCP].flags == "PA":
				print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t |Psh/Ack| 24 \t\t TCP \t\t {str(len(pkts[TCP].payload))} \t\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
			elif pkts[TCP].flags == "FA":
				print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t |Fın/Ack| 17 \t\t TCP \t\t {str(len(pkts[TCP].payload))} \t\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
			elif pkts[TCP].flags == "SF":
				print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t |Syn/Fın|  3 \t\t TCP \t\t {str(len(pkts[TCP].payload))} \t\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
			else:
				print("nothing")
				
		elif pkts.haslayer(ICMP):
			if str(len(pkts[ICMP].payload)) == "24":
				if pkts.getlayer(ICMP).type == 0:                    
					print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t Echo Reply  Type 0 \t ICMP \t\t {str(len(pkts[ICMP].payload))} | OS WİN \t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
				elif pkts.getlayer(ICMP).type == 8:
					print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t Echo Request Type 8 \t ICMP \t\t {str(len(pkts[ICMP].payload))} | OS WİN \t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
				else:
					print("nothing")
			elif str(len(pkts[ICMP].payload)) == "56":
				if pkts.getlayer(ICMP).type == 0:                    
					print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t Echo Reply   Type 0 \t ICMP \t\t {str(len(pkts[ICMP].payload))} | OS UNİX\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
				elif pkts.getlayer(ICMP).type == 8:
					print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t Echo Request Type 8 \t ICMP \t\t {str(len(pkts[ICMP].payload))} | OS UNİX\t %IP.src%:%TCP.sport% to %IP.dst%:%TCP.dport%"))
				else:
					print("nothing")
								
		elif pkts.haslayer(UDP):
			print(pkts.sprintf(f"%Ether.src% to %Ether.dst% \t\t ?? \t\t\t UDP \t\t {str(len(pkts[UDP].payload))} \t\t %IP.src%:{pkts.getlayer(UDP).sport} to %IP.dst%:{pkts.getlayer(UDP).dport}"))
										
									
		elif pkts.haslayer(IP):
			print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t %IP.flags% \t\t\t IP \t\t {str(len(pkts[IP].payload))} \t\t %IP.src%:%IP.sport% to %IP.dst%:%IP.dport%"))											
		
		elif pkts.haslayer(Ether):
			print(pkts.sprintf(f"%Ether.src% to %Ether.dst%\t\t %Ether.flags% \t\t\t Ether \t\t {str(len(pkts[Ether].payload))} \t\t %IP.src%:%Ether.sport% to %IP.dst%:%Ether.dport%"))
					

		
		
			
	except KeyboardInterrupt:
		print("\nPressed 'CTRL + C'")
		sys.exit()

	except Exception as E:
		print("Error : ", E)
		sys.exit()

print("Ether ADDRESS ('src' to 'dst')\t\t\t Flags/value \t\t Protocol \t packet length \t IP ADDRESS/PORT ('src' to 'dst')\n")
sniff(iface="eth0", prn=networkresult, store=0)
