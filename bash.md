## Bash-scripts (deel 1)

Tot nu toe hebben we altijd **interactief** gewerkt met Bash:

* Je typt een opdracht na de prompt.
* Bash voert deze opdracht uit (nadat je Enter hebt gedrukt).
* Bash toont de uitvoer van deze opdracht.

Een tweede modus waaronder je met een shell kan werken is **scripting**.  
Een script is een bestand waarin je één of meerdere opdrachten na elkaar plaatst. Deze kun je dan in één keer uitvoeren door dit script aan te roepen.

In dit deel bekijken we hoe je Bash-scripts aanmaakt.

### Shell- en omgevingsvariabelen

Voordat we aan scripts beginnen, moeten we even een stapje terug nemen. Een shell laat toe om - zoals in een programmeertaal - variabelen aan te maken en te gebruiken.

#### Een shellvariabele definiëren

Een shellvariabele is een **variabele** (eigenlijk een stuk tekst) die door de **shell** wordt **bijgehouden** gedurende de terminalsessie.  

Het volgende voorbeeld gebruikt dit mechanisme om het pad naar een directory bij te houden:

~~~
student@studentdeb:~$ MY_DATA_FOLDER=/home/student/data
student@studentdeb:~$ echo $MY_DATA_FOLDER 
/home/student/data
student@studentdeb:~$ cd $MY_DATA_FOLDER 
student@studentdeb:~/data$ 
~~~

* Zo'n variabele kun je initialiseren door de **naam** van deze variabele te verbinden via een `=`-teken aan een tekst.
* Je kunt de inhoud van zo'n **variabele** op de console tonen met de opdracht `echo`, met als argument de naam van de variabele voorafgegaan door `$`. 
* Je kunt de inhoud op dezelfde manier bij andere opdrachten gebruiken. De shell vervangt dan de variabele door de tekst die erachter gedefinieerd is. Dit heet **variable substitution**: de shell vervangt de variabele door de inhoud ervan.

> **Let op**: als deze variabele al bestaat, dan wordt de inhoud ervan bij de initialisatie overschreven.

#### Omgevingsvariabelen

Een **shellvariabele** zal alleen zichtbaar zijn binnen de **shell** zelf.  
Als je een nieuwe shell start, zal de variabele in die sessie niet zichtbaar zijn.

Je kunt echter zo'n shellvariabele "promoten" naar een omgevingsvariabele (*environment variabele*). Hiervoor gebruiken we de opdracht `export`:

In onderstaand voorbeeld:

* maken we een variabele `some_var` aan
* tonen we deze
* openen een nieuwe bash-sessie
* tonen we deze opnieuw

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

Dit geldt niet alleen voor bash, maar voor alle programma's die je in deze shell opstart: als een shellvariabele geëxporteerd is, heeft dat programma toegang tot deze variabele. Hierna zullen we zien hoe we zelf Bash-scripts kunnen maken, en die hebben dan ook toegang tot deze omgevingsvariabelen.

#### Alle omgevingsvariabelen zien

Als je alle omgevingsvariabelen wilt zien, typ dan de opdracht `printenv` in:

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

### Command substitution

Een andere praktisch hulpmiddel is **command substitution**.
Dit laat toe om de uitvoer van de ene opdracht te gebruiken binnen een andere opdracht.

In het onderstaand voorbeeld gebruiken we twee opdrachten:

* `hostname` => naam van de host opvragen
* `uname` => systeeminformatie opvragen

Zie hieronder als voorbeeld:

~~~
student@studentdeb:~$ hostname -s
studentdeb
student@studentdeb:~$ uname -r
5.15.0-86-generic
~~~

De uitvoer van deze twee opdrachten kun je gebruiken binnen de opdracht `echo`:

~~~
student@studentdeb:~$ echo "Deze host is $(hostname -s) met Linux-kernel $(uname -r)"
Deze host is studentdeb met Linux-kernel 5.15.0-86-generic
~~~

### Strings en spaties

Let op: als je achter een opdracht tekst typt gescheiden door spaties, dan zal elk woord aan de opdracht worden meegeven als afzonderlijk argument.

In het onderstaande voorbeeld worden er drie verschillende (mogelijke) bestandsnamen meegegeven.  
De `ls`-opdracht zal als gevolg antwoord geven voor drie verschillende bestandsnamen (die in dit geval niet bestaan).

~~~~
student@studentdeb:~$  ls niet bestaand bestand
ls: cannot access 'niet': No such file or directory
ls: cannot access 'bestaand': No such file or directory
ls: cannot access 'bestand': No such file or directory
$student@studentdeb:~$  
~~~~

