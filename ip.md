## Netwerken in Linux

Je hebt nu twee virtuele machines met Debian draaien: **studentdeb** en **studentdeb2**.

### IP-adressen raadplegen

Om alle IP-adressen van een Linux-systeem te bekijken, gebruik je:

~~~
$ ip address
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:6a:b3:73 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 86296sec preferred_lft 86296sec
    inet6 fd00::a00:27ff:fe6a:b373/64 scope global dynamic mngtmpaddr 
       valid_lft 86297sec preferred_lft 14297sec
    inet6 fe80::a00:27ff:fe6a:b373/64 scope link 
       valid_lft forever preferred_lft forever
~~~

of de afgekorte versie:

~~~
$ ip a
~~~

Elke netwerkinterface heeft een volgnummer (zoals 1, 2 hierboven) en een naam (zoals `lo` en `enp0s3` hierboven). De eerste is de _loopback interface_, die de computer gebruikt om met zichzelf te communiceren. De tweede is in dit geval een (virtuele) ethernetinterface.

#### Beperken tot IP-versie

Als je alleen de IPv4-adressen wilt zien, voeg je de optie `-4` toe:

~~~
$ ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 86265sec preferred_lft 86265sec
~~~

... of de optie `-6` voor alleen de IPv6-adressen:

~~~
$ ip -6 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 state UNKNOWN qlen 1000
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 state UP qlen 1000
    inet6 fd00::a00:27ff:fe6a:b373/64 scope global dynamic mngtmpaddr 
       valid_lft 86249sec preferred_lft 14249sec
    inet6 fe80::a00:27ff:fe6a:b373/64 scope link 
       valid_lft forever preferred_lft forever
~~~

#### Beperken tot interface

Als je de gegevens van een specifieke interface wilt zien, geef je de naam op na het subcommando `show`:

~~~
$ ip a show enp0s3
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:6a:b3:73 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 85918sec preferred_lft 85918sec
    inet6 fd00::a00:27ff:fe6a:b373/64 scope global dynamic mngtmpaddr 
       valid_lft 86129sec preferred_lft 14129sec
    inet6 fe80::a00:27ff:fe6a:b373/64 scope link 
       valid_lft forever preferred_lft forever
~~~

### Bewerken van IP-adressen

Vaak wordt een interface geconfigureerd zodat die automatisch een IP-adres toegewezen krijgt via DHCP (Dynamic Host Configuration Protocol).

#### IP-adres toekennen

De syntaxis om een IPv4/IPv6-adres toe te kennen aan een interface, is als volgt:

~~~
# ip a add {ip_addr/mask} dev {interface}
~~~

Om bijvoorbeeld 192.168.1.200/255.255.255.0 aan eth0 toe te kennen, gebruik je:

~~~
# ip a add 192.168.1.200/255.255.255.0 dev eth0
~~~

In bovenstaand geval gebruik je een bitmask voor de netmask.

Je kunt dit echter ook met de CIDR-notatie gebruiken:

~~~
# ip a add 192.168.1.200/24 dev eth0
~~~

#### IP-adres verwijderen

De syntaxis om een IPv4/IPv6-adres van een interface te verwijderen, is als volgt:

~~~
# ip a del {ipv6_addr_OR_ipv4_addr} dev {interface}
~~~

Om bijvoorbeeld 192.168.1.200/24 van eth0 te verwijderen, gebruik je: 

~~~
# ip a del 192.168.1.200/24 dev eth0
~~~

#### Alle IP-adressen verwijderen

Naast delete bestaat er ook flush. Hiermee verwijder je alle IP-adressen die aan een specifieke voorwaarde voldoen.

Als je bijvoorbeeld alle IP-adressen van interfaces startende met eth wilt verwijderen,
gebruik je de optie label:

~~~
# ip -4 addr flush label "eth*"
~~~

### Status van een interface wijzigen

Naast het IP-adres kun je ook nog de status van een interface beheren.  

Zo kun je een interface als volgt in- en uitschakelen:

~~~
# ip link set dev {DEVICE} {up|down}
~~~

Om de interface eth0 uit te schakelen, gebruik je: 

~~~
# ip link set dev eth1 down
~~~

Om deze terug aan te zetten, gebruik je:

~~~
# ip link set dev eth1 up
~~~

### ARP/Neighbour cache

Je kunt de cache van bekende IP-adressen opvragen:

~~~
$ ip neigh show
10.0.2.2 dev enp0s3 lladdr 52:55:0a:00:02:02 STALE 
10.0.2.3 dev enp0s3 lladdr 52:55:0a:00:02:03 STALE 
fe80::2 dev enp0s3 lladdr 52:56:00:00:00:02 router STALE 
~~~

Of de afgekorte versie:

~~~
$ ip n show
~~~
 
Drie statussen zijn mogelijk in de uitvoer:

* **REACHABLE**  
  Het MAC-adres is bereikbaar.
* **STALE**  
  Het adres is geldig, maar vermoedelijk niet bereikbaar. De kernel zal dit nakijken bij de eerstvolgende transmissie.
* **DELAY**  
  Een pakket is verstuurd naar het adres, maar de kernel is aan het wachten op bevestiging.

### Routingtabel

Om de verschillende routes naar ip-domeinen op te lijsten, gebruik je:

~~~
$ ip route list
default via 10.0.2.2 dev enp0s3 
10.0.2.0/24 dev enp0s3 proto kernel scope link src 10.0.2.15 
~~~

Of afgekort:

~~~
ip r list
~~~

En je kunt ook de list-optie weglaten:

~~~
ip r
~~~

Je kunt ook routes toevoegen:

~~~
ip route add {NETWORK/MASK} via {GATEWAYIP}
ip route add {NETWORK/MASK} dev {DEVICE}
~~~

Of een standaardroute toevoegen:

~~~
ip route add default {NETWORK/MASK} dev {DEVICE}
ip route add default {NETWORK/MASK} via {GATEWAYIP}
~~~

Of een route verwijderen:

~~~
ip route del 192.168.1.0/24 dev eth0
~~~
