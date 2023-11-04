## Links en aliassen

Twee handige tools binnen Linux-systeem zijn links en aliassen. Je kunt beide beschouwen als een soort *shortcuts*, één op het niveau van bestanden, het andere op het niveau van opdrachten. 

### Alias

Als Linux-gebruiker moet je vaak een specifieke opdracht keer op keer gebruiken.  
Zeker als dit opdrachten met lange opties zijn, kan dit je productiviteit aantasten.

Om dit te verhelpen, bestaat het concept van een **alias**.  
Je kunt jezelf heel wat tijd besparen door aliassen te maken voor een aantal van je meest gebruikte opdrachten.  

#### Aliassen bekijken

De kans is groot dat je al aliassen gebruikt op je Linux-systeem, omdat die al in een standaardconfiguratie aangemaakt zijn.  
Je kunt alle (reeds bestaande) aliassen die in je shell-sessie geladen zijn via de opdracht `alias` opvragen:

~~~
[student@fedora ~]$ alias
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'
[student@fedora ~]$ 
~~~

Kijk bijvoorbeeld naar de volgende regel:

~~~
alias ll='ls -l --color=auto'
~~~

Die regel wil zeggen dat het systeem een alias `ll` kent, die gedefinieerd is als `ls -l --color=auto`. Als je dus `ll` intypt in je shell, voert die in de plaats `ls -l --color=auto` uit.

#### Opdrachten herdefiniëren met een alias

Zoals je ziet, zijn er al een deel aliassen geladen.  
Ook bijzonder om te zien is dat een aantal opdrachten worden geherdefinieerd door middel van een alias omdat die dezelfde naam heeft als de opdracht zelf.

Zo wordt in veel systemen de opdracht `ls` overschreven om automatisch kleuren te tonen:

~~~
alias ls='ls --color=auto' 
~~~

Elke keer dat je dus `ls` intypt in de shell, voert die in feite `ls --color=auto` uit. En als je `ls -l` intypt, voert je shell eigenlijk `ls --color=auto -l` uit.

#### Zelf aliassen aanmaken

Als je zelf een alias wilt aanmaken, kan dat door de opdracht `alias` te laten volgen door de combinatie "naam=opdracht", zoals je hieronder ziet:

~~~
[student@fedora ~]$ alias lll="ls -lrt"
[student@fedora ~]$ lll
totaal 0
drwxr-xr-x. 1 student student 0 22 apr 09:01 "Video's"
drwxr-xr-x. 1 student student 0 22 apr 09:01  Sjablonen
drwxr-xr-x. 1 student student 0 22 apr 09:01  Openbaar
drwxr-xr-x. 1 student student 0 22 apr 09:01  Muziek
drwxr-xr-x. 1 student student 0 22 apr 09:01  Downloads
drwxr-xr-x. 1 student student 0 22 apr 09:01  Documenten
drwxr-xr-x. 1 student student 0 22 apr 09:01  Bureaublad
drwxr-xr-x. 1 student student 0 22 apr 09:01  Afbeeldingen
~~~

We voegden hierboven dus de alias `lll` toe die `ls` uitvoert met de opties l (long format), r (reverse) en t (sorteren op tijd). Het resultaat is dat de inhoud van de directory wordt gesorteerd op tijd in omgekeerde volgorde. Je kunt dit testen door een nieuw bestand aan te maken, dat dan onderaan de lijst wordt getoond:

~~~
[student@fedora ~]$ touch test.txt
[student@fedora ~]$ lll
totaal 4
drwxr-xr-x. 1 student student  0 22 apr 09:01 "Video's"
drwxr-xr-x. 1 student student  0 22 apr 09:01  Sjablonen
drwxr-xr-x. 1 student student  0 22 apr 09:01  Openbaar
drwxr-xr-x. 1 student student  0 22 apr 09:01  Muziek
drwxr-xr-x. 1 student student  0 22 apr 09:01  Downloads
drwxr-xr-x. 1 student student  0 22 apr 09:01  Documenten
drwxr-xr-x. 1 student student  0 22 apr 09:01  Bureaublad
drwxr-xr-x. 1 student student  0 22 apr 09:01  Afbeeldingen
-rw-r--r--. 1 student student  0 16 mei 18:58  test.txt
[student@fedora ~]$ 
~~~

Je ziet ook dat de alias `lll` toegevoegd is aan de lijst met aliassen:

~~~
[student@fedora ~]$ alias
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias lll='ls -lrt'
alias ls='ls --color=auto'
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'
[student@fedora ~]$ 
~~~

#### Een alias ontwijken

