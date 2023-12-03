## Netwerken in Linux

### IP-adressen raadplegen

Om alle IP-adressen van een Linux-systeem te bekijken, gebruik je:

~~~
$ ip address
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp8s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN group default qlen 1000
    link/ether e8:6a:64:6f:42:ef brd ff:ff:ff:ff:ff:ff
3: wlp7s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 28:3a:4d:7d:d8:05 brd ff:ff:ff:ff:ff:ff
    inet 10.25.87.235/19 brd 10.25.95.255 scope global dynamic noprefixroute wlp7s0
       valid_lft 529sec preferred_lft 529sec
    inet6 fe80::78e3:ad08:bfb0:eebd/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 52:54:00:72:55:08 brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
       valid_lft forever preferred_lft forever
5: virbr0-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel master virbr0 state DOWN group default qlen 1000
    link/ether 52:54:00:72:55:08 brd ff:ff:ff:ff:ff:ff
6: br-5c2c35c13eda: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:7f:b2:00:23 brd ff:ff:ff:ff:ff:ff
    inet 172.18.0.1/16 brd 172.18.255.255 scope global br-5c2c35c13eda
       valid_lft forever preferred_lft forever
7: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:b3:1a:8b:c2 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
~~~

of de afgekorte versie:

~~~
$ ip a
~~~

#### Beperken tot IP-versie

Als je alleen de IPv4-adressen wilt zien...

~~~
$ ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
3: wlp7s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    inet 10.25.87.235/19 brd 10.25.95.255 scope global dynamic noprefixroute wlp7s0
       valid_lft 505sec preferred_lft 505sec
4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
       valid_lft forever preferred_lft forever
6: br-5c2c35c13eda: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    inet 172.18.0.1/16 brd 172.18.255.255 scope global br-5c2c35c13eda
       valid_lft forever preferred_lft forever
7: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
$
~~~

... of alleen de IPv6-adressen:

~~~
$ ip -6 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 state UNKNOWN qlen 1000
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
3: wlp7s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 state UP qlen 1000
    inet6 fe80::78e3:ad08:bfb0:eebd/64 scope li
$
~~~

#### Beperken tot interface

Als je wilt focussen op één interface:

~~~
$ ip a show wlp7s0
3: wlp7s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 28:3a:4d:7d:d8:05 brd ff:ff:ff:ff:ff:ff
    inet 10.25.87.235/19 brd 10.25.95.255 scope global dynamic noprefixroute wlp7s0
       valid_lft 873sec preferred_lft 873sec
    inet6 fe80::78e3:ad08:bfb0:eebd/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
~~~

### Bewerken van IP-adressen

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
10.25.95.254 dev wlp7s0 lladdr de:fa:ce:db:ab:e1 REACHABLE
$
~~~

Of de afgekorte versie:

~~~
$ ip n show
10.25.95.254 dev wlp7s0 lladdr de:fa:ce:db:ab:e1 REACHABLE
$
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
default via 10.25.95.254 dev wlp7s0 proto dhcp metric 600 
10.25.64.0/19 dev wlp7s0 proto kernel scope link src 10.25.87.235 metric 600 
169.254.0.0/16 dev virbr0 scope link metric 1000 linkdown 
172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown 
172.18.0.0/16 dev br-5c2c35c13eda proto kernel scope link src 172.18.0.1 linkdown 
192.168.122.0/24 dev virbr0 proto kernel scope link src 192.168.122.1 linkdown 
$ 
~~~

Of afgekort:

~~~
ip r list
~~~

En je kan ook de list-optie weglaten:

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
