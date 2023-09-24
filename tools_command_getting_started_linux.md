## Werken met een shell (Bash)

### De command line in Linux

Een **command line** of opdrachtregel is een **tekstgeoriënteerde interface** die kan worden gebruikt om **diverse taken** binnen een **besturingssysteem uit te voeren**.  

De **command line voor Linux** wordt geleverd door een **toepassing** die we de **shell** noemen.

Op je Linux-systeem zal de shell je toelaten om alle soorten beheertaken uit te voeren:

* **Bestanden** en **mappen** bewerken
* Je besturingssysteem **configureren**
* **Programma's opstarten**
* Met een **netwerk** interageren
* Taken **automatiseren**
* ...

> *Nota*  
> In Windows heb je als command-line-toepassing CMD of PowerShell.  

Een groot deel van de activiteiten die we gaan uitvoeren in Linux vereisen een goede kennis van de shell.  

Het is dus belangrijk om deze goed onder de knie te krijgen. En dat is waarmee we in dit hoofdstuk zullen starten...

### Bash

De standaard shell voor gebruikers in Debian (maar ook veel andere Linux-distributies) is de **GNU Bourne-Again Shell** of afgekort **Bash**.  

Bash is een **verbeterde versie** van een van de meest succesvolle shells die wordt gebruikt op UNIX-achtige systemen, de **Bourne Shell** (sh).

#### Bash-shell openen

Laten we **van start gaan**...
Om een shell te openen vanuit een GUI bestaan er binnen Linux diverse **terminalprogramma's** of **terminalemulators**.  

Om deze te openen binnen onze Linux-distributie (Debian met Xfce) kies je binnen het menu **Applications** het onderdeel **Terminal Emulator**:

![](Pictures/debian_open_terminal.png)

Vervolgens krijg je een terminalvenster (ook console genoemd) waarin je **opdrachten kan uitvoeren**.

![](Pictures/bash_terminal.png)

#### Shell-sessie

Via de console gaan we de **shell** als gebruiker **interactief** gebruiken (later gaan we deze ook niet-interactief gebruiken via een script).

Nu deze console is geopend, spreken we van een **shell-sessie** (of in dit geval een Bash-sessie om precies te zijn).  
In deze sessie wacht de shell op opdrachten die je intypt. De shell voert een ingetypte opdracht uit zodra je op **Enter** drukt.

De shell zal vervolgens wachten tot de opdracht (of job) voltooid is (tenzij je de opdracht als achtergrondtaak uitvoert). Je krijgt de uitvoer van de job te zien.

De volgende taak zal bijvoorbeeld de inhoud van je huidige werkdirectory tonen:

~~~
student@studentdeb:~$ ls
Desktop  Documents  Downloads  Music  Pictures  Public  Templates  Videos
student@studentdeb:~$
~~~

#### Shell-prompt

Als je de **console** start, verschijnt er een een stuk **tekst** dat er ongeveer zo moet uitzien:  

~~~bash
student@studentdeb:~ $
~~~

> *Nota:*  
> Deze console kan verschillen tussen verschillende Linux-distributies.  


Dit is wat we noemen de **prompt** (shell prompt of gebruikersprompt). Deze:

* geeft aan welke **gebruiker** ingelogd is (bart)
* geeft aan wat het huidige **pad** - of **werkdirectory** - is (`~` komt overeen met de home-directory van de gebruiker)
* geeft je de mogelijkheid om een **opdracht** in te typen

Het dollarteken (`$`) aan het einde geeft aan waar de prompt eindigt. Het is ook het signaal dat je opdrachten kan invoeren.

> *Nota:*  
> Naast deze **gebruikersprompt** gaan we verderop in de cursus nog zien dat er ook nog een **superuser-prompt** is. Deze eindigt met een `#` in plaats van een `$`. Ze wordt gebruikt wanneer je wijzigingen aan het systeem wil aanbrengen met root-toegang (we komen hier weldra nog op terug).

### Opdrachten in de shell

Deze prompt geeft aan dat je opdrachten kan invoeren. Laten we starten met een aantal keren op de **Enter-toets** te duwen:

~~~
student@studentdeb:~$ 
student@studentdeb:~$ 
student@studentdeb:~$ 
~~~

Als je **niets typt** na de prompt en op Enter drukt, dan gebeurt er niets. Je krijgt gewoon een **nieuwe prompt** onder de oude prompt.

Als je terug **één prompt wil zien**, typ dan de opdracht `clear` in (gevolgd door een Enter):

~~~
student@studentdeb:~$ 
student@studentdeb:~$ 
student@studentdeb:~$ clear
~~~

Vervolgens zie je weer één gebruikersprompt...

~~~
student@studentdeb:~$ 
~~~

Hetzelfde kan je bereiken via de toetsencombinatie **Ctrl+L**.

#### Argumenten

Zo'n opdracht is telkens een **programma** dat wordt **uitgevoerd**, zelfs het eenvoudige programma `clear` dat we zonet hebben gebruikt.

Veel van deze programma's hebben echter een **argument** nodig.  
Laten we dit direct illustreren via een tweede opdracht, `echo`:

~~~
student@studentdeb:~$ echo hello
hello
student@studentdeb:~$ 
~~~

Deze opdracht heeft als functie om een stuk **tekst** te tonen op de **console**.  

Het stuk tekst dat je wil tonen kan je dan 
gewoon aan dit programma meegeven als **argument**.

Een **argument** volgt direct op de opdracht, dus in de volgende vorm:

~~~
[command] [arguments]
~~~

Zoals hierboven aangegeven, kan het zijn dat je meer dan één argument meegeeft aan een opdracht.  
Dat zullen we later nog zien bij andere opdrachten...

#### Opties

Naast argumenten kan je ook nog extra **opties** meegeven.  
Dit zijn extra opties (meestal niet verplicht) om het gedrag van een opdracht te **beïnvloeden**.  
Deze opties zijn meestal **voorafgegaan** door een **streepje** (`-` of ook *hyphen* genoemd).  

Bijvoorbeeld: de opdracht `echo` zal de meegegeven tekst tonen, maar daarna ook onmiddellijk naar een nieuwe regel gaan. Je kan dit gedrag wijzigen (geen nieuwe regel tonen) door de optie `-n` toe te voegen:

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

De meeste Linux-programma's gebruiken dan ook de volgende vorm:

~~~
[command] [options] [arguments]
~~~

Na de naam van de opdracht volgen dan één of meerder opties (telkens voorafgegaan door een streepje) en dan pas op het einde gevolgd door argumenten.  

Deze opties zijn meestal afkortingen en bestaan uit (meestal) één na het streepje, zoals in het voorbeeld van `-n`.  
Zo'n korte optie noemen we een **short option**.

#### Short en long options

Soms heb je zowel een short option als een **long option**.  
Zo'n long option wordt voorafgegaan door twee streepjes (`--` of double hyphen)

Bijvoorbeeld bij de opdracht `ls` waarmee je de inhoud van een directory bekijkt (zie ook eerder) heb je een optie `--all` waarmee je ook verborgen bestanden te zien krijgt.

De `--all` is hier een leesbaardere long option.

~~~
student@studentdeb:~$ ls --all
.              .mozilla
..             Music
.bash_history  Pictures
.bash_logout   .profile
.bashrc        Public
.cache         Templates
.config        .vboxclient-clipboard.pid
Desktop        .vboxclient-display-svga-x11.pid
.dmrc          .vboxclient-draganddrop.pid
Documents      .vboxclient-seamless.pid
Downloads      Videos
.gnupg         .Xauthority
.ICEauthority  .xsession-errors
.lesshst       .xsession-errors.old
.local
~~~

