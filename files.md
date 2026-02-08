## Werken met een shell (Bash)

### De command line in Linux

Een **command line** of opdrachtregel is een **tekstgeoriënteerde interface** die kan worden gebruikt om **diverse taken** binnen een **besturingssysteem uit te voeren**.  

De **command line voor Linux** wordt geleverd door een toepassing die we de **shell** noemen.

Op je Linux-systeem zal de shell je toelaten om allerlei soorten beheertaken uit te voeren:

* **bestanden** en **mappen** bewerken
* je besturingssysteem **configureren**
* **programma's opstarten**
* met een **netwerk** interageren
* taken **automatiseren**
* ...

Dit is niet uniek voor Linux; in Windows heb je als command line CMD of PowerShell.  

Een groot deel van de activiteiten die we gaan uitvoeren in Linux vereisen een goede kennis van de shell. Het is dus belangrijk om deze goed onder de knie te krijgen. En dat is waarmee we in dit hoofdstuk zullen starten...

### Bash

De standaard shell voor gebruikers in Debian (maar ook veel andere Linux-distributies) is de **GNU Bourne-Again Shell** of afgekort **Bash**.  

#### Bash-shell openen

Van zodra je in onze virtuele machine met Debian ingelogd bent, zit je in de shell Bash. Als je Linux met een grafische gebruikersinterface draait, kom je niet onmiddellijk in de shell, maar moet je eerst een **terminalemulator** openen.

In Debian met Xfce kan dat via het menu **Applications** door op het onderdeel **Terminal Emulator** te klikken:

![](Pictures/debian_open_terminal.png)

Vervolgens krijg je een terminalvenster (ook console genoemd) waarin je opdrachten kunt uitvoeren:

![](Pictures/bash_terminal.png)

Of je nu via een grafische terminalemulator werkt of rechtstreeks, maakt niet uit: de shell werkt hetzelfde.

Via de console spreken we van een **shell-sessie** (of in dit geval een Bash-sessie om precies te zijn). We gaan hier de shell als gebruiker **interactief** gebruiken (later gaan we deze ook niet-interactief gebruiken via een script). In deze sessie wacht de shell op opdrachten die je intypt. De shell voert een ingetypte opdracht uit zodra je op Enter drukt. De shell zal vervolgens wachten tot de opdracht (of job) voltooid is (tenzij je de opdracht als achtergrondtaak uitvoert). Je krijgt de uitvoer van de job te zien, en daarna kun je weer een opdracht intypen.

#### Shell-prompt

Als je de console start, verschijnt er een stuk tekst dat er ongeveer zo moet uitzien:  

~~~bash
student@studentdeb:~ $
~~~

Dit is wat we noemen de **prompt** (shell prompt of gebruikersprompt). Deze:

* geeft aan welke **gebruiker** ingelogd is (student) op welke **machine** (studentdeb)
* geeft aan wat het huidige **pad** - of **werkdirectory** - is (`~` komt overeen met de home-directory van de gebruiker)
* geeft je de mogelijkheid om een **opdracht** in te typen

Het dollarteken (`$`) aan het einde geeft aan waar de prompt eindigt. Het is ook het signaal dat je opdrachten kunt invoeren.

### Opdrachten in de shell

De prompt geeft aan dat je opdrachten kunt invoeren. Laten we starten met een aantal keren op de **Enter-toets** te duwen:

~~~
student@studentdeb:~$ 
student@studentdeb:~$ 
student@studentdeb:~$ 
~~~

Als je **niets typt** na de prompt en op Enter drukt, dan gebeurt er niets. Je krijgt gewoon een **nieuwe prompt** onder de oude prompt.

Je kunt nu ook een opdracht typen, gevolgd door Enter. Bijvoorbeeld:

~~~
student@studentdeb:~$ clear
~~~

De opdracht `clear` maakt het scherm helemaal leeg en toont helemaal bovenaan een nieuwe prompt:

~~~
student@studentdeb:~$ 
~~~

Hetzelfde kun je bereiken via de toetsencombinatie **Ctrl+L**.

#### Argumenten

Een opdracht is telkens een **programma** dat wordt uitgevoerd, zelfs het eenvoudige programma `clear` dat we zonet hebben gebruikt.

Aan veel van deze programma's kun je een **argument** toevoegen.  
Laten we dit direct illustreren via een tweede opdracht, `echo`:

~~~
student@studentdeb:~$ echo

student@studentdeb:~$ echo hello
hello
student@studentdeb:~$ 
~~~