Stel dat je een bestandsnaam (of tekst) wil meegeven die spaties bevat, dan kan je de string afscheiden met aanhalingstekens (*quotes*) zoals hieronder:

~~~~
student@studentdeb:~$  ls "niet bestaand bestand"
ls: cannot access 'niet bestaand bestand': No such file or directory
~~~~

Naast dubbele aanhalingstekens (```"tekst"```) kun je ook enkele aanhalingstekens (```'tekst'```) gebruiken.

~~~~
student@studentdeb:~$  ls 'niet bestaand bestand'
ls: cannot access 'niet bestaand bestand': No such file or directory
student@studentdeb:~$  
~~~~

#### Variable en command substitution binnen strings

Enkele en dubbele aanhalingstekens hebben echter wel een **verschil** in **gedrag**. Dit verschil komt naar voren bij het gebruik van **variable substitution** en **command substitution**.

Als je een shellvariabele aanmaakt, kun je deze integreren binnen een string, zoals hieronder geïllustreerd:

~~~
student@studentdeb:~$ test=hello
student@studentdeb:~$ echo "$test world"
hello world
~~~

Als je daarentegen enkele aanhalingstekens gebruikt, zal de shell deze variabele niet vervangen door zijn waarde:

~~~
student@studentdeb:~$echo '$test world'
$test world
~~~

Net op dezelfde manier zal een command substitution wel werken als je die binnen dubbele aanhalingstekens plaatst:

~~~
student@studentdeb:~$ echo "Deze host is $(hostname -s) met Linux-kernel $(uname -r)"
Deze host is studentdeb met Linux-kernel 5.15.0-86-generic
~~~

Maar niet als je die binnen enkele aanhalingstekens plaatst:

~~~
student@studentdeb:~$ echo 'Deze host is $(hostname -s) met Linux-kernel $(uname -r)'
Deze host is $(hostname -s) met Linux-kernel $(uname -r)
~~~

### Scripts

#### shebang

Als je een **Bash-script** wilt schrijven in een editor zoals nano, dient dit altijd te **starten** met de volgende regel:

~~~
#!/bin/bash
~~~

We noemen het symbool `#!` ook wel een **shebang**. Deze bepaalt **welke script-interpreter** gebruikt wordt.  
Vervolgens kun je daaronder dan opdrachten plaatsen alsof je ze zelf in de shell zou typen. Deze zullen dan **sequentieel** (één voor één na elkaar) worden **uitgevoerd**:

~~~bash
#!/bin/bash
echo "Hello World"
echo "Het is vandaag $(date)"
~~~

Met `$(date)` voer je de opdracht `date` uit en krijg je de uitvoer als een string (command substitution). Die kun je dan achter de string "Het is vandaag" opnemen om te tonen met de opdracht `echo`.

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

**Bewaar** dit bestand in nano onder de naam `hello.sh`, sluit nano af, en voer het script in de shell als volgt uit:

~~~
student@studentdeb:~$ bash hello.sh 
Hello World
Het is vandaag Wed 15 Dec 2021 03:24:45 PM CET
student@studentdeb:~$ 
~~~

Zoals je ziet, worden beide opdrachten van in het script één na één uitgevoerd.

#### Uitvoeren als programma (en permissies)

Je kunt het **script** ook **uitvoeren** net zoals je een gewoon **programma/opdracht** uitvoert, zonder er `bash` voor te moeten typen.  

Dit werkt niet vanzelf:

~~~
student@studentdeb:~$ ./hello.sh
bash: ./hello.sh: No such file or directory
student@studentdeb:~$ bash ./hello.sh 
Hello World
Het is vandaag Wed 15 Dec 2021 03:24:45 PM CET
~~~

Merk op dat we de locatie van het script aangeven met `./` (de huidige directory). We leggen dadelijk uit waarom.

Als je naar de bestandspermissies (zie later) kijkt, zie je dat een script **standaard niet uitvoerbaar** gemaakt wordt:

~~~
student@studentdeb:~$ ls -l ./hello.sh
-rw-r--r-- 1 student student 61 Dec 15 15:24 ./hello.sh
~~~

Om het script toch uitvoerbaar te maken, dien je de **permissies** te **wijzigen** (meer hierover later). Dit doe je met de opdracht `chmod`:

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

En ja hoor, nu kun je het script gewoon uitvoeren zonder het te laten voorafgaan door `bash`:

~~~
student@studentdeb:~$ ./hello.sh 
Hello World
Het is vandaag Wed 15 Dec 2021 03:28:37 PM CET
student@studentdeb:~$
~~~

#### `$PATH`

Naast de variabelen die je zelf definieert, zorgt je besturingssysteem zoals we zagen ook voor een aantal omgevingsvariabelen. Een belangrijke is `PATH`.

