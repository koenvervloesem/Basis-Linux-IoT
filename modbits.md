## Toegang tot bestanden controleren

### Bestandspermissies

Binnen **Linux** is het mogelijk om de **toegang** tot **bestanden** en **directory's** te **controleren** en **beheren**.
Dit doen we aan de hand van **bestandspermissies**.

Dit is een **eenvoudig** maar **flexibel** **mechanisme**, waarmee je de meest voorkomende scenario's voor toegangscontrole kunt afhandelen.

> Nota:  
> Dit is niet het enige mechanisme dat bestaat in Linux.
> In meer geavanceerde scenario's zou het ook kunnen dat
> je - als systeembeheerder bijvoorbeeld - **SELinux-permissies**
> dient aan te passen.  
> Dit val echter niet onder het korte bestek van deze (relatief korte) cursus.

#### Permissies bekijken met `ls -l`

We hebben al eerder gezien dat je via de opdracht `ls` - meer bepaald met de optie `-l` - de details van een bestand kunt opvragen.  
Deze opdracht toont ook informatie met betrekking tot de toegang tot bestanden en directory's.

Bijvoorbeeld:

~~~
student@studentdeb:~$ ls -l
...
-rw-r--r-- 1 student student      0 Dec 22 10:58  file
-rwxr-xr-- 1 student student      0 Nov 24 12:14  file1
-rw-r--r-- 1 student student      0 Dec 22 10:58  file11
-rw-rw-rw- 1 student student      0 Nov 24 12:14  file2
-rw-r--r-- 1 student student      0 Dec 22 11:25  filea
-rw-r--r-- 1 student student      0 Dec 22 11:31  fileb
drwxr-xr-x 2 student student   4096 Oct 27 19:06  hello
...
student@studentdeb:~$ 
~~~

De gegevens die we hier zien en betrekking hebben op **toegang/autorisatie** zijn:

* **Welke permissies** zijn geconfigureerd voor dit bestand (of directory)?
* **Welke gebruiker** is **eigenaar** van dit bestand/directory?
* Tot **welke groep** behoort dit bestand (niet noodzakelijk een groep van de gebruiker)

~~~
          permissies    user   group
          ____|____   ___|___ ___|___
          |       |   |     | |     |
         -rwxr-xr-- 1 student student      0 Nov 24 12:14  file1
         |
  type --+
~~~

##### Type van bestand

Het **eerste teken** geeft het **type** van het **bestand** aan:

* Het symbool **-** voor een **normaal bestand**
* **d** voor een **directory**
* **l** voor een *soft link* of **symbolic link** (verwijzing) naar een ander bestand
* Minder voorkomende types zijn:
  * **c** voor een **character device**
  * **b** voor een **block device**
  * **s** voor een **local domain socket**
  * **p** voor een **named pipes**

##### Permissies

De **volgende negen tekens** duiden de permissies aan.  
We zien daarin de volgende soorten tekens:

* **r,w,x** stellen respectievelijk **read, write en execute** voor
* Het teken **-** houdt het ontbreken van een permissie in

Deze **negen tekens** (rwxr-xr--) zijn onderverdeeld in **drie categorieën**: **user**, **group** en **other**:

~~~
   user --+  group --+  other --+
          |          |          |
         rwx        r-x        r--
~~~

#### Permissies voor wie?

Er zijn dus drie categorieën van gebruikers voor de permissies. Op deze drie niveaus wordt er bepaald wie er recht heeft om met een bestand te kunnen werken: 

* **user** of **u**:
  De **user** is de eigenaar van het bestand.
  Elk bestand is eigendom van een gebruiker. Meestal is dit degene die het bestand heeft gemaakt.
* **group** of **g**:
  Iedereen die tot de groep behoort waartoe het bestand toegekend is.  
  Het bestand behoort dus ook tot een groep.  
  Meestal is dit de primaire groep van de gebruiker 
  die het bestand heeft aangemaakt 
  (maar dat kan worden gewijzigd).
* **other**  of **o**:
  Iedereen die **niet** tot de **twee bovenvermelde niveaus** behoort, 
  met andere woorden niet de gebruiker of de groep waartoe het bestand behoort.