Deze opdracht heeft als functie om een stuk tekst te tonen op de console.

Het stuk tekst dat je wilt tonen, voeg je als argument toe achter de opdracht.

Een argument volgt direct op de opdracht, dus in de volgende vorm:

~~~
[command] [arguments]
~~~

Je kunt ook meer dan één argument aan een opdracht doorgeven.
Dat zullen we later nog zien bij andere opdrachten...

#### Opties

Naast argumenten kun je ook nog extra **opties** meegeven.  
Dit zijn extra opties (meestal niet verplicht) om het gedrag van een opdracht te beïnvloeden.  
Deze opties zijn meestal **voorafgegaan** door een **streepje** (`-` of ook *hyphen* genoemd).  

Bijvoorbeeld: de opdracht `echo` zal de meegegeven tekst tonen, maar daarna ook onmiddellijk naar een nieuwe regel gaan. Je kunt dit gedrag wijzigen (geen nieuwe regel tonen) door de optie `-n` toe te voegen:

~~~
student@studentdeb:~$ echo -n hello
hellostudent@studentdeb:~$ 
~~~

Deze toont dus nog altijd de tekst, maar in tegenstelling tot hieronder (zonder optie) zal deze **geen nieuwe regel** tonen:

~~~
student@studentdeb:~$ echo hello
hello
student@studentdeb:~$ 
~~~

#### Vorm van Linux-opdrachten

De meeste Linux-programma's gebruiken de volgende vorm:

~~~
[command] [options] [arguments]
~~~

Na de naam van de opdracht volgen dan één of meerder opties (telkens voorafgegaan door een streepje) en dan pas op het einde gevolgd door argumenten.  

Deze opties zijn meestal afkortingen en bestaan uit (meestal) één letter na het streepje, zoals in het voorbeeld van `-n`.  
Zo'n korte optie noemen we een **short option**.

#### Short en long options

Soms heb je zowel een short option als een **long option**.  
Zo'n long option wordt voorafgegaan door twee streepjes (`--` of double hyphen)

Bijvoorbeeld bij de opdracht `ls` waarmee je de inhoud van een directory bekijkt heb je een optie `--all` waarmee je ook verborgen bestanden te zien krijgt.

De `--all` is hier een leesbaardere long option.

~~~
student@studentdeb:~$ ls --all
.  ..  .bash_logout  .bashrc  .profile
~~~

De bijbehorende short option `-a` doet overigens exact hetzelfde...

~~~
student@studentdeb:~$ ls -a
.  ..  .bash_logout  .bashrc  .profile
~~~

Vergelijk dit met gewoon `ls`, dat niet alle bestanden toont:

~~~
student@studentdeb:~$ ls
student@studentdeb:~$
~~~

In dit geval geeft `ls` geen enkele uitvoer. Na de installatie bevat de home-directory van de gebruiker immers geen enkele bestanden, behalve de 'verborgen' bestanden waarvan de naam met een punt begint.

### Sneller werken in de shell 

Binnen de Bash-shell heb je een aantal hulpmiddelen die je leven gemakkelijker maken.

#### Terugkeren in de geschiedenis

Een eerste hulpmiddel is dat een shell de geschiedenis van je opdrachten onthoudt.  

Om opdrachten te hergebruiken - die je eerder had ingevoerd - kun je de **pijltjestoetsen** intypen om eerder ingevoerde opdrachten opnieuw op te vragen.

Stel dat je twee opdrachten na elkaar uitvoert:

* `ls -a` => Toon de inhoud van de home-directory
* `echo hello` => Toon 'hello' 

Dan krijg je volgend resultaat:

~~~
student@studentdeb:~$ ls -a
.  ..  .bash_logout  .bashrc  .profile
student@studentdeb:~$ echo hello
hello
student@studentdeb:~$
~~~

Als je vervolgens het pijltje omhoog van je toetsenbord indrukt, toont de shell de meest recente opdracht opnieuw na de prompt.

~~~
student@studentdeb:~$ ls -a
.  ..  .bash_logout  .bashrc  .profile
student@studentdeb:~$ echo hello
hello
student@studentdeb:~$ echo hello
~~~

Als je een tweede keer op het pijltje omhoog drukt, krijg je de opdracht `ls -a`.  

~~~
student@studentdeb:~$ ls -a
.  ..  .bash_logout  .bashrc  .profile
student@studentdeb:~$ echo hello
hello
student@studentdeb:~$ ls -a 
~~~

