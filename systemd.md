## Systemd en het beheer van een Linux-systeem

### Opstarten van een Linux-distributie

Zoals we eerder gezien hebben wordt een GNU/Linux-systeem opgestart volgens onderstaand schema:

~~~
+---------------------+
|  1ST BOOTLOADER     | (bv. BIOS/UEFI)
+----------+----------+
           |
+----------v----------+
|  2ND BOOTLOADER     |  (bv. GRUB, U-Boot)
+----------+----------+
           |
+----------v----------+
|        KERNEL       |  => PID 0
+----------+----------+
           |
+----------v----------+
|         INIT        |  => PID 1 (bv. systemd, init, system-v, ...)
+----------+----------+
           |
+----------v----------+
|       RUNLEVEL      |
+---------------------+
~~~

Op het moment dat de kernel opgestart is, zal deze het besturingssystee= opstarten dat je als eindgebruiker zult gebruiken.  
Dat doet de kernel door het eerste proces op te starten, namelijk `/sbin/init`.  
Zoals je hieronder ziet, start dit systeem op met PID 1:

~~~
$ ps aux | head
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0 168676 11996 ?        Ss   14:39   0:01 /sbin/init splash
root           2  0.0  0.0      0     0 ?        S    14:39   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        I<   14:39   0:00 [rcu_gp]
root           4  0.0  0.0      0     0 ?        I<   14:39   0:00 [rcu_par_gp]
root           5  0.0  0.0      0     0 ?        I    14:39   0:00 [kworker/0:0-events]
root           6  0.0  0.0      0     0 ?        I<   14:39   0:00 [kworker/0:0H-events_highpri]
root           8  0.0  0.0      0     0 ?        I<   14:39   0:00 [kworker/0:1H-events_highpri]
root           9  0.0  0.0      0     0 ?        I<   14:39   0:00 [mm_percpu_wq]
root          10  0.0  0.0      0     0 ?        S    14:39   0:00 [ksoftirqd/0]
~~~

Als je dit nader bekijkt, is deze `/sbin/init` eigenlijk een softlink naar een programma met de naam `systemd`: 

~~~
bart@bvlegion:~$ ls -l /sbin/init 
lrwxrwxrwx 1 root root 20 Apr 21 14:54 /sbin/init -> /lib/systemd/systemd
bart@bvlegion:~$ 
~~~

### systemd

Dit eerste proces - genaamd `systemd` - is verantwoordelijk voor het initialiseren en opstarten van het systeem en alle software waarmee je als gebruiker te maken krijgt.  

Dit houdt in dat het onder andere:

* **daemons** (services of systeemdiensten) opstart
* zorgt dat die in de juiste **volgorde** opgestart worden
* de mogelijkheid geeft om daemons **on demand** te **stoppen** en te **starten**
* daemons naar logbestanden laat schrijven met **journald**
* daemons op periodieke tijdstippen kan laten uitvoeren met **systemd-timers** (alternatief voor `cron`)
* ...

![](Pictures/systemd.png)

> Nota:  
> Op sommige embedded systemen en Android zul je een ander init-systeem dan `systemd` zien.
> Daar gaan we in deze cursus niet op in.

### services

De bedoeling van dit deel van de cursus is om je door de basisprincipes van het beheer van services in Linux te leiden. Je leert met `systemd` services te beheren en  nuttige informatie op te vragen over de status van deze services.

**Services** zijn **processen** die in de achtergrond draaien.  
Dat kan bijvoorbeeld een **webserver** zijn, een **database** maar ook basisonderdelen van je besturingssysteem zoals een **network manager**, een **window manager** voor de grafische interface, ...

> Naast een service kent `systemd` nog andere types **units**:
> 
> * Target: group of units
> * Automount: filesystem auto-mountpoint
> * Device: kernel device names, which you can see in sysfs and udev
> * Mount: filesystem mountpoint
> * Path: file or directory
> * Scope: external processes not started by systemd
> * Slice: a management unit of processes
> * Snapshot: systemd saved state
> * Socket: IPC (inter-process communication) socket
> * Swap: swap file
> * Timer: systemd timer
>
> In deze cursus focussen we ons op de services.

