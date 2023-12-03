## Installatie van een tweede Linux-distributie: Fedora

### Downloaden van de "Fedora Workstation"-image

Alvorens te starten, downloaden we de meest recente versie van Fedora, die je vindt op https://fedoraproject.org/workstation/download. Download het ISO-bestand **For Intel andAMD x86_64 systems**.

> Merk op: de screenshots zijn mogelijk nog van een oudere versie.

### Voorbereiding (VirtualBox)

We starten met VirtualBox voor te bereiden op de installatie.

We maken een nieuwe virtuele machine aan zoals hieronder geïllustreerd. Dat kan via het menu **Machine / New**.

![](Pictures/10000000000002480000018B3CD060A8B7738384.png)

De hoeveelheid geheugen (RAM) is bij voorkeur 2-4 GB, maar 1 GB zou ook moeten lukken. Zorg dat je nog voldoende RAM over houdt voor je besturingssysteem waarop je VirtualBox draait, én voor twee virtuele machines: Fedora en Debian. Want we gaan later de twee virtuele machines tegelijk draaien en met elkaar laten communiceren via een virtueel netwerk.

![](Pictures/100000000000024F0000018AAEEC681F99DD621A.png)

Maak een virtuele harde schijf aan. Kies ervoor om een nieuwe harde schijf aan te maken.

![](Pictures/100000000000024B0000018978A41FDB28CC93B7.png)

Kies als type harde schijf **VDI (VirtualBox Disk Image)**.

![](Pictures/1000000000000252000001D888151C11009A73A2.png)

Kies voor dynamische allocatie, zodat je VDI-bestand meegroeit met de ruimte die het besturingssysteem nodig heeft in plaats van al vanaf het begin de maximumgrootte in te nemen.

![](Pictures/1000000000000252000001D541F32B745A173B4E.png)

Kies de grootte van de harde schijf, bij voorkeur meer dan 15 GB.

![](Pictures/1000000000000255000001D64F664F61752A175E.png)

Daarna klik je op **Create** om je image aan te maken.

### Installatie-cd aankoppelen

Wanneer je op **Finish** klikt, zul je zien dat er een nieuwe virtuele machine toegevoegd is in de lijst van VirtualBox.

![](Pictures/10000000000001B200000078CC15107023C034A1.png)

Om de installatie-cd aan te koppelen:

* open je de instellingen van je virtuele machine
* navigeer je naar **Storage**
* klik je op het cd-schijfje om je iso-bestand als virtuele cd aan te koppelen

![](Pictures/10000000000002F90000022B2B1FD7E25E65943B.png)

Eenmaal geselecteerd, zul je zien dat het iso-bestand als cd aangeduid staat. Nu kun je de installatie starten...

### Installatie

Start de virtuele machine.

Je krijgt een tekstvenster te zien. Daarin kies je voor "Start Fedora-Workstation-Live".

![](Pictures/100000000000027F000002236314933178240796.png)

Zodra Fedora vanaf de cd opgestart is, kies je voor de installatie op de harde schijf:

![](Pictures/100000000000077F000003F1BF6FA67090E743B4.png)

In de eerste stap kies je de taal.

![](Pictures/100000000000077F000003EFA857AD2CDEDF5F06.png)

Vervolgens kom je in het installatie-overzicht.

Je kunt hier drie zaken configureren:

* toetsenbordinstellingen
* tijdzone
* de installatiebestemming 

De eerste twee worden normaal gezien automatisch gedetecteerd. Pas ze aan indien nodig.

Het belangrijkste is de installatiebestemming, namelijk op welke schijf je Fedora wilt installeren.

![](Pictures/100000000000077A000003EDC0DDFBBD6A1FD819.png)

Selecteer de volledige harde schijf en klik dan linksboven op **Klaar**.

![](Pictures/100000000000077F000003F3DD3A0BF1B6F2B544.png)

Zodra je terug bent in het hoofdinstallatiescherm, is de knop **Begin installatie** blauw om aan te tonen dat je verder kunt.

![](Pictures/1000000000000778000003EA8AE07B3FDEE03F4D.png)

Klik op de knop om de installatie van Fedora op je (virtuele) harde schijf te starten.

![](Pictures/100000000000077F000003EA072DE9F86760296D.png)

![](Pictures/100000000000077D000003E85978CAF3BC175E36.png)

Na deze installatie kun je de virtuele machine afsluiten.

![](Pictures/100000000000077C000003F743E6E3D0C7BBA5C2.png)

### Configuratie van het systeem

De installatie van Fedora Workstation gebeurt (in tegenstelling tot Debian) in twee stappen:

* Je installeert het besturingssysteem (alle software die je nodig hebt om een systeem te starten)
* Na de eerste opstart log je in om gebruikersspecifieke zaken te configureren op je systeem.

Start dus nu je systeem opnieuw op, maar zorg wel dat het iso-image niet meer aan de virtuele machine aangekoppeld is.

Je krijgt dan na het opstarten het volgende scherm:

![](Pictures/10000000000003E9000002CBF5C2A611752AFD92.png)

Ga verder met een klik op **Configuratie starten**.

Bij de eerste stap krijg je een keuze rond privacy, we laten deze uitgeschakeld staan.

![](Pictures/10000000000003CB000002D08B1F57C13FF14FCA.png)

We laten ook de volgende keuze uit staan...

![](Pictures/10000000000003C7000002CF92A8C5A8DF793925.png)

En koppelen geen online-accounts...

![](Pictures/10000000000003C5000002CA96171330B68FD891.png)

De nu komende opties zijn de belangrijkste, namelijk je gebruikersnaam en wachtwoord.

In het eerste scherm vul je je gebruikersnaam in. Kies hier voor dezelfde gebruiker als je op je Debian-systeem gebruikt, namelijk student.

![](Pictures/10000000000003D4000002CC564E1125AA6F55D9.png)

Als laatste kies je als wachtwoord student (net zoals je in je Debian-installatie hebt gebruikt).

![](Pictures/10000000000003D1000002C49777226BDBDC7F38.png)

Nu is je Fedora-systeem klaar om mee te werken.  

> Bemerk dat je geen root-gebruiker (en bijbehorend wachtwoord) hebt moeten gebruiken.  
> We komen hier later nog op terug...