Als je dan vervolgens op de Enter-toets drukt, wordt die opdracht `ls -a` uitgevoerd.

~~~
student@studentdeb:~$ ls -a
.  ..  .bash_logout  .bashrc  .profile
student@studentdeb:~$ echo hello
hello
student@studentdeb:~$ ls -a 
.  ..  .bash_logout  .bashrc  .profile
~~~

#### Tab completion

Als je een letter intypt en dan twee keer op de Tab-toets drukt, krijg je een lijst van opdrachten die met die letter beginnen:

~~~
student@studentdeb:~$ e
echo                   encguess               exfalso
edit                   enchant-2              exit
editor                 enchant-lsmod-2        exo-desktop-item-edit
editres                env                    exo-open
egrep                  envsubst               expand
eject                  eqn                    expiry
elif                   esac                   export
else                   eval                   expr
enable                 ex                     
enc2xs                 exec                   
student@studentdeb:~$ ec 
~~~

Als je dan vervolgens een c (na de e) typt:

~~~
...                 
student@studentdeb:~$ ec
~~~

En opnieuw op Tab tikt, dan zal de Bash-shell dit aanvullen tot:

~~~
...                 
student@studentdeb:~$ echo
~~~

`echo` is immers de enige herkende opdracht die met `ec` begint. Op deze manier hoef je niet volledige opdrachten in te typen.

#### Programma beëindigen met Ctrl+C

Soms kan het zijn dat je een opdracht intypt die niet uit zichzelf zal stoppen (bedoeld of onbedoeld).

Stel dat je de volgende opdracht typt:

~~~
$ cat /dev/random
... heel wat rommel op je schermt...
$
~~~

Dit zal heel wat rommel op je console afdrukken (en zal niet uit zichzelf stoppen).

Als je nu **Ctrl+C** typt, beëindig je dit programma en krijg je weer de beschikking over de shell.

Deze toetsencombinatie zal een **interrupt-signaal** doorsturen naar de applicatie en er voor zorgen dat deze wordt afgesloten.

Opmerking: als je niet meer ziet wat je intypt, typ dan `reset` in en druk op Enter.

#### Shell afsluiten met Ctrl+D (of exit)

Als je de shellsessie wilt afsluiten, kun je dit doen met de opdracht `exit` of de toetsencombinatie **Ctrl+D**. Je kunt dan een nieuwe shellsessie openen door weer in te loggen met je gebruikersnaam en wachtwoord.

### Bestanden en directory's

Net zoals de meeste besturingssystemen heeft Linux twee belangrijke elementen om informatie bij te houden en te structureren:

* Bestanden (*files*)
* Mappen (*directories*)

#### Geen C-schijf...

De structuur van een Linux-bestandssysteem (*file system*) verschilt wel enigszins van wat de meesten gewoon zijn onder Windows.  

Linux heeft geen **fysieke schijf** (zoals de C-schijf) aan de basis van het bestandssysteem.  
In plaats daarvan wordt er een **logisch bestandssysteem** gebruikt.  

Helemaal bovenaan de structuur staat **/**. Men noemt dit meestal de **root van het bestandssysteem** (niet te verwarren met de root-gebruiker).  

Onder deze root bevinden zich een hele hoop directory's en bestanden, hiërarchisch geordend (een beetje zoals een boomstructuur):

~~~
/ ──+
    ├── bin
    ├── boot
    ├── dev
    ├── etc
    └── home
          └── student
    ├── media
    ├── mnt
    ├── opt
    ├── proc
    ├── root
    ├── run
    ├── sbin
    ├── srv
    ├── sys
    ├── tmp
    └── usr
        ├── bin
        ├── include
        ├── lib
        ├── local
        └── sbin
    └── var
~~~

Direct onder deze root-directory bevinden zich een aantal systeemdirectory's.  
Deze bevatten software, bibliotheken, scripts, configuratiebestanden, ...

* **/etc/** => **configuraties** van het systeem
* **/boot/** => **kernel** en andere **opstartbestanden**
* **/run/** => **data** in verband met **processen**, geopende bestanden, ...
* **/usr/** => geïnstalleerde **software**, toepassingen, bibliotheken
* **/root/** => **home**-directory voor de **superuser** (niet binnen /home/)
* **/tmp/** => **tijdelijke bestanden** (wordt regelmatig opgekuist)
* **/var/** => variabele data die wel opgeslagen moeten blijven
* **/bin/** en **/sbin** => **programma's** 
* **/dev/** => bevat speciale **apparaatbestanden** om met hardware te communiceren
* ...

Als je in detail wilt weten waar elke van deze directory's voor wordt gebruikt, kun je gebruikmaken van de opdracht `man hier`.

#### Paden

Zoals eerder vermeld is de directory **/** of **root** de **hoofddirectory** bovenaan de **hiërarchie** van het bestandssysteem.  