### Services beheren met `systemctl`

Het beheren van services doe je met de opdracht `systemctl`. Je kunt dit beschouwen als de opdracht om `systemd` aan te sturen. 

Dit zijn de basisopdrachten:

~~~
# systemctl start [name.service]
# systemctl stop [name.service]
# systemctl restart [name.service]
# systemctl reload [name.service]
$ systemctl status [name.service]
$ systemctl is-active [name.service]
$ systemctl list-units --type service --all
...
~~~

Let op: voor sommige opdrachten heb je rootrechten nodig (aangeduid met `#`), voor andere niet (aangeduid met `$`).

### Service stoppen en starten

#### Stoppen

Als `ssh` een actieve service is, stop je die als volgt:

~~~
# systemctl stop ssh.service
~~~

> Je moet dit als rootgebruiker doen, omdat gewone gebruikers niet de toestand van het besturingssysteem mogen veranderen.

Je kunt overigens ook de `.service` weglaten:

~~~
# systemctl stop ssh
~~~

#### Starten

Een niet actieve service starten, doe je als volgt:

~~~
# systemctl start ssh.service
~~~

Ook hier kun je weer `.service` weglaten.

#### Herstarten en herladen

Als je een service wil stoppen en opnieuw starten, kan dat met één opdracht:

~~~
# systemctl restart ssh.service
~~~

Sommige services kunnen hun configuratie opnieuw inladen zonder het hele programma te moeten herstarten. Dat gaat met:  

~~~
# systemctl reload ssh.service
~~~

Als je er niet zeker van bent of de service de mogelijkheid heeft om zijn configuratie opnieuw te laden, gebruik dan:

~~~
# systemctl reload-or-restart ssh.service
~~~

Hiermee wordt de configuratie opnieuw geladen als de service dat ondersteunt.  
In het andere geval wordt de service herstart, wat uiteraard ook de configuratie opnieuw inlaadt.

### Services automatisch starten

Met de voorgaande opdrachten kun je services voor de huidige sessie starten of stoppen. Maar als je een service die standaard opstart stopt en daarna je Linux-systeem herstart, start die service ook opnieuw op. Met andere woorden: de toestand van het starten of stoppen blijft niet behouden.  
Je kunt `systemd` ook opdragen om services automatisch te starten bij het opstarten van het Linux-systeem:

~~~
# systemctl enable ssh.service
~~~

Dit zal een symbolische link maken naar het servicebestand 
(meestal in `/lib/systemd/system` of `/etc/systemd/system`). Die link wordt dan gemaakt op een plaats waar `systemd` zoekt naar bestanden om aytomatisch op te starten.

Om daarentegen juist te voorkomen dat de service automatisch wordt gestart, typ je:

~~~
# systemctl disable ssh.service
~~~

Hiermee wordt de symbolische link verwijderd die aangeeft dat de service automatisch moet worden gestart.

Hou er rekening mee dat het inschakelen van een service met `enable` deze service niet start in de huidige sessie. 
Als je de service nu wilt starten én deze ook bij het opstarten wilt inschakelen, 
moet je twee opdrachten geven:

~~~
# systemctl enable ssh.service
# systemctl start ssh.service
~~~

Maar het kan ook met de optie `--now` voor `enable`:

~~~
# systemctl enable --now ssh.service
~~~

### Status van een service opvragen

Om na te kijken wat de status van een service is, gebruik je:

~~~
# systemctl status ssh.service
~~~

Je krijgt dan te zien of de service ingeschakeld is, actief, wat de locatie van het servicebestand is, wat de PID's van de processen zijn, en de laatste regels van het logbestand:

~~~
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2023-11-21 16:01:25 CET; 1h 47min ago
       Docs: man:sshd(8)
             man:sshd_config(5)
    Process: 1414 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
   Main PID: 1445 (sshd)
      Tasks: 1 (limit: 8824)
     Memory: 3.2M
        CPU: 32ms
     CGroup: /system.slice/ssh.service
             └─1445 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"

