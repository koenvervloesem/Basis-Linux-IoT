## Een tekstbestand aanmaken of openen

Je hebt niet op elk Linux-systeem een grafische omgeving tot je beschikking waarin je een grafisch teksteditor opent om tekstbestanden aan te passen. Op de opdrachtregel kun je de editor `nano` gebruiken:

~~~
nano /tmp/nano_test
~~~

Bestaat dit bestand nog niet, dan wordt het door `nano` aangemaakt.  
Bestaat het wel, dan leest `nano` de huidige inhoud in en kan je die wijzigen.

### Werken met de interface van `nano`

Na het openen van een tekstbestand staat aan de bovenzijde links de versie van `nano`, in het midden de locatie van het geopende bestand, en rechts de term "Modified" indien het bestand door de gebruiker is aangepast.

Daaronder vind je de inhoud van het tekstbestand. Helemaal onderaan vind je een aantal sneltoetsen voor veel gebruikte acties, zoals het opslaan van en zoeken in het bestand, en het afsluiten van het programma.

~~~
^G Get Help	^O WriteOut	^R Read File	^Y Prev Page	^K Cut Text	^C Cur Pos
^X Exit	^J Justify	^W Where Is	^V Next Page	^U UnCut Text	^T To Spell
~~~

Het teken `^` (caret, of dakje) staat voor de Ctrl-toets op het toetsenbord.  
Deze sneltoetsen zijn ook via een F-toets (F1 t/m F12) bovenaan het toetsenbord aan te roepen (in de volgorde F1 voor ^G, F2 voor ^X, F3 voor ^O, enzovoorts).  

Hieronder vind je een vertaling van de snelkoppelingen:

~~~
^G Helpinformatie	^O Opslaan	^R Bestand invoegen	^Y Vorige pagina	^K Knip tekst	^C Huidige positie
^X Afsluiten	^J Uitlijnen	^W Zoeken	^V Volgende pagina	^U Plak tekst	^T Spellinghulp
~~~

In plaats van de Ctrl-toets kun je ook tweemaal op de Esc-toets drukken.  
Enkele andere sneltoetsen, die in de helpinformatie (^G) uitgebreid worden beschreven, kunnen met de Meta-, Esc- of Alt-toets aangeroepen worden. Zo staat M-} (regel inspringen) bijvoorbeeld voor de combinatie Alt/Esc/Meta+}.

Verder kun je vrijuit typen en de pijltjestoetsen gebruiken om door het bestand te navigeren. Tussentijds opslaan doe je aan de hand van de WriteOut-sneltoets (^O). Zodra je het bestand afsluit met ^X, zul je gevraagd worden of je niet opgeslagen wijzigingen wilt opslaan of negeren.


### Voorbeeld

In deze cursus bekijken we gewoon de basis van `nano`.
Voor een volledige uitleg kun je terecht op <https://www.nano-editor.org/docs.php>.

Je opent een bestand door de opdracht `nano` te typen gevolgd door de bestandsnaam als argument:  

~~~
student@studentdeb:~$ nano nano_test
~~~

Als dit bestand reeds bestaat, dan zal `nano` het bestaande bestand openen.  
In het geval van een niet bestaand bestand opent `nano` een leeg bestand.

~~~
  GNU nano 5.4                                               nano_test *                                                      










^G Help        ^O Write Out   ^W Where Is    ^K Cut         ^T Execute     ^C Location    M-U Undo       M-A Set Mark
^X Exit        ^R Read File   ^\ Replace     ^U Paste       ^J Justify     ^_ Go To Line  M-E Redo       M-6 Copy

~~~

Onderaan het bestand zie je diverse sneltoetsen voor opdrachten.
Je kunt nu gewoon tekst typen, net als in een grafische teksteditor.

~~~
  GNU nano 5.4                                               nano_test *                                                      
Hello World nano
Dit is een nano test








^G Help        ^O Write Out   ^W Where Is    ^K Cut         ^T Execute     ^C Location    M-U Undo       M-A Set Mark
^X Exit        ^R Read File   ^\ Replace     ^U Paste       ^J Justify     ^_ Go To Line  M-E Redo       M-6 Copy
~~~

Als je de inhoud wilt opslaan, druk je op Ctrl+O.  
Onderaan vraagt de editor (File Name to Write) om de bestandsnaam te bevestigen. 
Als je het bestand onder een andere naam wilt opslaan, vul dan een andere naam in voor je bevestigt.

~~~
  GNU nano 5.4                                               nano_test *                                                      
Hello World nano
Dit is een nano test



File Name to Write: nano_test   
^G Help        ^O Write Out   ^W Where Is    ^K Cut         ^T Execute     ^C Location    M-U Undo       M-A Set Mark
^X Exit        ^R Read File   ^\ Replace     ^U Paste       ^J Justify     ^_ Go To Line  M-E Redo       M-6 Copy
~~~

Daarna kun je verder de tekst aanvullen.


~~~
  GNU nano 5.4                                               nano_test *                                                      
Hello World nano
Dit is een nano test
Nog wat tekst



^G Help        ^O Write Out   ^W Where Is    ^K Cut         ^T Execute     ^C Location    M-U Undo       M-A Set Mark
^X Exit        ^R Read File   ^\ Replace     ^U Paste       ^J Justify     ^_ Go To Line  M-E Redo       M-6 Copy
~~~

Afsluiten doe je met Ctrl+X.  

Aangezien je nog een regel hebt toegevoegd, vraagt de editor je of je de wijzigingen 
wilt opslaan.  
Bevestig met Y.

~~~
  GNU nano 5.4                                               nano_test *                                                      
Hello World nano
Dit is een nano test
Nog wat tekst



Save modified buffer? Y

 Y Yes
 N No           ^C Cancel
~~~

Daarna krijg je weer zoals eerder de vraag om het bestand op te slaan 
(eventueel onder een andere naam).

~~~
  GNU nano 5.4                                               nano_test *                                                      
Hello World nano
Dit is een nano test



File Name to Write: nano_test   
^G Help        ^O Write Out   ^W Where Is    ^K Cut         ^T Execute     ^C Location    M-U Undo       M-A Set Mark
^X Exit        ^R Read File   ^\ Replace     ^U Paste       ^J Justify     ^_ Go To Line  M-E Redo       M-6 Copy
~~~
