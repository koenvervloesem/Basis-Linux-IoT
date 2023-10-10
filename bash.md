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

Waar we eerder zagen bij wildcards dat je files kon selecteren je bestaande files kon selecteren, 
kan je met **brace expansion** nieuwe files (of string genereren)

Door een lijst aan strings tussen braces te plaatsen (zie voorbeeld hieronder) kan je
verschillende filenames aanmaken met als extensie log.

~~~
student@studentdeb:~/Tmp/$  echo {Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday}.log
Sunday.log Monday.log Tuesday.log Wednesday.log Thursday.log Friday.log Saturday.log
~~~

Deze kan je dan in **combinatie** met **touch** dan gebruiken om **verschillende files te genereren** in een folder

~~~
student@studentdeb:~/Tmp$ touch {Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday}.log
student@studentdeb:~/Tmp$ ls
Sunday.log Monday.log Tuesday.log Wednesday.log Thursday.log Friday.log Saturday.log
~~~

ipv een lijst kan kan je ook een **sequentie** gebruiken.  
Bijvoorbeeld **{1..3}** zal **alle getallen van 1 tem 3** voorstellen
In onderstaand voorbeeld maak je **files** aan **startende** met **"file"** gevolgd door een getal van **1 tem 3**

~~~
student@studentdeb:~/Tmp$ echo file{1..3}.txt
file1.txt file2.txt file3.txt
~~~

Hetzelfde kan je ook met **karakters**:

~~~
student@studentdeb:~/Tmp$ echo file{a..c}.txt
filea.txt fileb.txt filec.txt
~~~

Je kan ook **combineren** van **braces**.  
In het onderstaand voorbeeld zie je dat alle **combinaties** (2 * 2 = 4) worden gegenereerd:

~~~
student@studentdeb:~/Tmp$ echo file{a,b}{1,2}.txt
filea1.txt filea2.txt fileb1.txt fileb2.txt
~~~

Of zelfs **braces** **embedden** binnen andere **braces**

~~~
student@studentdeb:~/Tmp$ echo file{a{1,2},b,c}.txt
filea1.txt filea2.txt fileb.txt filec.txt
student@studentdeb:~/Tmp$
~~~

#### Substitution

##### Command substitution

Een andere praktische tool is "command substitution".  
Dit laat toe om de output van het enen commando te gebruiken binnen een ander commando.

In het onderstaand voorbeeld gebruik ik **2 commando's**:

* **hostname** => naam van de host opvragen
* **uname** => opvragen van systeem-gegevens
  
Zie hieronder als **voorbeeld**:

~~~
student@studentdeb:~$ hostname -s
studentdeb
student@studentdeb:~$ uname -a
Linux studentdeb 5.10.0-8-amd64 #1 SMP Debian 5.10.46-5 (2021-09-23) x86_64 GNU/Linux
~~~

De output van deze 2 commando's kan je gebruiken binnen het **echo-commando**

~~~
student@studentdeb:~$ echo "Deze host is $(hostname -s) met volgende gegevens $(uname -a)"
Deze host is studentdeb met volgende gegevens Linux studentdeb 5.10.0-8-amd64 #1 SMP Debian 5.10.46-5 (2021-09-23) x86_64 GNU/Linux
~~~

##### Variable substitution

Je kan - zoals je vrij snel zal zien in scripting - variabele bijhouden binnen.  
Net zoals bij command substitution kan je deze gebruiken binnen een ander commando (en/string)

~~~
student@studentdeb:~$ export myhost=$(hostname -s)
student@studentdeb:~$ echo ${myhost}
studentdeb
student@studentdeb:~$ echo "Ik werk op ${myhost}"
Ik werk op studentdeb
~~~

Let wel, zowel variable als command substitution werken enkel als je met 
dubbele quotes werkt.

~~~
student@studentdeb:~$ echo 'Ik werk op ${myhost}'
Ik werk op ${myhost}
~~~

### Bash-scripting (deel 2)

#### Condities met if

Bash kan (zoals Python) ook als programmeer- of scripting-taal worden gebruikt.  
De structuur van een conditie ziet er als volgt uit:

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

Bijvoorbeeld onderstaande if gaat vergelijken of er argumenten zijn.