##### Hoe worden de permissies toegepast?

We weten nu dat er drie permissieniveaus bestaan. Wanneer en hoe worden deze nu toegepast?

Elk bestand en enkele directory binnen Linux heeft een gebruiker en een groep.
Beide worden gebruikt om permissies te vergelijken.  

In dit voorbeeld zie je dat **file1** de gebruiker **student** en de groep **student** heeft:

~~~
          permissies    user   group
          ____|____   ___|___ ___|___
          |       |   |     | |     |
  file1  -rwxr-xr-- 1 student student      0 Nov 24 12:14  file1
         |
  type --+
~~~

De permissies zijn in drie niveaus onder te verdelen (user, group en other):

~~~
   user --+  group --+  other --+
          |          |          |
         rwx        r-x        r--
~~~

**Wanneer** gaan we nu **welk** van deze drie **permissieniveaus** toepassen (`rwx`, `r-x` of `r--`)?  
Dit wordt bepaald door **drie elementen**:

* De **user** en **group** van het bestand, in dit geval `student` en `student`
* De **user** die **ingelogd** is en een bewerking met het bestand wil doen
* De **groepen** - primair of secundair - waartoe de gebruiker behoort

Als een **user** een bestand wil gebruiken, zal Linux de volgende **regel** toepassen:

* Komt de **user** die **ingelogd** is overeen met de **user** van het bestand:
  * Dan wordt het niveau **user** (het eerste blok) toegepast 
  * In dit geval is dit dus `rwx`
* **Anders** (als de gebruikers niet overeenkomen) kijkt het systeem na:
  * Of de **groep** van het bestand (student) een groep is waartoe de gebruiker behoort
  * Dan wordt het niveau **group** (het tweede blok) toegepast
  * In dit geval dus `r-x`
* Als dit ook niet voldaan is (noch gebruiker noch groep komen overeen): 
  * Dan wordt het niveau **other** (derde blok) toegepast
  * In dit geval dus `r--`


#### Wat betekenen deze permissies?

Elk van de drie **niveaus** van permissies bestaat uit **drie soorten rechten**  (r,w,x).
Deze hebben de volgende betekenis voor bestanden of directory's:

* **r** of **read**  
  * Een bestand kan **gelezen** worden.  
  * Van een **directory** kan men de **inhoud bekijken**.  
    (met bijvoorbeeld `ls`)
* **w** of **write**  
  * Een bestand kan **gewijzigd** worden.  
  * In een **directory** kan men bestanden toevoegen of verwijderen.
* **x** of **execute**  
  * Een bestand kan **uitgevoerd** worden als opdracht.  
  * Een **directory** kan je als **werkdirectory** gebruiken. 
    Met andere woorden: je kunt `cd` naar deze directory uitvoeren.  
    Let wel dat je ook **read permissions** nodig hebt.

#### Interpreteren van een permissieniveau

Per permissieniveau wordt er voor elk recht aangeduid of het van toepassing of niet.  

* Elke recht heeft zijn eigen afkorting 
  * r voor read
  * w voor write
  * x voor execute
* Deze worden altijd in een specifieke volgorde getoond
  * eerst read, dan write en als laatste execute
* Als het recht niet is toegekend wordt er een **-** in de plaats gezet


Dus bijvoorbeeld:

* `rwx` betekent: 
  * dat je het bestand kan lezen, schrijven en uitvoeren
* `rw-` betekent: 
  * dat je het bestand kan lezen, schrijven 
  * maar niet kan uitvoeren


~~~
   user --+  group --+  others --+
          |          |           |
         rwx        r-x         r--
~~~


### Permissies in actie

Als we voorgaande regels bij elkaar plaatsen, kunnen we gaan bekijken:

* wie oftewel welke ingelogde gebruiker
* wat kan uitvoeren
* op welk bestand

#### Permissies en eigenaars van bestanden

Zoals eerder gezien geeft de opdracht `ls -l` ons meer **gedetailleerde** informatie over een bestand:

~~~
student@studentdeb:~$ ls -l test.txt 
-rwxr--r-- 1 student students 192 Oct 27 14:33 test.txt
~~~

De informatie kunnen we als volgt interpreteren:

* Drie blokken tonen welke permissies zijn toegekend per soort gebruiker:
  * `rwx` dat aangeeft welke rechten de gebruiker heeft op dit bestand  
    (**r**ead - **w**rite - e**x**ecute)
  * `r-x` die aangeeft welke rechten leden van de **groep** gelinkt aan dit bestand hebben  
    (**r**ead - e**x**ecute)
  * `r--` die aangeeft welke rechten anderen (niet gelinkt aan dit bestand) hebben  
    (**r**ead)
  * (`-` betekent dat het recht niet toegekend is)
* Daarop volgen de gebruiker en groep waartoe dit bestand behoort:
  * Gebruiker `student`
  * Groep `students`

Samengevat betekent dit dat dit bestand (test.txt) **eigendom** is van de gebruiker **student** en de groep **students**.  

* **Iedereen** heeft het recht om dit bestand te **lezen**.
* Alleen de gebruiker **student** zelf leden van de groep **students** hebben het **recht** deze **uit te voeren**.
* Alleen de gebruiker **student** kan dit bestand bewerken.

#### Permissies en eigenaars van directory's

**Ook** voor **directory's** kan je dit **nakijken**. Maar als je dit met `ls -l` doet, zie je alleen
de rechten op de subdirectory's of bestanden:

~~~
student@studentdeb:~$ ls -l /home
total 16
drwxr-xr-x 14 bart    bart    4096 Oct 13 16:09 bart
drwxr-xr-x  2 joske   joske   4096 Oct 27 19:32 joske
drwxr-xr-x  2 joske2  test    4096 Oct 27 19:35 joske2
drwxr-xr-x 21 student student 4096 Nov 24 10:35 student
~~~

Als je de informatie wilt zien voor de directory zelf, gebruik je de optie `-d` met `ls -ld`:

~~~
student@studentdeb:~$ ls -ld /home
drwxr-xr-x 5 root root 4096 Oct 27 12:21 /home
~~~

Hier zie je dan de **rechten** en andere informatie op de **directory zelf**.

### Wijzigen van permissies met chmod

Met de opdracht `chmod` kan je deze rechten toevoegen of afnemen...  
Je kan deze opdracht op twee manieren toepassen:

* met symbolen
* met getallen

#### Met symbolen

~~~
chmod {Wie}{Wat}{Welk} {file|directory}
~~~

* **Wie**? Target...
  * **u** => gebruiker/eigenaar van het bestand
  * **g** => groep waartoe het bestand behoort
  * **o** => other, iedereen verschillend van hierboven
  * **a** of **ugo** => "all", iedereen
* **Wat**?  Toegepast op wie/target
  * **+** => add => Voeg een permissie toe (voor het target hierboven)
  * **-** => remove => Neem een permissie af
  * **=** => set exactly => Zet deze permissie exact (andere permissies worden afgenomen)
* **Welke** permissies?
  * **r** => read of leesrechten
  * **w** => write of schrijfrechten
  * **x** => execute oftewel het recht om het bestand uit te voeren als een programma

In onderstaand **voorbeeld** maken we twee bestanden aan:

* Bij **file1** nemen we **rw**-rechten **af** voor de **groep** en **andere** gebruikers
* Bij **file2** kennen we **recht** van **uitvoering** aan **iedereen** toe 
  (je kan ook **ugo** gebruiken in plaats van **a** in dit geval)

~~~
student@studentdeb:~$ rm file*
student@studentdeb:~$ touch file1
student@studentdeb:~$ touch file2
student@studentdeb:~$ ls -l file*
-rw-r--r-- 1 student student 0 Nov 24 12:14 file1
-rw-r--r-- 1 student student 0 Nov 24 12:14 file2
student@studentdeb:~$ chmod go-rw file1
student@studentdeb:~$ chmod a+x file2
student@studentdeb:~$ ls -l file*
-rw------- 1 student student 0 Nov 24 12:14 file1
-rwxr-xr-x 1 student student 0 Nov 24 12:14 file2
~~~

* Bij file2 stellen we vervolgens een exacte permissie in.  
  Je ziet dat de (vorige) toegekende rechten zijn overschreven...

