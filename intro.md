# Deel 1 - Basis Linux

## Doel van de cursus

Met deze cursus willen we bereiken dat je als IoT-technicus je weg kan vinden binnen een GNU/Linux-systeem.  
Het is geen cursus over besturingssystemen of een *deep dive* in Linux-distributies.  
De cursus heeft als doel om wat handigheid op te bouwen in het werken met Linux.

### Cursusmateriaal

De cursus wordt deel per deel op Toledo beschikbaar gesteld.

Let op: dit is een 'levend document'. De cursus wordt elke les bijgewerkt en in zijn nieuwste versie op Toledo geüpload.

Wie aanvullende verdieping wil, mag altijd vragen om verwijzingen naar goede boeken of online bronnen.

### Stijl van lesgeven

Dit is een **praktische cursus**. We vliegen er onmiddellijk in met praktijk. Het is ook de bedoeling dat je in de les zelf meevolgt met de voorbeelden, zaken zelf uitprobeert en opdrachten uitvoert.

### Opdrachten op Toledo

Alle **oefeningen** uit de cursus die je **moet maken** worden aangeduid in Toledo **onder opdrachten**.

### Evaluatie

De ECTS-fiche van het vak beschrijft hoe je geëvalueerd wordt: <https://onderwijsaanbod.ucll.be/syllabi/n/MGI32B?ids=55754089%2C55754854>

De verdeling van de punten is:

Eerste zit:

* 50% permanente evaluatie tijdens de les
* 50% praktische eindopdracht

Tweede zit:

* 50% permanente evaluatie tijdens de les (overgedragen van eerste zit)
* 50% praktische opdracht met verdediging tijdens de examenperiode

In eerste zit is er dus geen examen.

## Waarom Linux binnen IoT?

* Basiskennis vanuit het standpunt van een IoT-gebruiker/ontwikkelaar 
* 7 lessen:
  * We focussen op praktische kennis als gebruiker
  * Je wordt dus geen systeembeheerder
* De nadruk ligt op beheer en gebruik vanuit de terminal (de grafische omgeving is bijkomstig)
* Praktische insteek:
  * inloggen op een Linux-machine (via de console)
  * configureren en opzetten van een Linux-distributie
  * navigeren binnen een Linux-machine
  * basisvaardigheden om bestanden, directory's en gebruikers te beheren
  * automatisatie
  * configuratie
  * netwerk configureren en opzetten
  * logging
  * ... 

## Wat is Linux? Is het een besturingssysteem?

### Linux is een kernel

Linux is een **kernel**, dat is het **deel** van je **besturingssysteem** dat instaat voor:

* **Beheren** van en **interageren** met de **hardware** van je computer, smartphone, IoT-apparaat
* **Controleren** en **uitvoeren** van **processen** binnen je besturingssysteem
* **Beheren** van *low-level* diensten voor in- en uitvoer zoals netwerken, opslag, virtualisatie, ...
* Voorzien in een **bestandssysteem**
* ...

Zo'n kernel kun je beschouwen als de **motor** van het **besturingssysteem**.  
Deze zorgt er voor dat je **toepassingen**, **scripts** en andere **software** kunt **draaien** **zonder** de **details** te moeten kennen van de **hardware**.

### GNU/Linux

Met een motor alleen ben je niet veel. Je moet als gewone eindgebruiker met het besturingssysteem kunnen werken.  
Daarvoor worden er binnen een besturingssysteem - bovenop deze kernel - vele andere elementen voorzien, zoals:

* Shell waaraan je opdrachten kunt geven
* Services die op de achtergrond allerlei taken uitvoeren
* Bibliotheken met functionaliteit die gedeeld wordt door diverse programma's
* Window managers
* Compiler, linker, assembler, debugger, ...
* Andere tools zoals teksteditors, documentatie, ...
* ...

Het eigenlijke besturingssysteem dat wij gaan gebruiken in de cursus is **GNU/Linux**, waar GNU de collectie van software is die bovenop de Linux-kernel werkt.

~~~
       GNU/Linux     

    +-------------+ 
    |             | 
    |    GNU      | 
    |             | 
    +------+------+ 
           |   
           |   system calls
           |   
           v  
    +-------------+ 
    |             | 
    |    LINUX    | 
    |             | 
    +-------------+ 
           |
           |
           |
           v

        Hardware
~~~

### Een beetje geschiedenis...

