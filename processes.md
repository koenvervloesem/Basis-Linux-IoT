## Processen

In dit deel van de cursus geven we een introductie in een belangrijk concept in elk besturingssysteem, en dan specifiek in Linux: processen.

* Wat zijn processen?
* Hoe ze te **bekijken** of te **monitoren**? => `ps` en `top`
* Hoe ze te **manipuleren**? => **signals** en **job control**
* Hoe **periodieke** taken in te plannen? => `cron`

Met processen kunnen werken, is belangrijk om bijvoorbeeld:

* te controleren of een achtergrondtaak nog altijd draait
* na te kijken waarom een programma niet meer reageert
* een programma dat niet meer reageert te beëindigen
* te bekijken welke bestanden een programma open heeft
* ...

### Wat is een proces?

Elke keer dat je een programma start - of dat nu in een terminalsessie of een grafische interface is - start je een proces.  

Het besturingssysteem houdt heel wat informatie bij rond dit proces:

* Het **programma** (bestandslocatie/pad)
* Een **identificatie** (pid of **process ID**)
* Een **status**
* Een **eigenaar** (het programma wordt uitgevoerd door een gebruiker)
* **Bestanden** en andere **resources** die het proces gebruikt
* **Omgevingsvariabelen**
* Een virtueel geheugen
* ...

### Waarmee start alles?

Wat is het allereerste proces binnen een Linux-distributie?  
Waarmee start het systeem uiteindelijk?

De allereerste software die op je computer (of een embedded device) draait, is een **boot loader**.  
De eerste bootloader is in een chip van de hardware ingebakken (BIOS/UEFI) en zorgt ervoor dat een programma op je persistente geheugen (harde schijf, SSD of flash) wordt opgestart.

~~~
+---------------------+
|  1ST BOOTLOADER     | (bv. BIOS/UEFI)
+----------+----------+
           |
+----------v----------+
|  2ND BOOTLOADER     |  (bv. GRUB, U-Boot)
+----------+----------+
~~~

Het eerste programma dat dan zo van het persistente geheugen wordt opgestart, is een secundaire bootloader.  
Dit programma staat voor klassieke computers met een Basic Input/Output System (BIOS) in het Master Boot Record (MBR) van de harde schijf en voor computers met Unified Extensible Firmware Interface (UEFI) op de GUID Partition Table (GPT).

Dit programma (meestal **GRUB** op klassieke computers of **U-Boot** op embedded devices) doet dan de nodige voorbereidingen (zoals geheugen initialiseren) om dan vervolgens een kernel op te starten, zoals de Linux- of Windows-kernel.

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
~~~

Deze kernel is dan zoals we in de introductie van deze cursus al gezien hebben verantwoordelijk om verschillende **low-level taken** uit te voeren, zoals:

* processor initialiseren
* geheugen initialiseren
* apparaatstuurprogramma's (drivers) en kernelmodules laden
* randapparatuur detecteren
* rootbestandssysteem aankoppelen 

De belangrijkste taak echter is - na bovenstaande initialisaties - het opstarten van 
de *user space* (in contrast met de *kernel space*).

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

Het eerste programma dat in de user space opgestart wordt, zal verschillende services opstarten. Dit initialisatieprogramma krijgt proces-ID 1, terwijl het ouderproces (**parent process**), namelijk de kernel, PID 0 heeft.

~~~
bart@bvlegion:~$ ps -f 1
UID          PID    PPID  C STIME TTY      STAT   TIME CMD
root           1       0  0 Apr23 ?        Ss     0:05 /sbin/init splash
~~~

In dit geval is het programma `/sbin/init` een symbolische link:

~~~
bart@bvlegion:~$ ls -l /sbin/init 
lrwxrwxrwx 1 root root 20 Jan 10 05:56 /sbin/init -> /lib/systemd/systemd
bart@bvlegion:~$ 
~~~

Op de meeste Linux desktop- en serversystemen is dit proces met PID 1 `systemd`. Dit zal vanaf de opstart van de Linux-distributie de verschillende services die je nodig hebt als gebruiker opstarten, beheren en controleren.

> Nota:  
> We komen later nog terug op `systemd`. We focussen nu eerst op de processen en de andere tools
> om deze te beheren.

### Processen bekijken met `ps`

We kunnen deze processen - en hun eigenschappen - op je machine bekijken via de opdracht `ps`. Dit is de afkorting van **process status**.

#### Shell-processen

We zien dat - zonder extra opties - de opdracht `ps` alleen de processen toont binnen je huidige terminalsessie:

~~~
student@studentdeb:~$ ps
    PID TTY          TIME CMD
   1127 pts/3    00:00:00 bash
   3354 pts/3    00:00:00 ps
student@studentdeb:~$ 
~~~

Momenteel geeft het dan ook maar twee processen weer:

* de Bash-shell waarin je de opdracht `ps` intypt
* de opdracht `ps` zelf die op dat moment actief was

Daarnaast zien we dat er voor elk proces meerdere data weergegeven worden in een tabelvorm:

* PID  => het unieke process ID van het proces
* TTY  => de terminal waaraan het proces is gekoppeld voor in- en uitvoer
* TIME => de (processor)tijd dat het proces al actief is
* CMD  => het programma (of de opdracht) waarmee het proces gestart is

#### Meer info met de optie `-f`

Als je de optie `-f` toevoegt, krijg je extra kolommen te zien voor elk proces:

~~~
student@studentdeb:~$ ps -f
UID          PID    PPID  C STIME TTY          TIME CMD
student     1127    1035  0 15:21 pts/3    00:00:00 bash
student     3613    1127  0 21:29 pts/3    00:00:00 ps -f
student@studentdeb:~$ 
~~~

* UID => het ID van de gebruiker verbonden aan het proces
* PPID => het ID van het ouderproces (het proces dat dit proces opgestart heeft)
* C => het percentage in processorbelasting
* STIME => de moment dat het proces is gestart

Merk op: het PPID van het proces met CMD `ps -f` is hetzelfde als het PID van het proces met CMD `bash`. Dit wil zeggen dat die laatste het ouderproces van het eerste is. En dat klopt: we hebben `ps -f` in deze Bash-sessie uitgevoerd.

#### Processen per gebruiker 

De optie `-u` laat je toe om de processen op te vragen die een specifieke gebruiker draait:

~~~
student@studentdeb:~$ ps -u student
    PID TTY          TIME CMD
    724 ?        00:00:00 systemd
    725 ?        00:00:00 (sd-pam)
    744 ?        00:00:00 pipewire
    745 ?        00:00:00 pulseaudio
    747 ?        00:00:06 dbus-daemon
    748 ?        00:00:00 pipewire-media-
    757 ?        00:00:00 xfce4-session
    805 ?        00:00:00 VBoxClient
    ...
~~~

Dit kun je natuurlijk ook combineren met andere opties, zoals `-f`:

~~~
student@studentdeb:~$ ps -f -u student
UID          PID    PPID  C STIME TTY          TIME CMD
student      724       1  0 15:07 ?        00:00:00 /lib/systemd/systemd --user
student      725     724  0 15:07 ?        00:00:00 (sd-pam)
student      744     724  0 15:07 ?        00:00:00 /usr/bin/pipewire
student      745     724  0 15:07 ?        00:00:00 /usr/bin/pulseaudio --daemonize=no --log-target=journal
student      747     724  0 15:07 ?        00:00:06 /usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidf
student      748     744  0 15:07 ?        00:00:00 /usr/bin/pipewire-media-session
student      757     719  0 15:07 ?        00:00:00 xfce4-session
student      805       1  0 15:07 ?        00:00:00 /usr/bin/VBoxClient --clipboard
...
~~~

#### Alle processen bekijken met de optie `-e`

Als je alle processen wilt zien, niet alleen van je huidige shell-sessie of van een specifieke gebruiker, voeg dan de optie `-e` toe. Meestal combineer je deze optie met `-f` tot `ps -e -f`, wat je kunt afkorten tot `ps -ef`:

~~~
student@studentdeb:~$ ps -ef
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 15:05 ?        00:00:01 /sbin/init
root           2       0  0 15:05 ?        00:00:00 [kthreadd]
root           3       2  0 15:05 ?        00:00:00 [rcu_gp]
root           4       2  0 15:05 ?        00:00:00 [rcu_par_gp]
root           6       2  0 15:05 ?        00:00:00 [kworker/0:0H-events_highpri]
root           9       2  0 15:05 ?        00:00:00 [mm_percpu_wq]
root          10       2  0 15:05 ?        00:00:00 [rcu_tasks_rude_]
root          11       2  0 15:05 ?        00:00:00 [rcu_tasks_trace]
root          12       2  0 15:05 ?        00:00:00 [ksoftirqd/0]
...
student     1014     724  0 15:07 ?        00:00:00 /usr/libexec/gvfs-udisks2-volume-monitor
student     1022     875  0 15:07 ?        00:00:00 /usr/libexec/gvfsd-trash --spawner :1.14 /org/gtk/gvfs/exec_spaw/0
student     1028     724  0 15:07 ?        00:00:00 /usr/libexec/gvfsd-metadata
student     1035       1  0 15:07 ?        00:00:11 xfce4-terminal
student     1039    1035  0 15:07 pts/0    00:00:00 bash
student     1042    1039  0 15:07 pts/0    00:00:00 crontab -e
student     1043    1042  0 15:07 pts/0    00:00:00 /bin/sh -c /usr/bin/sensible-editor /tmp/crontab.NvTht0/crontab
student     1044    1043  0 15:07 pts/0    00:00:00 /bin/sh /usr/bin/sensible-editor /tmp/crontab.NvTht0/crontab
student     1046    1044  0 15:07 pts/0    00:00:00 /bin/nano /tmp/crontab.NvTht0/crontab
student     1101    1035  0 15:18 pts/1    00:00:00 bash
student     1103    1101  0 15:19 pts/1    00:00:00 nano nano_ttest
...
~~~

#### Nog meer informatie zien met de optie `-l`

Nog meer informatie krijg je met de optie `-l`. Hieronder zien we bijvoorbeeld dat er een extra kolom **S** (status) is bijgekomen:

~~~
student@studentdeb:~$ ps -efl
F S UID          PID    PPID  C PRI  NI ADDR SZ WCHAN  STIME TTY          TIME CMD
4 S root           1       0  0  80   0 - 41028 -      15:05 ?        00:00:01 /sbin/init
1 S root           2       0  0  80   0 -     0 -      15:05 ?        00:00:00 [kthreadd]
1 I root           3       2  0  60 -20 -     0 -      15:05 ?        00:00:00 [rcu_gp]
1 I root           4       2  0  60 -20 -     0 -      15:05 ?        00:00:00 [rcu_par_gp]
1 I root           6       2  0  60 -20 -     0 -      15:05 ?        00:00:00 [kworker/0:0H-events_highpri]
1 I root           9       2  0  60 -20 -     0 -      15:05 ?        00:00:00 [mm_percpu_wq]
1 S root          10       2  0  80   0 -     0 -      15:05 ?        00:00:00 [rcu_tasks_rude_]
1 S root          11       2  0  80   0 -     0 -      15:05 ?        00:00:00 [rcu_tasks_trace]
1 S root          12       2  0  80   0 -     0 -      15:05 ?        00:00:00 [ksoftirqd/0]
...
0 S lightdm     3825    3805  0  69 -11 - 22615 -      22:11 ?        00:00:00 /usr/bin/pipewire
0 S lightdm     3830    3805  0  80   0 -  2011 -      22:11 ?        00:00:00 /usr/bin/dbus-daemon --session --address
0 S lightdm     3831    3825  0  69 -11 - 21325 -      22:11 ?        00:00:00 /usr/bin/pipewire-media-session
0 S lightdm     3839    3805  0  80   0 - 76779 -      22:11 ?        00:00:00 /usr/libexec/at-spi-bus-launcher
0 S lightdm     3844    3839  0  80   0 -  1977 -      22:11 ?        00:00:00 /usr/bin/dbus-daemon --config-file=/usr/
0 S lightdm     3846    3805  0  80   0 - 59193 -      22:11 ?        00:00:00 /usr/libexec/gvfsd
0 S lightdm     3864    3805  0  80   0 - 41417 -      22:11 ?        00:00:00 /usr/libexec/at-spi2-registryd --use-gno
1 I root        3900       2  0  80   0 -     0 -      22:33 ?        00:00:00 [kworker/u2:3-ext4-rsv-conversion]
1 I root        3912       2  0  80   0 -     0 -      22:43 ?        00:00:00 [kworker/u2:1-events_unbound]
1 I root        3920       2  0  80   0 -     0 -      22:53 ?        00:00:00 [kworker/0:0-ata_sff]
1 I root        3924       2  0  80   0 -     0 -      22:58 ?        00:00:00 [kworker/0:2-ata_sff]
4 R student     3931    1127  0  80   0 -  2425 -      22:59 pts/3    00:00:00 ps -efl
~~~

In deze kolom staat voor elk proces een lettercode die de status van het proces voorstelt. In de man-pagina van de opdracht `ps` staan deze als volgt beschreven:

~~~
D    uninterruptible sleep (usually IO)
I    Idle kernel thread
R    running or runnable (on run queue)
S    interruptible sleep (waiting for an event to complete)
T    stopped by job control signal
t    stopped by debugger during the tracing
W    paging (not valid since the 2.6.xx kernel)
X    dead (should never be seen)
Z    defunct ("zombie") process, terminated but not reaped by its parent
~~~

De meest voorkomende zijn:

* **S** => wacht op een gebeurtenis
* **R** => is actief
* **T** => is gestopt door een extern signaal
* **D** => wacht op invoer (lezen van een bestand of een netwerk)
* **Z** => beëindigd maar nog niet opgekuist

### Signalen

Om de status van een proces te wijzigen kun je vanuit de shell **signalen** naar het proces sturen. Deze signalen zijn een communicatiemiddel tussen processen.

Wanneer een proces een signaal ontvangt, onderbreekt het proces zijn uitvoering en wordt een **signal handler** uitgevoerd. Hoe het programma op een signaal reageert, hangt meestal af van het type signaal dat wordt ontvangen. Nadat het signaal is verwerkt, kan het proces zijn normale uitvoering al dan niet voortzetten.

Een overzicht van deze signalen verkrijg je via de opdracht `kill -l` (zo dadelijk meer over de opdracht `kill`):

~~~
bart@bvlegion:~$ kill -l
 1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
 6) SIGABRT	 7) SIGBUS	 8) SIGFPE	 9) SIGKILL	10) SIGUSR1
11) SIGSEGV	12) SIGUSR2	13) SIGPIPE	14) SIGALRM	15) SIGTERM
16) SIGSTKFLT	17) SIGCHLD	18) SIGCONT	19) SIGSTOP	20) SIGTSTP
21) SIGTTIN	22) SIGTTOU	23) SIGURG	24) SIGXCPU	25) SIGXFSZ
26) SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGIO	30) SIGPWR
31) SIGSYS	34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
38) SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
43) SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
48) SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
53) SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
58) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
63) SIGRTMAX-1	64) SIGRTMAX	
~~~

Niet alle signalen zijn even belangrijk.  
De belangrijkste (meest gebruikte) signalen zijn SIGTERM, SIGQUIT, SIGSTOP, SIGINT en SIGKILL.


#### SIGTERM (15) en SIGQUIT (13)

SIGTERM- en SIGQUIT-signalen zijn bedoeld om een proces te beëindigen. Het zijn beide 'vriendelijke' manieren van vragen, want programma's kunnen dit signaal negeren of er een specifieke behandeling aan koppelen.

SIGTERM is het standaardsignaal wanneer we de opdracht `kill` gebruiken. SIGQUIT genereert ook een bestand met de inhoud van het geheugen voordat het proces beëindigd wordt. Dat is nuttig om problemen te analyseren.

