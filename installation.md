## Linux-distributie installeren: Debian

Vooraleer we met de cursus starten, moeten we een **Linux-distributie installeren**.  

Omdat doorgaans de meeste studenten als besturingssysteem **Windows** of **macOS** gebruiken, maken we in deze cursus gebruik van Linux in een virtuele machine. We doen dit met **VirtualBox**.

> Mocht je ervaring hebben of voorkeur geven aan een andere virtualisatietechnologie
> (Qemu, VMware, Parallels, ...) mag dit ook. Maar dan kan de lector minder hulp bieden.

### Opzetten van een Virtual Image met VirtualBox

We installeren voor de cursus de Linux-distributie **Debian** in een virtuele machine.

#### VirtualBox installeren

VirtualBox is vrij beschikbaar voor Windows, macOS en Linux.

Meer informatie en downloads vind je op https://www.virtualbox.org/wiki/Downloads.

Installeer VirtualBox voordat je verdergaat. 

#### VirtualBox Manager verkennen

Eenmaal VirtualBox geïnstalleerd is, start je het programma op via het **applicatiemenu** van je
Host-besturingssysteem (Windows, macOS of Linux).

> We zullen in deze cursus verwijzen naar **host** en **guest**:
> 
> * **Host** => Het besturingssysteem van je **computer** waarop je VirtualBox draait
> * **Guest** => Het besturingssysteem dat **binnen VirtualBox** draait

VirtualBox kun je eigenlijk beschouwen als een virtuele computer waarop je besturingssystemen draait.

Het hoofdvenster van VirtualBox is de **VirtualBox Manager**. Die geeft je een **overzicht** van de **bestaande VM's** (Virtual Machines).

> Als je VirtualBox net geïnstalleerd hebt, zijn er vanzelfsprekend nog geen virtuele machines te zien.

Vanuit dit overzicht kan je deze **machines configureren en opstarten**.

![](Pictures/10000000000005030000031CF35DDD5C6C93C4C9.png)

#### VirtualBox image aanmaken

We starten met het **aanmaken** van een **image**. Dit is een "virtuele" harde schijf waarop je besturingssysteem zal geïnstalleerd worden.
Je kiest in het VirtualBox-menu **Machine/New**

Het onderstaand **configuratiescherm** verschijnt:

![](Pictures/1000000000000245000001831CBA82EC3EF521B5.png)

Vul hier de volgende **gegevens** in:

* De **naam**: bijvoorbeeld **studentdeb**
* Het **type** besturingssysteem: **Linux**
* De **versie** (distributie): **Debian (64-bit)**

Druk op **Next** om te vervolgen.  

Je **virtuele machine** zal een deel van het **geheugen** van je **host**
innemen. In het volgende scherm dien je het **maximale RAM** in te voeren dat dit systeem mag innemen:

![](Pictures/100000000000024300000186E57B7BA5058C6AC3.png)

Als je host voldoende RAM (4 GB of meer) heeft, ken dan 2 GB toe aan de virtuele machine. Heeft je host minder RAM (minder dan 4 GB), dan mag je het RAM van de virtuele machine beperken tot 1 GB.

##### Harde schijf aanmaken

Net zoals bij de installatie van een besturingssysteem op een fysieke
machine (PC, server, Raspberry Pi, ...) heb je een **harde schijf** of
**persistente opslag** nodig.

In het geval van een virtuele machine, wordt deze schijf **geëmuleerd** door
middel van een bestand, een **VirtualBox Disk Image (VDI)**.

In dit geval mag je gewoon de optie **Create a virtual hard disk now**
kiezen:

![](Pictures/100000000000024500000185022003F032A2FC36.png)

Vervolgens mag je de installatie verderzetten met de standaard
VDI-optie:

![](Pictures/1000000000000250000001D039AE295F86AD2FF0.png)

Bij de volgende optie kiezen we voor een **dynamisch gealloceerd**
VDI-bestand. Dit zorgt ervoor dat het bestand zal **groeien**
naarmate het **besturingssysteem meer ruimte** nodig heeft.  
Als je "Fixed Size" selecteert, zal het bestand daarentegen onmiddellijk de voorgedefinieerde ruimte (zie volgende stap) innemen. Dat is iets **performanter**, maar verspilt wel opslagruimte.

![](Pictures/1000000000000249000001D1CDDCC11193710C8C.png)

Vervolgens bepaal je de **grootte** van deze **harde schijf**.

Als je voldoende ruimte hebt, mag die **20-30 GB** innemen. Indien je dat niet beschikbaar hebt, kies je indien mogelijk **minimum 10 GB**.

