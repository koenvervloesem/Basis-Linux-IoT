## Gebruikers en groepen

### Gebruikers 

Linux-gebruikers hebben - net als op andere systemen - een gebruikersnaam en wachtwoord om in te loggen.

Elke gebruikersnaam is in Linux verbonden aan een **uniek identificatienummer**: het gebruikers-ID of **UID** (*user ID*).

Deze gebruiker (met bijbehorend wachtwoord) heeft twee functies:

* **Authenticatie**: is de gebruiker wie hij/zij beweert te zijn?
* **Autorisatie**: mag de gebruiker toegang krijgen tot het gevraagde bestand, proces, dienst, ...?

#### Soorten gebruikers

We onderscheiden drie soorten gebruikers:

* De **superuser** of **root**:  
  Wordt gebruikt voor **systeembeheer** en/of **-configuratie**.  
  Deze superuser heeft in principe **toegang tot het hele systeem** (bestanden, processen, ...)
  De naam van deze gebruiker is **root**, met een **UID** van **0**.  
* **Gewone gebruikersaccounts**:  
  **Gewone gebruikers** die **inloggen** op het systeem.  
  In het Debian-systeem in onze virtuele machine hebben we zo'n gebruiker aangemaakt: student  
  Hebben een UID van **1000+**.
* **Systeemaccounts**:  
  Sommige gebruikers zijn niet bedoeld om in te loggen, maar hebben als functie om specifieke processen en/of services te beheren.  
  Deze services (ook wel **daemons** genoemd) draaien in de achtergrond. Ze hoeven meestal niet als superuser te worden uitgevoerd.  
  Hebben een UID van **1-999**.

#### Informatie over je eigen gebruiker

Linux kent een aantal handige opdrachten om **informatie** te verkrijgen over je gebruiker.  
Als je de gebruikersnaam waarmee je ingelogd bent wil tonen, gebruik je de opdracht `logname`:

~~~
student@studentdeb:~$ logname
student
~~~

Voor meer informatie is de opdracht `id` nuttig. Die geeft:

* Je numeriek **UID**
* De **GID** van de **primaire groep** waartoe je behoort
* Een **lijst** van alle **groepen** en hun GID's

~~~
student@studentdeb:~$ id
uid=1000(student) gid=1000(student) groups=1000(student),24(cdrom),25(floppy),29(audio),30(dip),44(video),46(plugdev),109(netdev),112(bluetooth),116(lpadmin),119(scanner)
~~~

Wil je alleen de lijst van de groepen waartoe je behoort tonen, gebruik dan de opdracht `groups`:

~~~
student@studentdeb:~$ groups
student cdrom floppy audio dip video plugdev netdev bluetooth lpadmin scanne
~~~

#### Inloggen als de superuser

Andere gebruikers en groepen beheren kan niet zomaar met een standaard gebruikersaccount.  Hiervoor moet je inloggen als superuser of **root**.  

Je kan dit doen via de opdracht `su`, ofwel "**s**witch **u**ser".  
De naam van deze opdracht staat dus niet voor superuser, want je kan ze ook gebruiken om met gelijk welke ander gebruiker in te loggen.

Om als de root-account in te loggen, gebruik je `su -`:

~~~
student@studentdeb:~$ su -
Password: 
root@studentdeb:~#
~~~

Vergeet je de `-`, dan worden de omgevingsvariabelen niet aangepast aan de root-gebruiker en verander je niet naar de home-directory van de root-gebruiker.

> *Waarschuwing*  
> Als **root-gebruiker** kun je zowat alles doen op je systeem.  
> Maar vergeet niet: **"With great power comes great responsibility"**.  
> Bij **foutief gebruik** kan het zijn dat je
> **onherstelbare schade** toebrengt aan je Linux-systeem, waardoor
> het niet meer correct werkt (of zelfs niet meer opstart).  
> Log dus alleen als superuser in wanneer het absoluut noodzakelijk is.

#### Gebruiker toevoegen

Laten we starten met het toevoegen van een gebruiker.  
Hiervoor gebruiken we de opdracht `useradd`. Let op: we dienen deze opdracht uit te voeren met **root-permissies**.

Hieronder voegen we een gebruiker toe. We hebben daarvoor een aantal opties nodig:

~~~
root@studentdeb:~# useradd -c "My personal user" -m -s /bin/bash bart
~~~

De gebruikte opties zijn:

* `-c`, `--comment COMMENT`  
  Voegt de echte naam (of schermnaam) van de gebruiker toe aan het opmerkingenveld.