~~~bash
if [ $# -eq 0 ]; then
        echo Er zijn geen argumenten.
else
        echo Er zijn wel argumenten.
fi
~~~

##### Testen op getal-waardes

Je kan deze variabelen gaan interpreteren als getallen met de volgende mogelijkheiden:

~~~
INTEGER1 -eq INTEGER2 => INTEGER1 is numeriek gelijk to INTEGER2
INTEGER1 -gt INTEGER2 => INTEGER1 is numeriek groter than INTEGER2
INTEGER1 -lt INTEGER2 => INTEGER1 is numeriek kleiner than INTEGER2
~~~

met als voorbeelden:

* Testen of een argument groter is dan een getal:

~~~bash
#!/bin/bash
if [ $1 -gt 100 ]
then
    echo Nummer is groter dan 100.
fi
~~~

##### else if...

In de meeste programmeertalen kan je ook naast else ook een "else if"-clausule toevoegen.  
Deze zal andere alternatieven testen indien de if-clausule niet true evalueert.

~~~bash
#!/bin/bash
if [ $1 -gt 100 ]
then
    echo Nummer is groter dan 100.
elif [ $1 -gt 75 ]
then
    echo Nummer is tussen 76 en 100
elif [ $1 -gt 50 ]
then
    echo Nummer is tussen 51 en 75
else
    echo Nummer is kleiner of gelijk aan 50
fi
~~~

Als we deze testen met wat getallen...

~~~
$ ./hello.sh 101
Nummer is groter dan 100.
$ ./hello.sh 99
Nummer is tussen 76 en 100
$ ./hello.sh 65
Nummer is tussen 51 en 75
$ ./hello.sh 50
Nummer is kleiner of gelijk aan 50
$ 
~~~

##### not/inversie

Je kan je test ook inverteren, als ik bijvoorbeeld het omgekeerde
wil van groter dan 100 kan ik de eigenlijke test inverteren met een uitroepteken.

~~~bash
#!/bin/bash
if [ ! $1 -gt 100 ]
then
    echo Nummer is niet groter dan 100.
else
    echo Nummber is groter dan 100
fi
~~~

Deze mag eventueel ook buiten de haakjes staan

~~~bash
#!/bin/bash
if ! [ $1 -gt 100 ]
then
    echo Nummer is niet groter dan 100.
else
    echo Nummber is groter dan 100
fi
~~~


##### Testen op string-waardes

* Testen op basis van het aantal argumenten

~~~
-n STRING => 	De lengte string > 0.
-z STRING =>	Het betref een lege string.
STRING1 = STRING2 => STRING1 is equal to STRING2
STRING1 != STRING2 =>	STRING1 is not equal to STRING2
~~~

Voorbeelden:

* Nakijken of de string gelijk is

~~~bash
#!/bin/bash
if [ $1 = "go" ]
then
        echo "go"
fi
~~~

~~~bash
#!/bin/bash
if [ -n $1 ]
then
        echo "geen lege string"
fi
~~~

##### File-verificaties

Een 3de manier is deze vergelijkingen te maken als zijn het files

~~~
-e FILE => FILE bestaat.
-d FILE => FILE bestaat en is een directory.
-r FILE => FILE bestaat en de read-permissie is toegekend.
-s FILE => FILE bestaat en is niet leeg.
-w FILE => FILE bestaat en je mag er naar schrijven.
-x FILE => FILE bestaat en heeft execute-permissies.
~~~

Het volgende voorbeeld kijkt na of het argument een file is:

~~~bash
#!/bin/bash
if [ $# -eq 0 ]
then
        echo Er zijn geen argumenten.
else
        echo Er zijn $# argumenten.
        if [ -e $1 ]
        then
                echo Het bestand $1 bestaat.
        else
                echo Het bestand $1 bestaat niet.
        fi
fi
~~~

##### Combinaren met && en ||

Je kan (net zoals in Python) ook combinaties maken

~~~
! EXPRESSION =>	EXPRESSION geinverteerd (false => true)
&& => en
|| => of
~~~

Volgende script gaat het vergelijk maken of een eerste getal 
tussen de 2 andere argumenten ligt

~~~bash
if [ $1 -gt $2 ] && [ $1 -lt $3 ]
then
        echo "$1 ligt tussen  $a en $b"
else
        echo "$1 ligt niet tussen $a en $b"
fi
~~~

Met als volgende gebruik:

~~~
student@studentdeb:~$  ./between.sh 6 5 10
6 ligt tussen  5 en 10
student@studentdeb:~$  ./between.sh 4 5 10
4 ligt niet tussen 5 en 10
student@studentdeb:~$  
~~~

#### for loop

De for-loop kan gebruikt worden om door een lijst te lopen

~~~bash
#!/bin/bash
for i in 1 2 3 4 5 6 7 8 9 10;
do
    echo $i
done 
~~~

Deze lijst kan je ook genereren met het commando **seq**  

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

en als volgt **toepassen** binnen een **script**

~~~bash
#!/bin/bash
for i in $(seq 1 10);
do
    echo $i
done 
~~~

#### while loop

Een andere loop die gaat testen op een conditie.  
Deze heeft het volgende **formaat**:

~~~bash
while [ condition ]
do
   command1
   command2
   command3
done
~~~

Je kan deze bijvoorbeeld gebruiken in **combinatie** met een **teller** en **conditie**:

~~~bash
#!/bin/bash
x=1
while [ $x -le 5 ]
do
  echo "Welcome $x times"
  x=$(( $x + 1 ))
done
~~~

Maar ook om een **oneindige loop** aan te maken:

~~~bash
#!/bin/bash
while true; do
    echo "hello"
    sleep 5
done
~~~

#### Inlezen van een variabele met read

Om binnen een script tekst in te lezen gebruik je het commando **read**:

~~~bash
#!/bin/bash
echo; echo "Typ een teken, daarna Return."
read text
echo $text
~~~

#### case

**case** kan je gebruiken als **alternatief** op **if** als je exact wil mappen naar een waarde
en daar 1 of meerder commando's wil op uitvoeren

~~~bash
#!/bin/bash
case $var in
        yes) echo "You entered yes" ;;
        no) echo "You entered no" ;;
        quit) echo "You want to quit" ;;
        *) echo "You types something else" ;;