Dit teken **/** wordt ook gebruikt als scheidingsteken in een pad (*file path*).  
Dit pad gebruik je om naar een bestand in de hiërarchie te verwijzen.  

Bijvoorbeeld het pad naar de directory /home/student geeft aan dat:

* **student** een subdirectory is van **home**
* **home** een subdirectory is van de **root**-directory

Dit ziet er in een boomstructuur als volgt uit:

~~~
  / 
  └── home
        └── student
~~~

Onder deze verschillende **directory's** kun je dan bestanden plaatsen.  
Naar deze bestanden kun je dan gemakkelijk verwijzen via een pad. Bijvoorbeeld het bestand .profile in de directory /home/student (dat we eerder bekeken hebben met de opdracht `ls -a`) heeft het pad /home/student/.profile.

#### Werkdirectory

Als je een interactieve shell of command line opent, start deze in een specifieke directory, namelijk de home-directory van de gebruiker.  
Je kunt opvragen in welke directory je exact aan het werken bent via de opdracht `pwd` ofwel "**pr**int **w**orking **d**irectory":

~~~
student@studentdeb:~$ pwd
/home/student
student@studentdeb:~$ 
~~~

#### Een directory aanmaken

We kunnen nu een nieuwe directory aanmaken. Dat kan met de opdracht `mkdir` met als argument de naam van de directory. Bijvoorbeeld:

~~~
student@studentdeb:~$ mkdir data
student@studentdeb:~$ ls
data
student@studentdeb:~$ 
~~~

We maken hier een directory aan met de opdracht `mkdir` gevolgd door het pad `data`.

Zonder argumenten kun je maar één niveau van directory aanmaken. Stel dat je bijvoorbeeld het volgende wilt aanmaken, dan gaat dit niet zomaar:

~~~
student@studentdeb:~$ mkdir hello/world
mkdir: cannot create directory ‘hello/world’: No such file or directory
~~~

Als je echter de optie `-p` meegeeft zullen de *parent directories* (`hello` in dit geval) mee worden aangemaakt als deze nog niet bestaan:

~~~
student@studentdeb:~$ mkdir -p hello/world
student@studentdeb:~$ ls
data  hello
student@studentdeb:~$ ls hello
world
student@studentdeb:~$ 
~~~

Je ziet hier dat we aan de opdracht `ls` als argument een directorynaam kunnen doorgeven om de inhoud van die directory te bekijken in plaats van de inhoud van de huidige directory.

#### Navigeren met cd

Hoewel we nu directory's aangemaakt hebben, blijft onze werkdirectory hetzelfde. We kunnen die wijzigen met de opdracht `cd` ofwel "**c**hange **d**irectory.

~~~
student@studentdeb:~$ cd hello
student@studentdeb:~/hello$ pwd
/home/student/hello
student@studentdeb:~/hello$ ls
world
~~~

Je ziet hier dat de prompt ook verandert nadat we van werkdirectory veranderd zijn: in plaats van `~` staat er nu `~/hello`. Als je dus niet meer weet wat je werkdirectory is, kun je altijd naar je prompt kijken.

Merk op dat `ls` nu de inhoud van je directory `hello` toont: je werkdirectory is immers veranderd.

##### Superdirectory

Als je naar een hogere directory (of de **superdirectory**) wilt navigeren, gebruik dan `..` als naam.

~~~
student@studentdeb:~/hello$ cd ..
student@studentdeb:~$ pwd
/home/student
student@studentdeb:~$ ls
data  hello
~~~

Je kunt ook **meerdere niveaus** naar boven verwijzen:

~~~
student@studentdeb:~$ cd ../..
student@studentdeb:/$ pwd
/
student@studentdeb:/$
~~~

Merk op: `~` in de prompt is nu vervangen door `/`, de rootdirectory.

##### Vorige directory

Een handig hulpmiddel bij `cd` is de **combinatie** met een **hyphen** (streepje).  
Als je de volgende opdracht uitvoert...

~~~
student@studentdeb:/$ cd -
/home/student
student@studentdeb:~$ 
~~~

...keer je terug naar de **vorige werkdirectory** die je gebruikte in je shell-sessie.

#### Een leeg bestand aanmaken via `touch`

We kunnen nu directory's aanmaken en van werkdirectory veranderen. We kunnen ook nieuwe bestanden aanmaken. Een leeg bestand maak je aan met de opdracht `touch` en als argument de naam van het bestand:

~~~
student@studentdeb:~$ touch sensors.json
student@studentdeb:~$ ls
data  hello  sensors.json
student@studentdeb:~$ 
~~~

Als je in een andere directory een bestand wilt aanmaken, geef je het pad naar dat bestand op:

~~~
student@studentdeb:~$ touch data/README.txt
student@studentdeb:~$ ls data/
README.txt
student@studentdeb:~$
~~~

#### Meer informatie tonen met ls

We zagen al de opdracht `ls` om de inhoud van een directory weer te geven. Zonder argumenten wordt de inhoud van de werkdirectory (huidige directory) getoond. Als je de inhoud van een specifieke directory wilt tonen, dan geef je deze als argument op. Merk op: ook voor namen van bestanden en directory's werkt tab completion, wat heel wat typen (en typefouten) uitspaart.

Als je meer details te weten wilt komen, gebruik dan de optie `-l`:

~~~
student@studentdeb:~$ ls -l
total 8
drwxr-xr-x 2 student student 4096 Sep 14 20:22 data
drwxr-xr-x 3 student student 4096 Sep 14 20:23 hello
-rw-r--r-- 1 student student    0 Sep 14 20:36 sensors.json
~~~

Dit toont meer volledige info zoals:

* type van item
  * **d** staat voor directory
  * **\-** voor een gewoon bestand
* permissies (zie later)
* gebruiker en groep (zie later)
* grootte
* tijd van laatste aanpassing
* ...

Een aantal andere opties van `ls` die handig kunnen zijn:

* `-S`: sorteer op bestandsgrootte
* `-t`: sorteer op tijd
* `-r`: draai de volgorde om (van het sorteren)
* `-R`: recursief, geef ook de inhoud van subdirectory's weer
* `-a`: geef ook verborgen bestanden weer (die beginnen met een punt)
* `-d`: geef bij directory's niet de inhoud ervan weer, maar slechts de directorynaam zelf
* `-h`: geef de groottes niet in bytes aan maar in 'menselijke' ('human') termen, zoals kilobytes (K), megabytes (M), ...

Als je meerdere opties tegelijk wilt gebruiken, hoef je niet telkens de `-` te herhalen, maar kun je de opties achter elkaar plakken. Zo hoef je niet `ls -l -a -h` te typen, maar volstaat `ls -lah`.

#### HOME-directory

/home/student/ is de **home-directory**, net zoals je onder Windows een home-directory `C:\Users\student` zou hebben.  

Als je een shell-sessie opent, kom je automatisch terecht in deze home-directory.  
Als je van een andere werkdirectory weer naar je home-directory wilt terugkeren, gebruik dan `cd` zonder argument. Dat werkt ongeacht in welke directory je je bevindt.

~~~
student@studentdeb:~/data$ pwd
/home/student/data
student@studentdeb:~/data$ cd
student@studentdeb:~$ pwd
/home/student
student@studentdeb:~$ 
~~~

Er zijn nog twee andere manieren om naar de home-directory te verwijzen:

* De omgevingsvariabele `$HOME`
* Een tilde of `~`

Deze kun je bijvoorbeeld gebruiken om de lijst van bestanden te tonen in je home-directory wanneer je je in een andere werkdirectory bevindt:

~~~
student@studentdeb:~/hello$ ls
world
student@studentdeb:~/hello$ ls ~
data  hello  sensors.json
student@studentdeb:~/hello$ 
~~~

#### Relatieve en absolute paden

Aan `mkdir`, `cd` en `ls` geef je als argument een pad mee. Zo'n pad is de verwijzing naar een (doel)directory waarop je de opdracht wilt uitvoeren.  

Je kunt een onderscheid maken op basis van de manier waarop je een pad construeert:

* **absoluut** is een pad dat start vanaf de root-directory. Dit pad start namelijk vanaf de schijf waarnaar je wilt verwijzen.

~~~
student@studentdeb:~$ cd /home/student/hello/world/
student@studentdeb:~/hello/world$ pwd
/home/student/hello/world
student@studentdeb:~/hello/world$ 
~~~

* **relatief** is een pad relatief ten opzichte van je huidige directory.

~~~
student@studentdeb:~/hello/world$ cd
student@studentdeb:~$ cd hello/world/
student@studentdeb:~/hello/world$ pwd
/home/student/hello/world
student@studentdeb:~/hello/world$ 
~~~

Het symbool `..` (twee punten na elkaar) kun je ook gebruiken in deze relatieve paden:

~~~
student@studentdeb:~/hello/world$ cd ../../data/
student@studentdeb:~/data$ pwd
/home/student/data
~~~

Of het teken `~`: 

~~~
student@studentdeb:~/data$ cd ~/hello/
student@studentdeb:~/hello$ pwd
/home/student/hello
~~~

#### Directory's en bestanden verwijderen

Een directory verwijderen doe je met de opdracht `rmdir`.  
Deze directory mag wel geen bestanden of directory's bevatten. Anders breekt de opdracht af met een foutmelding:

~~~
student@studentdeb:~/hello$ cd 
student@studentdeb:~$ rmdir hello
rmdir: failed to remove 'hello': Directory not empty
~~~

Als je een niet-lege directory wil verwijderen, dien je dus eerst de bestanden of directory's erin te verwijderen. 

Omdat de directory `hello` nog een (lege) directory `world` bevat, verwijder je dus eerst die laatste directory, waarna je de eerste (die dan leeg is) wel kunt verwijderen:

~~~
student@studentdeb:~$ rmdir hello/world/
student@studentdeb:~$ rmdir hello/
student@studentdeb:~$ ls
data  sensors.json 
student@studentdeb:~$
~~~

Als een directory bestanden bevat, kun je die verwijderen met de opdracht `rm` en dan het pad:
 
~~~
student@studentdeb:~$ rm data/README.txt
student@studentdeb:~$ ls data/
student@studentdeb:~$
~~~

Zodra de directory leeg is, kun je deze wel verwijderen via de opdracht `rmdir`:

~~~
student@studentdeb:~$ rmdir data
student@studentdeb:~$ ls
sensors.json
student@studentdeb:~$
~~~

#### Bestanden kopiëren 

Je kunt ook een bestand kopiëren met de opdracht `cp` ofwel "**c**o**p**y". Het eerste argument is het bestand dat je wilt kopiëren, het tweede argument de plaats waarnaar je dit bestand wilt kopiëren:

~~~bash
student@studentdeb:~$ cp sensors.json sensors2.json 
student@studentdeb:~$ ls -l
total 0 
-rw-r--r-- 1 student student    0 Sep 14 20:54 sensors2.json
-rw-r--r-- 1 student student    0 Sep 14 20:36 sensors.json
~~~

Het bestand `sensors2.json` is nu een exacte kopie van `sensors.json`.

Als je als tweede argument een directory opgeeft, kopieer je het bestand naar die directory. Bijvoorbeeld:

~~~bash
student@studentdeb:~$ mkdir data 
student@studentdeb:~$ cp sensors.json data/ 
student@studentdeb:~$ ls data/ 
sensors.json
student@studentdeb:~$
~~~

#### Directory kopiëren

Met `cp` kun je ook een directory kopiëren, maar dan moet je de optie `-r` (voor recursief) toevoegen:

~~~bash
student@studentdeb:~$ cp -r data/ data2
student@studentdeb:~$ ls data
sensors.json 
student@studentdeb:~$ ls data2
sensors.json 
~~~

#### Bestanden en directory's verplaatsen

Om een bestand of directory te verplaatsen naar een directory, gebruik je de opdracht `mv` ofwel **m**o**v**e:

~~~
student@studentdeb:~$ mkdir hello  
student@studentdeb:~$ mv data hello/
student@studentdeb:~$ ls
data2  hello  sensors2.json  sensors.json
student@studentdeb:~$ ls hello/
data
~~~

De directory `data` bevindt zich nu niet meer in de home-directory, maar in de directory `hello`.

#### Naam van een bestand wijzigen

Dezelfde opdracht `mv` kun je ook gebruiken om van een bestand of directory de naam te veranderen.

~~~
student@studentdeb:~$ mv sensors2.json sensors-prev.json
student@studentdeb:~$ ls
data2  hello  sensors.json  sensors-prev.json
student@studentdeb:~$ mv data2 data
student@studentdeb:~$ ls
data  hello  sensors.json  sensors-prev.json
student@studentdeb:~$
~~~