![](Pictures/100000000000024B000001D093455ED8AD6EB35C.png)

Vervolgens kies voor "Create" om het image aan te maken.

Zoals je ziet, toont VirtualBox Manager je nu een **nieuwe virtuele machine**:

![](Pictures/10000000000004FF000002ED3781FBE4715A6E69.png)

Als je met de rechtermuisknop binnen VirtualBox Manager de
optie "Show in file manager" kiest, krijg je de bestanden te
zien die aan deze virtuele machine zijn gekoppeld:

* studentdeb.vdi => virtuele harde schijf
* studentdeb.vbox => XML-bestand met de configuratie van het image
* studentdeb.vbox.prev => back-up van bovenvermeld XML-bestand

![](Pictures/100000000000045B0000018B79E541D24B27E727.png)

In de praktijk hoef je niet met deze bestanden te werken; VirtualBox Manager regelt alles voor je.

##### Debian downloaden

Als laatste voorbereiding voor de eigenlijke installatie moeten we een installatiebestand van een Linux-distributie downloaden.

We maken gebruik van Debian 12 (bookworm). Ga hiervoor naar de website https://www.debian.org of kijk in Toledo van deze cursus in het tabblad **Software**, waar we het juiste iso-bestand al klaargezet hebben.

![](Pictures/100000000000076E0000039DD32F1EF032331888.png)

De download neemt +- 360 MB in beslag. Het betreft hier een ISO-image die een minimale installatie voorziet van een Debian-installatie. Hou er dus rekening mee dat je tijdens de installatie nog een internetverbinding zal nodig hebben omdat er dan extra software gedownload wordt.

##### Debian ISO-image aankoppelen

Als je op een fysiek systeem Debian wilt installeren, dan ga je dit ISO-image op een usb-stick schrijven  of (vroeger) op een cd-r branden. Daarna start je je computer vanaf dit opslagmedium op en begint de installatie, die Debian dan op de harde schijf of ssd van je computer installeert.

Binnen VirtualBox doen we iets gelijkaardig. Je kan dit bestand in je virtuele machine rechtstreeks aankoppelen als een (virtuele) CD/DVD.

Hiervoor klik je in VirtualBox Manager met de rechtermuisknop op je "studentdeb"-VM en kies je "Settings". Vervolgens:

-   Navigeer je naar Storage.
-   Klik je op de lege DVD (onder Controller: IDE).
-   Klik je op het schijficoontje aan de rechterkant van het scherm.
-   Selecteer je "Choose a disk file".

![](Pictures/10000000000002F4000002270756CFDAB5552296.png)

Vervolgens opent er zich een scherm waar je het eerder gedownloade
image kan aankoppelen.

![](Pictures/100000000000031600000226E78B5F9D2CA9CE8F.png)

Als resultaat zul je zien dat het image "virtueel" is geplaatst als
CD/DVD:

![](Pictures/10000000000002F6000002289F9BAF02CDBA5811.png)

We zijn nu (eindelijk) klaar om van start te gaan met de werkelijke
installatie...

### Debian installeren

Om je virtuele machine (en bijbehorende installatie vanaf de CD/DVD) te
starten, volstaat het om te dubbelklikken op de studentdeb-VM.

![](Pictures/10000000000005030000031CF35DDD5C6C93C4C9.png)

Eenmaal de virtuele machine gestart is, kom je in het installatiescherm van Debian.

Van deze opties kies je voor "Graphical Install".

De optie Install doet hetzelfde, maar toont geen grafische interface.

![](Pictures/100000000000027B0000021F933A120F4D523C4B.png)

Je drukt gewoon op Enter, waarna de installatie zal starten...

#### Locatie- en taalgegevens kiezen

De eerste stap is het selecteren van de taal, we kiezen hier voor
**English**:

![](Pictures/100000000000032100000298E8400320416A9111.png)

Druk op **Continue**, de volgende stap nu is het **selecteren** van je **locatie**:

![](Pictures/100000000000031D0000029B78C8D40B81F5C369.png)

**België** is **niet** in het **hoofdmenu** voorzien, dus selecteer **"other"** en klik
op **"Continue"**

**Kies** vervolgens voor **"Europe"**:

![](Pictures/100000000000031A000002928323622F3DED1B49.png)

Tenslotte kan je **België** selecteren als land. Dit wordt gebruikt om je tijdzone te weten te komen.

![](Pictures/100000000000031B000002982D48F090782C5816.png)

