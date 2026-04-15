## Tekst en zoeken

Zoals we al zagen, zijn veel Linux-programma's op de commandline tekstgebaseerd. Dat is een krachtige en flexibele aanpak. In dit deel bespreken we enkele handige opdrachten die van deze eigenschap gebruikmaken.

### echo en redirection

We zagen al dat we met `echo` een tekst kunnen tonen. In combinatie met _redirection_ kunnen we zo eenvoudig een specifieke tekst in een tekstbestand plaatsen of eraan toevoegen:

~~~
bvo@lol-owi-01:~$ echo "greetings from linux" > testt
bvo@lol-owi-01:~$ echo "hello world" >> testt
bvo@lol-owi-01:~$ echo "hello mars" >> testt
bvo@lol-owi-01:~$ cat testt 
greetings from linux
hello world
hello mars
bvo@lol-owi-01:~$ 
~~~

Als je meerdere regels wilt toevoegen aan een bestand, hoeft dat niet met een `echo`-opdracht per regel. Met de optie `-e` interpreteert `echo` immers een backslash met een teken erachter als een _escape character_. Met `\n` voeg je zo een _newline character_ toe. Bijvoorbeeld:

~~~
bvo@lol-owi-01:~$ echo -e "a\na\nd\na\n" > aaa
bvo@lol-owi-01:~$ cat aaa
a
a
d
a
bvo@lol-owi-01:~$ 
~~~

### Zoeken naar bestanden en opdrachten

Er bestaan enkele nuttige opdrachten om op je Linux-systeem te zoeken naar specifieke bestanden of opdrachten.

#### find

Met `find` zoek je naar bestanden op basis van hun naam. Het basispatroon is:

~~~
find <path> -name <name or pattern>
~~~

Stel dat ik een bestand zoek

