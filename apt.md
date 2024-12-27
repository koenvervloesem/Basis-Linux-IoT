## Pakketbeheer

De opdracht `apt` dient om softwarepakketten op Debian, Ubuntu en gerelateerde Linux-distributies te installeren, bij te werken naar nieuwere versies en te verwijderen. De naam van het programma is een afkorting van Advanced Packaging Tool.

### De pakketindex bijwerken (`apt update`) 

De pakketindex van APT is in feite een database die records bevat van beschikbare pakketten uit de pakketbronnen (repository's) die voor je systeem geconfigureerd zijn.

Voer de onderstaande opdracht uit om de pakketindex bij te werken (dit kan alleen als rootgebruiker):

~~~
# apt update
~~~

Zorg dat je altijd deze pakketindex bijwerkt alvorens een upgrade of een installatie uit te voeren.

### Pakketten upgraden 

#### Pakketten upgraden (`apt upgrade`)

Het regelmatig bijwerken van je software is een belangrijk aspect van de systeembeveiliging. Als er een beveiligingsfout ontdekt is, wordt die in de software opgelost. Maar dan moet je wel de nieuwste versie installeren om van de oplossing te profiteren. Voer de volgende opdracht uit om de geïnstalleerde pakketten naar hun nieuwste versies te upgraden:

~~~
# apt upgrade
~~~

Als je één specifiek pakket wilt upgraden, geef je de pakketnaam door, bijvoorbeeld:

~~~
# apt upgrade nano
~~~

Je kunt hier ook meerdere pakketnamen opgeven, gescheiden door een spatie.

#### Volledige upgrade (`apt full-upgrade`)

Het verschil tussen een upgrade en een volledige upgrade is dat de laatste 
geïnstalleerde pakketten zal verwijderen als dat nodig is 
om het hele systeem te upgraden.

~~~
# apt full-upgrade
~~~

### Pakketten installeren (`apt install`)

Het installeren van pakketten gaat met (bijvoorbeeld voor het pakket `tree`):

~~~
# apt install tree
~~~

Als je meerdere pakketten met één opdracht wilt installeren, 
geef je ze mee met spaties gescheiden, zoals in:

~~~
# apt install tree vim
~~~

### Repository's

De pakketten die je installeert, worden vanuit een database gedownload.  
De locatie waar deze pakketten staan, noemt men een pakketbron of repository.  

Je kunt deze locaties wijzigen (of toevoegen) in het bestand `/etc/apt/sources.list`:

~~~
# cat /etc/apt/sources.list
# deb cdrom:[Debian GNU/Linux 11.0.0 _Bullseye_ - Official amd64 NETINST 20210814-10:07]/ bullseye main

#deb cdrom:[Debian GNU/Linux 11.0.0 _Bullseye_ - Official amd64 NETINST 20210814-10:07]/ bullseye main

deb http://deb.debian.org/debian/ bullseye main
deb-src http://deb.debian.org/debian/ bullseye main

deb http://security.debian.org/debian-security bullseye-security main
deb-src http://security.debian.org/debian-security bullseye-security main

# bullseye-updates, to get updates before a point release is made;
# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports
deb http://deb.debian.org/debian/ bullseye-updates main
deb-src http://deb.debian.org/debian/ bullseye-updates main

# This system was installed using small removable media
# (e.g. netinst, live or single CD). The matching "deb cdrom"
# entries were disabled at the end of the installation process.
# For information about how to configure apt package sources,
# see the sources.list(5) manual.
# 
~~~

### Lokale deb-bestanden

De pakketten die worden geïnstalleerd, hebben een specifiek bestandsformaat dat we deb noemen.  
Dit is een gecomprimeerd archiefbestand dat de programma's en bijbehorende bestanden (man-pagina's, standaard configuratiebestanden, ...) bevat om op je systeem te installeren (een beetje vergelijkbaar met een msi-bestand in Windows).

Je kunt zo'n deb-bestand ook lokaal installeren - zonder tussenkomst van een repository. Om dit te doen, gebruik je dezelfde opdracht als we al zagen, maar in plaats van de pakketnaam, geef je het absolute pad naar het deb-bestand door.  

Let op: als je geen absoluut pad gebruikt, zal de opdracht proberen om het pakket uit de APT-repository's op te halen en te installeren.

~~~
# apt install /home/student/file.deb
~~~