esac
~~~

een krachtigere variant als je de combinatie maakt met de **patterns** en **karakter-klassen** die we eerder vermeldden

~~~bash
#!/bin/bash
echo; echo "Typ een teken, daarna Return."
read Keypress
case "$Keypress" in
    [[:lower:]] ) echo "Kleine letter";;
    [[:upper:]] ) echo "Hoofdletter";;
    [[:digit:]] ) echo "Cijfer";;
    * ) echo "Leesteken, spatie of iets anders";;
esac
~~~

### Sourcing

Als je een script uitvoert binnen een linux-shell zal dit script niet de huidige shell aanpassen.  
De shell zal een script binnen een apart process uitvoeren en dan terugkeren naar de huidige shell.

Neem nu volgend script dat als je dat uitvoert naar een directory hoger verhuist:

~~~bash
#!/bin/bash
old_directory=$(pwd)
cd ..
echo "Moved from $old_directory to $(pwd)"
~~~

Als je dit script uitvoert zou je **verwachten** dat je een **directory** zou **stijgen**...  
Zeker als je de **output** van dit script *Moved from /home/bart/Tmp to /home/bart* **bekijkt**:

~~~
bart@bvlegion:~/Tmp$ chmod u+x up.sh 
bart@bvlegion:~/Tmp$ pwd
/home/bart/Tmp
bart@bvlegion:~/Tmp$ ./up.sh 
Moved from /home/bart/Tmp to /home/bart
bart@bvlegion:~/Tmp$ 
~~~

Maar als het **pwd**-commando gebruikt zie je dat je je nog altijd op **dezelfde** **locatie** bevindt

~~~
bart@bvlegion:~/Tmp$ pwd
/home/bart/Tmp
bart@bvlegion:~/Tmp$
~~~

Ook de variabele **old_directory** is **nergens** te **bespeuren** (leeg):

~~~
bart@bvlegion:~/Tmp$ echo $old_directory

bart@bvlegion:~/Tmp$ 
~~~

Er is echter de mogelijk om dit script **binnen de huidige shell uit te voeren**.  
Dit principe noemt men sourcing en je kan dit simpel gebruiken door de uitvoering van je script
te prependen met een **.** of alternatief het keyword **source** zoals je ziet in onderstaand voorbeeld:

~~~
bart@bvlegion:~/Tmp$ . ./up.sh 
Moved from /home/bart/Tmp to /home/bart
bart@bvlegion:~$ 
~~~

of in de 2de variant

~~~
bart@bvlegion:~/Tmp$ source ./up.sh 
Moved from /home/bart/Tmp to /home/bart
bart@bvlegion:~$ 
~~~

Je zien al aan de prompt dat de directory is gewijzigd.  
Het **pwd-commando** hieronder bevestigd dit

~~~
bart@bvlegion:~$ pwd
/home/bart
~~~

Ook zie je dat de variabele **nog altijd zichtbaar** is binnen de console (wat daarvoor niet het geval was)

~~~
bart@bvlegion:~$ echo $old_directory
/home/bart/Tmp
bart@bvlegion:~$ 
~~~