* `-m`, `--create-home`  
  Zorgt ervoor dat de gebruiker een home-directory verkrijgt (als deze nog niet bestaat).
* `-s`, `--shell SHELL`  
  Geef een specifieke login-shell voor deze gebruiker bij het inloggen.

Daarnaast kun je nog een aantal andere opties toevoegen:

* `-g`, `--gid GROUP`  
  Geef de primaire groep voor de gebruikersaccount op.
* `-G`, `--groups GROUPS`  
  Geef een door komma's gescheiden lijst op van aanvullende groepen voor
  de gebruikersaccount.
* `-a`, `--append`  
  Gebruikt samen met `-G` om aan te duiden dat je groepen gaat toevoegen
* `-L`, `--lock`  
  Vergrendel de gebruikersaccount.

#### Wachtwoord aanpassen

Een tweede stap om te kunnen inloggen is de gebruiker een wachtwoord geven.
Dat kan met de opdracht `passwd`:

~~~
root@studentdeb:~# passwd bart
New password: 
Retype new password: 
passwd: password updated successfully
root@studentdeb:~# 
~~~

#### Wissel van gebruiker

Zoals we eerder vermeldden, kun je met de opdracht `su` vanuit een shell **wisselen** van **gebruiker**.  
Het volstaat om na `su` je naam te vermelden (zonder naam zal `su` proberen in te loggen als de root-gebruiker):

~~~
student@studentdeb:~$ su - bart
Password: 
bart@studentdeb:~$ users
student
bart@studentdeb:~$ pwd
/home/bart
bart@studentdeb:~$
~~~

Merk op dat je ook hier `-` na `su` toevoegt om de omgevingsvariabelen juist te zetten en van home-directory te veranderen.

#### Wachtwoordbestand

De informatie die je meegaf aan `useradd` wordt samen met andere gegevens standaard bijgehouden in een bestand `/etc/passwd`.  
Bekijk bijvoorbeeld de laatste tien regels van dit bestand (via de opdracht `tail`):

~~~
root@studentdeb:~# tail /etc/passwd
avahi:x:109:115:Avahi mDNS daemon,,,:/run/avahi-daemon:/usr/sbin/nologin
speech-dispatcher:x:110:29:Speech Dispatcher,,,:/run/speech-dispatcher:/bin/false
pulse:x:111:117:PulseAudio daemon,,,:/run/pulse:/usr/sbin/nologin
saned:x:112:120::/var/lib/saned:/usr/sbin/nologin
colord:x:113:121:colord colour management daemon,,,:/var/lib/colord:/usr/sbin/nologin
lightdm:x:114:122:Light Display Manager:/var/lib/lightdm:/bin/false
student:x:1000:1000:student,,,:/home/student:/bin/bash
systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
vboxadd:x:998:1::/var/run/vboxadd:/bin/false
bart:x:1001:1001:My personal user:/home/bart:/bin/bash
~~~

Kijken we nu eens in detail naar de regel voor gebruiker bart...

~~~
bart:x:1001:1001:My personal user:/home/bart:/bin/bash
~~~

...dan zien we volgende gegevens:

* **bart** =>  
  **Gebruikersnaam** voor deze gebruiker.
* **x** =>  
  Het **wachtwoord** van de gebruiker werd hier **versleuteld** opgeslagen. Dat is verplaatst naar het
  bestand `/etc/shadow`, dat later wordt behandeld. Dit veld moet altijd x zijn.
* **1001** =>  
  Het **UID** voor deze gebruikersaccount.
* **1001** =>  
  Het **GID** voor de primaire groep van deze gebruikersaccount (zie verder).
* **My personal user** =>  
  **De echte naam** of **commentaar** voor deze gebruiker.
* **/home/bart** =>  
  De **home-directory** voor deze gebruiker.  
  Dit is de initiële werkdirectory wanneer de shell start.