nov 21 16:01:25 x1 systemd[1]: Starting OpenBSD Secure Shell server...
nov 21 16:01:25 x1 sshd[1445]: Server listening on 0.0.0.0 port 22.
nov 21 16:01:25 x1 systemd[1]: Started OpenBSD Secure Shell server.
nov 21 16:01:25 x1 sshd[1445]: Server listening on :: port 22.
~~~

Op deze manier kun je eventuele problemen herkennen.

Er zijn ook opdrachten om op te vragen of een service zich in een specifieke toestand bevindt.  
Om bijvoorbeeld te controleren of een service momenteel actief is:

~~~
# systemctl is-active ssh.service
active
~~~

Of als je wilt weten of de service automatisch opstart samen met je Linux-systeem:

~~~
# systemctl is-enabled application.service
enabled
~~~

Beide opdrachten zullen de exitcode op 0 of niet 0 zetten afhankelijk van het antwoord.  
Hieronder zie je wat er gebeurt als je een service stopzet:

~~~
# systemctl is-active ssh.service
active
# echo $?
0
# systemctl stop ssh.service
# systemctl is-active ssh.service
inactive
# echo $?
3
~~~

Wanneer de service actief is, krijg je een exitcode 0.  
Is deze echter stopgezet, dan krijg je een getal verschillend van 0 
(in het voorbeeld 3).

### Overzicht van de services

#### Lijst met huidige units

Om een lijst op te vragen van alle actieve eenheden die `systemd` kent, kunnen we de opdracht `list-units` gebruiken:

~~~
# systemctl list-units
UNIT                                      LOAD   ACTIVE SUB     DESCRIPTION
atd.service                               loaded active running ATD daemon
avahi-daemon.service                      loaded active running Avahi mDNS/DNS-SD Stack
dbus.service                              loaded active running D-Bus System Message Bus
dcron.service                             loaded active running Periodic Command Scheduler
dkms.service                              loaded active exited  Dynamic Kernel Modules System
getty@tty1.service                        loaded active running Getty on tty1
. . .
~~~

De kolommen hebben de volgende betekenis:

* **UNIT:**  
  De naam van de eenheid
* **LOAD:**  
  Of de configuratie van de eenheid is geladen door `systemd`.  
  De configuratie van geladen eenheden wordt in het geheugen bewaard.
* **ACTIVE:**  
  De status op hoog niveau: of de unit actief is. 
  Dit is meestal een vrij eenvoudige manier om te zien of de eenheid succesvol is gestart of niet.
* **SUB:**  
  Dit is een status op een lager niveau die gedetailleerdere informatie over de eenheid geeft. 
  Dit varieert vaak per type van unit.
* **DESCRIPTION:**  
  Een korte tekstuele beschrijving van wat de unit is/doet.

We kunnen ook extra opties toevoegen aan `systemctl` om andere informatie te verkrijgen.   
Om bijvoorbeeld alle (niet alleen de actieve) units geladen door `systemd` (of geprobeerd te laden) te zien, gebruik je de optie `--all`:

~~~
# systemctl list-units --all
~~~

Stel dat je alleen de units wilt zien die niet gestart zijn, dan kun je ook nog een extra optie toevoegen:

~~~
# systemctl list-units --all --state=inactive
~~~

Wil je alleen de units zien van het type `service` (degene waarin we hier vooral geïnteresseerd zijn), voeg dan een filter op het type toe:

~~~
# systemctl list-units --type=service
~~~

### Extra informatie over een unit opvragen

#### Het bestand van een unit tonen

Om het bestand van een unit weer te geven dat `systemd` in zijn systeem heeft geladen, 
kun je de opdracht `cat` gebruiken. Voor de service `ssh` iet dat er bijvoorbeeld als volgt uit:  

~~~
$ systemctl cat ssh
# /lib/systemd/system/ssh.service
[Unit]
Description=OpenBSD Secure Shell server
Documentation=man:sshd(8) man:sshd_config(5)
After=network.target auditd.service
ConditionPathExists=!/etc/ssh/sshd_not_to_be_run

[Service]
EnvironmentFile=-/etc/default/ssh
ExecStartPre=/usr/sbin/sshd -t
ExecStart=/usr/sbin/sshd -D $SSHD_OPTS
ExecReload=/usr/sbin/sshd -t
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=on-failure
RestartPreventExitStatus=255
Type=notify
RuntimeDirectory=sshd
RuntimeDirectoryMode=0755