Zoals we zagen, herdefiniëren vele aliassen bestaande opdrachten, vaak door er opties aan toe te voegen. Maat wat als je de originele opdracht wilt uitvoeren, zonder rekening te houden met die alias? Dat kan door er een backslash (`\`) voor te zetten.

Stel dat je de volgende alias aanmaakt...

~~~
[student@fedora ~]$ echo -n test
test[student@fedora ~]$ alias echo="echo -n"
[student@fedora ~]$ echo test
test[student@fedora ~]$
~~~

... die ervoor zorgt dat de uitvoer van de opdracht `echo` niet naar een nieuwe regel gaat.  
Als je de originele opdracht `echo` wilt gebruiken die wel naar een nieuwe regel gaat, zonder deze alias te verwijderen, plaats je gewoon een backslash voor `echo`:

~~~
test[student@fedora ~]$ \echo test
test
[student@fedora ~]$ 
~~~

#### Een alias verwijderen

Als je een alias niet meer wilt gebruiken, kun je die verwijderen met de opdracht `unalias`.

We zien hieronder de alias voor `echo`:

~~~
[student@fedora ~]$ alias
alias echo='echo -n'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias lll='ls -lrt'
alias ls='ls --color=auto'
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'
[student@fedora ~]$
~~~

We verwijderen de alias met:

~~~
[student@fedora ~]$ unalias echo 
[student@fedora ~]$
~~~

Je ziet vervolgens dat de alias voor `echo` verdwenen is:

~~~
[student@fedora ~]$ alias
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias lll='ls -lrt'
alias ls='ls --color=auto'
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'
[student@fedora ~]$
~~~

Je ziet ook dat de opdracht `echo` zich weer standaard gedraagt:

~~~
[student@fedora ~]$ echo test
test
[student@fedora ~]$ 
~~~

#### Aliassen behouden tussen sessies (`~/.bashrc`)

Als je een alias aanmaakt binnen een Bash-sessie, zal die verdwenen zijn in een nieuwe Bash-sessie.  
Om die alias tussen sessies te behouden, dien je ze toe te voegen aan het einde van het bestand `~/.bashrc` (waar je ook andere definities van aliassen zult vinden).

Het bestand `~/.bashrc` is een (Bash-)script dat door Bash wordt uitgevoerd wanneer je Bash interactief opstart door een terminalsessie te openen.  
Het doel van dit script is om je sessie te initialiseren met zaken zoals:

* omgevingsvariabelen (waaronder `$PATH`)
* de prompt
* aliassen

De home-directory van elke gebruiker met Bash als shell zal een bestand `.bashrc` bevatten.  

Op een Debian-systeem zien de eerste twintig regels van dit bestand er als volgt uit:

~~~bash
student@studentdeb:~$ head -20 ~/.bashrc 
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
student@studentdeb:~$ 
~~~

En op een Fedora-systeem, een andere Linux-distributie:

~~~bash
[student@fedora ~]$ head -20 ~/.bashrc 
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
[student@fedora ~]$ 
~~~

Zoals je ziet, zijn dit gewoon Bash-scripts die allerlei opdrachten uitvoeren.

### Links aanmaken

Linux heeft net zoals Windows een concept van (snel)koppelingen naar bestanden.  
We noemen dit **links**, en je kunt het programma `ln` gebruiken om deze aan te maken.

In Linux hebben we twee varianten: **soft links** en **hard links**.

#### Soft links

Laten we starten bij de soft links.  
Een **soft link** (of **symbolic link**) kun je beschouwen als een andere naam (eventueel op een andere locatie) voor een bestand of directory.

We demonstreren dit via:

* het aanmaken van een bestand "hello.txt"
* een soft link met de naam "world.txt"

~~~
bart@bvlegion:~/Tmp$ echo "test" > hello.txt
bart@bvlegion:~/Tmp$ ln -s hello.txt world.txt
~~~

We gebruiken hiervoor de opdracht `ln` met de optie `-s` die ervoor zorgt dat dit een soft link wordt.  
Bekijk nu deze twee bestanden met `ls -l`:

~~~
bart@bvlegion:~/Tmp$ ls -l *txt
-rw-rw-r-- 1 bart bart 5 May 16 21:28 hello.txt
lrwxrwxrwx 1 bart bart 9 May 16 21:28 world.txt -> hello.txt
~~~

We observeren hier twee kenmerken van de symbolic link:

* het type is `l` in plaats van `-`
* na de naam van de link volgt een pijltje (`->`) en dan de naam van het bestand waarnaar wordt gelinkt

We kunnen nu de symbolic link gebruiken als was dit het originele bestand:

~~~
bart@bvlegion:~/Tmp$ cat world.txt 
test
bart@bvlegion:~/Tmp$ 
~~~

#### inodes en links...

Vooraleer we het verschil tussen soft links en hard links uitleggen, moeten we een nieuw concept introduceren: **inodes**.

Een inode is eigenlijk een afkorting voor **index node** en is een gegevensstructuur in een Linux-bestandssysteem. Die gegevensstructuur beschrijft een bestand of een map.  

Elke inode slaat de locaties op de schijf op van het bestand of de map, samen met eigenschappen zoals het tijdstip van de laatste wijziging, de eigenaar en groep, de permissies, ... Elke inode heeft ook een unieke index, een getal. Dat kun je opvragen met de optie `-i` bij `ls`. Voor ons voorbeeld geeft dit:

~~~
bart@bvlegion:~/Tmp$ ls -li *txt
21367519 -rw-rw-r-- 1 bart bart 5 May 16 21:28 hello.txt
21369308 lrwxrwxrwx 1 bart bart 9 May 16 21:28 world.txt -> hello.txt
bart@bvlegion:~/Tmp$ 
~~~

Je ziet hier twee verschillende inodes:

* Het oorspronkelijke bestand is inode 21367519
* De soft link heeft inode 21369308

Zoals je ziet heeft de soft link een andere inode dan het originele bestand. Je zou dit als volgt kunnen voorstellen:

~~~
+--------------+--------------+-----+--------------+
| FILESYSTEM:  |   world.txt  |     |  hello.txt   |
+-----------------------------+     +--------------+
| INODE:       |   21367519   |     |   21369308   |
+-----------------------------+     +--------------+
               |=> /home/bart/|     |              |
               |  hello.txt   +---->+    test      |
               |              |     |              |
               +--------------+     +--------------+

~~~

De soft link en het bestand waarnaar de link verwijst, staan dus op twee verschillende locaties.

Als je het originele bestand verwijdert, zal de soft link blijven bestaan:

~~~
bart@bvlegion:~/Tmp$ rm hello.txt
bart@bvlegion:~/Tmp$ ls -li *txt
21369308 lrwxrwxrwx 1 bart bart 9 May 16 21:28 world.txt -> hello.txt
~~~

Maar je krijgt vanzelfsprekend een foutmelding als je deze soft link probeert te gebruiken:

~~~
bart@bvlegion:~/Tmp$ cat world.txt 
cat: world.txt: No such file or directory
bart@bvlegion:~/Tmp$ 
~~~

#### Hard links

Een ander type link is de **hard link**.

Verwijder de bestanden en maak het originele bestand opnieuw aan. We maken nu ook een nieuwe link aan, maar zonder de optie `-s` bij `ln`. Zo maken we een hard link aan:

~~~
bart@bvlegion:~/Tmp$ rm *txt
bart@bvlegion:~/Tmp$ echo "test" > hello.txt
bart@bvlegion:~/Tmp$ ln hello.txt world.txt
bart@bvlegion:~/Tmp$ cat world.txt 
test
~~~

Bekijk nu de inodes van beide bestanden:

~~~
bart@bvlegion:~/Tmp$ ls -li *txt
21367519 -rw-rw-r-- 2 bart bart 5 May 16 21:32 hello.txt
21367519 -rw-rw-r-- 2 bart bart 5 May 16 21:32 world.txt
~~~

Je ziet dat beide bestanden hetzelfde inode hebben. Je maakt dus twee namen voor hetzelfde bestand, oftewel twee verwijzingen naar dezelfde locatie:

~~~
+---------------------------+-------------+
| FILESYSTEEM: | world.txt  |  hello.txt  |
+---------------------------+-------------+
| INODE:       |        21367519          |
+-----------------------------------------+
               |                          |
               |        test              |
               |                          |
               +--------------------------+
~~~

Eigenlijk is elk bestand dat je op het bestandssysteem aanmaakt een hard link, of je het nu aanmaakt met de opdracht `ln`, via `touch` of `nano`. Maar als je met `ln` een hard link aanmaakt, creëer je gewoon een extra naam die naar de locatie van het bestand verwijst.

Als je nu het oorspronkelijk bestand (hello.txt) verwijdert, wordt de eigenlijke inode (bestand) niet verwijderd, aangezien er nog naar verwezen wordt door world.txt:

~~~
bart@bvlegion:~/Tmp$ rm hello.txt 
bart@bvlegion:~/Tmp$ ls -li *txt
21367519 -rw-rw-r-- 1 bart bart 5 May 16 21:32 world.txt
bart@bvlegion:~/Tmp$ cat world.txt 
test
bart@bvlegion:~/Tmp$ 
~~~

#### Hard link of soft link gebruiken?

De volgende vraag die je jezelf zou kunnen stellen, is: wanneer moet je een hard link gebruiken en wanneer een soft link?

Over het algemeen zijn soft links flexibeler:

* Een soft link is niet gebonden aan een bestandssysteem, terwijl je geen hard links kunt aanmaken tussen twee verschillende bestandssystemen.
* Een soft link is gemakkelijker terug te vinden: je hoeft maar te kijken naar de `l` bij het bestandstype in de uitvoer van `ls -l`, en je ziet er onmiddellijk naar welk origineel bestand de link verwijst.

Maar daarentegen zijn er toch wat problemen met soft links:

* Als je het originele bestand verwijdert, blijft er een ongeldige soft link over  
  (en moet je deze afzonderlijk verwijderen)
* Niet alle software werkt correct met soft links (soms omwille van beveiligingsregels)

Ook zal een hard link performanter zijn vergeleken met een soft link.  
De relevantie hangt natuurlijk af van waarvoor je de links gebruikt. Als je voor één bestand een link moet uitlezen, zal dit weinig of geen verschil maken. Maar als je een paar honderdduizend links achter elkaar uitleest, wordt het wel relevanter hoe snel dit gaat...