* **/bin/bash/** =>  
  Het **standaard** **shell**-programma voor deze gebruiker.  
  Voor een gewone gebruiker is dit normaal gesproken het programma dat bij inloggen de opdrachtregelprompt toont. Voor een systeemgebruiker zou hier `/sbin/nologin` kunnen staan als interactieve logins niet zijn toegestaan.

#### Schaduwbestand 

De wachtwoorden zelf worden in **versleutelde vorm** in een **afzonderlijk bestand** bijgehouden, `/etc/shadow`.

~~~
root@studentdeb:~# tail /etc/shadow
avahi:*:18896:0:99999:7:::
speech-dispatcher:!:18896:0:99999:7:::
pulse:*:18896:0:99999:7:::
saned:*:18896:0:99999:7:::
colord:*:18896:0:99999:7:::
lightdm:*:18896:0:99999:7:::
student:$y$j9T$hFAAuVnT/y76TGLtQUxt90$AmI4Ee/G58nhQs0/FPR3wEpVThZwOKs8eyZqXmGU4n.:18896:0:99999:7:::
systemd-coredump:!*:18896::::::
vboxadd:!:18899::::::
bart:$y$j9T$XjMYmgIXJKlf5XiUZTWFe0$skqNAAVJg6a1gPETcar/q8FMxzBH5mHuyXazVGWjpm1:18913:0:99999:7:::
root@studentdeb:~# 
~~~

Merk op dat je als gewone gebruiker de inhoud van dit bestand niet kunt bekijken.

### Groepen

Je kunt in Linux meerdere gebruikers aan een groep toekennen.
Zo kun je bijvoorbeeld eenvoudig in één keer toegang tot bestanden verlenen aan een groep gebruikers in plaats van aan één gebruiker.

Net als gebruikers gebruikersnamen hebben, hebben groepen groepsnamen.
Intern zal Linux groepen echter onderscheiden door het unieke identificatienummer 
dat eraan is toegekend, de groeps-ID of GID.

De toewijzing van groepsnamen aan GID's wordt gedefinieerd in het bestand `/etc/group`:

~~~
root@studentdeb:~# tail /etc/group
pulse:x:117:
pulse-access:x:118:
scanner:x:119:saned,student
saned:x:120:
colord:x:121:
lightdm:x:122:
student:x:1000:
systemd-coredump:x:999:
vboxsf:x:998:
bart:x:1001:
root@studentdeb:~# 
~~~

Kijk bijvoorbeeld naar de regel voor de groep scanner:

~~~
scanner:x:119:saned,student
~~~

Hierin vind je de volgende info:

* **scanner** =>  
  Groepsnaam voor deze groep.
* **x** =>  
  Veld voor het groepswachtwoord. Dit veld moet altijd x zijn.
* **119** =>  
  Het GID voor deze groep.
* **saned,student** =>  
  Een lijst met gebruikers die deze groep als aanvullende groep hebben.

#### Gebruiker aan een groep toevoegen

Met de opdracht `groups` kan je nakijken tot welke groepen je behoort.  
Standaard wordt er een groep aangemaakt met dezelfde naam als je gebruiker:

~~~
root@studentdeb:~# groups bart
bart : bart
~~~

Als je de gebruiker bart bijvoorbeeld wil **toevoegen** aan een **bestaande groep**, kan dit met de opdracht `usermod`.  
Deze opdracht herkent **dezelfde opties** als `useradd`. In dit geval gebruiken we `usermod -aG` om een een groep toe te voegen:

~~~
root@studentdeb:~# usermod -aG scanner bart
root@studentdeb:~# groups bart
bart : bart scanner
root@studentdeb:~# 
~~~

#### Groep aanmaken

In bovenstaand geval voegden we een bestaande groep toe. Maar wat als je een nieuwe groep wil aanmaken?  

Dat kan via de opdracht `groupadd`.  
We maken bijvoorbeeld een groep students aan:

~~~
root@studentdeb:~# groupadd students
~~~

Vervolgens voegen we de twee huidige gebruikers (bart en student) toe aan deze groep (via `usermod`):

~~~
root@studentdeb:~# usermod -aG students bart
root@studentdeb:~# usermod -aG students student
~~~

#### Gebruikers van een groep tonen

Vervolgens kan je de opdracht `groupmems` gebruiken om de leden van deze groep te tonen:

~~~
root@studentdeb:~# groupmems -g students --list
bart  student 
~~~

#### Primaire en secundaire groepen

Elke gebruiker heeft precies één primaire groep.  
Voor lokale gebruikers is dit de groep met het GID vermeld in
het bestand `/etc/passwd`.

Standaard is dit de groep die eigenaar is van nieuwe bestanden die door de gebruiker zijn gemaakt.  
Normaal gesproken - wanneer je een nieuwe gewone gebruiker aanmaakt - wordt er een nieuwe groep met dezelfde naam als die gebruiker aangemaakt.

Deze groep wordt gebruikt als de primaire groep voor de nieuwe gebruiker, en die gebruiker is het enige
lid van deze groep. Het maakt het beheer van de bestanden en directory's (en de permissies ervan) eenvoudiger.