~~~
student@studentdeb:~$ chmod a=rw file2
student@studentdeb:~$ ls -l file2
-rw-rw-rw- 1 student student 0 Nov 24 12:14 file2
~~~

#### Met getallen

Een tweede manier is het werken met getallen om deze rechten toe te kennen of af te nemen.  

Op deze manier kun je rechten alleen exact toekennen (equivalent tot de =-optie bij `chmod` met symbolen). 
Het is wel belangrijk om deze manier te kennen. Binnen sommige (minimale embedded Linux-)omgevingen is immers misschien alleen deze methode beschikbaar.

Het **basisprincipe** is dat aan elke permissie een getalwaarde wordt toegekend:

* **r** = **4**
* **w** = **2**
* **x** = **1**

Per permissieniveau (**u**ser-**g**roup-**o**ther) ga je telkens de som maken van deze drie permissies:

1. Je start met 0.
2. Heb je leesrechten nodig, dan tel je 4 hierbij op.
3. Heb je schrijfrechten nodig, dan tel je 2 op.
4. Heb je uitvoerrechten nodig, dan tel je 1 op.

Bijvoorbeeld:

* 7 (4 + 2 + 1) zal overéén komen met rwx (alle rechten)
* 6 (4 + 2) met lees- en schrijfrechten
* 5 (4 + 1) met lees- en uitvoerrechten
* 4 (4) met alleen leesrechten
* ...

Daarna combineer je dan drie cijfers met elkaar tot één getal (in volgorde van links naar rechts):

* Eerste cijfer voor de gebruikersrechten
* Tweede cijfer voor de groepsrechten
* Derde cijfer voor de rechten toegekend aan other

Bijvoorbeeld het equivalent van `rwxr-xr--` is "754".

~~~
rwx = 4 + 2 + 1 = 7
r-x = 4 + 0 + 1 = 5 
r-- = 4 + 0 + 0 = 4
~~~

We passen dit toe als volgt...

~~~
student@studentdeb:~$ chmod 754 file1
student@studentdeb:~$ ls -l file1
-rwxr-xr-- 1 student student 0 Nov 24 12:14 file1
~~~

... en zien dat deze permissies worden aangepast als beschreven.

### Eigenaar wijzigen met `chown` en `chgrp`

We kunnen ondertussen de permissies van bestanden aanpassen. Nu moeten we nog leren om de eigenaar aan te passen...

Om te starten maken we - met de gebruiker `student` - een directory en twee bestanden aan:

~~~
student@studentdeb:~$ rm -rf test*
student@studentdeb:~$ touch test_file
student@studentdeb:~$ mkdir test_dir
student@studentdeb:~$ touch ./test_dir/test_file
~~~

De bestanden en directory's die worden aangemaakt, krijgen automatisch de gebruiker student en de bijhorende primaire groep student toegekend:

~~~
student@studentdeb:~$ ls -ld test_*
drwxr-xr-x 2 student student 4096 Nov 24 13:59 test_dir
-rw-r--r-- 1 student student    0 Nov 24 13:59 test_file
student@studentdeb:~$ ls -l ./test_dir/
total 0
-rw-r--r-- 1 student student 0 Nov 24 14:05 test_file
student@studentdeb:~$ 
~~~

#### Gebruiker wijzigen

Om de **eigenaar** van een bestand te **wijzigen**, gebruiken we de opdracht `chown`.  
Dit kan zowel de gebruiker als de groep waartoe een bestand/directory behoort wijzigen:

~~~
student@studentdeb:~$ chown bart test_file 
chown: changing ownership of 'test_file': Operation not permitted
~~~

Zoals je ziet, moet je als superuser inloggen. Je kan immers niet zomaar een bestand toekennen aan een andere gebruiker:

~~~
student@studentdeb:~$ su -
Password: 
root@studentdeb:~# cd /home/student/
~~~

Vervolgens **passen** we de **gebruiker** **aan** van het bestand `test_file` met de opdracht `chmod`, gevolgd door de **nieuwe eigenaar** en het bestand waarvan je de eigenaar wilt wijzigen:

~~~
root@studentdeb:/home/student# chown bart test_file
root@studentdeb:/home/student# ls -ld test_*
drwxr-xr-x 2 student student 4096 Nov 24 13:59 test_dir
-rw-r--r-- 1 bart    student    0 Nov 24 13:59 test_file
~~~

#### Eigenaar van een directory

Hetzelfde mechanisme geldt voor een directory...

~~~
root@studentdeb:/home/student# chown bart test_dir
~~~

Wel zie je dat alleen de directory zelf is gewijzigd:

~~~
root@studentdeb:/home/student# ls -ld test_dir
drwxr-xr-x 2 bart student 4096 Nov 24 14:05 test_dir
root@studentdeb:/home/student# ls -l test_dir
total 0
-rw-r--r-- 1 student student 0 Nov 24 14:05 test_file
root@studentdeb:/home/student# 
~~~

#### Eigenaar van een directory recursief wijzigen

Als je wilt dat ook alle onderliggende bestanden en directory's gewijzigd worden, gebruik je de optie `-R`:

~~~
root@studentdeb:/home/student# chown -R bart test_dir
root@studentdeb:/home/student# ls -ld test_dir
drwxr-xr-x 2 bart student 4096 Nov 24 14:05 test_dir
root@studentdeb:/home/student# ls -l test_dir
total 0
-rw-r--r-- 1 bart student 0 Nov 24 14:05 test_file
~~~

#### Groep wijzigen

Als je de groep (in plaats van de gebruiker) van een bestand of directory wilt wijzigen, gebruik je
dezelfde vorm maar plaats je een dubbele punt voor de groepsnaam:

~~~
root@studentdeb:/home/student# chown :bart test_dir
root@studentdeb:/home/student# ls -ld test_dir
drwxr-xr-x 2 bart bart 4096 Nov 24 14:05 test_dir
root@studentdeb:/home/student# ls -l test_dir
total 0
-rw-r--r-- 1 bart student 0 Nov 24 14:05 test_file
~~~

Je kan hetzelfde doen met de opdracht `chgrp`. Dan heb je geen dubbele punt nodig:

~~~
root@studentdeb:/home/student# chgrp bart test_dir
...
~~~

#### Tegelijk gebruiker en groep wijzigen

Tenslotte zetten we `test_dir` terug naar de oorspronkelijke gebruiker en groep.  
Je kan dit in één keer doen door de gebruiker en groep te combineren met een dubbele punt 
(user:group):

~~~
root@studentdeb:/home/student# chown -R student:student test_dir
root@studentdeb:/home/student# ls -ld test_dir
drwxr-xr-x 2 student student 4096 Nov 24 14:05 test_dir
root@studentdeb:/home/student# ls -l test_dir
total 0
-rw-r--r-- 1 student student 0 Nov 24 14:05 test_file
root@studentdeb:/home/student# 
~~~

### Speciale permissies (u+s, g+s, o+t)

We hadden eerder al drie types van permissies gezien:

* **r** => read of leesrechten
* **w** => write of schrijfrechten
* **x** => execute oftewel het recht om een bestand uit te voeren als programma

Naast deze hebben we drie andere mogelijkheden: SUID, SGID en sticky bit.

#### SUID 

Dit is de afkorting van  **"Set owner User ID up on execution"**.  
Dit houdt in dat als je een bestand uitvoert, alle acties (zoals bijvoorbeeld bestanden creëren) worden uitgevoerd met de rechten van de eigenaar (in plaats van die van de gebruiker die het script uitvoert op dat moment).

Dit is alleen van toepassing op **bestanden**, niet op directory's...  
Om dit toe te kennen aan een bestand, geef je de gebruiker de permissie s op een bestand:

~~~
root@studentdeb:/home/student# chmod u+s /usr/bin/passwd
~~~

Een voorbeeld waar Linux dit gebruikt, is de opdracht `passwd`. Dit wordt als gebruiker root uitgevoerd, ondanks dat je het als je eigen gebruiker start:

~~~
student@studentdeb:~$ ls -l /usr/bin/passwd
-rwsr-xr-x. 1 root root 35504 Nov 16 2021 /usr/bin/passwd
~~~

#### SGID

Dit is de afkorting van **"Set Group ID up on execution"**.  
Dit is van toepassing op zowel bestanden als directory's met een licht andere betekenis:

* Voor een **bestand** betekent dit dat je het bestand uitvoert met de groep die toegekend is aan het bestand.
* Voor een **directory** betekent dit dat bestanden binnen deze directory automatisch de groep van deze directory toegekend krijgen (en niet deze van de gebruiker die een bestand toevoegt).

Om dit toe te kennen, gebruik je `chmod g+s`:

~~~
student@studentdeb:~$ ls -ld testa
drwxr-xr-x 2 student student 4096 Nov 24 19:18 testa
student@studentdeb:~$ chmod a+rwx testa/
student@studentdeb:~$ ls -ld testa/
drwxrwxrwx 2 student student 4096 Nov 24 19:18 testa/
student@studentdeb:~$ chmod g+s testa
student@studentdeb:~$ ls -ld testa/
drwxrwsrwx 2 student student 4096 Nov 24 19:21 testa/
~~~


~~~
student@studentdeb:~$ ls -ld testa/
drwxrwsrwx 2 student student 4096 Nov 24 19:18 testa/
~~~

~~~
student@studentdeb:~$ su - bart
Password: 
bart@studentdeb:~$ cd ../student/testa/
bart@studentdeb:/home/student/testa$ ls
bart@studentdeb:/home/student/testa$ touch aa
bart@studentdeb:/home/student/testa$ ls -l
total 0
-rw-r--r-- 1 bart student 0 Nov 24 19:21 aa
bart@studentdeb:/home/student/testa$ 
~~~

#### Sticky bit

De sticky bit is alleen van toepassing op directory's. Als je dit voor een directory instelt, kunnen bestanden in die directory alleen verwijderd worden door de eigenaar van het bestand, de eigenaar van de directory, of de rootgebruiker. Anderen kunnen dit niet, ook al hebben ze schrijf- en uitvoerrechten op de directory.

Je stelt het sticky bit in met `chmod o+t`:

```
student@studentdeb:~$ mkdir sticky_dir
student@studentdeb:~$ chmod +t sticky_dir
student@studentdeb:~$ ls -ld sticky_dir
drwxrwxr-t 2 student student 4096 okt  3 15:50 sticky_dir
```

Creëer nu in deze directory een bestand:

```
student@studentdeb:~$ cd sticky_dir
student@studentdeb:~$ touch test.txt
```

Schakel nu met `su` over naar een andere gebruiker (niet root), die tot dezelfde groep als de eerste gebruiker behoort, en probeer het bestand te verwijderen:

```
student@studentdeb:~$ su bart
bart@studentdeb:~$ rm test.txt
```

Dit lukt nu niet. Het sticky bit in de directory voorkomt immers het verwijderen of wijzigen van bestanden van andere gebruikers. Dit wordt typisch gebruikt in de gedeelde directory `/tmp` voor tijdelijke bestanden.

#### Numerieke voorstelling

Deze **speciale permissies** hebben net zoals de andere permissies een numerieke voorstelling:

* **1** voor **sticky bit**
* **2** voor **SGID**
* **4** voor **SUID**

Bijvoorbeeld 6775 zal zowel de SGID- en SUID-bits zetten (6 = 4 + 2), naast de bijhorende standaard permissies rwx, rwx en r-x.

#### s vs S

Als je **SUID** (bij de gebruiker) of **SGID** (bij de groep) configureert, zie je in de uitvoer van `ls`
een **s** verschijnen zoals hieronder:

~~~
student@studentdeb:~$ ls -ld derde/
drwxrwxrwx 2 student student 4096 Nov 24 19:48 derde/
student@studentdeb:~$ chmod g+s derde/
student@studentdeb:~$ ls -ld derde
drwxrwsrwx 2 student student 4096 Nov 24 19:48 derde
~~~

Een kleine **s** duidt aan dat zowel deze speciale bit (SUID of SGID) is gezet maar ook dat de 
**x**-permissie is ingesteld.  

Als je echter de directory configureert **zonder execute** maar wel met **SUID** of **SGID**, zie
je een grote **S** in plaats van een kleine **s** verschijnen:

~~~
student@studentdeb:~$ chmod g-s derde/
student@studentdeb:~$ ls -ld derde
drwxrwxrwx 2 student student 4096 Nov 24 19:48 derde
student@studentdeb:~$ chmod g-x derde/
student@studentdeb:~$ ls -ld derde
drwxrw-rwx 2 student student 4096 Nov 24 19:48 derde
student@studentdeb:~$ chmod g+s derde/
student@studentdeb:~$ ls -ld derde
drwxrwSrwx 2 student student 4096 Nov 24 19:48 derde
student@studentdeb:~$ ls -ld derde
drwxrwsrwx 2 student student 4096 Nov 24 19:48 derde
~~~

### Standaardpermissies en het umask

#### Standaardpermissies

Op een Linux-systeem worden standaard de volgende **permissies** toegekend:

* Voor bestanden **0666** of **rw-rw-rw**
* Voor directory's **0777** of **rwxrwxrwx**

#### Standaardpermissies in de praktijk

Als voorbeeld maken we met onze gebruiker een leeg bestand en een nieuwe directory aan...  
We bekijken de permissies van dit bestand en deze directory:

~~~
student@studentdeb:~$ touch hello.txt 
student@studentdeb:~$ mkdir hello_dir
student@studentdeb:~$ ls -ld hello*
drwxr-xr-x 2 student student 4096 Nov 24 15:57 hello_dir
-rw-r--r-- 1 student student    0 Nov 24 15:57 hello.txt
~~~

...en zien:

* `rwxr-xr-x` of **0755** voor een **directory**
* `rw-r--r--` of **0644** voor een **bestand**

Hoe komt het dat deze permissies niet 666 en 777 zijn?

#### umask

Dit komt door de **umask**. Dit is een waarde die wordt ingeladen **per shell-sessie**. Je kan deze opvragen met de opdracht `umask`:

~~~
student@studentdeb:~$ umask
0022
student@studentdeb:~$ 
~~~

Deze waarde is hier **0022** en de cijfers worden **afgetrokken** (niet helemaal, we nuanceren later) van die van de **permissies**.  

In eerder voorbeeld zien we dat:

* **0777** min **0022** wordt **0755** voor de **directory**
* **0666** min **0022** wordt **0644** voor een **bestand**

De feitelijke permissies die standaard worden toegepast, worden dus mee bepaald door deze umask-waarde.

~~~
student@studentdeb:~$ umask
0022
student@studentdeb:~$ ls -ld hello*
drwxr-xr-x 2 student student 4096 Nov 24 15:57 hello_dir
-rw-r--r-- 1 student student    0 Nov 24 15:57 hello.txt
~~~

#### Het umask-mechanisme op modbit-niveau

In het vorige voorbeeld legden we uit dat de umask-waarde gewoon afgetrokken wordt van de standaardpermissies om de in realiteit toegepaste standaardpermissies te verkrijgen.

Dat klopt niet helemaal.

Laten we dit eens illustreren met een ander voorbeeld. Met de opdracht `umask` kunnen we de umask-waarde wijzigen voor de huidige Bash-sessie. Stel dat we die wijzigen van 022 naar 023:

~~~
student@studentdeb:~$ umask
0002
student@studentdeb:~$ umask 0023
student@studentdeb:~$ umask
0023
~~~

We verwachten dus als permissies 0666 - 0023 = 0643.

Vervolgens maken we een **nieuw bestand** aan en **bekijken** we de **permissies**:

~~~
student@studentdeb:~$ touch umasktest
student@studentdeb:~$ ls -l umasktest 
-rw-r--r-- 1 student student 0 Mar 20 21:10 umasktest
student@studentdeb:~$ 
~~~

We zien dat de modbits **niet 643** (`rw-r---wx`) maar **644** (`rw-r--r--`) zijn.  

Hebben we hier **verkeerd geteld**?  
**Neen**, de eigenlijke bewerking is **geen verschil** van de **permissies** en de **umask**-waarde.

Je moet het umask eerder bekijken als een **soort van masker**, met de volgende regels:

* Elke **modbit** (rwx) van de **originele** **permissie** wordt **vergeleken** met dezelfde **modbit** (rwx) binnen de **umask**.
* Is de **overeenkomstige** **modbit** binnen de **umask** **0**, dan **behouden** we de originele **modbit** in de **permissie**.
* Staat deze modbit echter op **1**, dan wordt het overeenkomstige bit automatisch **geforceerd** op **0** gezet.

