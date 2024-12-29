## Extra netwerk tussen twee virtuele machines aanmaken

Beide virtuele machines kregen standaard één netwerkadapter (NIC) om te
verbinden met de buitenwereld.

Zoals je hieronder ziet, wordt hiervoor een NAT-adapter voorzien zodat er door VirtualBox:

* privé-adressen worden uitgedeeld aan de virtuele machines
* aan Network Address Translation (NAT) wordt gedaan net zoals het in een klassieke (IPv4-)situatie gebeurt

![](Pictures/10000000000002FC0000022611049BCBEBC4B966.png)

### Intern netwerk

De bedoeling is nu echter dat we onze twee virtuele machines met elkaar laten
communiceren via een intern netwerk.

Om dat te kunnen doen, kun je in VirtualBox een intern netwerk (of als alternatief een host-only network) aanmaken.

Schakel dus voor beide virtuele machines een tweede netwerkadapter in (in het tabbled **Adapter 2**, maar dit kun je alleen als de virtuele machine uitgeschakeld is), kies **Internal Network** en geef het netwerk bij beide machines dezelfde naam **studentnet**.

### Testen

Start beide virtuele machines op. Je ziet op beide via de opdracht `ip a` een nieuwe NIC verschijnen, `enp0s8`. Je ziet ook dat die standaard niet ingeschakeld wordt: de status staat op **DOWN** en er wordt geen IP-adres toegekend.

~~~
student@studentdeb:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:6a:b3:73 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 86347sec preferred_lft 86347sec
    inet6 fd00::a00:27ff:fe6a:b373/64 scope global dynamic mngtmpaddr 
       valid_lft 86348sec preferred_lft 14348sec
    inet6 fe80::a00:27ff:fe6a:b373/64 scope link 
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 08:00:27:ce:94:12 brd ff:ff:ff:ff:ff:ff
~~~

Om deze op te starten, gebruik je de onderstaande opdracht:

~~~
student@studentdeb:~$ sudo ip link set enp0s8 up
student@studentdeb:~$ ip a show enp0s8
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:ce:94:12 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::a00:27ff:fece:9412/64 scope link 
       valid_lft forever preferred_lft forever
~~~

We zien dat er automatisch een link-local IPv6-adres aangemaakt wordt, dat we kunnen gebruiken om te testen.  

Op de andere virtuele machine voer je dezelfde test uit en schakel je de interface ook in.

We zien dat hier ook een IPv6-adres wordt gegenereerd.  
We kunnen nu op basis van deze link-local-adressen testen of de machines elkaar kunnen bereiken:

~~~
student@studentdeb:~$ ping fe80::a00:27ff:fece:9412%enp0s8
PING fe80::a00:27ff:fece:9412%enp0s8(fe80::a00:27ff:fece:9412%enp0s8) 56 data bytes
64 bytes from fe80::a00:27ff:fece:9412%enp0s8: icmp_seq=1 ttl=64 time=0.046 ms
64 bytes from fe80::a00:27ff:fece:9412%enp0s8: icmp_seq=2 ttl=64 time=0.080 ms
64 bytes from fe80::a00:27ff:fece:9412%enp0s8: icmp_seq=3 ttl=64 time=0.087 ms
64 bytes from fe80::a00:27ff:fece:9412%enp0s8: icmp_seq=4 ttl=64 time=0.060 ms
64 bytes from fe80::a00:27ff:fece:9412%enp0s8: icmp_seq=5 ttl=64 time=0.079 ms
^C
--- fe80::a00:27ff:fece:9412%enp0s8 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4093ms
rtt min/avg/max/mdev = 0.046/0.070/0.087/0.015 ms
~~~

Merk op: na het link-local IPv6-adres moet je `%` en de naam van de interface plaatsen.

Druk op Ctrl+C om het pingen te beëindigen.

Test hetzelfde ook van de andere kant. De verbinding tussen de twee virtuele machines over het interne netwerk werkt dus.
