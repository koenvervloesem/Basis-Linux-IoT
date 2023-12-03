
## Inloggen op machines over het netwerk met ssh

Om over het netwerk op andere Linux-systemen in te loggen, maakt men meestal gebruik van `ssh` (Secure SHell). Deze verbinding wordt versleuteld, zodat niemand op hetzelfde netwerk de communicatie kan onderscheppen.

### Installatie en configuratie

Installeer hiervoor de OpenSSH-server. Op Debian:

~~~
# apt install openssh-server
~~~

Op Fedora:

~~~
$ sudo dnf install openssh-server
~~~

### Verbinden 

Als eerste test kan je eventueel lokaal verbinden met de machine zelf. Dat gebeurt op de volgende manier:

~~~
ssh <user>@<host-adres>
~~~

Bijvoorbeeld voor de gebruiker student:

~~~
ssh student@localhost
~~~

Om met een andere machine te verbinden, gebruik je het IP-adres of de hostname:

~~~
ssh student@fe80::a00:27ff:fe1c:bf74%wlp2s0
~~~

Merk op: gebruik je een link-local IPv6-adres, dan moet je daarachter `%` en de naam van de interface plaatsen.

### Verbinden zonder wachtwoord

Er bestaat nog een veiliger manier om met ssh in te loggen dan met een wachtwoord: met een sleutelpaar.

#### Sleutels 

Zulke sleutels worden standaard opgeslagen in de directory `~/.ssh`:

~~~
$ ls .ssh/
id_ed25519  id_ed25519.pub  id_rsa  id_rsa.pub  known_hosts  known_hosts.old
$
~~~

#### Een sleutelpaar aanmaken

Om met een server te verbinden, kun je een bestaand sleutelpaar gebruiken, maar we gaan ervan uit dat er nog geen bestaat.

Een sleutelpaar genereren, doe je met de opdracht `ssh-keygen`.
Vul bij de eerste vraag de locatie van de sleutel in, bijvoorbeeld `~/.ssh/id_student`:

~~~
$ ssh-keygen 
Generating public/private rsa key pair.
Enter file in which to save the key (/home/student/.ssh/id_rsa): .ssh/id_student
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in .ssh/id_student
Your public key has been saved in .ssh/id_student.pub
The key fingerprint is:
....
~~~

Als je een passphrase invult, moet je dit elke keer invoeren dat je met de sleutel inlogt. Als je deze passphrase leeg laat, moet dat niet. Dat is uiteraard minder veilig: iedereen die aan je sleutelbestand kan, kan nu op andere machines inloggen waarvoor je deze sleutel ingesteld hebt als inlogmethode.

#### Een sleutel op de server plaatsen

Met `ssh-keygen` maak je een publieke en geheime sleutel aan. De publieke sleutel heeft een bestandsnaam die eindigt op .pub.

Die publieke sleutel verplaats je naar de server waarop je wilt inloggen. Dat kan met de opdracht `ssh-copy-id`:

~~~
$ ssh-copy-id -i ~/.ssh/id_student student@otherhost
~~~

Je moet hiervoor het wachtwoord voor de gebruiker student op otherhost invoeren, want je logt nu nog via het wachtwoord op de andere machine in.

#### Testen

Zodra de publieke sleutel op de andere machine staat, kun je kiezen om via de bijbehorende geheime sleutel op de machine in te loggen:

~~~
$ ssh -i ~/.ssh/id_student student@otherhost
~~~

Er wordt nu niet meer om het wachtwoord van de gebruiker student op de machine gevraagd, maar wel om de passphrase van het sleutelpaar als je die ingesteld hebt.
