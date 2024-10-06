## Bash (vervolg)

### Patterns

Bash beschikt over verschillende manieren om het werken op de opdrachtregel te vergemakkelijken.  
Eerder hadden we functionaliteit gezien zoals:

* **Tab completion**: Als je op de Tab-toets drukt tijdens het typen van opdrachten of bestandsnamen zal de shell een poging doen om deze te vervolledigen.
* **Geschiedenis**
  * Met de pijltjes naar boven en naar beneden kun je door de recentste opdrachten scrollen.
  * **Recall mode** of **reverse-i-search**  
    via **Ctrl+R** kun je door alle opdrachten zoeken die een bepaalde tekst bevatten
  * De opdracht `history`

Een aantal andere functies die je het leven gemakkelijker maken zijn:

* **Wildcards**/pattern matching (of globbing)
* **Tilde** expansion
* **Variable substitution**
* **Command substitution**

#### Globbing/wildcards

Bij het gebruik van `ls` (of andere opdrachten die als invoer bestanden nodig hebben) kun je 
via patronen een selectie maken van bestanden.

In onderstaande directory zie je veel bestanden:

~~~
student@studentdeb:~$ ls -l
total 160
-rw-r--r-- 1 student student      0 Nov 24 15:30  a
-rw-r--r-- 1 student student    602 Oct 13 22:19  aaa
-rw-r--r-- 1 student student      0 Nov 24 15:30  a_file
...
drwxr-xr-x 2 student student   4096 Oct 27 19:06  hello
-rw-r----- 1 student student      0 Nov 24 16:13  hello2
drwxr-x--x 2 student student   4096 Nov 24 16:13  hello2_dir
drwxr-xr-x 2 student student   4096 Nov 24 15:57  hello_dir
-rw-r--r-- 1 student student      0 Nov 24 15:39  hellofile
-rwxr--r-- 1 student student     92 Dec 15 15:12  hello.sh
-rw-r--r-- 1 student student      0 Nov 24 15:57  hello.txt
drwxr-xr-x 2 student student   4096 Nov 24 19:39  helloworld
-rwxr--r-- 1 student student    226 Dec 15 20:37  helloworld.sh
drwxr-xr-x 2 student student   4096 Sep 26 20:49  Music
-rw-r--r-- 1 student student     41 Dec 15 18:47  nanotest
drwxr-xr-x 2 student student   4096 Sep 26 20:49  Pictures
-rw-r--r-- 1 student student      0 Oct 27 20:30  ppp
drwxr-xr-x 2 student student   4096 Sep 26 20:49  Public
-rwxr--r-- 1 student student     99 Nov 24 21:34  sayhello.sh
drwxrwxr-- 2 student students  4096 Oct 27 21:13  shared
-rw-r----- 1 student students    12 Oct 13 21:49  sharedfile
drwxr-xr-x 2 student student   4096 Sep 26 20:49  Templates
---------- 1 student student      0 Nov 24 19:58  test
drwxrwsrwx 2 student student   4096 Nov 24 19:21  testa
drwxr-xr-x 2 student student   4096 Nov 24 14:05  test_dir
-rwsr--r-- 1 student student      0 Nov 24 15:36  testeje
-rwxrwxrwx 1 bart    bart         0 Nov 24 13:59  test_file
-rw-r--r-- 1 student student   3720 Dec 15 21:17  test.txt
...
~~~

Stel dat je nu de uitvoer wilt beperken/filteren tot bestanden en directory's waarvan de naam begint met **hello**, dan gebruik je het teken `*` na **hello**:

~~~
student@studentdeb:~$ ls -l hello*
-rw-r----- 1 student student    0 Nov 24 16:13 hello2
-rw-r--r-- 1 student student    0 Nov 24 15:39 hellofile
-rwxr--r-- 1 student student   92 Dec 15 15:12 hello.sh
-rw-r--r-- 1 student student    0 Nov 24 15:57 hello.txt
-rwxr--r-- 1 student student  226 Dec 15 20:37 helloworld.sh

hello:
total 4
-rwxr--r-- 1 student student 13 Oct 27 19:06 world.sh

hello2_dir:
total 0

hello_dir:
total 0

helloworld:
total 0
~~~

Dit teken `*` komt overeen met **0 of meer willekeurige tekens**.