#### SIGSTOP (19) en SIGCONT (18)

SIGSTOP en SIGCONT worden vaak samen gebruikt.  

Het eerste signaal zal een proces pauzeren (suspend). Het programma wordt daardoor niet beëindigd. Dit signaal wordt aan een lopend proces gestuurd wanneer je Ctrl+Z in de terminal indrukt.

Het tweede signaal start een proces dat eerder via signaal 19 gepauzeerd was terug op.

#### SIGINT (2) of keyboard interrupt

SIGINT is het signaal dat verzonden wordt wanneer we Ctrl+C in de terminal invoeren. De standaardactie is om het proces te beëindigen.  

Sommige programma's negeren dit signaal echter en gaan er anders mee om. Een voorbeeld is Bash. Als je in de Bash-prompt op Ctrl+C drukt, wordt Bash niet afgesloten, maar krijg je een nieuwe, lege prompt te zien.

#### SIGKILL (9)

De ultieme manier om een proces te stoppen (als alle andere manieren falen) is het signaal SIGKILL.  

Dit is een speciaal signaal, omdat een proces het niet kan negeren. Wanneer een proces dit signaal ontvangt, wordt het dus sowieso beëindigd. 

Dit signaal kun je gebruiken om een proces geforceerd te beëindigen. Doe dat wel altijd met de hoogste voorzichtigheid, omdat het proces niet de kans krijgt om opruimtaken uit te voeren.

Vaak stuur je eerst het signaal SIGTERM als je een proces wilt beëindigen. Geef het proces wat tijd om zijn opruimtaken uit te voeren. Als het dan nog niet stopt, stuur het dan pass een SIGKILL-signaal.

### Signalen sturen met de opdracht `kill`

De opdracht `kill` laat je toe om één van bovenstaande signalen naar een proces te sturen.  
Je gebruikt dit als volgt:

~~~
kill -<signaal> <pid>
~~~

Je kunt het signaal opgeven als getal (bijvoorbeeld `-9`) of als signaal (bijvoorbeeld `-SIGKILL` of `-KILL`).

We illustreren dit aan de hand van de signalen SIGSTOP en SIGCONT.
Als eerste starten we een langdurende job (die de prompt zal onderbreken):

* Terminal 1:

~~~
$ sleep 5000
~~~

We openen nu een aparte terminal om het PID van dit proces op te zoeken:

* Terminal 2:

~~~
$ ps -u student | grep sleep
50663 pts/23   00:00:00 sleep
$ ps -f 50663 | grep sleep
student      50663 57255  0 13:49 pts/23   S      0:00 sleep 5000
~~~

We zien dat deze job pid 50663 heeft en zich in de toestand **idle** bevindt.  

Via de opdracht `kill` kun je nu signalen sturen.  
We sturen het SIGSTOP-signaal (19) om ervoor te zorgen dat deze job stopt (pauzeert):

* Terminal 2:

~~~
$ kill -19 50663
$ ps -f 50663 | grep sleep
bvo      50663 57255  0 13:49 pts/23   T      0:00 sleep 5000
~~~

In terminal 1 zie je nu dat de prompt weer beschikbaar is.  
Daar kunnen we zien (via de opdracht `jobs` die we zo dadelijk verder uitleggen) dat deze job in de toestand **Stopped** staat:

* Terminal 1:

~~~
$ jobs
[1]+  Stopped                 sleep 5000
$ 
~~~

De job staat dan wel in de stop-state (**T** in de uitvoer van `ps`), dit betekent echter niet dat deze job beëindigd is.  
We kunnen deze job herstarten via het SIGSTART-signaal (18):

* Terminal 2:

~~~
$ kill -18 50663
$ ps -f 50663 | grep sleep
bvo      50663 57255  0 13:49 pts/23   S      0:00 sleep 5000
$
~~~

Aan de kant van terminal 1 zien we dat deze job ook running is (weliswaar in de achtergrond):

* Terminal 1:

~~~
$ jobs
[1]+  Running                 sleep 5000 &
~~~

We kunnen de job nu naar de voorgrond brengen:

~~~
$ fg
sleep 5000
~~~

### Realtime monitoring van processen met `top`

Met de opdracht `ps` krijg je een **snapshot** van wat er op dat moment gaande is. Als je realtime processen wilt monitoren, gebruik je `top`. Hou er wel rekening mee dat dit continu je processor belast. Laat dit dus niet langer draaien dan nodig:

~~~
top - 12:48:49 up 19:38, 21 users,  load average: 2,83, 2,12, 1,88
Tasks: 419 total,   1 running, 417 sleeping,   0 stopped,   1 zombie
%Cpu(s): 13,5 us,  6,7 sy,  0,0 ni, 77,9 id,  0,0 wa,  0,0 hi,  1,8 si,  0,0 st
MiB Mem :  31991,0 total,  13155,7 free,   8652,9 used,  10182,4 buff/cache
MiB Swap:   2048,0 total,   2048,0 free,      0,0 used.  21606,6 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   3563 bart      20   0 5621272   1,0g 483780 S  23,5   3,2 122:01.87 GeckoMain
  35669 bart      20   0   29,7g 329700 100744 S  23,5   1,0  52:33.10 spotify
   2649 bart      20   0 4613048 234084 124064 S  17,6   0,7  17:26.29 cinnamon
  35619 bart      20   0 1284856 134680  93964 S  17,6   0,4  27:20.25 spotify
  47850 bart      20   0 2965720 352428 138208 S  17,6   1,1   2:14.40 Isolated Web Co
   1210 root      20   0 1894144 290696 218180 S  11,8   0,9  40:43.91 Xorg
   3871 bart      20   0 3184476 538468 110888 S  11,8   1,6  90:30.93 Isolated Web Co
   7371 bart      20   0 1465044 121764  74916 S  11,8   0,4   9:34.47 cinnamon-settin
  58405 bart      20   0   12460   4092   3368 R  11,8   0,0   0:00.04 top
   2306 bart       9 -11 3205688  28184  21676 S   5,9   0,1 117:23.16 pulseaudio
   2720 bart      20   0  525400  85380  50012 S   5,9   0,3   0:40.45 guake
  35596 bart      20   0 3604784 242044 149124 S   5,9   0,7   9:54.74 spotify
      1 root      20   0  167828  11776   8368 S   0,0   0,0   0:03.95 systemd
      2 root      20   0       0      0      0 S   0,0   0,0   0:00.05 kthreadd
      3 root       0 -20       0      0      0 I   0,0   0,0   0:00.00 rcu_gp
      4 root       0 -20       0      0      0 I   0,0   0,0   0:00.00 rcu_par_gp
      6 root       0 -20       0      0      0 I   0,0   0,0   0:02.17 kworker/0:0H-events_highpri
      9 root       0 -20       0      0      0 I   0,0   0,0   0:00.00 mm_percpu_wq
     10 root      20   0       0      0      0 S   0,0   0,0   0:02.89 ksoftirqd/0
     11 root      20   0       0      0      0 I   0,0   0,0   0:36.25 rcu_sched
     12 root      rt   0       0      0      0 S   0,0   0,0   0:00.35 migration/0
     13 root     -51   0       0      0      0 S   0,0   0,0   0:00.00 idle_inject/0
     14 root      20   0       0      0      0 S   0,0   0,0   0:00.00 cpuhp/0
     15 root      20   0       0      0      0 S   0,0   0,0   0:00.00 cpuhp/1
     16 root     -51   0       0      0      0 S   0,0   0,0   0:00.00 idle_inject/1
     17 root      rt   0       0      0      0 S   0,0   0,0   0:00.49 migration/1
     18 root      20   0       0      0      0 S   0,0   0,0   0:01.57 ksoftirqd/1
    ...
~~~

In het bovenste deel van de uitvoer geeft `top` statistieken rond uptime (de tijd sinds de computer opgestart is), het aantal ingelogde gebruikers, het aantal processen, en het gebruikte geheugen:

~~~
top - 12:48:49 up 19:38, 21 users,  load average: 2,83, 2,12, 1,88
Tasks: 419 total,   1 running, 417 sleeping,   0 stopped,   1 zombie
%Cpu(s): 13,5 us,  6,7 sy,  0,0 ni, 77,9 id,  0,0 wa,  0,0 hi,  1,8 si,  0,0 st
MiB Mem :  31991,0 total,  13155,7 free,   8652,9 used,  10182,4 buff/cache
MiB Swap:   2048,0 total,   2048,0 free,      0,0 used.  21606,6 avail Mem 
~~~

Daarna komt een tabel met alle processen. Dit zijn de kolommen:

* PID    =>  uniek ID van het proces
* USER   =>  de gebruiker gekoppeld aan het proces
* S      =>  status van het proces
* %CPU => percentage processorbelasting
* %MEM => percentage van het totale werkgeheugen
* TIME => totale processortijd dat het programma heeft ingenomen
* COMMAND => opdracht waarmee het proces opgestart is

### Jobs en job control

**Job control** is een tool binnen de shell die je toelaat om in één shell verschillende opdrachten op te starten en parallel uit te voeren.

Wanneer we een opdracht in Bash opstarten, wordt die uitgevoerd als een **job**.  

We bekijken in dit deel van de cursus hoe die jobs gelinkt zijn aan processen, hoe je ze moet starten, pauzeren en in de achtergrond laten draaien.

#### Een job/opdracht => meerdere processen

Een eerste belangrijk principe om te begrijpen is dan een job kan bestaan uit meerdere processen:

~~~
+--------+
|  CMD   |  Een opdracht starten 
+---+----+  maakt een job aan binnen Bash
    |
    |
+---v----+              +----------+
|  JOB   +--------------+ PROCESS  |
+---+----+              +----------+
    |  Deze job bestaat uit één of meer processen
    |                   +----------+
    +-------------------+ PROCESS  |
                        +----------+

                         ...
~~~

Laten we starten met een job die normaal gezien veel tijd moet innemen.  
De volgende opdracht zoekt het woord blabla in alle bestanden binnen mijn home-directory.  
Dit is een job die meer dan een paar minuten kan duren afhankelijk van de grootte van je home-directory.

~~~
bart@bvlegion:~$ rgrep "blabla" . | less
~~~

Dit heeft nu een job gestart met twee processen (`grep` en `less`).


#### Job onderbreken met Ctrl+Z

Laten we nu even deze job stoppen met de toetsencombinatie Ctrl+Z.  
Dit zal deze job stoppen (of pauzeren). Je krijgt dan een boodschap zoals hieronder:

~~~
[1]+  Stopped                 rgrep "blabla" . | less
bart@bvlegion:~$ pwd 
/home/bart
bart@bvlegion:~$
~~~