Aan een taal wordt ook een "locale" gekoppeld die aanduidt welke variant
van Engels er gebruikt wordt. Kies hier voor de "en\_US"-versie:

![](Pictures/100000000000031C000002989F9DD8C35D8B7B70.png)

Daarna selecteer je de toetsenbordindeling.

Als je de standaard Belgische **azerty-indeling** gebruikt, kies je **Belgian**, anders wat op jouw toetsenbord van toepassing is:

![](Pictures/100000000000031D00000299CA42E08DA77969BD.png)

Klik na de keuze van de toetsenbordindeling op **"Continue"**. Het installatieprogramma configureert dan het netwerk:

![](Pictures/100000000000031B0000029441D8AC48FA160319.png)

#### Hostname en gebruiker 

Je Debian-installatie heeft een **hostname** nodig. Kies hier de naam
**studentdeb**.

![](Pictures/100000000000031D0000029A1F70A22B43D1681A.png)

Klik op **Continue**. De **domain name** mag je voorlopig **negeren**:

![](Pictures/1000000000000320000002961DF412DDAF054AB4.png)

Vervolgens dien je een wachtwoord te kiezen voor je **root-account**.  
Dit is een account waarmee je alle beheerdersrechten hebt (te vergelijken met Admin in Windows) en die je normaal gezien alleen gebruikt om **systeemconfiguraties** of **installaties** uit te voeren.

Kies een wachtwoord dat je **kunt onthouden**, want je gaat dit waarschijnlijk niet elke dag invoeren, aangezien de lessen om de twee weken doorgaan...

Gezien het hier een proefopstelling is, stelen we voor om als wachtwoord eenvoudigweg **student** in te stellen.

> Kies **nooit** zo'n eenvoudig wachtwoord voor productiedoeleinden.

![](Pictures/100000000000031F00000298A2928719CEEB69B4.png)

Vervolgens vraagt het systeem je om een **standaardgebruiker** te maken. Deze gebruik je voor taken die geen root-rechten nodig hebben.

Maak hiervoor een gebriker **student** en bijhorend wachtwoord **student** (hetzelfde als bij root).

![](Pictures/10000000000003200000029C7CD38B4698B0D1F3.png)

![](Pictures/100000000000031D0000029AAAB033A4ECA89872.png)

#### Schijf en partitionering

In de volgende stap kiezen we op welke harde schijf (en/of partitie) we Debian gaan
installeren.  
We kiezen hier voor **"Guided Partitioning"**:

![](Pictures/100000000000031B00000298AA7ED65DC857510A.png)

En gebruiken de **volledige schijf** (we komen later nog terug op LVM):

![](Pictures/100000000000031D00000295AAEFC9AD422D04D7.png)

Vervolgens **selecteren** we de schijf:

![](Pictures/100000000000031E00000298E156C6511A88F035.png)

En we kiezen ervoor om alle bestanden in dezelfde partitie bij te
houden:

![](Pictures/100000000000031D0000029879F553A47ECCF326.png)

Het systeem stelt vervolgens een **overzicht** voor van de **installatie**:

![](Pictures/100000000000031E00000294AA4018F7B883F92C.png)

Als je op **Continue** klikt, kom je bij een laatste bevestigingsscherm. Veiligheidshalve staat er standaard **No** geselecteerd op de vraag of je de wijzigingen naar de schijf wilt schrijven:

![](Pictures/100000000000031B00000296CD5981FB355F67B3.png)

Selecteer **Yes** alvorens te bevestigen met **Continue**. Daarna zal het installatieprogramma wijzigingen naar je (virtuele) harde schijf beginnen te schrijven...

![](Pictures/100000000000031D0000029AE2D696A9F2EC2B20.png)

#### Basissysteem installeren

Vervolgens **start** de **installatie** van het **"base system"**. Dat omvat alle **software** die **nodig** is voor het opstarten van een minimale Debian-installatie (zonder grafische gebruikersinterface):

![](Pictures/1000000000000317000002993A9C8C2A65B9ED07.png)

