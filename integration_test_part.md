## Proeftest

Los al je vragen op binnen dit tekstbestand en upload dit naar Toledo.  

### Basisgedeelte (16 punten)

#### Gebruikers en permissies

Maak twee gebruikers **gwen** en **mark** aan op je Linux-systeem.  
Voeg beide gebruikers aan de groep **lectoren** toe.

Maak een directory **/home/lectoren/leerstof** aan en een directory **/home/lectoren/examens**.   
Zorg ervoor dat niemand de directory's leerstof en examens kan deleten.

Zorg ervoor dat enkel gwen en mark bestanden kunnen toevoegen aan beide directory's. Alle gebruikers op het systeem hebben toegang tot /home/lectoren/leerstof.

Buiten mark en gwen heeft er niemand toegang tot de directory /home/lectoren/examens.

Extra: Zorg er ook voor dat mark en gwen elkaars bestanden niet kunnen verwijderen.

Antwoord:

~~~bash

~~~

#### Modbits

Welke permissies stellen volgende **modbits** voor: **631**. Leg (heel beknopt) uit.  
Zet ook om naar de symbolische versie (die je verkrijgt met `ls -l`).

Antwoord:

~~~

~~~

#### Script toegankelijk maken

Ik voer volgende opdracht uit:

~~~
$ echo "echo Hello World" > ~/hello.sh
~~~

Waar komt dit script terecht?  
Welke twee extra opdrachten dien ik uit te voeren opdat ik het volgende kan doen vanuit gelijk welke directory:

~~~
$ hello.sh
Hello World
$
~~~

> Tip: zowel permissies als een specifieke variabele moeten ingesteld worden...

Antwoor:

~~~

~~~

#### Directory tonen

Toon de huidige directory via een script.
Gebruik hiervoor **command substitution**:

~~~
$ ./print_current_directory
Mijn huidige directory is /home/bart/test
~~~

Antwoord (script):

~~~bash

~~~

#### Opdrachten

Met welke opdracht kun je vanuit gelijk welke locatie naar de home-directory gaan?

~~~

~~~

Gegeven een directory **dossiers**, hoe kun je de volledige directory met inhoud kopiëren naar een nieuwe directory **backup_dossiers**?

~~~

~~~

Welke opdracht gebruik je om de huidige werkdirectory te zien?

~~~

~~~

Welke opdracht gebruik je om een leeg bestand aan te maken?


~~~

~~~

Ik wil alle bestanden en directory's tonen in volgorde van tijd, met de meest recente bestanden op het laatst:

~~~

~~~

#### crontab

Beschrijf een crontab (één regel) die een script **/home/students/test.sh** elke woensdag om 18:25 opstart:

~~~

~~~

### Gevorderd (4 punten)

#### Mini-scriptje

Schrijf een kort script dat een bestand kopieert.  
Geef beide namen mee als argument, zoals hieronder gedemonstreerd:

~~~
student@studentdeb:~$ ./copy_files.sh fileone filetwo
~~~

Het eerste bestand is het te kopiëren bestand.  
Zorg er wel voor dat je het bestand alleen kopieert als het doelbestand niet bestaat. Als dat al wel bestaat, toon je een duidelijke boodschap.

~~~bash

~~~

#### Heeft bart toegang tot de directory?

Gebruiker bart maakt deel uit van de groep students.

Die directory heeft de volgende eigenschappen:

~~~
$ ls -ld /home/students
drw-rwx--T 2 bart students 4096 Jan 25 20:24 /home/students/
$
~~~

Kan bart deze directory als werkdirectory (`cd /home/students/`) gebruiken?  
Waarom wel of niet?  Leg heel kort uit...

Antwoord:

~~~

~~~

#### umask

Ik voer de opdracht `umask 0065` uit.  
Leg bondig uit wat het gevolg hiervan is en wat het resultaat is als ik de volgende opdrachten uitvoer:

~~~
$ mkdir hello
$ touch world
~~~

Antwoord:

~~~

~~~

Bonus-vraag: ik wil graag dat deze umask-waardes telkens worden toegepast bij het inloggen. Hoe doe ik dat?