Bemerk ook dat de prompt nu beschikbaar is en ik andere opdrachten in de shell kan uitvoeren (geïllustreerd met `pwd`).

#### Job table (en de opdracht `jobs`)

De processen en de jobs zijn gestopt maar niet verdwenen.  
Hiervoor voorziet Bash namelijk een **job table** die bijhoudt welke jobs worden uitgevoerd.

Deze tabel kun je raadplegen via de opdracht `jobs`.  
Deze duidt aan dat er momenteel één job draaiende is. Bemerk ook dat deze een id heeft gekregen (in dit geval 1):

~~~
bart@bvlegion:~$ jobs
[1]+  Stopped                 rgrep "blabla" . | less
~~~

Dit id (1 in het voorbeeld) is niet te verwarren met de PID.  
De PID kun je ook opvragen door een extra optie mee te geven aan jobs (`-l`):

~~~
bart@bvlegion:~$ jobs -l
[1]+ 84420 Stopped                 rgrep "blabla" .
     84421                       | less
bart@bvlegion:~$ 
~~~

Je ziet hier dat er meerdere processen verbonden zijn aan deze job, namelijk met PID 88420 en 88421. De bijbehorende opdrachten worden ook getoond.  
Bestudeer deze processen nu via `ps`:

~~~
bart@bvlegion:~$ ps -l
F S   UID     PID    PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
0 S  1000    3116    2861  0  80   0 -  2870 do_wai pts/6    00:00:00 bash
0 T  1000   84420    3116  0  80   0 -  2428 do_sig pts/6    00:00:01 grep
0 T  1000   84421    3116  0  80   0 -  2193 do_sig pts/6    00:00:00 less
4 R  1000   86246    3116  0  80   0 -  2936 -      pts/6    00:00:00 ps
~~~

* Het hoofdproces is de **Bash-shell** en heeft PID **3116**.
  * Dit proces heeft de status **S**  
    (wat er op neerkomt dat deze wacht op CPU-tijd en **idle** is).
* Dit proces heeft twee kinderen:
  * 84420 => `grep`
  * 84421 => `less`
  * Deze twee processen hebben de status **T**  
    (stop-status die je na een signaal SIGSTOP verkrijgt).

Om deze job terug naar de voorgrond te brengen, gebruik je de opdracht `fg`. De Bash-prompt is dan niet meer toegankelijk en je kunt de job beëindigen met Ctrl+C.

We gaan nu zien hoe je dit programma `fg` en zijn collega `bg` gebruikt om meerdere jobs parallel te draaien.

#### Een job in de achtergrond draaien met &

Een job waarvan het proces wordt gepauzeerd (door een STOP-signaal) wordt in de achtergrond geplaatst.  
Wat als je een job **rechtstreeks** in de **achtergrond** wilt laten lopen (en niet stoppen)?

Een veel gebruikte manier is om je opdracht te laten volgen door een `&`.  
Daardoor zal je opdrachtprompt niet wachten op deze job en deze dus in de achtergrond draaien...

In het onderstaande voorbeeld starten we drie jobs met de opdracht `sleep`. 

> Met de opdracht `sleep` kun je een gegeven aantal seconden wachten.
> Dit wordt vaak gebruikt binnen scripts om een vertraging toe te voegen.

~~~
$ sleep 360 &
[1] 31056
$ sleep 365 &
[2] 31452
$ sleep 370 &
[3] 31714
~~~

#### Job table

Bash houdt alle jobs binnen je Bash-sessie bij in een **job table**.  
Zoals eerder getoond, kun je hier de opdracht `jobs` voor gebruiken. Met de optie `-l` krijg je bij deze jobs het overeenkomende PID te zien:

~~~
$ jobs -l
[1]  31056 Running                 sleep 360 &
[2]- 31452 Running                 sleep 365 &
[3]+ 31714 Running                 sleep 370 &
~~~

Als we nu de job table bekijken, zien we dat er drie jobs draaien:

* job 1 met PID 31056 (sleep 360)
* job 1 met PID 31452 (sleep 365)
* job 1 met PID 31714 (sleep 370)

> Bemerk ook dat de laatst gestarte job voorafgegaan wordt door een + en de voorlaatste door een -.

De processen die gelinkt zijn aan deze job vind je terug via `ps`. Kijk naar de PID's:

~~~
$ ps -l
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
0 S  1173  2425  2424  0  80   0 -  2141 -      pts/16   00:00:00 bash
0 S  1173 31056  2425  0  80   0 -  1315 hrtime pts/16   00:00:00 sleep
0 S  1173 31452  2425  0  80   0 -  1315 hrtime pts/16   00:00:00 sleep
0 S  1173 31714  2425  0  80   0 -  1315 hrtime pts/16   00:00:00 sleep
0 R  1173 33096  2425  0  80   0 -  2637 -      pts/16   00:00:00 ps
~~~

#### Job naar de voorgrond brengen met `fg` 

Stel dat je één van de jobs terug naar de voorgrond wilt brengen, dan kan dat via de opdracht `fg`.

Hiervoor duid je de job die je naar de voorgrond wenst te brengen aan met een `%` gevolgd door het jobnummer (niet de PID):

~~~
$ jobs -l
[1]  31056 Running                 sleep 360 &
[2]- 31452 Running                 sleep 365 &
[3]+ 31714 Running                 sleep 370 &
$ fg %2
sleep 365
~~~