[Install]
WantedBy=multi-user.target
Alias=sshd.service
~~~

Op de eerste regel van de uitvoer krijg je ook de locatie van dit bestand te zien, `/lib/systemd/system/ssh.service`.

#### Afhankelijkheden

Om te zien wat de afhankelijkheden van een service zijn, kun je de opdracht `list-dependencies` gebruiken:  

~~~
$ systemctl list-dependencies ssh
ssh.service
● ├─-.mount
● ├─system.slice
● └─sysinit.target
●   ├─apparmor.service
●   ├─blk-availability.service
●   ├─dev-hugepages.mount
●   ├─dev-mqueue.mount
●   ├─finalrd.service
●   ├─keyboard-setup.service
●   ├─kmod-static-nodes.service
●   ├─lvm2-lvmpolld.socket
●   ├─lvm2-monitor.service
●   ├─plymouth-read-write.service
●   ├─plymouth-start.service
●   ├─proc-sys-fs-binfmt_misc.automount
●   ├─setvtrgb.service
●   ├─sys-fs-fuse-connections.mount
●   ├─sys-kernel-config.mount
●   ├─sys-kernel-debug.mount
●   ├─sys-kernel-tracing.mount
○   ├─systemd-ask-password-console.path
●   ├─systemd-binfmt.service
○   ├─systemd-boot-system-token.service
●   ├─systemd-journal-flush.service
●   ├─systemd-journald.service
○   ├─systemd-machine-id-commit.service
●   ├─systemd-modules-load.service
○   ├─systemd-pstore.service
●   ├─systemd-random-seed.service
●   ├─systemd-sysctl.service
●   ├─systemd-sysusers.service
●   ├─systemd-timesyncd.service
●   ├─systemd-tmpfiles-setup-dev.service
●   ├─systemd-tmpfiles-setup.service
●   ├─systemd-udev-trigger.service
●   ├─systemd-udevd.service
●   ├─systemd-update-utmp.service
●   ├─cryptsetup.target
●   │ └─systemd-cryptsetup@nvme0n1p5_crypt.service
●   ├─local-fs.target
●   │ ├─-.mount
●   │ ├─boot.mount
○   │ ├─systemd-fsck-root.service
●   │ └─systemd-remount-fs.service
●   ├─swap.target
●   │ └─dev-mapper-vgubuntu\x2dswap_1.swap
●   └─veritysetup.target
~~~

#### Detailinformatie

Je kunt ook alle eigenschappen van een service opvragen:

~~~
$ systemctl show ssh|head
Type=notify
Restart=on-failure
NotifyAccess=main
RestartUSec=100ms
TimeoutStartUSec=1min 30s
TimeoutStopUSec=1min 30s
TimeoutAbortUSec=1min 30s
TimeoutStartFailureMode=terminate
TimeoutStopFailureMode=terminate
RuntimeMaxUSec=infinity
...
~~~

Of vraag één specifieke eigenschap op met de optie `-p`:

~~~
$ systemctl show ssh -p Description
Description=OpenBSD Secure Shell server 
~~~

### Masking en unmasking van units

We hebben eerder gezien dat je een service kunt starten en stoppen, en ook kunt in- en uitschakelen om ze al dan niet automatisch te laten starten bij het opstarten van je Linux-systeem.  

In sommige gevallen wil je echter dat de service niet gestart kan worden (ook niet manueel).  
Dat doe je door ze te maskeren:

~~~
# systemctl mask ssh.service
~~~

Dit voorkomt dat de service wordt gestart, automatisch of handmatig, zolang deze "masked" is.  
Als je de opdracht `list-unit-files` gebruikt, zie je dat de service nu wordt aangeduid als "masked".

Als je probeert de service dan toch nog te starten, krijg je een boodschap zoals hieronder:

~~~
# systemctl start ssh.service
Failed to start ssh.service: Unit ssh.service is masked.
~~~

Om de service weer 'bruikbaar' te maken, moet je ze "unmasken":

~~~
# systemctl unmask ssh.service
~~~