GNU is een softwareproject dat in 1984 (zo'n 10 jaar vóór Linux) opgestart werd door **Richard M. Stallman** (ook soms afgekort als RMS). Het beoogde een compleet UNIX-compatibel systeem te maken dat bestaat uit alleen "Free Software". We komen zo dadelijk terug op deze term.

> GNU staat voor "GNU's not UNIX". Stallman kon het gekibbel en de licentieproblematiek binnen de UNIX-wereld niet meer verkroppen.

Begin jaren 1990 was deze (huzaren)-taak voor een groot deel afgewerkt maar...  
Eén belangrijk onderdeel was echter nog niet afgewerkt, de kernel. Men was gestart met GNU Hurd als kernel, maar deze was nog niet klaar.

In 1991 stuurde echter een jonge Finse student, Linus Torvalds, onderstaande mail naar een mailing-lijst:

~~~
From: torvalds@klaava.Helsinki.FI (Linus Benedict Torvalds)
Newsgroups: comp.os.minix
Subject: What would you like to see most in minix?
Summary: small poll for my new operating system
Message-ID: <1991Aug25.205708.9541@klaava.Helsinki.FI>
Date: 25 Aug 91 20:57:08 GMT
Organization: University of Helsinki
Hello everybody out there using minix -
I'm doing a (free) operating system (just a hobby, won't be big and
professional like gnu) for 386(486) AT clones. This has been brewing
since april, and is starting to get ready. I'd like any feedback on
things people like/dislike in minix, as my OS resembles it somewhat
(same physical layout of the file-system (due to practical reasons)
among other things). I've currently ported bash (1.08) and gcc (1.40),and
things seem to work. This implies that I'll get something practical within a
few months, and I'd like to know what features most people would want.
Any suggestions are welcome, but I won't promise I'll implement them :-)
Linus (torvalds@kruuna.helsinki.fi)
PS. Yes - it's free of any minix code, and it has a multi-threaded fs.
It is NOT portable (uses 386 task switching etc), and it probably never
will support anything other than AT-harddisks, as that's all I have :-(.
~~~

Deze mail was de start van Linux, een "kleine" maar vrije kernel die zou uitgroeien
tot het meest gebruikte en gedeelde stuk software uit de geschiedenis.

Rond 1992 combineerde men de Linux-kernel als ontbrekend puzzelstuk met GNU en ontstond er een nieuw
besturingssysteem dat een paar jaar later een enorme impact zou hebben op de wereld.

Zie ook <https://www.cs.cmu.edu/~awb/linux.history.html> voor een diepgaandere uitleg over de geschiedenis van Linux.


### GNU/Linux-distributies

Met GNU/Linux heb je echter in de praktijk nog geen werkend besturingssysteem.  
Je moet deze tools en de kernel nog compileren, alles bundelen, de verschillende tools binnen een bestandssysteem organiseren, ...

Hiervoor bestaan de distributies zoals we vandaag kennen:

* Debian
* Fedora
* Ubuntu
* openSUSE
* ...

Distributies zorgen ervoor dat:

* De kernel, GNU-software en andere systeemsoftware wordt samengesteld tot één pakket dat je eenvoudig installeert.
* De combinatie getest en gepubliceerd wordt.
* Er software geselecteerd wordt.
* Softwareframeworks gekozen en geconfigureerd worden.
* Je systeem up-to-date wordt gehouden.
* ...


~~~
       GNU/Linux    

    +-------------+ 
    |   DISTRO    |  (Debian, Fedora, Ubuntu, openSUSE, ...)
    +-------------+ 
    +-------------+ 
    |             | 
    |    GNU      | 
    |             | 
    +-------------+ 
    +-------------+ 
    |             | 
    |    LINUX    | 
    |             | 
    +-------------+ 
~~~

### Zijn er Linux-distributies zonder GNU?

Linux is echter niet onlosmakelijk aan GNU verbonden en vormt
bijvoorbeeld ook de basis van Android.

~~~
       GNU/Linux                 Android

    +-------------+          +-------------+
    |   DISTRO    |          |   VENDOR    |
    +-------------+          +-------------+
    +-------------+          +-------------+
    |             |          |             |
    |    GNU      |  <--->   |    AOSP     |
    |             |          |             |
    +-------------+          +-------------+
    +-------------+          +-------------+
    |             |          |             |
    |    LINUX    |          |    LINUX    |
    |             |          |             |
    +-------------+          +-------------+
~~~

Zie <https://source.android.com> voor het Android Open Source Project (AOSP).

Daarnaast zijn er in embedded Linux veel alternatieve systemen op basis van de Linux-kernel
die niet noodzakelijk gebruikmaken van GNU-software.