Job met nummer 2 wordt dan opnieuw naar de voorgrond gebracht. De prompt is nu opnieuw geblokkeerd, omdat Bash wacht tot deze job beëindigd wordt.

#### Naar de achtergrond brengen met `bg` 

Als je nu (vanuit deze shell) de job terug naar de achtergrond wilt brengen, druk je Ctrl+Z in. Dit zendt een stop-signaal naar het proces gelinkt aan deze job.

~~~
$ fg %2
sleep 365
^Z
[2]+  Stopped                 sleep 365
$
~~~

De prompt is weer beschikbaar, maar de job blijft nog in een stop-status:

~~~
$ jobs -l
[1]  31056 Running                 sleep 360 &
[2]+ 31452 Stopped                 sleep 365
[3]- 31714 Running                 sleep 370 &
~~~

Hetzelfde vind je terug in de procestabel. Zie het proces met PID 31452, dat de status T heeft:

~~~
$ ps -l
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
0 S  1173  2425  2424  0  80   0 -  2141 -      pts/16   00:00:00 bash
0 S  1173 31056  2425  0  80   0 -  1315 hrtime pts/16   00:00:00 sleep
0 T  1173 31452  2425  0  80   0 -  1315 -      pts/16   00:00:00 sleep
0 S  1173 31714  2425  0  80   0 -  1315 hrtime pts/16   00:00:00 sleep
0 R  1173 35174  2425  0  80   0 -  2637 -      pts/16   00:00:00 ps
~~~

Om het proces te hervatten, gebruik je de opdracht `bg` met `%` en dan het jobnummer.  
Dit plaatst de job weer in de toestand **Running**, waardoor het proces op de achtergrond draait:

~~~
$ bg %2
[2]+ sleep 365 &
$ jobs -l
[1]  31056 Running                 sleep 360 &
[2]- 31452 Running                 sleep 365 &
[3]+ 31714 Running                 sleep 370 &
~~~

#### Job beëindigen met `fg` en `Ctrl+C`

De eenvoudigste manier om een job te beëindigen, is het volgende tweestappenplan:

* de job naar de voorgrond brengen (via `fg`)
* deze job vervolgens te stoppen met Ctrl+C

~~~
$ fg %3
sleep 370
^C
$ 
~~~

Vervolgens zie je dat deze job gestopt is (en verwijderd uit de jobtabel):

~~~
$ jobs
[1]-  Running                 sleep 360 &
[2]+  Running                 sleep 365 &
$
~~~

#### Job beëindigen via `kill`

Je kunt een job ook beëindigen met de opdracht `kill`. Gegeven dat je onderstaande jobtabel overhebt...

~~~
$ jobs
[1]-  Running                 sleep 360 &
[2]+  Running                 sleep 365 &
$
~~~

...kun je een van deze jobs stoppen met behulp van de percentagenotatie (je hoeft dus niet de PID te gebruiken):

~~~
$ kill %1
~~~

Deze job zie je nadien nog in de jobtabel met de status **Terminated**:

~~~
$ jobs
[1]-  Terminated              sleep 360
[2]+  Running                 sleep 365 &
$
~~~

#### Done...

Als we de overblijvende job laten "uitdraaien" dan zal deze job uiteindelijk (na 365 seconden) de toestand **Done** hebben:

~~~
$ jobs
[2]+  Done                    sleep 365
$ jobs
$
~~~

Eenmaal je deze informatie opgevraagd hebt, verdwijnt de job uit de jobtabel...

### crontab

Cron is een toepassing waarmee je scripts en taken kunt automatiseren.

Door te werken met een **cron job** (of geplande taak) kun je achter de schermen opdrachten op terugkerende tijdstippen uitvoeren.  

Je kunt dit gebruiken om periodiek:

* bestanden op te kuisen
* back-ups te maken
* metingen te doen
* ...

Hoe werkt dit?

Elke gebruiker beschikt over een eigen crontab. Die gebruik je via de opdracht `crontab`. Dit programma kun je op de volgende manieren aanroepen:  

* `crontab -e` => crontab wijzigen (*edit*)
* `crontab -l` => crontab weergeven (*list*)
* `crontab -r` => crontab verwijderen (*remove*)

Binnen zo'n crontab kun je meerdere regels plaatsen. Elke regel staat dan voor een geplande taak.  
De regel start steeds met de definitie van het tijdstip.

De vorm van een regel lijkt op het eerste gezicht intimiderend, maar de opbouw is logisch.
Een crontab-regel bestaat uit zes velden, die telkens gescheiden worden door witruimte (één of meerder spaties of tabs):

~~~
+------------- minuten (0 - 59) 
¦ +-------------- uren (0 - 23)
¦ ¦ +--------------- dag van de maand (1 - 31)
¦ ¦ ¦ +---------------- maand (1 - 12)
¦ ¦ ¦ ¦ +----------------- weekdag (0 - 6) (0 is zondag, 1 is maandag, ..., 7 is eveneens zondag)
¦ ¦ ¦ ¦ ¦
¦ ¦ ¦ ¦ ¦
* * * * *     plaats hier je opdracht
~~~

Een correcte regel kan er dus als volgt uit zien:

~~~
05 18 * * 3     echo "hello $(date)" >> /home/student/test.txt
~~~

