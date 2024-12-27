## Sudo

We hebben in het eerste deel van de cursus gezien dat je gebruikersnaam (eigenlijk het gebruikers-ID) een belangrijke factor is die bepaalt wat je op je Linux-systeem kan doen. Een essentieel verschil is dat tussen de root-gebruiker en normale gebruikers. De rootgebruiker kan alles op het Linux-systeem doen. We hebben ook gezien dat je vanuit een shellsessie als normale gebruiker een shellsessie als rootgebruiker kunt opstarten met de opdracht `su -` (waarbij `su` staat voor 'substitute user').

Maar lange tijd als rootgebruiker ingelogd blijven is ook een risico: als je een fout maakt, is de schade groter. Het introduceert ook beveiligingsrisico's. Soms moet je ook door elkaar opdrachten uitvoeren met rootrechten en andere opdrachten die deze rechten niet nodig hebben. Elke keer uit de rootsessie uitloggen en weer inloggen daartussen is omslachtig, en dat niet doen verhoogt de risico's.

Daarom is er een alternatief: `sudo`, wat staat voor 'superuser do'. Hiermee kun je één opdracht in de shell met rootrechten uitvoeren, terwijl je als normale gebruiker ingelogd bent.

### Installatie en configuratie

Op ons minimale Debian-systeem is `sudo` standaard niet geïnstalleerd. Installeer het als volgt:

~~~
# apt install sudo
~~~

Let op: dat kan alleen in een rootsessie. Daarna moeten we eerst nog configureren dat je normale gebruiker met `sudo` kan werken. Bij de installatie van het pakket `sudo` is er ook een groep met de naam `sudo` aangemaakt. De standaardconfiguratie geeft elk lid van die groep het recht om opdrachten met `sudo` uit te voeren. Voeg je gebruiker `student` daarom aan die groep toe:

~~~
# usermod -aG sudo student
~~~

Log nu niet alleen uit je rootsessie uit, maar ook uit de sessie van je normale gebruiker waarin je deze rootsessie opgestart hebt. Type dus twee keer `exit` in en log dan opnieuw in als je normale gebruiker. Deze kan nu `sudo` gebruiken.

### Hoe werkt sudo?

Met `sudo` voer je dus één enkele opdracht uit met de vereiste rootrechten. Na het uitvoeren van de opdracht keer je terug naar je shell met normale gebruikersrechten. Je voert eenvoudigweg de opdracht `sudo` toe vóór de opdracht die je wilt uitvoeren. Als je bijvoorbeeld de pakketbronnen wilt bijwerken maar je niet als rootgebruiker ingelogd bent, voer je de volgende opdracht uit:

~~~
sudo apt update
~~~

De eerste keer dat je `sudo` binnen een sessie gebruikt, vraagt het systeem je om je wachtwoord. Dit is een beveiligingsmaatregel om ervoor te zorgen dat de juiste gebruiker toegang verkrijgt. Na deze initiële verificatie moet je geen wachtwoord meer invoeren bij het aanroepen van `sudo` als dit binnen de vijftien minuten na de vorige aanroep van `sudo` komt. Deze periode is in te stellen.

Merk op dat `sudo` om het wachtwoord van de ingelogde gebruiker vraagt, niet om het wachtwoord van de rootgebruiker.

### Waarom sudo gebruiken?

Er zijn verschillende redenen waarom de voorkeur naar `sudo` uitgaat boven `su`. Zoals gezegd is `sudo` gebruiksvriendelijker en leidt daardoor tot veiliger gedrag. Het voorkomt dat je per ongeluk langdurig als root ingelogd blijft, wat het risico op onherstelbare fouten beperkt.

Op een systeem met meerdere gebruikers is er een ander voordeel: meerdere personen kunnen dankzij `sudo` opdrachten met rootrechten uitvoeren zonder dat ze het rootwachtwoord hoeven te weten. Bovendien houdt `sudo` logboeken bij van alle uitgevoerde opdrachten, wat helpt bij audits en het oplossen van problemen.

Met `sudo` zijn er ook complexere configuraties mogelijk waarbij je sommige gebruikers toelaat om specifieke opdrachten voor het beheer van het systeem uit te voeren zonder hen volledige toegang tot het systeem te geven. Dit wordt allemaal beheerd in het bestand `/etc/sudoers`. Standaard staat hierin bijvoorbeeld de volgende regel op een Debian-systeem:

```
%sudo   ALL=(ALL:ALL) ALL
```

Dit betekent dat ieder lid van de groep `sudo` alle opdrachten met rootrechten mag uitvoeren.

### Sudo configureren

Als je meer fijnmazig rechten wilt toekennen, kan dat ook. Stel dat je een gebruiker genaamd "jan" hebt en je wilt hem toestaan om `apt`-opdrachten uit te voeren zonder telkens een wachtwoord in te voeren, dan zou je dit in `/etc/sudoers` als volgt kunnen configureren:

```plaintext
jan ALL=(ALL) NOPASSWD: /usr/bin/apt
```

Om te voorkomen dat je bij een ongeldige configuratie van `sudo` in de problemen komt, is het belangrijk dat je niet rechtstreeks het bestand `/etc/sudoers` in je editor aanpast, maar dat je dit met de opdracht `visudo` doet. Die controleert of je configuratie geldig is en weigert een ongeldige configuratie op te slaan.
