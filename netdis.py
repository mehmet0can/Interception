from optparse import OptionParser
from scapy.all import ARP, Ether, srp

parser = OptionParser()
parser.add_option("-i", "--ipaddress", dest="ip_adres", help="ip adresi giriniz")
parser.add_option("-s", "--subnetmask", dest="subnet", help="subnet mask degerini giriniz")
(user_input, arguments) = parser.parse_args()

address = user_input.ip_adres
subnet = user_input.subnet

target_ip = address + "/" +  subnet
arp = ARP(pdst=target_ip)
ether = Ether(dst="ff:ff:ff:ff:ff:ff")

packet = ether/arp
result = srp(packet, timeout=3, verbose=0)[0]
clients = []

for sent, received in result:
	clients.append({'ip': received.psrc, 'mac': received.hwsrc})

print("Available devices in the network:\n")
print("IP" + " "*18+"MAC")
for client in clients:
	print("{:16}    {}".format(client['ip'], client['mac']))