Zie voor de toepassing naar onderstaande vergelijking:

~~~
       GETALLEN    
       rwx rwx rwx
666 => 420 420 420
023 => 000 020 021
       -----x---x-
644 <= 420 400 400
~~~

De waarde is nu 644 ipv 643 omdat modbits die al op 0 stonden (zoals de x-modbit voor other) 0 blijven.  
Als gevolg zal een umask van 023 of 022 geen verschil uitmaken voor bestanden, aangezien de x-bit daarvoor automatisch al uit staat.

Op niveau van bit-operaties (boolean algebra) wordt er een &-operatie uitgevoerd gecombineerd met een inversie...

~~~
       GETALLEN       BITS
       rwx rwx rwx    rwx rwx rwx
666 => 420 420 420 => 110 110 110
023 => 000 020 021 => 111 101 100 (~000 010 011)
       -----x---x-  & -----------
644 <= 420 400 400 <= 110 100 100
~~~

In code (C-code bijvoorbeeld, zie het vak "Embedded programmeren") zou je dit als volgt kunnen uitdrukken:

~~~c
default_permissie = 666;
umask = 023;
permissie = default_permissie & ~(umask);
~~~

### Oefening

#### Opgave

In deze oefening maak je een map aan die gebruikers binnen dezelfde groep kunnen gebruiken 
om bestanden te delen waartoe de hele groep toegang heeft.  

De **setup**:

* **vier gebruikers**
  * **hilde, marie, jan, joris**
  * **wachtwoord** is hetzelfde als hun **naam**
* Een groep noem je **operators**
  * De vier voorgaande **gebruikers** behoren tot deze **groep**
* Een directory `/home/operators`
  * Enkel **root** en leden van de groep **operators** kunnen bestanden binnen deze directory **lezen, creëren en verwijderen** 
  * Bestanden die je aanmaakt binnen deze map worden **automatisch toegekend** aan de groep **operators**
  * Let wel, elke **gebruiker** mag **enkel bestanden verwijderen** die **zij/hij heeft aangemaakt**

Gebruik in je opdrachten de numerieke permissies.

* **Bewaar** al de opdrachten die je hiervoor gebruikte (in volgorde) in een **script** (`make_operators.sh`)
* **Demonstreer** deze permissies in de **shell** en copy-paste deze bash-sessie in een apart tekstbestand (permissions.txt)

Bonus-vraag:

* Maak een **script** dat deze **directory, groepen en gebruikers** opkuist (verwijdert) uit het systeem.

#### Oplossing

Voor het **eerste deel** kon je bijna alle opdrachten in een **script** plaatsen.  
Met **uitzondering** van het initialiseren van het wachtwoord, dit moet je interactief doen.
(Er bestaan manieren om dit ook binnen het script te doen, maar dat valt buiten het bestek van deze cursus.)

##### Script

~~~bash
#!/bin/bash

# Create users and groups
useradd -c "Hilde" -m -s /bin/bash hilde
useradd -c "Marie" -m -s /bin/bash marie
useradd -c "Jan" -m -s /bin/bash jan
useradd -c "Joris" -m -s /bin/bash joris
groupadd operators

# Add users to groups
usermod -aG operators hilde
usermod -aG operators marie
usermod -aG operators jan
usermod -aG operators joris
mkdir /home/operators

# Set root as owner and operators as group
chown root:operators /home/operators

# Only users and groups are allowed to access the files inside
chmod a-rwx /home/operators
chmod g=rwsx /home/operators
chmod u=rwx /home/operators

# Set sticky bit on folder in order to avoid deletions by other users
chmod +t /home/operators
~~~

##### Clean up

Je kan volgend script gebruiken om alle gebruikers, groepen en folders te verwijderen

~~~bash
# Delete the users
userdel -r -f joris
userdel -r -f jan
userdel -r -f marie
userdel -r -f hilde

# Delete the operators-group
groupdel operators

# Delete the operators-directory
rm -rf /home/operators
~~~