De bijbehorende short option `-a` doet overigens exact hetzelfde...

~~~
student@studentdeb:~$ ls -a
.              .mozilla
..             Music
.bash_history  Pictures
.bash_logout   .profile
.bashrc        Public
.cache         Templates
.config        .vboxclient-clipboard.pid
Desktop        .vboxclient-display-svga-x11.pid
.dmrc          .vboxclient-draganddrop.pid
Documents      .vboxclient-seamless.pid
Downloads      Videos
.gnupg         .Xauthority
.ICEauthority  .xsession-errors
.lesshst       .xsession-errors.old
.local

~~~

### Sneller werken in de shell 

Binnen de Bash-shell heb je een aantal hulpmiddelen die je leven gemakkelijker maken.

#### Terugkeren in de geschiedenis

Een eerste hulpmiddel is dat een shell de geschiedenis van je opdrachten onthoudt.  

Om opdrachten te hergebruiken - die je eerder had ingevoerd - kan je de **pijltjestoetsen** intypen om eerder ingevoerde opdrachten opnieuw op te vragen.

Stel dat je twee opdrachten na elkaar uitvoert:

* `ls` => Tonen van de inhoud van de home-directory
* `cd Desktop` => Navigeren naar de Desktop-directory

Dan krijg je volgend resultaat:

~~~
student@studentdeb:~$ ls
Desktop  Documents  Downloads  Music  Pictures  Public  Templates  Videos
student@studentdeb:~$ cd Desktop/
student@studentdeb:~/Destop$
~~~

Als je vervolgens het pijltje omhoog van je toetsenbord indrukt, toont de shell de meest recente opdracht opnieuw na de prompt.

~~~
student@studentdeb:~$ ls
Desktop  Documents  Downloads  Music  Pictures  Public  Templates  Videos
student@studentdeb:~$ cd Desktop/
student@studentdeb:~/Desktop$ cd Desktop/
~~~

Als je een tweede keer op het pijltje omhoog drukt, krijg je de opdracht `ls`.  

~~~
student@studentdeb:~$ ls
Desktop  Documents  Downloads  Music  Pictures  Public  Templates  Videos
student@studentdeb:~$ cd Desktop/
student@studentdeb:~/Desktop$ ls
~~~

Als je dan vervolgens op de Enter-toets drukt, wordt die opdracht `ls` uitgevoerd.

~~~
student@studentdeb:~$ ls
Desktop  Documents  Downloads  Music  Pictures  Public  Templates  Videos
student@studentdeb:~$ cd Desktop/
student@studentdeb:~/Desktop$ ls
student@studentdeb:~/Desktop$ 
~~~

#### Tab completion

Als je een letter intypt en dan twee keer op de Tab-toets drukt, krijg je een lijst van opdrachten die met die letter beginnen:

~~~
student@studentdeb:~/Desktop$ e
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
student@studentdeb:~/Desktop$ ec 
~~~

Als je dan vervolgens een c (na de e) typt:

~~~
...                 
student@studentdeb:~/Desktop$ ec
~~~

En opnieuw op Tab tikt, dan zal de Bash-shell dit aanvullen tot:

~~~
...                 
student@studentdeb:~/Desktop$ echo
~~~

`echo` is immers de enige herkende opdracht die met `ec` begint. Op deze manier hoef je niet volledige opdrachten in te typen.

#### Programma beëindigen met Ctrl+C

Soms kan het zijn dat je een opdracht intypt die niet uit zichzelf zal stoppen (bedoeld of onbedoeld).

Stel bijvoorbeeld dat je de volgende opdracht typt:

~~~
$ cat /dev/random
... heel wat rommel op je schermt...
$
~~~

Dit zal heel wat rommel op je console afdrukken (en zal niet uit zichzelf stoppen).

Als je echter **Ctrl+C** typt, beëindig je dit programma en krijg je weer de beschikking over de shell.

Deze toetsencombinatie zal een **interrupt-signaal** doorsturen naar de applicatie en er voor zorgen dat deze wordt afgesloten.

> *Nota*:  
> Hoewel dit zal werken voor de meeste programma's,
> kan een programma dit interrupt-signaal opvangen
> (en dus negeren).  
> In dat geval zijn er nog andere manieren om een 
> job af te sluiten.  
> We komen hier in het gedeelte rond jobs en processen nog 
> op terug.

#### Shell afsluiten met Ctrl+D (of exit)

Als je de shellsessie wil afsluiten, kan je dit doen met de opdracht `exit` of de toetsencombinatie **Ctrl+D**. 

### Bestanden en directory's

Net zoals de meeste besturingssystemen heeft Linux twee belangrijke elementen om informatie bij te houden en te structureren:

* Bestanden (*files*)
* Mappen (*directories*)

#### Geen C-schijf...

De structuur van een Linux-bestandssysteem (*file system*) verschilt wel enigszins van wat de meesten gewoon zijn onder Windows.  

Linux heeft geen **fysieke schijf** (zoals de C-schijf) aan de basis van het bestandssysteem.  
In plaats daarvan wordt er een **logisch bestandssysteem** gebruikt.  

![](Pictures/roothierachy.png)

Helemaal bovenaan de structuur staat **/**. Men noemt dit meestal de **root van het bestandssysteem** (niet te verwarren met de root-gebruiker).  

#### Linux File Hierarchy

Onder deze root bevinden zich een hele hoop directory's en bestanden, hiërarchisch geordend (een beetje zoals een boomstructuur):

~~~
/ ──+
    ├── bin -> usr/bin (link)
    ├── boot
    ├── dev
    ├── etc
    └── home
          └── student
          └── bart
    ├── media
    ├── mnt
    ├── opt
    ├── proc
    ├── root
    ├── run
    ├── sbin -> usr/sbin (link)
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
* **/bin/** en **/sbin** => verwijzingen naar gelijknamige directory's binnen /usr
* **/dev/** => bevat speciale **apparaatbestanden** gebruikt om met hardware te communiceren
* ...

Als je in detail wil weten waar elke van deze directory's voor wordt gebruikt, kan je gebruikmaken van de opdracht `man hier`.

#### Paden

Zoals eerder vermeld is de directory **/** of **root** de **hoofddirectory** bovenaan de **hiërarchie** van het bestandssysteem.  

Dit teken **/** wordt ook gebruikt als scheidingsteken in een pad (*file path*).  
Dit pad gebruik je om naar een bestand in de hiërarchie te verwijzen.  

Bijvoorbeeld het pad naar de directory /home/student/Desktop geeft aan dat:

* **Desktop** een **subdirectory** is van **student**
* **student** van **home**
* **home** van de **root**-directory

Dit ziet er in een boomstructuur als volgt uit:

~~~
  / 
  └── home
        ├── bart
        └── student
              └── Desktop
~~~

Onder deze verschillende **directory's** kan je dan bestanden plaatsen.  
Deze bestanden kan je dan gemakkelijk terugvinden en **adresseren** via een pad.

We breiden bovenstaand voorbeeld uit door bestanden te plaatsen onder deze directoriy's.
Als je bijvoorbeeld het bestand sensors.json wil gebruiken...

~~~
  / 
  └── home
        ├── bart
        └── student
              ├── hello.csv
              ├── test.xml
              └── data
                    └── sensors.json
~~~

... kan dat via het pad **/home/student/data/sensors.json**

