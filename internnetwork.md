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

Om dat te kunnen doen, kun je in VirtualBox een intern netwerk (of
als alternatief een host-only network) aanmaken.

Schakel dus voor beide virtuele machines een tweede netwerkadapter in, kies **Internal Network** en geef het netwerk bij beide machines dezelfde naam **studentnet**.

Voor **studentfed**:

![](Pictures/10000000000002F600000223EF15E24ED8DEE9C5.png)

en voor **studentdeb** doe je exact hetzelfde:

![](Pictures/10000000000002FB0000022A8184213687799D55.png)

### Testen

We zien op beide virtuele machines een nieuwe NIC verschijnen.  
Op studentfed is dit enp0s8. We zien via de opdracht `ip a` dat deze niet standaard ingeschakeld wordt.

~~~
[student@fedora ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:8c:ba:ef brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 metric 1024 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 86278sec preferred_lft 86278sec
    inet6 fe80::a00:27ff:fe8c:baef/64 scope link 
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 08:00:27:1c:bf:74 brd ff:ff:ff:ff:ff:ff
~~~

Om deze op te starten, gebruik je de onderstaande opdracht:

~~~
[student@fedora ~]$ sudo ip link set enp0s8 up
[student@fedora ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:8c:ba:ef brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 metric 1024 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 86200sec preferred_lft 86200sec
    inet6 fe80::a00:27ff:fe8c:baef/64 scope link 
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:1c:bf:74 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::a00:27ff:fe1c:bf74/64 scope link 
       valid_lft forever preferred_lft forever
~~~

Merk op: op Fedora kun je standaard niet als root-gebruiker inloggen. Maar als we een opdracht laten voorafgaan door `sudo`, kunnen we die ook met rootrechten uitvoeren.

We zien dat er automatisch een link-local IPv6-adres aangemaakt wordt, dat we kunnen gebruiken om te testen.  
Aan de studentdeb-kant voeren we dezelfde procedure uit, per toeval zien we dat hier dezelfde NIC-naam wordt gekozen...

~~~
student@studentdeb:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:33:7a:d1 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 86386sec preferred_lft 86386sec
    inet6 fe80::a00:27ff:fe33:7ad1/64 scope link 
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 08:00:27:4a:c5:21 brd ff:ff:ff:ff:ff:ff
~~~

We starten deze ook op (let op: eerst inloggen als root).

~~~
root@studentdeb:~# ip link set enp0s8 up
root@studentdeb:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:33:7a:d1 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 86320sec preferred_lft 86320sec
    inet6 fe80::a00:27ff:fe33:7ad1/64 scope link 
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:4a:c5:21 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::a00:27ff:fe4a:c521/64 scope link tentative 
       valid_lft forever preferred_lft forever
~~~

We zien dat hier ook een IPv6-adres wordt gegenereerd.  
We kunnen nu op basis van deze link-local-adressen even testen:

~~~
root@studentdeb:~# ping fe80::a00:27ff:fe1c:bf74%enp0s8
PING fe80::a00:27ff:fe1c:bf74%enp0s8(fe80::a00:27ff:fe1c:bf74%enp0s8) 56 data bytes
64 bytes from fe80::a00:27ff:fe1c:bf74%enp0s8: icmp_seq=1 ttl=64 time=1.84 ms
64 bytes from fe80::a00:27ff:fe1c:bf74%enp0s8: icmp_seq=2 ttl=64 time=1.16 ms
64 bytes from fe80::a00:27ff:fe1c:bf74%enp0s8: icmp_seq=3 ttl=64 time=0.895 ms
64 bytes from fe80::a00:27ff:fe1c:bf74%enp0s8: icmp_seq=4 ttl=64 time=1.73 ms
64 bytes from fe80::a00:27ff:fe1c:bf74%enp0s8: icmp_seq=5 ttl=64 time=1.02 ms
^C
--- fe80::a00:27ff:fe1c:bf74%enp0s8 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4004ms
rtt min/avg/max/mdev = 0.895/1.327/1.843/0.384 ms
root@studentdeb:~# 
~~~

Merk op: na het link-local IPv6-adres moet je `%` en de naam van de interface plaatsen.

We testen ondertussen ook van de andere kant:

~~~
[student@fedora ~]$ ping fe80::a00:27ff:fe4a:c521%enp0s8
PING fe80::a00:27ff:fe4a:c521%enp0s8(fe80::a00:27ff:fe4a:c521%enp0s8) 56 data bytes
64 bytes from fe80::a00:27ff:fe4a:c521%enp0s8: icmp_seq=1 ttl=64 time=0.441 ms
64 bytes from fe80::a00:27ff:fe4a:c521%enp0s8: icmp_seq=2 ttl=64 time=0.568 ms
64 bytes from fe80::a00:27ff:fe4a:c521%enp0s8: icmp_seq=3 ttl=64 time=0.523 ms
64 bytes from fe80::a00:27ff:fe4a:c521%enp0s8: icmp_seq=4 ttl=64 time=0.473 ms
64 bytes from fe80::a00:27ff:fe4a:c521%enp0s8: icmp_seq=5 ttl=64 time=0.520 ms
^C
--- fe80::a00:27ff:fe4a:c521%enp0s8 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4078ms
rtt min/avg/max/mdev = 0.441/0.505/0.568/0.043 ms
[student@fedora ~]$ 
~~~

De verbinding tussen de twee virtuele machines over het interne netwerk werkt dus.