Je kan deze *wildcard* overal in een bestandsnaam toevoegen. Bijvoorbeeld om alle shell-bestanden te bekijken waarvan de naam begint met **hello** en de extensie eindigt met **sh**:

~~~
student@studentdeb:~$ ls -l hello*sh
-rwxr--r-- 1 student student  92 Dec 15 15:12 hello.sh
-rwxr--r-- 1 student student 226 Dec 15 20:37 helloworld.sh
student@studentdeb:~$ 
~~~

Je kunt ook meerdere wildcards gebruiken: 

~~~
student@studentdeb:~$ ls -l h*w*sh
-rwxr--r-- 1 student student 226 Dec 15 20:37 helloworld.sh
~~~

#### Pattern matching

Het teken `*` matcht met gelijk welke reeks tekens, maar er zijn er nog meer van deze symbolen.
Je kunt bijvoorbeeld ook matchen op één willekeurig teken, namelijk met de wildcard `?`.

Gegeven het volgende voorbeeld:

~~~
student@studentdeb:~$ ls file*
file  file1  file11  file2 filea fileb
~~~

In dit geval hebben we zes bestanden waarvan de naam begint met **file**: file, file1, file11, file2, filea en fileb.  
Met de wildcard `*` hebben we alle bestanden geselecteerd die starten met **file**, ook file zelf.  

Vergelijk dit met het volgende:

~~~
student@studentdeb:~$ ls file?
file1  file2 filea fileb
student@studentdeb:~$ 
~~~

Hiermee selecteren we alle bestanden waarvan de naam begint met **file** en dan nog één teken heeft. De bestanden **file** en **file11** vallen daar dus niet onder: het eerste heeft een teken te weinig en het tweede een teken te veel.

Je kunt ook meerdere keren `?` gebruiken:

~~~
student@studentdeb:~$ ls file??
file11
student@studentdeb:~$ 
~~~

##### Klassen van tekens

Daarnaast kun je ook testen op **specifieke tekens**:

~~~
[abc] => één van de tekens a, b of c 
[!abc] of [^abc] => gelijk welk karakter behalve a, b of c 
~~~

Bijvoorbeeld

~~~
student@studentdeb:~$ ls file?
file1  file2  filea  fileb
student@studentdeb:~$ ls file[ac]
filea
student@studentdeb:~$ ls file[!ac]
file1  file2  fileb
~~~

Je hebt ook klassen van tekens:

~~~
[[:alpha:]] => Alfabetische tekens (a tot en met z)
[[:lower:]] => Zelfde als voorgaande maar alleen kleine letters
[[:upper:]] => Zelfde als voorgaande maar alleen hoofdletters
[[:digit:]] => Cijfers van 0 tot en met 9
[[:alnum:]] => Alfanumerieke tekens (dus alfabetische en cijfers)
[[:punct:]] => Leestekens
[[:space:]] => Witruimte (spaties, tabs, nieuwe regel, ...)
~~~

Zo kunnen we dus in bestandsnamen filteren op het voorkomen van één cijfer:

~~~
student@studentdeb:~$ ls file[[:digit:]]
file1  file2
~~~

...of twee:

~~~
student@studentdeb:~$ ls file[[:digit:]][[:digit:]]
file11
~~~

#### Tilde expansion

We kennen de **tilde** (`~`) al om te verwijzen de **home-directory** van de gebruiker.  
Je kunt er echter ook mee verwijzen naar de home-directory **van een andere gebruiker**:

~~~
student@studentdeb:~$ echo ~root
/root
student@studentdeb:~$ echo ~user
/home/user
student@studentdeb:~$ echo ~/glob
/home/user/glob
~~~

#### Brace expansion

Waar we eerder zagen bij wildcards dat je bestaande bestanden kon selecteren, 
kun je met **brace expansion** nieuwe bestanden (of strings) genereren.

Door een lijst aan strings tussen accolades (`{` en `}`) te plaatsen, kun je bijvoorbeeld verschillende bestandsnamen met als extensie log genereren:

~~~
student@studentdeb:~/Tmp/$  echo {Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday}.log
Sunday.log Monday.log Tuesday.log Wednesday.log Thursday.log Friday.log Saturday.log
~~~

Deze bestandsnamen kun je dan in combinatie met de opdracht `touch` gebruiken om in één keer **verschillende bestanden te genereren** in een directory:

~~~
student@studentdeb:~/Tmp$ touch {Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday}.log
student@studentdeb:~/Tmp$ ls
Sunday.log Monday.log Tuesday.log Wednesday.log Thursday.log Friday.log Saturday.log
~~~

In plaats van een lijst kun je ook een **sequentie** gebruiken.  
Bijvoorbeeld `{1..3}` zal **alle getallen van 1 tot en met 3** genereren.
In onderstaand voorbeeld maak je bestanden aan waarvan de bestandsnaam begint met "file", gevolgd door een getal van 1 tot en met 3:

~~~
student@studentdeb:~/Tmp$ echo file{1..3}.txt
file1.txt file2.txt file3.txt
~~~

Hetzelfde kun je ook met **tekens**:

~~~
student@studentdeb:~/Tmp$ echo file{a..c}.txt
filea.txt fileb.txt filec.txt
~~~

Je kan ook accolades **combineren**.  
In het onderstaand voorbeeld zie je dat alle **combinaties** (2 * 2 = 4) worden gegenereerd:

~~~
student@studentdeb:~/Tmp$ echo file{a,b}{1,2}.txt
filea1.txt filea2.txt fileb1.txt fileb2.txt
~~~

Je kunt zelfs accolades **binnen andere accolades** opnemen:

~~~
student@studentdeb:~/Tmp$ echo file{a{1,2},b,c}.txt
filea1.txt filea2.txt fileb.txt filec.txt
student@studentdeb:~/Tmp$
~~~

### Bash-scripts (deel 2)

#### Voorwaarden met `if`

Bash kan (zoals Python) ook als programmeer- of scriptingtaal gebruikt worden.  
Een van de belangrijkste structuren in een programmeertaal is een voorwaardelijk blok: opdrachten die alleen worden uitgevoerd als aan een gegeven voorwaarde voldaan is. De structuur van een voorwaarde ziet er in Bash als volgt uit:

~~~bash
if [ condition ]
then
  command1
  command2
  ...
  commandn
else
  command1
  command2
  ...
  commandn
fi
~~~

Dit kan ook geschreven worden met de `then` op dezelfde regel als de `if`, maar dan moet er een `;`  tussen:

~~~bash
if [ condition ]; then
  command1
  command2
  ...
  commandn
else
  command1
  command2
  ...
  commandn
fi
~~~

Zo zal onderstaande code in een script controleren of de gebruiker op de opdrachtregel argumenten doorgegeven heeft:

~~~bash
#!/bin/bash
if [ $# -eq 0 ]; then
        echo "Er zijn geen argumenten."
else
        echo "Er zijn $# argumenten."
fi
~~~

##### Testen op getalwaardes

Je kunt deze variabelen interpreteren als getallen en hun waarden op de volgende manieren vergelijken:

~~~
INTEGER1 -eq INTEGER2 => INTEGER1 is gelijk aan INTEGER2
INTEGER1 -ne INTEGER2 => INTEGER1 is niet gelijk aan INTEGER2
INTEGER1 -gt INTEGER2 => INTEGER1 is groter dan INTEGER2
INTEGER1 -ge INTEGER2 => INTEGER1 is groter dan of gelijk aan INTEGER2
INTEGER1 -lt INTEGER2 => INTEGER1 is kleiner dan INTEGER2
INTEGER1 -le INTEGER2 => INTEGER1 is kleiner dan of gelijk aan INTEGER2
~~~

Zo kunnen we testen of een argument groter is dan een getal:

~~~bash
#!/bin/bash
if [ $1 -gt 100 ]
then
    echo Getal is groter dan 100.
fi
~~~

##### Alternatieven testen

Als niet aan de voorwaarde op de regel met `if` voldaan is, kun je alternatieven testen met `elif`:

~~~bash
#!/bin/bash
if [ $1 -gt 100 ]
then
    echo Getal is groter dan 100.
elif [ $1 -gt 75 ]
then
    echo Getal ligt tussen 76 en 100.
elif [ $1 -gt 50 ]
then
    echo Getal ligt tussen 51 en 75.
else
    echo Getal is kleiner dan of gelijk aan 50.
fi
~~~

Test dit script met wat getallen:

~~~
$ ./hello.sh 101
Getal is groter dan 100.
$ ./hello.sh 99
Getal ligt tussen 76 en 100.
$ ./hello.sh 65
Getal ligt tussen 51 en 75.
$ ./hello.sh 50
Getal is kleiner dan of gelijk aan 50.
$ 
~~~

##### Voorwaarde omdraaien

Je kan je test ook omdraaien. Stel dat je het omgekeerde
wil van groter dan 100. Dan draai je de voorwaarde om door er een uitroepteken voor te plaatsen:

~~~bash
#!/bin/bash
if [ ! $1 -gt 100 ]
then
    echo Getal is niet groter dan 100.
else
    echo Getal is groter dan 100.
fi
~~~

Deze omkering mag ook buiten de rechte haakjes staan, wat duidelijker is:

~~~bash
#!/bin/bash
if ! [ $1 -gt 100 ]
then
    echo Getal is niet groter dan 100.
else
    echo Getal is groter dan 100.
fi
~~~

##### Testen op stringwaardes

Je kunt niet alleen getallen vergelijken, maar ook strings testen:

~~~
-n STRING           => STRING is niet leeg (lengte > 0).
-z STRING           => STRING is leeg (lengte = 0).
STRING1 = STRING2   => STRING1 is gelijk aan STRING2
STRING1 != STRING2  => STRING1 is niet gelijk aan STRING2
~~~

Zo test je bijvoorbeeld of het eerste argument van een script gelijk is aan een gegeven string:

~~~bash
#!/bin/bash
if [ $1 = "go" ]
then
        echo "go"
fi
~~~

En zo test je of het eerste argument geen lege string is:

~~~bash
#!/bin/bash
if [ -n $1 ]
then
        echo "geen lege string"
fi
~~~

##### Bestanden testen

Op dezelfde manier kun je bestanden testen:

~~~
-e FILE => FILE bestaat.
-s FILE => FILE bestaat en is niet leeg.
-d FILE => FILE bestaat en is een directory.
-r FILE => FILE bestaat en je kunt het lezen (read). 
-w FILE => FILE bestaat en je kunt ernaar schrijven (write).
-x FILE => FILE bestaat en je kunt het uitvoeren (execute).
~~~

Het volgende voorbeeld kijkt na of het argument een bestaand bestand is:

~~~bash
#!/bin/bash
if [ $# -eq 0 ]
then
        echo "Er zijn geen argumenten."
else
        echo "Er zijn $# argumenten."
        if [ -e $1 ]
        then
                echo "Het bestand $1 bestaat."
        else
                echo "Het bestand $1 bestaat niet."
        fi
fi
~~~

##### Voorwaarden combineren met `&&` en `||`

Je kunt ook combinaties van voorwaarden maken:

~~~
! EXPRESSION =>	EXPRESSION geïnverteerd
&&           => en
||           => of
~~~

Volgende script gaat het vergelijk maken of een eerste getal 
tussen de 2 andere argumenten ligt

~~~bash
#!/bin/bash
if [ $1 -gt $2 ] && [ $1 -lt $3 ]
then
        echo "$1 ligt tussen $2 en $3"
else
        echo "$1 ligt niet tussen $2 en $3"
fi
~~~

Met als volgende gebruik:

~~~
student@studentdeb:~$ ./between.sh 6 5 10
6 ligt tussen  5 en 10
student@studentdeb:~$ ./between.sh 4 5 10
4 ligt niet tussen 5 en 10
student@studentdeb:~$  
~~~

#### Lussen met `for` 

Met de `for`-lus loop je door een lijst:

~~~bash
#!/bin/bash
for i in 1 2 3 4 5 6 7 8 9 10;
do
    echo $i
done 
~~~

Deze lijst kun je ook genereren met de opdracht `seq`:  

~~~
bart@bvlegion:~$ seq 1 10
1
2
3
4
5
6
7
8
9
10
bart@bvlegion:~$
~~~

In een script pas je dit dan zo toe:

~~~bash
#!/bin/bash
for i in $(seq 1 10);
do
    echo $i
done 
~~~

#### Lussen met `while`

Een andere lus test op een voorwaarde.
Deze heeft de volgende structuur:

~~~bash
while [ condition ]
do
   command1
   command2
   command3
done
~~~

Je kunt deze bijvoorbeeld gebruiken in **combinatie** met een **teller**:

~~~bash
#!/bin/bash
x=1
while [ $x -le 5 ]
do
  echo "Welcome $x times"
  x=$((x + 1))
done
~~~

Let op: rekenkundige bewerkingen moet je in Bash tussen `$((` en `))` plaatsen.

Maar je kunt ook een **oneindige lus** aanmaken:

~~~bash
#!/bin/bash
while true; do
    echo "hello"
    sleep 5
done
~~~

Wil je deze lus onderbreken, dan dien je Ctrl+C in te typen.

#### Inlezen van een variabele met `read`

Om binnen een script tekst op te vragen aan de gebruiker, werk je met de opdracht `read`:

~~~bash
#!/bin/bash
echo "Typ een teken, daarna Return."
read text
echo $text
~~~

Dit slaat het ingetypte teken/woord op in de variabele `text`.

#### Alternatieven met `case`

Als je op specifieke waardes wilt testen, kun je in plaats van `if` gebruikmaken van `case`:

~~~bash
#!/bin/bash
echo "[yes|no|quit]"
read text
case $text in
        yes) echo "You entered yes" ;;
        no) echo "You entered no" ;;
        quit) echo "You want to quit" ;;
        *) echo "You typed something else" ;;