Dit is wat we noemen een **absoluut pad**, een adressering vanaf de root-directory.  
Naast een absoluut pad bestaat er ook nog een relatief pad, daar komen we zo dadelijk nog op terug. 

#### Werkdirectory

We starten met het aanmaken van een **directory** waarin we bestanden kunnen plaatsen.  
We starten vanuit de volgende hiërarchie die automatisch zou moeten zijn aangemaakt na de installatie:

> *Nota:*  
> We gaan er hier vanuit dat je **student** als gebruikersnaam hebt gekozen zoals gevraagd...

~~~
  / 
  └── home
        └── student
              ├── Desktop
              └── Documents
~~~

Als je een terminalvenster opent, krijg je volgende shell:

![](Pictures/cmd_homedir.png)

Als je een interactieve shell of command line opent, start deze in een specifieke directory.  
Je kan opvragen in welke directory je exact aan het werken bent via de opdracht `pwd` ofwel "**pr**int **w**orking **d**irectory".

~~~
student@studentdeb:~$ pwd
/home/student
student@studentdeb:~$ 
~~~

#### Inhoud tonen met ls

Onder GNU/Linux is `ls` (ofwel "**l**i**s**t) een opdracht om de inhoud van een directory weer te geven. 

~~~
student@studentdeb:~$ ls
Desktop  Documents  Downloads  Music  Pictures  Public  Templates  Videos
student@studentdeb:~$ 
~~~

Zonder argumenten wordt de inhoud van de werkdirectory (huidige directory) getoond.  
Als je de inhoud wil tonen van een subdirectory, geef deze dan als argument op:

~~~
student@studentdeb:~$ ls Documents/
hello  myhistory  tweedehistory
~~~

Merk op: ook voor namen van bestanden en directory's werkt tab completion, wat heel wat typen (en typefouten) uitspaart.

Als je meer details te weten wil komen, gebruik dan de optie `-l`:

~~~
student@studentdeb:~$ ls -l Documents/
total 12
drwxr-xr-x 2 student student 4096 Sep 29 20:24 hello
-rw-r--r-- 1 student student 3063 Sep 29 21:33 myhistory
-rw-r--r-- 1 student student 2794 Sep 29 21:16 tweedehistory
~~~

Dit toont meer volledige info zoals:

* type van item
  * **d** staat voor directory
  * **\-** voor een gewoon bestand
* permissies (zie hoofdstuk rond gebruikers en permissies)
* gebruiker en groep (zie hoofdstuk rond gebruikers en permissies)
* tijd van laatste aanpassing
* grootte
* ...

Een aantal andere opties van `ls` die handig kunnen zijn:

* `-S`: sorteer op bestandsgrootte
* `-t`: sorteer op tijd
* `-r`: draai de volgorde om (van het sorteren)
* `-R`: recursief, geef ook de inhoud van subdirectory's weer
* `-a`: geef ook verborgen bestanden weer (die beginnen met een punt)
* `-d`: geef bij directory's niet de inhoud ervan weer, maar slechts de directorynaam zelf

#### Navigeren met cd

Je kan deze **werkdirectory** ook **wijzigen** met de opdracht `cd` ofwel "**c**hange **d**irectory.

~~~
student@studentdeb:~$ cd Documents/
student@studentdeb:~/Documents$ pwd
/home/student/Documents
student@studentdeb:~/Documents$ ls -l
total 12
drwxr-xr-x 2 student student 4096 Sep 29 20:24 hello
-rw-r--r-- 1 student student 3063 Sep 29 21:33 myhistory
-rw-r--r-- 1 student student 2794 Sep 29 21:16 tweedehistory
~~~

##### Super-directory

Als je naar een hogere directory (of de **superdirectory**) wil navigeren, gebruik dan `..` als naam.

~~~
student@studentdeb:~/Documents$ cd ..
student@studentdeb:~$ pwd
/home/student
student@studentdeb:~$ ls -l
total 32
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Desktop
drwxr-xr-x 3 student student 4096 Oct 10 20:48 Documents
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Downloads
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Music
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Pictures
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Public
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Templates
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Videos
student@studentdeb:~$ ls ..
student
student@studentdeb:~$
~~~

Je kan ook **meerdere niveaus** naar boven verwijzen:

~~~
student@studentdeb:~$ ls ../..
bin   home            lib32       media  root  sys  vmlinuz
boot  initrd.img      lib64       mnt    run   tmp  vmlinuz.old
dev   initrd.img.old  libx32      opt    sbin  usr
etc   lib             lost+found  proc   srv   var
student@studentdeb:~$ 
~~~

##### Vorige directory

Een handig hulpmiddel bij `cd` is de **combinatie** met een **hyphen** (streepje).  
Als je de volgende opdracht uitvoert...

~~~
student@studentdeb:~$ cd -
/home/student/Documents
student@studentdeb:~/Documents$ 
~~~

...keer je terug naar de **vorige werkdirectory** die je gebruikte in je shell-sessie.

#### HOME-directory

/home/student/ is de **home-directory**, net zoals je onder Windows een home-directory `C:\Users\student` zou hebben.  

Als je inlogt in een shell-venster, kom je automatisch terecht in deze home-directory.  
Als je van een andere werkdirectory weer naar je home-directory wil terugkeren, gebruik dan `cd` zonder argument.

~~~
student@studentdeb:~/Documents$ pwd
/home/student/Documents
student@studentdeb:~/Documents$ cd
student@studentdeb:~$ pwd
/home/student
student@studentdeb:~$ 
~~~

Er zijn nog twee andere manieren om naar de home-directory te verwijzen:

* De omgevingsvariabele `$HOME`
* Een tilde of `~`

Deze kan je bijvoorbeeld gebruiken om de lijst van bestanden te tonen in je home-directory (vanuit een andere directory):

~~~
student@studentdeb:~/Documents$ ls
hello  myhistory  tweedehistory
student@studentdeb:~/Documents$ ls ~
Desktop  Documents  Downloads  Music  Pictures  Public  Templates  Videos
student@studentdeb:~/Documents$ ls $HOME
Desktop  Documents  Downloads  Music  Pictures  Public  Templates  Videos
student@studentdeb:~/Documents$ 
~~~

#### Een directory aanmaken

Na het navigeren volgt het aanmaken van directory's en bestanden.
We gaan volgende bestanden aanmaken:

~~~
  / 
  └── home
        ├── bart
        └── student
              ├── hello.csv
              ├── test.xml
              └── data
                    └── sensors.json
~~~

We starten met de directory `data` aan te maken:

~~~
student@studentdeb:~$ mkdir data
student@studentdeb:~$ ls -l
total 36
drwxr-xr-x 2 student student 4096 Oct 13 13:04 data
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Desktop
drwxr-xr-x 3 student student 4096 Oct 10 20:48 Documents
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Downloads
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Music
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Pictures
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Public
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Templates
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Videos
student@studentdeb:~$ 
~~~

Dat doen we met de opdracht `mkdir` gevolgd door het pad `data`.

Zonder argumenten kan je maar één niveau van directory aanmaken. Stel dat je bijvoorbeeld het volgende wil aanmaken, dan gaat dit niet zomaar:

~~~
student@studentdeb:~$ mkdir hello/world
mkdir: cannot create directory ‘hello/world’: No such file or directory
~~~

Als je echter de optie `-p` meegeeft zullen de *parent directories* (`hello` in dit geval) mee worden aangemaakt als deze nog niet bestaan:

~~~
student@studentdeb:~$ mkdir -p hello/world
student@studentdeb:~$ ls hello
world
student@studentdeb:~$ ls -l hello
total 4
drwxr-xr-x 2 student student 4096 Oct 13 13:07 world
student@studentdeb:~$ 
~~~

#### Relatieve en absolute paden

Aan `mkdir` en `cd` geef je als argument een pad mee.

Zo'n pad is de verwijzing naar een (doel)directory waarop je de opdracht wil uitvoeren.  

Je kunt een onderscheid maken op basis van de manier waarop je een pad construeert:

* **absoluut** is een pad dat start vanaf de root-directory. Dit pad start namelijk vanaf de schijf waarnaar je wil verwijzen.

~~~
student@studentdeb:~$ cd /home/student/hello/world/
student@studentdeb:~/hello/world$ pwd
/home/student/hello/world
student@studentdeb:~/hello/world$ 
~~~

* **relatief** is een pad relatief ten opzichte van je huidige directory.

~~~
student@studentdeb:~$ cd hello/world/
student@studentdeb:~/hello/world$ pwd
/home/student/hello/world
student@studentdeb:~/hello/world$ 
~~~

Het symbool `..` (twee punten na elkaar) kan je ook gebruiken in deze relatieve paden:

~~~
student@studentdeb:~/hello/world$ cd ../../data/
student@studentdeb:~/data$ pwd
/home/student/data
~~~

Of het teken `~`: 

~~~
student@studentdeb:~/data$ cd ~/data/
student@studentdeb:~/data$ pwd
/home/student/data
~~~

#### Een leeg bestand aanmaken via touch

Een bestand aanmaken kan je doen met de opdracht `touch`:

~~~
student@studentdeb:~/data$ touch sensors.json
student@studentdeb:~/data$ ls -l
total 0
-rw-r--r-- 1 student student 0 Oct 13 13:27 sensors.json
student@studentdeb:~/data$ 
~~~

Als het bestand reeds bestaat, zal `touch` echter alleen de update-datum aanpassen:

~~~
student@studentdeb:~/data$ touch sensors.json 
student@studentdeb:~/data$ ls -l
total 0
-rw-r--r-- 1 student student 0 Oct 13 13:29 sensors.json
~~~

#### Directory's en bestanden verwijderen

Een directory verwijderen doe je met de opdracht `rmdir`.  
Deze directory mag wel geen bestanden of directory's bevatten. Anders breekt de opdracht af met een foutmelding:

~~~
student@studentdeb:~$ rmdir data
rmdir: failed to remove 'data': Directory not empty
~~~

Als je een niet-lege directory wil verwijderen, dien je dus eerst de bestanden erin te verwijderen.  
Dat kan met de opdracht `rm`:

~~~
student@studentdeb:~$ rm data/sensors.json 
student@studentdeb:~$ ls data
student@studentdeb:~$
~~~

Zodra de directory leeg is, kan je deze verwijderen via de opdracht `rmdir`:

~~~
student@studentdeb:~$ rmdir data
student@studentdeb:~$ ls -l
total 36
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Desktop
drwxr-xr-x 3 student student 4096 Oct 10 20:48 Documents
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Downloads
drwxr-xr-x 3 student student 4096 Oct 13 13:07 hello
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Music
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Pictures
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Public
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Templates
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Videos
~~~

#### Bestanden kopiëren 

Je kan ook een bestand via de terminal kopiëren met de opdracht `cp` ofwel "**c**o**p**y":

~~~bash
student@studentdeb:~$ touch test.txt
student@studentdeb:~$ cp test.txt test2.txt
student@studentdeb:~$ ls -l
total 36
...
-rw-r--r-- 1 student student    0 Oct 13 13:37 test2.txt
-rw-r--r-- 1 student student    0 Oct 13 13:36 test.txt
...
~~~

#### Directory kopiëren

Deze opdracht geldt ook voor directory's. Maar als deze niet leeg zijn, moet je hier de optie `-r` (voor recursief) aan toevoegen:

~~~bash
student@studentdeb:~$ cp Documents/ DocumentsCopy/
cp: -r not specified; omitting directory 'Documents/'
student@studentdeb:~$ cp -r Documents/ DocumentsCopy/
student@studentdeb:~$ ls -lrt
total 40
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Videos
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Templates
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Public
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Pictures
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Music
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Downloads
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Desktop
drwxr-xr-x 3 student student 4096 Oct 10 20:48 Documents
drwxr-xr-x 3 student student 4096 Oct 13 13:07 hello
-rw-r--r-- 1 student student    0 Oct 13 13:36 test.txt
-rw-r--r-- 1 student student    0 Oct 13 13:37 test2.txt
drwxr-xr-x 3 student student 4096 Oct 13 13:39 DocumentsCopy
~~~

#### Bestanden en directory's verplaatsen

Om een bestand of directory te verplaatsen naar een directory, gebruik je de opdracht `mv` ofwel **m**o**v**e:

~~~
student@studentdeb:~$ mv hello/ Documents
student@studentdeb:~$ ls -l Documents
total 12
drwxr-xr-x 3 student student 4096 Oct 13 13:07 hello
-rw-r--r-- 1 student student 3063 Sep 29 21:33 myhistory
-rw-r--r-- 1 student student 2794 Sep 29 21:16 tweedehistory
~~~

#### Naam van een bestand wijzigen

Dezelfde opdracht `mv` kan je ook gebruiken als je van een bestand of directory de naam wil wijzigen.

~~~
student@studentdeb:~$ mv test.txt test
student@studentdeb:~$ ls -lrt
total 36
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Videos
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Templates
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Public
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Pictures
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Music
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Downloads
drwxr-xr-x 2 student student 4096 Sep 26 20:49 Desktop
-rw-r--r-- 1 student student    0 Oct 13 13:36 test
-rw-r--r-- 1 student student    0 Oct 13 13:37 test2.txt
drwxr-xr-x 3 student student 4096 Oct 13 13:39 DocumentsCopy
drwxr-xr-x 3 student student 4096 Oct 13 14:08 Documents
student@studentdeb:~$ 
~~~

### Shell- en omgevingsvariabelen

Een shell laat toe om - zoals in een programmeertaal - variabelen aan te maken en te gebruiken.

#### Een shellvariabele definiëren

Een shellvariabele is een **variabele** (eigenlijk een stuk tekst) die door de **shell** wordt **bijgehouden** gedurende de terminalsessie.  

Het volgende voorbeeld gebruikt dit mechanisme om het pad naar een directory bij te houden:

~~~
student@studentdeb:~$ MY_DATA_FOLDER=/home/student/Documents
student@studentdeb:~$ echo $MY_DATA_FOLDER 
/home/student/Documents
student@studentdeb:~$ cd $MY_DATA_FOLDER 
student@studentdeb:~/Documents$ 
~~~

* Zo'n variabele kan je initialiseren door de **naam** van deze variabele te verbinden via een `=`-teken aan een tekst.
* Je kan de inhoud van zo'n **variabele** op de console tonen met de opdracht `echo`, met als argument de naam van de variabele voorafgegaan door `$`. 
* Je kan de inhoud op dezelfde manier bij andere opdrachten gebruiken. De shell vervangt dan de variabele door de tekst die erachter gedefinieerd is.

> **Let op**: als deze variabele al bestaat, dan wordt de inhoud ervan overschreven.

#### Omgevingsvariabelen

Een **shellvariabele** zal alleen zichtbaar zijn binnen de **shell** zelf.  
Als je een nieuwe shell start, zal de variabele in die sessie niet zichtbaar zijn.

Je kan echter zo'n shellvariabele "promoten" naar een omgevingsvariabele (*environment variabele*). Hiervoor gebruiken we de opdracht `export`:

In onderstaand voorbeeld:

* Maken we een variabele `some_var` aan
* Tonen we deze
* Openen een nieuwe bash-sessie
* Tonen we deze opnieuw

~~~
student@studentdeb:~$ some_var="hello world"
student@studentdeb:~$ echo $some_var 
hello world
student@studentdeb:~$ bash
student@studentdeb:~$ echo $some_var

student@studentdeb:~$ exit
student@studentdeb:~$ echo $some_var 
hello world
~~~

We zien dat deze variabele niet meer zichtbaar is binnen de nieuwe sessie.   
Dat is normaal, aangezien een shellvariabele gebonden is aan één shell-sessie.

Als je daarentegen `export` gebruikt, zal de variabele zichtbaar zijn in alle shells en andere programma's die je **vanuit deze shell** opstart:

~~~
student@studentdeb:~$ export some_var="hello world"
student@studentdeb:~$ bash
student@studentdeb:~$ echo $some_var 
hello world
student@studentdeb:~$ 
~~~

Hetzelfde kunnen we ook **demonstreren** via een **shellscript**.
Gegeven het onderstaande shellscript `print_some_var.sh` dat de inhoud van een variabele `some_var` zal tonen:

~~~
student@studentdeb:~$ cat print_some_var.sh 
echo $some_var
~~~

Als je een **Bash-script** of een **programma** start vanuit de shell, zie je hetzelfde verschil tussen een shellvariabele en omgevingsvariabele.

In onderstaand voorbeeld maken we opnieuw de shell-variabele aan.  
Zoals je ziet, zal deze echter **niet zichtbaar** zijn voor het script (om dezelfde reden als voorgaand voorbeeld).  

~~~
student@studentdeb:~$ some_var="hello world"
student@studentdeb:~$ echo $some_var 
hello world
student@studentdeb:~$ bash print_some_var.sh 
student@studentdeb:~$
~~~

Als je vervolgens echter de variabele 'exporteert' met de opdracht `export`, zal deze zichtbaar zijn voor programma's die je start vanuit die shell, en dus ook ons shellscript:

~~~
student@studentdeb:~$ export some_var
student@studentdeb:~$ bash print_some_var.sh 
hello world
~~~

#### Systeemvariabelen

We kennen ondertussen het **verschil** tussen **shellvariabelen** en **omgevingsvariabelen**.

Naast de variabelen die je zelf definieert, zorgt je besturingssysteem ook voor een aantal omgevingsvariabelen.

##### PATH

Om een programma uit te voeren binnen Linux, moet je in principe altijd het exacte pad naar het programma opgeven.
Je kan bijvoorbeeld niet een **script** uitvoeren dat in de werkdirectory staat door de **naam** te typen.

Als je bijvoorbeeld voorgaand script wil uitvoeren als programma (zonder `bash` er voor te zetten) moet je `./` ervoor plaatsen om de exacte locatie aan te geven (`.` verwijst naar je **werkdirectory**):

~~~
student@studentdeb:~$ ls -l print_some_var.sh 
-rwxr--r-- 1 student student 15 Mar  7 11:25 print_some_var.sh
student@studentdeb:~$ print_some_var.sh 
bash: print_some_var.sh: command not found
student@studentdeb:~$ ./print_some_var.sh 
test
student@studentdeb:~$ 
~~~

Er is echter een **uitzondering** op deze regel.  
Je systeem/shell voorziet een omgevingsvariabele `PATH`. Deze bevat een **lijst** van alle **locaties** waarin je shell naar **uitvoerbare programma's** zoekt.

~~~
student@studentdeb:~$ echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
student@studentdeb:~$
~~~

Als je in één van deze directory's gaat kijken, zal je zien
dat veel programma's die je reeds gebruikt hierin te vinden zijn.

Als we bijvoorbeeld kijken naar waar `ls` zich bevindt...

~~~
student@studentdeb:~$ ls /usr/bin/ls*
/usr/bin/ls           /usr/bin/lscpu        /usr/bin/lslogins  /usr/bin/lsof
/usr/bin/lsattr       /usr/bin/lsinitramfs  /usr/bin/lsmem     /usr/bin/lspci
/usr/bin/lsblk        /usr/bin/lsipc        /usr/bin/lsmod     /usr/bin/lspgpot
/usr/bin/lsb_release  /usr/bin/lslocks      /usr/bin/lsns      /usr/bin/lsusb
~~~

Als je nu wilt dat een directory aan dat zoekpad wordt toegevoegd, kan je deze variabele `PATH` wijzigen.  
In onderstaand voorbeeld vindt de shell geen `print_some_var.sh`-script terug ondanks het feit dat deze in dezelfde directory staat.

~~~
student@studentdeb:~$ ls print_some_var.sh
print_some_var.sh
student@studentdeb:~$ print_some_var.sh
bash: print_some_var.sh: command not found
student@studentdeb:~$ echo $PATH 
/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
~~~

Als je echter je huidge workdirectory toevoegt aan `PATH`...

~~~
student@studentdeb:~$ export PATH=/home/student/:$PATH
student@studentdeb:~$ echo $PATH
/home/student/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
~~~

...ga je zien dat het script wordt herkend door de tab completion...

~~~
student@studentdeb:~$ pr
pr                 prezip             printf             prtstat
precat             prezip-bin         print_some_var.sh  
preconv            print              prlimit            
preunzip           printenv           prove              
~~~

...en het script kan uitvoeren zonder de locatie aan te duiden

~~~
student@studentdeb:~$ print_some_var.sh 
test
student@studentdeb:~$ 
~~~

Merk op: de huidige directory aan `PATH` toevoegen is geen goed idee. Want wat als malware zich in die directory plaatst met de naam van een veel gebruikte opdracht zoals `ls`? Dan wordt de malware uitgevoerd als je in die directory `ls` intypt...

#### Alle omgevingsvariabelen zien

Als je alle omgevingsvariabelen wil zien, typ dan de opdracht `printenv` in:

~~~
student@studentdeb:~/mijn_eerste_programma$ printenv
LC_PAPER=de_BE.UTF-8
XDG_VTNR=8
SSH_AGENT_PID=2713
XDG_SESSION_ID=c1
LC_ADDRESS=de_BE.UTF-8
LC_MONETARY=de_BE.UTF-8
COMP_WORDBREAKS= 	
"'><;|&(:
QT_STYLE_OVERRIDE=gtk
GPG_AGENT_INFO=/home/bart/.gnupg/S.gpg-agent:0:1
TERM=xterm-256color
...
~~~

### Strings en spaties

Als je achter een opdracht **tekst** typt gescheiden door spaties, dan zal elk woord aan de opdracht worden meegeven als afzonderlijk argument.

In het onderstaande voorbeeld worden er drie verschillende (mogelijke) bestandsnamen meegegeven.  
De `ls`-opdracht zal als gevolg antwoord geven voor drie verschillende bestandsnamen (die in dit geval niet bestaan).

~~~~
student@studentdeb:~$  ls niet bestaande file
ls: cannot access 'niet': No such file or directory
ls: cannot access 'bestaande': No such file or directory
ls: cannot access 'file': No such file or directory
$student@studentdeb:~$  
~~~~

Stel dat je een bestandsnaam (of tekst) wil meegeven die spaties bevat, dan kan je de string **demarkeren** met aanhalingstekens (*quotes*) zoals hieronder:

~~~~
student@studentdeb:~$  ls "niet bestaande file"
ls: cannot access 'niet bestaande file': No such file or directory
~~~~

Naast dubbele aanhalingstekens (```"tekst"```) kan je ook enkele aanhalingstekens (```'tekst'```) gebruiken.

~~~~
student@studentdeb:~$  ls 'niet bestaande file'
ls: cannot access 'niet bestaande file': No such file or directory
student@studentdeb:~$  
~~~~

#### Variable substitution binnen strings

Enkele en dubbele aanhalingstekens hebben echter wel een **verschil** in **gedrag**. Dit verschil komt naar voren bij het gebruik van **variable substitution**  

Als je een shellvariabele declareert, kan je deze integreren binnen een string, zoals hieronder geïllustreerd:

~~~
test=hello
student@studentdeb:~$  echo "$test world"
hello world
~~~

Als je daarentegen enkele aanhalingstekens gebruikt, zal de shell deze variabele niet vervangen door zijn waarde:

~~~
student@studentdeb:~$  echo '$test world'
$test world
~~~

### Bash-scripting (deel 1)

Tot nu toe hebben we altijd **interactief** gewerkt met Bash:

* Je typt een **opdracht** na de prompt.
* Bash **voert** deze opdracht **uit** (nadat je Enter hebt gedrukt).
* Bash toont de **uitvoer** van deze opdracht.

Een tweede modus waaronder je met een shell kan werken is **scripting**.  
Een script is een bestand waarin je één of meerdere opdrachten bundelt. Deze bundel kun je dan uitvoeren door dit script aan te roepen.

#### shebang

Als je een **Bash-script** wil schrijven, dient dit altijd te **starten** met de volgende regel:

~~~
#!/bin/bash
~~~

We noemen het symbool `#!` ook wel een **shebang**. Deze bepaalt **welke script-interpreter** gebruikt wordt.  
Vervolgens kan je daaronder dan opdrachten plaatsen. Deze zullen dan **sequentieel** (één voor één) worden **uitgevoerd**:

~~~bash
#!/bin/bash
echo "Hello World"
echo "Het is vandaag $(date)"
~~~

#### Commentaar

Op elke andere regel dan de eerste kan je ook het hash-teken of `#` gebruiken als een commentaarteken (zoals in Python).  
Alles wat achter dit teken komt op dezelfde regel, zal dan niet geïnterpreteerd worden door de Bash-interpreter.

~~~bash
#!/bin/bash
# Eerste opdracht
echo "Hello World"
# Tweede opdracht
echo "Het is vandaag $(date)"
~~~

#### Uitvoeren met de bash-interpreter

**Bewaar** dit bestand onder de naam `hello.sh` en voer het als volgt uit:

~~~
student@studentdeb:~$ bash hello.sh 
Hello World
Het is vandaag Wed 15 Dec 2021 03:24:45 PM CET
student@studentdeb:~$ 
~~~

Zoals je ziet, worden beide opdrachten van in het script één na één uitgevoerd.

#### Uitvoeren als programma (en permissies)

Je kan het **script** ook **uitvoeren** net zoals je een gewoon **programma/opdracht** uitvoert, zonder er `bash` voor te moeten typen.  

Dit werkt niet vanzelf:

~~~
student@studentdeb:~$ ./hello.sh
bash: ./hello.sh: No such file or directory
student@studentdeb:~$ bash ./hello.sh 
~~~

Als je naar de bestandspermissies (zie later) kijkt, zie je dat een script **standaard niet uitvoerbaar** gemaakt wordt:

~~~
student@studentdeb:~$ ls -l ./hello.sh
-rw-r--r-- 1 student student 61 Dec 15 15:24 ./hello.sh
~~~

Om het script toch uitvoerbaar te maken, dien je de **permissies** te **wijzigen**. Dit doe je met de opdracht `chmod`:

~~~
student@studentdeb:~$ chmod u+x hello.sh
~~~

Met `ls -l` zie je daarna dat je het script kan uitvoeren, want je ziet een x waar er voorheen geen stond:

~~~
student@studentdeb:~$ ls -l ./hello.sh
-rwxr--r-- 1 student student 61 Dec 15 15:24 ./hello.sh
~~~

> *Geduld:*
> De **uitleg** rond **permissies** **volgt** in een verder hoofdstuk.

En ja hoor, nu kan je het script gewoon uitvoeren:

~~~
student@studentdeb:~$ ./hello.sh 
Hello World
Het is vandaag Wed 15 Dec 2021 03:28:37 PM CET
student@studentdeb:~$
~~~

#### Argumenten

Je kan aan zo'n **script** ook **argumenten** meegeven, net zoals we dit eerder bij programma's hebben gezien.

Binnen dat script kan je naar deze argumenten verwijzen via een `$` gevolgd door de positie van het argument:

* Het eerste argument kan je via `$1` bereiken
* Het tweede via `$2`
* Het derde via `$3`
* ...

Als je bijvoorbeeld een script maakt als volgt:

~~~bash
#!/bin/bash

echo "Hello $1 $2"
~~~

Dan zal dit script het eerste en tweede argument tonen met de `echo`-opdracht (en met behulp van string-substitutie).

~~~
student@studentdeb:~$ chmod u+x a.sh 
student@studentdeb:~$ ./a.sh 
Hello  
student@studentdeb:~$ ./a.sh a
Hello a 
student@studentdeb:~$ ./a.sh a b
Hello a b
student@studentdeb:~$ ./a.sh a b c
Hello a b
student@studentdeb:~$ 
~~~

#### Speciale argumenten

Naast deze argumenten heb je nog een aantal andere speciale variabelen tot je beschikking in een Bash-script:

* `$0` => de naam van het script
* `$#` => aantal argumenten
* `$@` => alle argumenten op een rij
* `$*` => alle argumenten op een rij als één string

Als we deze toevoegen aan voorgaand script...

~~~bash
#!/bin/bash

echo "Hello $1 $2"
echo $0
echo $#
echo $@
echo $*
~~~

... en je dit uitvoert als hieronder:

~~~
student@studentdeb:~$ $ bash ./hello.sh 1 2 3 4
Hello 1 2
./hello.sh
4
1 2 3 4
1 2 3 4
student@studentdeb:~$ 
~~~

... zien we:

* `$0` => ./hello.sh  
  De naam van het script (`./hello.sh`) zelf wordt als argument 0 beschouwd.
* `$#` => 4  
  Het aantal argumenten.
* `$@` => 1 2 3 4  
  Alle argumenten die aan het script zijn meegegeven (als array)
* `$*` => 1 2 3 4  
  Alle argumenten die aan het script zijn meegegeven (als string)

#### Verschil tussen `$@` en `$*`

Zowel `$@`  als `$*` zullen alle argumenten opleveren die worden meegegeven aan het script (startende van `$1`).

Het verschil ligt echter in de details:

* `$*` zal deze argumenten voorzien als **één string**
* `$@` daarentegen zal deze argumenten als **array** (rij) voorzien

De laatste is nuttig om binnen een script bijvoorbeeld in een lus alle argumenten af te gaan.
Hier komen we later nog op terug.

Je ziet het verschil ook als je aan **variable substitution** doet.  
Als voorbeeld het onderstaande script dat `ls` toepast op alle argumenten:

* De eerste keer passen we `ls` toe op de rij.
* De tweede keer passen we `ls` toe op de string.

~~~bash
#!/bin/bash

echo "test 1:"
ls "$@"
echo "test 2:"
ls "$*"
~~~

Voer dit script nu uit met enkele argumenten:

~~~
$ bash ls_test.sh a b c
test 1:
ls: cannot access 'a': No such file or directory
ls: cannot access 'b': No such file or directory
ls: cannot access 'c': No such file or directory
test 2:
ls: cannot access 'a b c': No such file or directory
~~~

Als je dan de uitvoer bestudeert, zie je:

* `$@` zal **substitueren** naar **drie afzonderlijke argumenten**
* `$*` zal substitueren naar **één string**

### In- en uitvoer van programma's

Programma's en scripts hebben meestal in- en uitvoer nodig om te kunnen werken.  
Op de command line zijn er drie belangrijke elementen:

* Invoer bij de **start** van het **programma**: **argumenten**
* In- en uitvoer tijdens de **uitvoering** van het programma: **stdin, stdout en stderr**
* Uitvoer bij het einde van het programma

~~~
START PROGRAMMA:       argumenten   
                           |
                           V                        (1)
(0)                 +------+-----+----> standard output
standard input ---->|   process  |  
                    +------+-----+---->  standard error
                           |                        (2)
                           V
EINDE PROGRAMMA:       exit-code    
~~~

#### Invoer bij de start: argumenten (en opties)

Het eerste element hebben we al een aantal maal toegepast bij het gebruiken van diverse opdrachten.  
Als je een programma aanroept, kan je daar namelijk een aantal extra argumenten aan doorgeven.

~~~
START PROGRAMMA:       argumenten   
                           |
                           V      
                    +------+-----+
                    |   process  |  
                    +------+-----+
~~~

Een voorbeeld:

~~~
student@studentdeb:~$ ls -l hello.sh 
-rwxr--r-- 1 student student 60 Mar 13 20:04 hello.sh
student@studentdeb:~$
~~~

In dit geval zijn `-l` en `hello.sh` beide argumenten.  

* `-l` is in dit geval een optie (een speciaal soort argument voorafgegaan door een koppelteken)
* `hello.sh` is het tweede argument

#### Uitvoer bij het einde van het programma: Exit-code

Elk programma binnen Linux zal bij het beëindigen een code teruggeven.  

~~~
START PROGRAMMA:       argumenten   
                           |
                           V      
                    +------+-----+
                    |   process  |  
                    +------+-----+
                           |
                           V
EINDE PROGRAMMA:       exit-code    
~~~

Deze code noemen we ook exit-code en heeft als bedoeling informatie mee te geven over het al dan niet succesvol uitvoeren van de opdracht.

Deze exit-code kan je vanuit de shell opvragen via een speciale variabele: `$?`.  
Bij normale uitvoering  - **zonder fout of waarschuwing** - zal deze waarde (dat is een afspraak) **0** zijn.

~~~
student@studentdeb:~$ ls -l hello.sh 
-rwxr--r-- 1 student student 60 Mar 13 20:04 hello.sh
student@studentdeb:~$ echo $?
0
~~~

Als we echter een **foutje** maken bij de uitvoering zal de opdracht een exit-code **verschillend van 0** teruggeven.  
In onderstaand voorbeeld geven we de naam van een niet bestaand bestand door aan `ls`, waarop deze een exit-code 2 teruggeeft:

~~~
student@studentdeb:~$ ls -l hello.sh.not 
ls: cannot access 'hello.sh.not': No such file or directory
student@studentdeb:~$ echo $?
2
student@studentdeb:~$
~~~

Deze code is niet voor elke opdracht identiek.  
Het tweede voorbeeld - `cd` naar een niet bestaande directory - bevestigt dit...

~~~
student@studentdeb:~$ cd bestaatniet
bash: cd: bestaatniet: No such file or directory
student@studentdeb:~$ echo $?
1
student@studentdeb:~$ echo $?
0
student@studentdeb:~$ 
~~~

Een laatste belangrijke bemerking is dat deze variabele `$?` altijd wordt overschreven. Ze bevat altijd de exit-code van de laatst uitgevoerde opdracht (ongeacht of deze 0 is of niet).  
In bovenstaand voorbeeld zie je dan ook dat de `echo`-opdracht zelf de variabele weer op 0 zet. De `echo`-opdracht is immers succesvol uitgevoerd...

> Nota: Als je gewoon op Enter drukt na de prompt, zal deze exit-code niet worden overschreven. Er wordt dan immers geen opdracht uitgevoerd.

##### Exit-code bij scripts

In je eigen script kan je ook de exit-code instellen.  
Dat kan je via de opdracht `exit` gevolgd door een geheel getal (*integer*):

~~~bash
#!/bin/bash

echo "Hello exit-demo"
exit 25
~~~

Als je dit uitprobeert, zie je dat er inderdaad 25 door het script wordt teruggegeven.

~~~
student@studentdeb:~$ ./exit_code_demo.sh
Hello exit-demo
student@studentdeb:~$ echo $?
25
student@studentdeb:~$ 
~~~

#### Tijdens de uitvoering: stdin, stdout en stderr

Een proces binnen een Linux-distributie heeft altijd automatisch **drie bestanden** of **streams** ter beschikking:

* **stdin**: standard input
* **stdout**: standard output
* **stderr**: standard error

Dit zijn datastromen die een toepassing standaard met de in- en uitvoer van de shell verbindt. 
Vanuit de shell echter kan je deze **datastromen** doorgeven aan **andere toepassingen** via een aantal operatoren (`>`, `>>`, `<`, `|`).

##### Stdout

De eerste is stdout. Dit is de tekst/uitvoer die je toepassing produceert.

~~~
START PROGRAMMA:       argumenten   
                           |
                           V                        (1)
                    +------+-----+----> standard output
                    |   process  |  
                    +------+-----+
                           |
                           V
EINDE PROGRAMMA:       exit-code    
~~~

In onderstaand voorbeeld zal de standard output van de opdracht `ls` in de shell te zien zijn:

~~~
student@studentdeb:~$ ls -l hello.sh 
-rwxr--r-- 1 student student 60 Mar 13 20:04 hello.sh
student@studentdeb:~$
~~~

##### Redirection operator > (overwrite)

Deze uitvoer kan je echter omleiden (*redirect*) naar een een bestand.
Dat doe je door na de opdracht een `>`-teken te plaatsen gevolgd door de naam van het bestand waarnaar je wil schrijven:

~~~
student@studentdeb:~$ ls -l hello.sh > lsout
student@studentdeb:~$ cat lsout
-rwxr--r-- 1 student student 60 Mar 13 20:04 hello.sh
student@studentdeb:~$
~~~

In een tweede voorbeeld maken we gebruik van redirection om een bestand aan te maken met reeds wat tekst in:

~~~
student@studentdeb:~$ echo "Hello World" > helloworld 
student@studentdeb:~$ cat helloworld
Hello world
student@studentdeb:~$
~~~

##### Redirection operator >> (append)

De `>`-operator zal een bestand altijd overschrijven. Als het bestand al bestaat, wordt de inhoud ervan dus overschreven met de volledige uitvoer van de opdracht:

~~~
student@studentdeb:~$ ls -l hello.sh > lsout
student@studentdeb:~$ cat lsout
-rwxr--r-- 1 student student 60 Mar 13 20:04 hello.sh
student@studentdeb:~$ 
~~~

Als je het bestand niet wil overschrijven, gebruik je de `>>`-operator.  

~~~
tudent@studentdeb:~$ ls -l hello.sh >> lsout
student@studentdeb:~$ ls -l hello.sh >> lsout
student@studentdeb:~$ cat lsout
-rwxr--r-- 1 student student 60 Mar 13 20:04 hello.sh
-rwxr--r-- 1 student student 60 Mar 13 20:04 hello.sh
-rwxr--r-- 1 student student 60 Mar 13 20:04 hello.sh
student@studentdeb:~$ 
~~~

Dit voegt de uitvoer van de opdracht aan het bestaande bestand toe.

##### Stderr

Naast stdout is er ook nog een tweede output-stream, namelijk **stderr**.  

~~~
START PROGRAMMA:       argumenten   
                           |
                           V                        (1)
                    +------+-----+----> standard output
                    |   process  |  
                    +------+-----+---->  standard error 
                           |                        (2)
                           V
EINDE PROGRAMMA:       exit-code    
~~~

Een **applicatie** zal **foutboodschappen** doorsturen naar **stderr**, niet naar stdout.
In het volgende voorbeeld proberen we met opzet een niet-bestaand bestand op te vragen en de uitvoer weg te schrijven naar een bestand:

~~~
student@studentdeb:~$ ls -l hello.sh.not > lsout
ls: cannot access 'hello.sh.not': No such file or directory
student@studentdeb:~$ cat lsout 
student@studentdeb:~$ 
~~~

Hier zien we dat het bestand leeg is. Waarom? Omdat de enige uitvoer van de `ls`-opdracht hier de foutboodschap was die je op de console zag verschijnen.  

##### Redirect van stderr via 2>

Als je ervoor wil zorgen dat de foutboodschap naar een bestand wordt weggeschreven, kan je dit door een cijfer toe te voegen vóór het redirect-symbool. Voor de **stderr-stream** is dit altijd **2**:

~~~
student@studentdeb:~$ ls -l hello.sh.not 2> lserr
student@studentdeb:~$ cat lserr 
ls: cannot access 'hello.sh.not': No such file or directory
student@studentdeb:~$ 
~~~

Je kan ook zorgen dat **beide** streams **tegelijkertijd** worden weggeschreven.  
In onderstaand voorbeeld:

* vragen we zowel een bestaand als niet-bestaand bestand op
* de foutboodschap gaat naar lserr
* de gewone uitvoer gaat naar lsout 

~~~
student@studentdeb:~$ ls -l hello.sh hello.sh.not >lsout 2> lserr
student@studentdeb:~$ cat lserr 
ls: cannot access 'hello.sh.not': No such file or directory
student@studentdeb:~$ cat lsout
-rwxr--r-- 1 student student 60 Mar 13 20:04 hello.sh
student@studentdeb:~$ 
~~~

##### Redirect van zowel stdout als stderr via &>

Als je zowel stdout als stderr tegelijkertijd wil omleiden, kan je `&>` gebruiken.  
In het **voorbeeld** hieronder zullen **beide streams** naar één bestand worden weggeschreven.

~~~
student@studentdeb:~$ ls -l hello.sh hello.sh.not &> lsall
student@studentdeb:~$ cat lsout 
-rwxr--r-- 1 student student 60 Mar 13 20:04 hello.sh
ls: cannot access 'hello.sh.not': No such file or directory
student@studentdeb:~$ 
~~~

##### Stdin

Een derde stream is stdin. Dit is de standaard invoer die een toepassing meekrijgt vanaf de shell.

~~~
START PROGRAMMA:       argumenten   
                           |
                           V                        (1)
(0)                 +------+-----+----> standard output
standard input ---->|   process  |  
                    +------+-----+---->  standard error
                           |                        (2)
                           V
EINDE PROGRAMMA:       exit-code    
~~~

Om dit de demonstreren, gebruiken we de opdracht `wc`. Dit is de afkorting voor **word count**. Het programma geeft (standaard zonder argumenten) drie zaken weer:

* Aantal regels
* Aantal woorden
* Aantal tekens

Als je deze opdracht uitvoert zonder argumenten, zal ze wachten op invoer van de console,
namelijk stdin.  
In onderstaand voorbeeld typen we wat tekst. Om stdin te beëindigen gebruiken we **Ctrl+D**.

~~~
student@studentdeb:~$ wc
hello
world
greetings from the shell
      3       6      37
student@studentdeb:~$ 
~~~

##### Redirection vanuit een bestand naar stdin via <

Net als we met `>` uitvoer naar een bestand kunnen omleiden, kunnen we de inhoud van een bestand omleiden naar stdin.  
Daarvoor gebruiken we de operator `<`.

We komen terug op ons voorgaand voorbeeld waar we een bestand aanmaken met twee regels.

~~~
student@studentdeb:~$ ls -l hello.sh hello.sh.not &> lsall
student@studentdeb:~$ cat lsall
ls: cannot access 'hello.sh.not': No such file or directory
-rwxr--r-- 1 student student 60 Mar 13 20:04 hello.sh
~~~

Als we nu de inhoud van dit bestand als invoer naar de opdracht `wc` willen omleiden, kan dit als hieronder.

~~~
student@studentdeb:~$ wc < lsall
  2  18 114
student@studentdeb:~$ 
~~~

##### Redirection van stdin/stdout vanuit een ander proces/opdracht naar stdin via |

In bovenstaand voorbeeld werkten we nog altijd met een tussenbestand - lsall - om de uitvoer
van de `ls`-opdracht te verbinden met de invoer van de `wc`-opdracht.

Er is echter een operator die de uitvoerstream van de ene opdracht (`ls`) met de invoerstream van de andere opdracht (`wc`) verbindt.  
Om dit te doen, plaatsen we een `|`-operator (*pipe*) tussen beide opdrachten:

~~~
bart@studentdeb:~$ ls -l hello.sh hello.sh.not | wc
ls: cannot access 'hello.sh.not': No such file or directory
      1       9      52
bart@studentdeb:~$
~~~

Bemerk hier wel dat deze pipe-operator alleen stdout van de ene opdracht verbindt met stdin van de andere.

~~~
            STDOUT    |    STDIN   STDOUT     CONSOLE:
    +------+-----+-------->+------+-----+---->  1       9      52 
    |  ls -l ... |         |     WC     |
    +------+-----+         +------+-----+
~~~


##### Redirection vanuit een ander proces/opdracht naar stdin via |&

Wil je toch zowel stdout als stderr omleiden naar stdin van een ander programma, dan dien je dit te doen met een variant van de pipe-operator, namelijk `|&`.

~~~
bart@studentdeb:~$ ls -l hello.sh hello.sh.not |& wc
      2      18     112
bart@studentdeb:~$ 
~~~

Met deze operator worden stdout en stderr dus bij elkaar gevoegd en daarna doorgegeven aan stdin van `wc`.

~~~
            STDOUT  |&      STDIN   STDOUT     CONSOLE:
    +------+-----+---+----->+------+-----+---->  2      18     112 
    |  ls -l ... |   |      |     WC     |
    +------+-----+---+      +------+-----+
            STDERR
~~~