Nu kun je de service wel weer starten.

### Targets

Targets functioneren in `systemd` als synchronisatiepunten tijdens het opstarten van het systeem. 
Unit-bestanden waarvan de naam eindigt op de bestandsextensie `.target` vertegenwoordigen de systemd-targets. 

Het doel van target-units is om verschillende systeem-units te groeperen via afhankelijkheden.

Twee voorbeelden:

* De unit `graphical.target` voor het starten van een grafische sessie start systeemdiensten zoals de GNOME Display Manager (`gdm.service`) of Accounts Service (`accounts-daemon.service`) en activeert ook de eenheid `multi-user.target`.
* De unit `multi-user.target` start onder andere essentiële systeemdiensten zoals NetworkManager (`NetworkManager.service`) en D-Bus (`dbus.service`)

#### Wat is je target?

Je kunt het target dat je systeem gebruikt op twee manieren nakijken. Met `systemctl get-default`:

~~~
$ systemctl get-default
graphical.target
~~~

Of door de volgende symbolic link na te gaan:

~~~
$ ls -l /usr/lib/systemd/system/default.target 
lrwxrwxrwx 1 root root 16 mrt  2  2023 /usr/lib/systemd/system/default.target -> graphical.target
~~~

#### Wat zijn de mogelijke targets?

Als je de mogelijke targets wil zien (of toch deze die geladen zijn), kun je alle units van het type `target` opvragen:

~~~
$ systemctl list-units --type target

UNIT                  LOAD   ACTIVE SUB    DESCRIPTION
basic.target          loaded active active Basic System
cryptsetup.target     loaded active active Encrypted Volumes
getty.target          loaded active active Login Prompts
graphical.target      loaded active active Graphical Interface
local-fs-pre.target   loaded active active Local File Systems (Pre)
local-fs.target       loaded active active Local File Systems
multi-user.target     loaded active active Multi-User System
network.target        loaded active active Network
paths.target          loaded active active Paths
remote-fs.target      loaded active active Remote File Systems
sockets.target        loaded active active Sockets
sound.target          loaded active active Sound Card
spice-vdagentd.target loaded active active Agent daemon for Spice guests
swap.target           loaded active active Swap
sysinit.target        loaded active active System Initialization
time-sync.target      loaded active active System Time Synchronized
timers.target         loaded active active Timers

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
SUB    = The low-level unit activation state, values depend on unit type.

17 loaded units listed.
~~~

Bovenstaande opdracht zal slechts de targets tonen die momenteel actief zijn.  
Wil je alle targets zien, voeg dan de optie `--all` toe:

~~~
$ systemctl list-units --type target --all
~~~

#### Target wijzigen

Als je wilt dat het systeem standaard niet met een grafische interface
opstart, gebruik dan de opdracht `set-default` om een andere standaard target in te stellen.

Bijvoorbeeld:

~~~
# systemctl set-default multi-user.target
rm /etc/systemd/system/default.target
ln -s /usr/lib/systemd/system/multi-user.target /etc/systemd/system/default.target
~~~

Zoals je ziet, vervangt deze opdracht het bestand `/etc/systemd/system/default.target` 
door een nieuwe symbolic link naar `/usr/lib/systemd/system/multi-user.target`.

#### Targets isoleren

Wil je terugvallen naar een specifieke target, gebruik dan de opdracht `isolate`.   
Zo zorg je er op de volgende manier voor dat je naar het target `multi-user` terugkeert en alle
units verbonden aan het target `graphical` afsluit.

~~~
# systemctl isolate multi-user.target
~~~

#### Belangrijke targets

Er zijn targets bepaald voor belangrijke gebeurtenissen zoals het uitschakelen of opnieuw opstarten. Zo kun je bijvoorbeeld naar de rescuemodus overschakelen met:

~~~
# systemctl isolate rescue.target
~~~

Maar `systemctl` biedt dit ook in een kortere opdracht aan:

~~~
# systemctl rescue
~~~

Andere van deze korte opdrachten zijn:
 
~~~
# systemctl halt
~~~

~~~
# systemctl poweroff
~~~

~~~
# systemctl reboot
~~~