> Het spreekt voor zich dat je moet oppassen met het installeren van 
> deb-bestanden van een willekeurige bron, omdat deze niet gevalideerd zijn zoals degene van 
> de officiële Debian-repository's.  
> Installeer daarom alleen deb-bestanden van een vertrouwde bron...

### Pakketten verwijderen `(apt remove`)

Typ de volgende opdracht om een geïnstalleerd pakket `vim` te verwijderen:

~~~
# apt remove vim
~~~

Je kunt ook meerdere pakketten aanduiden, gescheiden door spaties:

~~~
# apt remove vim tree
~~~

De opdracht `apt remove` zal de gegeven pakketten verwijderen, maar zal configuratiebestanden ongemoeid laten.  
Als je het pakket volledig - inclusief alle configuratiebestanden - wilt verwijderen, gebruik dan `apt purge`:

~~~
# apt purge vim
~~~


### Verwijderen van ongebruikte pakketten (`apt autoremove`)

Telkens wanneer je een nieuw pakket op het systeem installeert, kan het zijn dat dit afhangt van andere pakketten. Die afhankelijkheden (*dependencies*) worden dan ook geïnstalleerd.  

Maar wanneer je het pakket daarna verwijdert, blijven de afhankelijkheden op het systeem.  
Deze overgebleven pakketten worden misschien door niets anders meer gebruikt 
en zijn dus eigenlijk overbodig.

Als je deze wilt verwijderen, gebruik dan de volgende opdracht 
om geïnstalleerde afhankelijkheden die niet meer nodig zijn te verwijderen:

~~~
# apt autoremove
~~~

### Tonen van pakketten (`apt list`)

Gebruik de volgende opdracht om alle beschikbare pakketten weer te geven:

~~~
# apt list
ad-data-common/stable 0.0.23.1-1.1 all
0ad-data/stable 0.0.23.1-1.1 all
0ad/stable 0.0.23.1-5+b1 amd64
0install-core/stable 2.16-1 amd64
0install/stable 2.16-1 amd64
0xffff/stable 0.9-1 amd64
2048-qt/stable 0.1.6-2+b2 amd64
2048/stable 0.20210105.1243-1 amd64
2ping/stable 4.5-1 all
2to3/stable 3.9.2-3 all
2vcard/stable 0.6-4 all
3270-common/stable 4.0ga12-3 amd64
389-ds-base-dev/stable 1.4.4.11-2 amd64
389-ds-base-libs/stable 1.4.4.11-2 amd64
389-ds-base/stable 1.4.4.11-2 amd64
389-ds/stable 1.4.4.11-2 all
3dchess/stable 0.8.1-20 amd64
3depict/stable 0.0.22-2+b4 amd64
4g8/stable 1.0-3.3 amd64
4pane/stable 7.0-1 amd64
4ti2-doc/stable 1.6.9+ds-2 all
4ti2/stable 1.6.9+ds-2 amd64
64tass/stable 1.55.2200-1 amd64
6tunnel/stable 1:0.13-2 amd64
7kaa-data/stable 2.15.4p1+dfsg-1 all
7kaa/stable 2.15.4p1+dfsg-1 amd64
...
~~~

Dit toont dus een lijst van alle pakketten die je kunt installeren, inclusief informatie over de versies en architectuur van het pakket.  
Om erachter te komen of een specifiek pakket geïnstalleerd is, kun je de uitvoer filteren met de opdracht `grep`.

~~~
# apt list | grep guake
guake-indicator/stable 1.4.5-1 amd64
guake/stable,now 3.6.3-2 all [installed]
# 
~~~

Je ziet dan of het pakket geïnstalleerd is of niet doordat er `[installed]` achter staat.

Om alleen de geïnstalleerde pakketten weer te geven, typ je:

~~~
# apt list --installed
accountsservice/focal-updates,focal-security,now 0.6.55-0ubuntu12~20.04.5 amd64 [installed]
acl/focal,now 2.2.53-6 amd64 [installed]
acpi-support/focal,now 0.143 amd64 [installed]
acpid/focal,now 1:2.0.32-1ubuntu1 amd64 [installed]
adb/focal,now 1:8.1.0+r23-5ubuntu2 amd64 [installed]
add-apt-key/focal,focal,now 1.0-0.5 all [installed]
adduser/focal,focal,now 3.118ubuntu2 all [installed]
adwaita-icon-theme-full/focal-updates,focal-updates,now 3.36.1-2ubuntu0.20.04.2 all [installed]
adwaita-icon-theme/focal-updates,focal-updates,now 3.36.1-2ubuntu0.20.04.2 all [installed]
aglfn/focal,focal,now 1.7+git20191031.4036a9c-2 all [installed]
alsa-base/focal,focal,now 1.0.25+dfsg-0ubuntu5 all [installed]
alsa-topology-conf/focal,focal,now 1.2.2-1 all [installed]
alsa-ucm-conf/focal-updates,focal-updates,now 1.2.2-1ubuntu0.13 all [installed]
alsa-utils/focal-updates,now 1.2.2-1ubuntu2.1 amd64 [installed]
amd64-microcode/focal,now 3.20191218.1ubuntu1 amd64 [installed]
anacron/focal,now 2.3-29 amd64 [installed]
android-libadb/focal,now 1:8.1.0+r23-5ubuntu2 amd64 [installed,automatic]
android-libbase/focal,now 1:8.1.0+r23-5ubuntu2 amd64 [installed,automatic]
android-libboringssl/focal,now 8.1.0+r23-2build1 amd64 [installed,automatic]
...
~~~

Als je de lijst van pakketten wilt zien die je naar een nieuwere versie kunt bijwerken, gebruik dan de volgende opdracht:

~~~
# apt list --upgradeable
Listing...
chromium/ulyssa 108.0.5359.124~linuxmint1+una amd64 [upgradable from: 108.0.5359.98~linuxmint1+una]
firefox-locale-en/ulyssa 108.0.1+linuxmint1+una amd64 [upgradable from: 108.0+linuxmint1+una]
firefox/ulyssa 108.0.1+linuxmint1+una amd64 [upgradable from: 108.0+linuxmint1+una]
libodbc1/bullseye 2.3.7 amd64 [upgradable from: 2.3.6-0.1build1]
...
~~~

### Pakketten zoeken (`apt search`)

Met deze opdracht kun je zoeken naar een bepaald pakket:

~~~
# apt search guake
Sorting... Done
Full Text Search... Done
guake/stable,now 3.6.3-2 all [installed]
  Drop-down terminal for GNOME Desktop Environment

guake-indicator/stable 1.4.5-1 amd64
  Guake terminal app indicator

terminus/stable 1.13.0-1 amd64
  Drop-down or in-window terminal for X11 and Wayland
~~~

De opdracht toont dan de pakketten waarvan de naam overeenkomt met de zoekterm.

### Pakketinformatie opvragen (`apt show`)

Als je meer informatie wilt over een pakket, zoals de afhankelijkheden, de installatiegrootte, de pakketbron, ... dan kan de opdracht `apt show` nuttig zijn voordat je een nieuw pakket 
verwijdert of installeert:

~~~
# apt show guake
Package: guake
Version: 3.6.3-2
Priority: optional
Section: x11
Maintainer: Daniel Echeverry <epsilon@debian.org>
Installed-Size: 2,103 kB
Depends: python3-pbr, python3-cairo, python3-gi (>= 3.26.1), python3-dbus (>= 1.2.4), gir1.2-notify-0.7 (>= 0.7.7), gir1.2-vte-2.91 (>= 0.50.2), gir1.2-gtk-3.0 (>= 3.22.26), gir1.2-keybinder-3.0 (>= 0.3.2), gir1.2-glib-2.0 (>= 1.54.1), gir1.2-pango-1.0 (>= 1.40.14), gir1.2-wnck-3.0, libglib2.0-bin, libutempter0, dconf-gsettings-backend | gsettings-backend, python3:any
Suggests: numix-gtk-theme
Homepage: http://guake-project.org
Tag: interface::graphical, interface::x11, role::program, suite::gnome,
 uitoolkit::gtk, x11::application, x11::terminal
Download-Size: 841 kB
APT-Manual-Installed: yes
APT-Sources: http://deb.debian.org/debian bullseye/main amd64 Packages
Description: Drop-down terminal for GNOME Desktop Environment
 Guake is a drop-down terminal for GNOME Desktop Environment, so you just
 need to press a key to invoke him, and press again to hide.
 Guake supports hotkeys, tabs, background transparent, etc.
#
~~~