Na deze installatie zal de installer **voorstellen** of er nog installatiemedia
zijn (extra CD's en/of USB-sticks). Hier mag je gewoon **nee** kiezen. Alle
**volgende software gaan we installeren via het netwerk**.

![](Pictures/100000000000031A000002991F45B7629DB0670C.png)

#### Extra software installeren

Ondertussen staat er een **basissysteem** geïnstalleerd, waarop we via een tekstconsole kunnen werken.

We gaan echter nog **extra software installeren** zodat we ook een **grafische interface** ter
beschikking hebben, aangevuld met wat **extra tools** om het beheer van een
systeem te kunnen uitvoeren.

##### Pakketbeheerder configureren

Vele Linux-distributies werken met een **pakketbeheerder** (package manager) om software te installeren en te updaten.

Debians pakketbeheerder, APT (Advanced Package Tool), haalt de software die je installeert van online pakketbronnen, repository's. In de volgende twee stappen kies je een spiegelserver (mirror) waarvan de software gedownload wordt.

Als eerste stap selecteer je het **land** van waaruit je deze updates zal doen. Standaard staat hier het land dat je eerder al ingaf. Doorgaans zullen downloads uit hetzelfde land sneller gaan.

![](Pictures/10000000000002C600000258394F90C0D8F13E96.png)

Vervolgens krijg je een aantal keuzes voor spiegelservers. Kies er een. In de gebouwen van UCLL hebben we een rechtstreekse verbinding met Belnet, dus die zal hier het snelste zijn.

![](Pictures/100000000000031D0000029B0AEA4E5C641F6610.png)

De Debian-installer zal nu verbinding met internet maken en vragen om indien nodig een **proxy** in te stellen.

In de **meeste gevallen** kun je dit leeg laten. In sommige bedrijfsnetwerken moet je een proxy configureren om met internet te verbinden.

![](Pictures/100000000000031A000002975C3E5C62DF77369D.png)

De installer gaat vervolgens op zoek naar beschikbare software:

![](Pictures/100000000000031900000292699108F2CEC2C964.png)

Als dit gedaan is, krijg je nog de vraag of je systeem statistieken mag doorsturen over welke pakketten geïnstalleerd worden. Het staat je vrij om dit al dan niet toe te staan.

![](Pictures/debian_popularity_contest.png)

Klik dan op **Continue** om de volgende stap van de installatie te starten.

##### Software selecteren

We krijgen nu de vraag welke extra software we bovenop het basissysteem willen installeren.

We kiezen hier: 

* **Debian desktop environment** (X-server installatie)
* **Xfce** =\> lichtgewicht desktop environment
* **Standaard system utilities**

![](Pictures/1000000000000322000002986CA54C8BD49E87AD.png)

Nadat je op **Continue** klikt, zal de installer de geselecteerde software
downloaden en installeren...

![](Pictures/100000000000031A0000029A8E7775C05494CB83.png)

#### Bootloader installeren (GRUB)

Een laatste - maar noodzakelijke - stap is het installeren van een
bootloader.  
Dat is software die - voordat het besturingssysteem (en kernel) wordt opgestart - een aantal noodzakelijke initialisaties doet.

Kies **Yes** om deze te installeren op je (virtuele) harde schijf...

![](Pictures/100000000000031E00000297867CDCC5849C7565.png)

Aangezien we maar met één image/schijf werken, mag je deze
selecteren.

![](Pictures/100000000000031C000002974F92BC2762959572.png)

Vervolgens wordt de bootloader geïnstalleerd ...

![](Pictures/100000000000031A00000292007A4A8C18A54D1F.png)

#### Installatie beëindigen

Na het installeren van de bootloader is de installatie compleet. Als je
nu op **Continue** klikt, zal de VM rebooten en zal Debian opstarten.

Je ziet dat de installer vraagt om de installatie-CD/DVD te verwijderen
zodat je niet per ongeluk opnieuw de installer opstart.

VirtualBox zal deze echter automatisch -- bij de reboot -- voor jou
ontkoppelen.

![](Pictures/100000000000031E00000299538E046FB5DA8881.png)

### Debian (met Xfce) opstarten

Bij het opstarten zal eerst het GRUB-scherm verschijnen waar je de keuze
krijgt tussen Debian opstarten of extra boot-opties configureren:

![](Pictures/100000000000027C0000022024EB1439C2FCCD75.png)

Zodra Debian opgestart is, krijg je een scherm om in te loggen. Voer daar
als gebruiker "student" in en als wachtwoord het wachtwoord dat je eerder hebt
gekozen:

![](Pictures/100000000000031B00000299111AAF409B09D171.png)

Vervolgens kom je terecht in de Xfce-desktop:

![](Pictures/100000000000031800000298A66ADF8AE2104181.png)

### VirtualBox Guest Additions installeren

Zoals je waarschijnlijk zult ervaren, is er maar een beperkte keuze in
schermresoluties.

VirtualBox zal de resolutie van het scherm van je virtuele machine niet aanpassen aan de resolutie van de host. Het gevolg? Je krijgt alles in een kleiner scherm te zien, zoals hieronder: 

![](Pictures/10000000000004F3000003F7A2F21EE797EE0EBB.png)

Om de gebruikerservaring te verbeteren gaan we -- vanuit VirtualBox Manager -- de **Guest Additions** installeren/activeren.

#### Guest Additions aankoppelen

Als eerste stap kies je in Virtualbox Manager het menu-onderdeel **Devices / Insert Guest Additions CD Image**.

![](Pictures/10000201000002DF000001EBDFD46DA23D8DA5C2.png)

Als dit de **eerste keer** is dat je deze Guest Additions gebruikt, zal
VirtualBox vragen of het deze mag downloaden.

![](Pictures/100000000000031F0000025BC675106B22848AD5.png)

Klik op **Download**. Vervolgens zal VirtualBox dit opnieuw vragen en
bevestig je opnieuw met een klik op **Download**.

![](Pictures/10000000000003240000025DDED1A2B861A4BDCA.png)

Na de download bevestig je nog een laatste maal dat je de Guest Additions als CD/DVD wil voorzien.

![](Pictures/100000000000032000000256DFCBA1CD7892AF03.png)

#### Guest Additions installeren via de terminal

Nu de Guest Additions beschikbaar zijn, kun je deze binnen je guest (Debian) installeren.

##### Terminalvenster openen

Voor de volgende stap heb je een een terminalvenster nodig. Klik hiervoor **onderaan** in de **dock** op het **tweede icoontje van links**.

![](Pictures/100000000000016800000031315CE3A519FC9352.png)

Vervolgens opent het programma **Terminal**, waarin je opdrachten kan typen.

![](Pictures/10000000000003210000025BAF86F1A2EB214E99.png)

##### Installeren via de terminal

In de terminal voer je de volgende opdrachten uit.

Allereerst wijzig je de gebruiker in de shell naar de root-gebruiker via de opdracht `su` (switch user).

Deze opdracht zal je het wachtwoord van je root-gebruiker ragen (dat je eerder had ingevoerd bij de installatie).  

Tijdens het typen van het wachtwoord krijg je niets te zien. Dat is normaal. Druk gewoon op Enter nadat je je wachtwoord ingevoerd hebt.

~~~
student@studentdeb:~$ su -
Password:
root@studentdeb:~# 
~~~

Zoals je ziet, is de prompt na de opdracht `su` gewijzigd van `student@studentdeb:~$` naar `root@studentdeb:~#`. Dit om je te laten zien dat je als root-gebruiker aan het werken bent.

Vervolgens voer je de volgende opdracht uit:

~~~
root@studentdeb:~# mount /media/cdrom0/
mount: /media/cdrom0: WARNING: source write-protected, mounted read-only
root@studentdeb:~#
~~~

Zoals je ziet geeft deze een kleine waarschuwing. Deze mag je negeren.  

De volgende opdracht is de **eigenlijke installatie** van deze Guest Additions.  

De opdracht die je intypt (op de eerste regel) zal heel wat uitvoer geven, zoals je hieronder ziet...

~~~
root@studentdeb:~# sh /media/cdrom0/VBoxLinuxAdditions.run --nox11
Verifying archive integrity... All good.
Uncompressing VirtualBox 6.1.38 Guest Additions for Linux........
VirtualBox Guest Additions installer
Copying additional installer modules ...
Installing additional modules ...
VirtualBox Guest Additions: Starting.
VirtualBox Guest Additions: Building the VirtualBox Guest Additions kernel 
modules.  This may take a while.
VirtualBox Guest Additions: To build modules for other installed kernels, run
VirtualBox Guest Additions:   /sbin/rcvboxadd quicksetup <version>
VirtualBox Guest Additions: or
VirtualBox Guest Additions:   /sbin/rcvboxadd quicksetup all
VirtualBox Guest Additions: Kernel headers not found for target kernel 
5.10.0-18-amd64. Please install them and execute
  /sbin/rcvboxadd setup
VirtualBox Guest Additions: Running kernel modules will not be replaced until 
the system is restarted
root@studentdeb:~# 
~~~

De belangrijkste boodschap is echter op het einde te zien:

"Running kernel modules will not be replaced until 
the system is restarted"


Je moet je systeem (je guest) dus herstarten alvorens deze Guest Additions beschikbaar zijn.  

Na de herstart van de virtuele machine zul je zien dat je Debian-installatie een hogere schermresolutie gebruikt. Daarnaast kun je nu ook een gedeeld klembord activeren in het menu **Devices / Shared Clipboard**. Dan kun je geselecteerde tekst kopiëren en plakken tussen host en guest en andersom.
