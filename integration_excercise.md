## Integratie-oefening

### Opgave

#### Deel 1: script aanmaken

Maak een **script** dat een directory aanmaakt op basis van de datum van vandaag.  
Een voorbeeld: stel dat het vandaag **22 december 2021** is, dan moet deze map **20211222** heten.  

Geef dit script de naam `create_daily_folder.sh`.  
Als je dit script uitvoert, zal het zich als volgt gedragen:

~~~
student@studentdeb:~$ date
Wed 22 Dec 2021 01:35:48 PM CET
student@studentdeb:~$ ./create_daily_folder.sh
Creating folder /home/student/202112
student@studentdeb:~$ ls -ld 20211222
drwxr-xr-x 2 student student 4096 Dec 22 13:36 20211222
student@studentdeb:~$
~~~

Om deze directory aan te maken, maak je gebruik van:

* de opdracht `date`
* het principe van **command substitution**

##### Help: `date`

De opdracht `date` wordt in Bash gebruikt om het exacte tijdstip op te vragen, zoals hieronder geïllustreerd:

~~~
student@studentdeb:~$ date
Wed 22 Dec 2021 01:51:04 PM CET
~~~

Om een **datum** via een **exact formaat** te tonen kun je als argument het formaat opgeven voorafgegaan door een `+` zoals hieronder vertoond:

~~~
student@studentdeb:~$ date +%y
21
student@studentdeb:~$
~~~

De oefening is nu om te bekijken met welk formaat je de datum in de gevraagde vorm kunt weergeven.

> Tip: Bekijk de man-pagina van `date`.  

##### Help: command substitution

Om de opdracht `date` te combineren met de opdracht om een directory aan te maken, gebruik je **command substitution**. Een voorbeeld van dit principe:

~~~
student@studentdeb:~$ hostname -s
studentdeb
student@studentdeb:~$ touch $(hostname -s)-filetest
student@studentdeb:~$ ls *filetest
studentdeb-filetest
student@studentdeb:~$ 
~~~

#### Deel 2: de directory bestaat al...

Als de directory al aangemaakt is, moet het script:

* de directory niet opnieuw aanmaken
* een foutmelding tonen
* met exitcode 2 afsluiten

Dat ziet er dan als volgt uit:

~~~
student@studentdeb:~$ ls -ld 20211222
drwxr-xr-x 2 student student 4096 Dec 22 13:36 20211222
student@studentdeb:~$ ./create_daily_folder.sh
Folder /home/student/202112 exists already
student@studentdeb:~$ echo $?
2
~~~

##### Help: nakijken of een bestand of map al bestaat

Je hebt de volgende opties ter beschikking om na te kijken of een bestand of map al bestaat (zie eerder in de cursus):

~~~
-e FILE => FILE bestaat
-d FILE => FILE bestaat en is een directory
-r FILE => FILE bestaat en je mag het lezen
-s FILE => FILE bestaat en is niet leeg
-w FILE => FILE bestaat en je mag ernaar schrijven
-x FILE => FILE bestaat en je mag het uitvoeren
~~~

Het volgende voorbeeld kijkt na of het argument een bestand is:

~~~bash
#!/bin/bash
if [ $# -eq 0 ]; then
        echo Er zijn geen argumenten.
else
        echo Er zijn $# argumenten.
        if [ -e $1 ]; then
                echo Het bestand $1 bestaat.
        else
                echo Het bestand $1 bestaat niet.
        fi
fi
~~~

Gebruik een gelijkaardige aanpak om in je script na te kijken of de directory al bestaat.

### Deel 3: geef een directory mee als argument

Het script maakt **zonder argument** een directory aan binnen de directory vanwaar je het script uitvoert (de werkdirectory).  
Zorg er nu voor dat het script deze directory aanmaakt binnen een andere directory als je een extra argument meegeeft.

~~~
student@studentdeb:~$ ./create_daily_folder.sh /home/student/Tmp
Creating folder /home/student/Tmp/20211222
student@studentdeb:~$ ls -ld /home/student/Tmp/20211222
drwxr-xr-x 2 student student 4096 Dec 22 13:36 20211222
~~~

Laat het script wel een foutmelding tonen als de bovenliggende directory niet bestaat.

~~~
student@studentdeb:~$ ./create_daily_folder.sh /home/student/Blabla
Cannot create af folder /home/student/Blabla/20211222 because /home/student/Blabla doesn't exist
~~~

#### Deel 4: schrijf alles weg in een logbestand

Schrijf de boodschappen die je tot nog toe hebt gemaakt weg naar een logbestand `create_daily_folder.log`.  
Dit bestand bevindt zich in de basisdirectory waarin je de directory met de datum aanmaakt.

#### Deel 5: plan dit dagelijks met een crontab

Roep dit **script** op **dagelijkse basis** aan via een crontab (dagelijks om 18:05).  
Pas het script toe op de directory `/home/student/shared/` (via het argument).

#### Deel 6: groepen en gebruikers

* Maak een groep `shared` aan.
* Zorg dat bovenstaande directory uit deel 5 eigendom is van deze groep.
* Enkel leden van deze groep hebben toegang tot deze directory.
* De subdirectory's die worden aangemaakt behoren automatisch tot deze groep.