Om een programma uit te voeren binnen Linux, moet je in principe altijd het exacte pad naar het programma opgeven.
Je kunt bijvoorbeeld, zoals we al zagen met hello.sh, niet een **script** uitvoeren dat in de werkdirectory staat door de **naam** te typen.

Toen we voorgaand script wilden uitvoeren als programma (zonder `bash` er voor te zetten), moesten we `./` ervoor plaatsen om de exacte locatie aan te geven (`.` verwijst naar je **werkdirectory**).

Er is echter een **uitzondering** op deze regel.  
Je systeem/shell voorziet een omgevingsvariabele `PATH`. Deze bevat een **lijst** van alle **locaties** waarin je shell naar **uitvoerbare programma's** zoekt.

~~~
student@studentdeb:~$ echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
student@studentdeb:~$
~~~

Als je in één van deze directory's gaat kijken, zul je zien
dat veel programma's die je reeds gebruikt hierin te vinden zijn.

Als we bijvoorbeeld kijken naar waar `ls` zich bevindt...

~~~
student@studentdeb:~$ ls /usr/bin/ls*
/usr/bin/ls           /usr/bin/lscpu        /usr/bin/lslogins  /usr/bin/lsof
/usr/bin/lsattr       /usr/bin/lsinitramfs  /usr/bin/lsmem     /usr/bin/lspci
/usr/bin/lsblk        /usr/bin/lsipc        /usr/bin/lsmod     /usr/bin/lspgpot
/usr/bin/lsb_release  /usr/bin/lslocks      /usr/bin/lsns      /usr/bin/lsusb
~~~

Als je nu wilt dat een directory aan dat zoekpad wordt toegevoegd, kun je deze variabele `PATH` wijzigen.  
In onderstaand voorbeeld vindt de shell geen `hello.sh`-script terug ondanks het feit dat deze in dezelfde directory staat.

~~~
student@studentdeb:~$ ls hello.sh
hello.sh
student@studentdeb:~$ hello.sh
bash: hello.sh: command not found
student@studentdeb:~$ echo $PATH 
/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
~~~

Als je echter je huidge werkdirectory toevoegt aan `PATH`...

~~~
student@studentdeb:~$ export PATH=/home/student/:$PATH
student@studentdeb:~$ echo $PATH
/home/student/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
~~~

...ga je zien dat het script wordt herkend door de tab completion als je de eerste letters h, e enzovoort typt en op tab drukt... en je kunt het script ook uitvoeren zonder de locatie aan te duiden:

~~~
student@studentdeb:~$ hello.sh 
Hello World
Het is vandaag Wed 15 Dec 2021 03:28:37 PM CET
student@studentdeb:~$ 
~~~

Merk op: de huidige directory aan `PATH` toevoegen is geen goed idee. Want wat als malware zich in die directory plaatst met de naam van een veel gebruikte opdracht zoals `ls`? Dan wordt de malware uitgevoerd als je in die directory `ls` intypt...

#### Argumenten

Je kunt aan zo'n **script** ook **argumenten** meegeven, net zoals we dit eerder bij programma's hebben gezien.

Binnen dat script kun je naar deze argumenten verwijzen via een `$` gevolgd door de positie van het argument:

* Het eerste argument kun je via `$1` bereiken
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
Op de opdrachtregel zijn er drie belangrijke elementen:

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

Het eerste element hebben we al een aantal keren toegepast bij het gebruiken van diverse opdrachten.  
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

In je eigen script kun je ook de exit-code instellen.  
Dat kun je via de opdracht `exit` gevolgd door een geheel getal (*integer*):

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
Vanuit de shell echter kun je deze **datastromen** doorgeven aan **andere toepassingen** via een aantal operatoren (`>`, `>>`, `<`, `|`).

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

Deze uitvoer kun je echter omleiden (*redirect*) naar een een bestand.
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

Als je ervoor wilt zorgen dat de foutboodschap naar een bestand wordt weggeschreven, kun je dit door een cijfer toe te voegen vóór het redirect-symbool. Voor de **stderr-stream** is dit altijd **2**:

~~~
student@studentdeb:~$ ls -l hello.sh.not 2> lserr
student@studentdeb:~$ cat lserr 
ls: cannot access 'hello.sh.not': No such file or directory
student@studentdeb:~$ 
~~~

Je kunt ook zorgen dat **beide** streams **tegelijkertijd** worden weggeschreven.  
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

Als je zowel stdout als stderr tegelijkertijd wil omleiden, kun je `&>` gebruiken.  
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

##### Redirection van stdout vanuit een ander proces/opdracht naar stdin via |

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


##### Redirection van stdout en stderr vanuit een ander proces/opdracht naar stdin via |&

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