esac
~~~

In een krachtigere variant maak je de combinatie met de **patterns** en **klassen van tekens** die we eerder zagen:

~~~bash
#!/bin/bash
echo "Typ een teken, daarna Return."
read keypress
case "$keypress" in
    [[:lower:]] ) echo "Kleine letter";;
    [[:upper:]] ) echo "Hoofdletter";;
    [[:digit:]] ) echo "Cijfer";;
    * ) echo "Leesteken, spatie of iets anders";;
esac
~~~

### Sourcing

Als je een script uitvoert binnen een Linux-shell, zal dit script niet de huidige shell aanpassen.  
De shell zal een script binnen een apart proces uitvoeren en dan terugkeren naar de huidige shell.

Neem nu het volgende script, dat naar een directory hoger verhuist:

~~~bash
#!/bin/bash
old_directory=$(pwd)
cd ..
echo "Moved from $old_directory to $(pwd)"
~~~

Als je dit script uitvoert, zou je verwachten dat je een directory zou stijgen...  
Zeker als je de uitvoer van dit script bekijke, **Moved from /home/bart/Tmp to /home/bart**.

~~~
bart@bvlegion:~/Tmp$ chmod u+x up.sh 
bart@bvlegion:~/Tmp$ pwd
/home/bart/Tmp
bart@bvlegion:~/Tmp$ ./up.sh 
Moved from /home/bart/Tmp to /home/bart
bart@bvlegion:~/Tmp$ 
~~~

Maar als je de opdracht `pwd` gebruikt, zie je dat je je nog altijd op **dezelfde locatie** bevindt:

~~~
bart@bvlegion:~/Tmp$ pwd
/home/bart/Tmp
bart@bvlegion:~/Tmp$
~~~

Ook de variabele `old_directory` is **nergens te bespeuren** (leeg):

~~~
bart@bvlegion:~/Tmp$ echo $old_directory

bart@bvlegion:~/Tmp$ 
~~~

Het is echter mogelijk om dit script **binnen de huidige shell uit te voeren**.  
Dit principe noemt men **sourcing**. Om dit te doen, moet je eenvoudigweg de opdracht om je script uit te voeren laten voorafgaan door `.` of `source`:

~~~
bart@bvlegion:~/Tmp$ . ./up.sh 
Moved from /home/bart/Tmp to /home/bart
bart@bvlegion:~$ 
~~~

Let op: het is belangrijk dat er na de eerste punt een spatie komt!

De versie met `source` ziet er zo uit:

~~~
bart@bvlegion:~/Tmp$ source ./up.sh 
Moved from /home/bart/Tmp to /home/bart
bart@bvlegion:~$ 
~~~

Je ziet al aan de prompt dat de directory deze keer wel gewijzigd is.  
De uitvoer van de opdracht `pwd` hieronder bevestigt dit:

~~~
bart@bvlegion:~$ pwd
/home/bart
~~~

Ook zie je dat de variabele `old_directoty` nog altijd zichtbaar is binnen de shell:

~~~
bart@bvlegion:~$ echo $old_directory
/home/bart/Tmp
bart@bvlegion:~$ 
~~~