* met een exacte naam (in dit geval `app_permission_item_money.xml`)
* in de directory `/home/bvo/Android/Sdk` (inclusief subdirectory's)

dan doe je dit als volgt:

~~~
bvo@lol-owi-01:/$ find /home/bvo/Android/Sdk/ -name "app_permission_item_money.xml"
/home/bvo/Android/Sdk/platforms/android-23/data/res/layout/app_permission_item_money.xml
/home/bvo/Android/Sdk/platforms/android-30/data/res/layout/app_permission_item_money.xml
bvo@lol-owi-01:/$ 
~~~

Zoals je hierboven ziet, toont `find` het volledige pad van elk gevonden bestand met die naam.

De gevraagde naam kan ook een patroon zijn. Zo kun je wildcards als de `*` (voor een willekeurig teken) gebruiken in de naam:

~~~
bvo@lol-owi-01:/$ find /home/bvo/Android/Sdk/ -name "app*item*xml"
/home/bvo/Android/Sdk/platforms/android-23/data/res/layout/app_permission_item_money.xml
/home/bvo/Android/Sdk/platforms/android-23/data/res/layout/app_permission_item.xml
/home/bvo/Android/Sdk/platforms/android-23/data/res/layout/app_permission_item_old.xml
/home/bvo/Android/Sdk/platforms/android-30/data/res/layout/app_permission_item_money.xml
/home/bvo/Android/Sdk/platforms/android-30/data/res/layout/app_permission_item.xml
/home/bvo/Android/Sdk/platforms/android-30/data/res/layout/app_permission_item_old.xml
bvo@lol-owi-01:/$ 
~~~

Als je het zoekpad weglaat, dan zal `find` in de huidige directory beginnen zoeken. Bovenstaande opdracht kon je dus ook als volgt uitvoeren:

~~~
bvo@lol-owi-01:/$ cd /home/bvo/Android/Sdk/
bvo@lol-owi-01:~/Android/Sdk$ find -name "app*item*xml"
./platforms/android-23/data/res/layout/app_permission_item_money.xml
./platforms/android-23/data/res/layout/app_permission_item.xml
./platforms/android-23/data/res/layout/app_permission_item_old.xml
./platforms/android-30/data/res/layout/app_permission_item_money.xml
./platforms/android-30/data/res/layout/app_permission_item.xml
./platforms/android-30/data/res/layout/app_permission_item_old.xml
bvo@lol-owi-01:~/Android/Sdk$ 
~~~

Je kunt de resultaten ook beperken tot een bepaald type. Stel dat je bijvoorbeeld alle directory's wilt zoeken met de naam `layout`:

~~~
bvo@lol-owi-01:/$ find /home/bvo/Android/Sdk/ -type d -name layout
/home/bvo/Android/Sdk/sources/android-23/android/widget/layout
/home/bvo/Android/Sdk/sources/android-23/com/android/test/layout
/home/bvo/Android/Sdk/sources/android-30/com/android/layout
/home/bvo/Android/Sdk/platforms/android-23/data/res/layout
/home/bvo/Android/Sdk/platforms/android-30/data/res/layout
bvo@lol-owi-01:/$ 
~~~

Bekijk zeker de man-pagina van `find` eens, want de mogelijkheden van dit programma zijn heel uitgebreid.

#### which

Met de opdracht `which` kun je een programma zoeken dat op je systeem is geinstalleerd. Je krijgt dan het pad te zien:

~~~
bvo@lol-owi-01:~$ which tmux
/usr/bin/tmux
bvo@lol-owi-01:~$ 
~~~

Het programma `which` zoekt daarvoor in alle paden van de omgevingsvariabele `PATH`. Is het gevraagde programma daarin niet te vinden, dan toont `which` geen uitvoer. De exitcode (te vinden met `echo $?`) is dan bovendien 1.

#### whereis

Het programma `whereis` vindt niet alleen het gevraagde programma, maar ook eventuele geïnstalleerde broncode en man-pagina's hiervoor:

~~~
bvo@lol-owi-01:~$ whereis tmux
tmux: /usr/bin/tmux /usr/share/man/man1/tmux.1.gz
bvo@lol-owi-01:~$ 
~~~

### Zoeken naar tekst met grep

Omdat zoveel informatie op een Linux-systeem in tekstbestanden is opgeslagen, kun je hier eenvoudig in zoeken. Het programma `grep` biedt hiervoor krachtige mogelijkheden.

We maken ter illustratie een bestand aan met wat regels tekst in:

~~~
bvo@lol-owi-01:~$ echo "greetings from linux" > testt
bvo@lol-owi-01:~$ echo "hello world" >> testt
bvo@lol-owi-01:~$ echo "hello mars" >> testt
bvo@lol-owi-01:~$ cat testt 
greetings from linux
hello world
hello mars
bvo@lol-owi-01:~$ 
~~~

Nu kun je hierin zoeken naar een tekst die je als eerste argument aan `grep` doorgeeft, met als tweede argument het bestand waarin je zoekt. Je krijgt als resultaat alle regels in het bestand waarin de tekst voorkomt:

~~~
bvo@lol-owi-01:~$ grep hello testt
hello world
hello mars
bvo@lol-owi-01:~$ grep linux testt
greetings from linux
bvo@lol-owi-01:~$ 
~~~

Met de optie `--color` wordt de gevonden zoekterm in een kleur getoond.

We hebben nu zoekwoorden gebruikt, maar eigenlijk gebruikt grep _reguliere expressies_. Dit zijn patronen zodat je tekst van een specifieke vorm kunt zoeken. Zo zoek je bijvoorbeeld eenvoudig naar alle gebruikersnamen in `/etc/passwd` die beginnen met een underscore:

```
$ grep "^_" /etc/passwd
_apt:x:42:65534::/nonexistent:/usr/sbin/nologin
```

Er bestaan verschillende 'dialecten' van reguliere expressies. Vaak gebruik je de _extended_ reguliere expressies. Dan gebruik je `egrep`. Bijvoorbeeld om alle gebruikers te vinden die een user id hebben van exact vier cijfers:

```
$ egrep "[^0-9][0-9]{4}[^0-9]" /etc/passwd
koan:x:1000:1000:Koen Vervloesem,,,:/home/koan:/bin/bash
```

Wil je letterlijk naar een zoekterm zoeken en die niet als reguliere expressie interpreteren, gebruik dan `fgrep`. Je kunt met grep ook recursief alle bestanden onder een gegeven directory doorzoeken. Dat doe je met `rgrep`.

### Tekst bekijken

We zagen al dat je met `cat` de inhoud van een bestand kunt bekijken. Er zijn nog enkele manieren.

#### tail/head

Met `tail` bekijk je de laatste X regels van een bestand of invoer voor het programma:

~~~
bvo@lol-owi-01:~$ history | tail -10
 1989  echo "hello world" > testt
 1990  echo "hello mars" > testt
 1991  grep hello test
 1992  grep hello testt
 1993  echo "greetings from linux" > testt
 1994  echo "hello world" >> testt
 1995  echo "hello mars" >> testt
 1996  grep hello testt
 1997  grep linux testt
 1998  history | tail -10
bvo@lol-owi-01:~$ 
~~~

Om de eerste X regels te bekijken, gebruik je `head`.

#### less

Als een programma veel uitvoer geeft, kun je die _pipen_ naar `less`. Dat opent dan een _pager_ waardoor je met de pijltjestoetsen of PgUp/PgDown kunt scrollen. Met **q** verlaat je het programma.

### Tekstmanipulate

Er zijn ook nog enkele handige programma's om tekst te manipuleren.

#### uniq

Met het programma `uniq` verwijder je opeenvolgende dubbele regels:

~~~
bvo@lol-owi-01:~$ echo -e "a\na\nd\na" | uniq
a
d
a
bvo@lol-owi-01:~$ 
~~~

#### sort

Met `sort` sorteer je de regels in een bestand of tekstinvoer alfabetisch:

~~~
bvo@lol-owi-01:~$ echo -e "a\na\nd\na\n" | sort | uniq

a
d
bvo@lol-owi-01:~$ 
~~~