De bovenstaande regel zorgt ervoor dat éénmaal per week, namelijk op woensdag om 18.05, "hello" gevolgd door de datum en het tijdstip naar een bestand test.txt in de home-directory van de gebruiker student geschreven wordt.

Als je dit nu elke dag wilt, dan vervang je de `3` door een `*`:

~~~
05 18 * * *     echo "hello $(date)" >> /home/student/test.txt
~~~

Als je deze periodieke taak tijdelijk wilt uitschakelen, voeg dan een commentaarteken (`#`) aan het begin van de regel toe:

~~~
# 05 18 * * *     echo "hello $(date)" >> /home/student/test.txt
~~~

### Eerste keer gebruikmaken van cron

Als je voor het eerst cron gebruikt, moet je een editor kiezen. Maak hier de keuze voor `nano` (`vim` alleen als je daar kennis van hebt):

~~~
student@studentdeb:~$ crontab -l
no crontab for student
student@studentdeb:~$ crontab -e
no crontab for student - using an empty one

Select an editor.  To change later, run 'select-editor'.
  1. /bin/nano        <---- easiest
  2. /usr/bin/vim.tiny

Choose 1-2 [1]: 1
~~~

Vervolgens opent `nano` een standaard crontab met uitleg in commentaarregels:

~~~bash
# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command
~~~

Hieraan kun je nu regels toevoegen. Op de volgende manier voeg je bijvoorbeeld elke minuut een regel met het tijdstip toe aan het bestand `/home/student/test.txt`:

~~~
* * * * * echo "$(date)" >> /home/student/test.txt
~~~

Voeg deze regel toe, sla de crontab op en sluit de editor af. Daarna kun je de crontab bekijken met:

~~~bash
student@studentdeb:~$ crontab -l
# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command

* * * * * echo "$(date)" >> /home/student/test.txt
~~~

Een minuut later zou het bestand `/home/student/test.txt` aangemaakt moeten zijn (en stelselmatig groeien):

~~~
student@studentdeb:~$ ls -l /home/student/student.txt 
-rw-r--r-- 1 student student 32 Dec 22 16:30 /home/student/student.txt
student@studentdeb:~$ cat /home/student/student.txt 
Wed 22 Dec 2021 04:30:46 PM CET
student@studentdeb:~$ ls -l /home/student/student.txt 
-rw-r--r-- 1 student student 64 Dec 22 16:31 /home/student/student.txt
student@studentdeb:~$ student@studentdeb:~$ cat /home/student/student.txt 
Wed 22 Dec 2021 04:30:46 PM CET
Wed 22 Dec 2021 04:31:46 PM CET
student@studentdeb:~$ 
~~~

#### Andere opties

Zoals we eerder aangaven, zorgt het asterisk-teken (`*`) ervoor dat de specifieke
precisie (minuut - uur - dag - maand - weekdag) niet uitmaakt.

In het onderstaande voorbeeld zal cron ervoor zorgen dat het script wordt 
uitgevoerd om 18 uur en 5 minuten.  
De dag, maand of weekdag maakt hierbij niet uit:

~~~
# 05 18 * * *     echo "hello $(date)" >> /home/student/test.txt
~~~

Je kunt dit echter nog verfijnen met behulp van een aantal andere opties.

##### Lijst

Je kunt een lijst specificeren door cijfers aan te duiden gescheiden door komma's.  
Als je bijvoorbeeld alleen de eerste en de vijftiende van de maand het script wilt uitvoeren:

~~~
# 05 18 1,15 * *     echo "hello $(date)" >> /home/student/test.txt
~~~

Of je wilt het zowel op 12:05 als op 18:05 uitvoeren:

~~~
# 05 12,18 * * *     echo "hello $(date)" >> /home/student/test.txt
~~~

##### Bereik

Naast een lijst kun je ook een bereik instellen door een streepje te plaatsen
tussen 2 getallen.

Voer het script bijvoorbeeld elk uur uit tussen 9 en 17:

~~~
# 05 9-17 * * *     echo "hello $(date)" >> /home/student/test.txt
~~~

Let op: dit is tot en met, dus 17 is inbegrepen in dit bereik.

Je kunt op deze manier ook een script alleen tijdens weekdagen inplannen (1=maandag, 5=vrijdag):

~~~
# 05 18 * * 1-5     echo "hello $(date)" >> /home/student/test.txt
~~~

##### Stappen

Een complexere optie is het gebruik van stappen.  
Dit houdt in dat je een startwaarde geeft, gevolgd door een `/`, 
gevolgd door de stappen waarmee je wilt verhogen.

Stel dat je het script alleen op even dagen wilt uitvoeren, dan noteer je dat als volgt:

~~~
# 05 18 2/2 * *     echo "hello $(date)" >> /home/student/test.txt
~~~

##### Onofficiële toevoegingen

De reeks van vijf posities kan ook vervangen worden door één van de volgende waardes:

~~~
@yearly	
@annually
@monthly
@weekly
@daily
@hourly
@reboot
~~~

Je mag deze letterlijk vertalen, yearly is jaarlijks, monthly elke maand, ...  
Hou er echter rekening mee dat deze niet noodzakelijk in elke Linux-distributie worden ondersteund, dus het gebruik wordt afgeraden.

#### Extra info

Een handige website om je crontabs te testen is <https://crontab.guru>.

#### Alternatief: systemd-timers

Een belangrijke nieuwere implementatie is voorzien in systemd, deze worden in een verder hoofdstuk in deze cursus behandeld.
