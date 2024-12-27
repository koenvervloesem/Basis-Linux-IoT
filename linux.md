
## Intro

### Waarom Linux binnen IoT?

* Basiskennis vanuit het standpunt van een IoT-gebruiker/ontwikkelaar 
* 6 lessen
  * Focus op praktische kennis als gebruiker
  * Dus je wordt geen system-admin
* Focus op beheer en gebruik vanuit de terminal (desktop is bijkomstig)
* Wel praktisch gericht
  * Automatisatie
  * Configuratie
  * Netwerk, connecteren en setup
  * Logging
  * ... 

### Wat is Linux? Is het een besturingssysteem?

#### Linux is een kernel

Linux is een **kernel**, dat is het **deel** van je **besturingssysteem** dat instaat voor:

* **Beheren** en **interageren** met de **hardware** van je computer, smarthphone, IoT-device
* **Controleren** en **shedulen** van **processen** binnen je besturingssysteem
* **Beheren** van lowel level **(IO-)services** zoals networking, storage, virtualisatie, ...
* Voorzien in een **bestandsysteem**
* ...

Zo'n kernel kan je bekijken als de **motor** van het **besturingssysteem**.  
Deze zorgt er voor dat je **applicaties**, **scripten** en andere **software** kan **draaien** **zonder** de **details** te moeten kennen van de **hardware**.

#### Van Linux naar GNU/Linux (of beter gezegd van GNU naar GNU/Linux)

Met een motor alleen ben je echter niet veel, je moet als gewone eindgebruiker met dit besturingssysteem kunnen werken.  
Daarvoor worden en binnen een besturingssysteem - bovenop deze kernel - vele andere elementen voorzien zoals:

* Shell
* Systeem-utilities
* Services
* Libraries
* Window-managers
* Compilers, linkers, assembler, debuggers, ...
* Andere tools zoals tekst-editors, documentatie, ...
* ...

Het eigenlijke besturingssysteem dat wij gaan gebruiken in de cursus is **GNU/Linux** waar GNU het systeem is dat bovenop deze kernel ageert.  

~~~
       GNU/Linux     

    +-------------+ 
    |             | 
    |    GNU      | 
    |             | 
    +------+------+ 
           |   * system calls
           |   * ioctl
           |   * node files
           v   * ...    
    +-------------+ 
    |             | 
    |    LINUX    | 
    |             | 
    +-------------+ 
~~~

#### Een beetje geschiedenis...

GNU is een software-project dat opgestart werd in 1984 (+- 10 jaar voor Linux) door **Richard M. Stallman** (ook soms verwezen als RMS) en beoogde een compleet UNIX-compatibel systeem dat bestaat uit alleen "Free Software" (komen zo dadelijk terug op deze term).

> GNU staat voor "GNU's not UNIX", Stallman kon het gekibbel en licentievoorwaarden binnen de UNIX-wereld niet meer verkroppen

Begin jaren 90 was deze (huzaren)-taak voor een groot deel afgewerkt maar...  
Eén belangrijk onderdeel was echter nog niet afgewerkt, de kernel (met was gestart met GNU Hurd maar deze was nog niet klaar).

In 1991 stuurde echter een jong Finse student Linux Torvalds onderstaand volgende mail verstuurde naar een mailing-lijst

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

Deze mail is de start geweest van Linux, een "kleine" maar vrije kernel die zou uitgroeien
tot het meest gebruikte en gedeelde stuk software uit de geschiedenis.

Rond 1992, combineerde men de Linux Kernel als ontbrekend puzzelstuk met GNU en onstond er een nieuw
besturingssyteem dat een paar jaar later een enorme impact zou hebben op de wereld.

> Zie ook https://www.cs.cmu.edu/~awb/linux.history.html voor een diepgaande uitleg


#### GNU/Linux Distributies

Met GNU/Linux heb je echter in de praktijk nog geen werkend besturinggsysteem.  
Je moet deze tools en de kernel nog compileren, alles bundelen, de verschillende tools binnen een bestandssysteem organiseren, ...

Hiervoor bestaan de distributes zoals we vandaag kennen:

* Debian
* Fedora
* Ubuntu
* Suse
* ...

Deze zorgen distrubuties zorgen ervoor dat:

* De kernel, GNU-software en andere systeem-software wordt samengesteld tot een installeer pakket
* Testen en distributie
* Selectie van software
* Configuratie en keuze van frameworks
* Voorzien extra software om je systeem up to date te houden
* ...


~~~
       GNU/Linux    

    +-------------+ 
    |   DISTRO    |  (Debian, Fedora, Ubuntu, Suse, ...)
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

#### Zijn er niet GNU/Linux distro's

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

Daarnaast zijn er in de embedded Linux veel alternatieve systemen op basis van de Linux Kernel
die niet noodzakelijk gebruik maken van GNU-software
