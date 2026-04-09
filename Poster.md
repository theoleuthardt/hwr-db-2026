# Poster Projekt in SQL

## Aufgabe

P_KUNDEN = { [ Anzahl: int, Betrag: real, KName: string ] }
P_PREISE = { [ Anzahl: int, EPreis: real ] }

von  1 = 0.4 - Element 1 im Array
     10 = 0.3 - Element 2 im Array 
     50 = 0.2 - Element 3 im Array
     100 = 0.1 - Element 4 im Array

Ein Package.

1. Prozedur - öffentlich, Init, keine Parameter, keine Rückgabe.
Daten aus der Tabelle P_PREISE in ein Array übernehmen.
Dieses Array muss privat sein.

2. Funktion - öffentlich, FindEPreis,
ein Parameter ist Anzahl der Exemplare,
Rückgabewert ist der entsprechende Einzelpreis.
Die Einzelpreise werden im Array gesucht.
Beim falschen Parameter ist der Einzelpreis 0!
   
## Strukturierung

Strukturierung ist eine Methode, die für die Darstellung der Algorithmen verwendet wird, mit dem Ziel, den Algorithmus und das daraus resultierende Programm leicht zu erstellen, zu ändern und zu verstehen. Ergebnis ist relativ geringere Fehleranfälligkeit, bessere Wartbarkeit und höhere Qualität der Software-Produkte.

Diese Web-Seite als PDF-Datei herunterladen
Prinzipien

Prinzipien der Strukturierung stellen folgende Anforderungen an den Aufbau der Algorithmen und Programme:

    Ein Algorithmus (bzw. ein Programm, eine Funktion) setzt sich linear aus Blöcken zusammen. Die Blöcke werden in ihrer natürlichen Reihenfolge ausgeführt.
    Eine Anweisung (Zuweisung, Steuerungskonstruktion, Ein- und Ausgabe, Funktionsaufruf) ist ein Block.
    Ein Block hat genau einen Eingang und genau einen Ausgang.
    Es gibt keine direkten Übergänge zwischen den Blöcken (keine jump-, break-, exit-, loop-, continue- oder goto-Anweisungen). Zur Ablaufsteuerung werden nur folgende Steuerungskonstruktionen eingesetzt: Folge, Auswahl und Schleife. Die Schleifen werden nur durch Bedingungen im Kopf- oder Fußbereich verlassen. Die Prozeduren und Funktionen werden nur einmal am Ende durch return verlassen.
    "Use break and continue only with caution. Use of break eliminates the possibility of treating a loop as a black box. Limiting yourself to only one statement to control a loop's exit condition is a powerful way to simplify your loops. Using break forces the person reading your code to look inside the loop for an understanding of the loop control. This makes the loop more difficult to understand."
    Steve McConnell: Code Complete, pp 337-338.
    Blöcke können verschachtelt werden. Die Verschachtelung der Blöcke wird beim Programmieren durch deren Verschiebung nach rechts gekennzeichnet.

Strukturierung steht über der Programmierung, da die Strukturierung unabhängig von der Programmiersprache formuliert wird. Programmiersprache kann die Strukturierung unterstützen, oder auch nicht.

Strukturierung stellt keine Anforderungen an die Programmvorbereitung (Kompilieren, Interpretieren, VM), folglich hat sie mit Compiler oder Interpreter nichts zu tun. Strukturierung stellt keine Anforderungen an die Datentypen. Datenstrukturierung spielt selbstverständlich eine wichtige Rolle bei der Programmierung.

Die Struktogramme (Nassi-Shneiderman-Diagramme) unterstützen strukturierte Darstellung der Algorithmen. Die Struktogramme bilden die Ideen ab. Sie können in jeder Programmiersprache umgesetzt werden.
Vorteile

Strukturierung beim Programmieren ist entscheidend für die Entwicklung robuster, verständlicher und wartungsfreundlicher Software.

    Verbesserte Lesbarkeit:
    Eine gut strukturierte Codebasis macht es einfacher für andere (oder für sich selbst in der Zukunft), den Code zu lesen und zu verstehen. Dies reduziert die Zeit, die zum Einarbeiten in den Code erforderlich ist, und verringert das Risiko von Missverständnissen.
    Erleichterte Wartung:
    Strukturierter Code ist modular organisiert, was es einfacher macht, Fehler zu erkennen und zu beheben. Änderungen oder Updates können ohne unbeabsichtigte Nebeneffekte durchgeführt werden.
    Wiederverwendbarkeit:
    Gut strukturierter Code befindet sich in Modulen, Paketen oder Funktionen, die leicht in anderen Projekten wiederverwendet werden können. Dies spart Entwicklungszeit und fördert Best Practices.
    Bessere Fehlersuche:
    Durch eine klare Struktur kann man leichter eine logische Fehlerverfolgung durchführen und den Ursprung eines Problems finden. Das Debugging wird dadurch vereinfacht.
    Förderung von Teamarbeit:
    In Teams ist es wichtig, dass alle Mitglieder den Code verstehen und sich an vereinbarte Standards halten. Strukturierte Programmierung stellt sicher, dass alle auf dem gleichen Stand sind und effektiv zusammenarbeiten können.
    Erleichtertes Hinzufügen neuer Funktionen:
    Wenn der Code gut strukturiert ist, ist es einfacher, neue Features hinzuzufügen, da der Entwickler genau weiß, wo Anpassungen erforderlich sind, ohne das gesamte System zu beeinträchtigen.
    Effiziente Dokumentation:
    Strukturierter Code erleichtert die Dokumentation, da der Programmfluss klar und logisch durchdacht ist. Dies hilft nicht nur dem ursprünglichen Entwickler, sondern auch neuen Entwicklern, die am Projekt arbeiten.
    Unterstützung bei der Einhaltung von Standards:
    Strukturen ermutigen zur Einhaltung von Programmierstandards und -richtlinien, die Qualität und Konsistenz fördern und somit eine höhere Codequalität sicherstellen.
    Skalierbarkeit:
    Ein gut strukturierter Ansatz berücksichtigt zukünftige Erweiterungen und Wachstum. Dies macht es einfacher, das System zu skalieren, ohne das grundlegende Design zu überarbeiten.
    Reduktion von Duplikationen:
    Strukturierter Code fördert die Nutzung von Funktionen und Modulen zur Reduzierung von Redundanzen, was zu weniger Fehleranfälligkeit und einfacherem Management führt.

Insgesamt führt eine gute Struktur beim Programmieren zu effizienteren Entwicklungsprozessen, höherer Qualität des Codes und größerer Zufriedenheit aller Beteiligten, vom Entwickler bis zum Endnutzer.
Beispiele

Regel: Alles, was zu einem verschachtelten Block gehört, wird um gleichen Abstand nach rechts verschoben.

void main(void)
{
int i, j, k;
printf ("\nZahl eingeben ==> ");
scanf ("%d", &k );

    for (j=1, i=2; i<k; i++)
    {
        j *= i;
    }

    printf("\nFakultät von %d ist %d\n", k, j);
}

void main(void)
{
unsigned int Alter;
printf("\nAlter eingeben: ");
scanf("%u", &Alter);
if (Alter < 18)
{
printf("\nSie sind noch minderjährig");
}
else
{
if (Alter > 18)
{
printf("\nSie sind schon volljährig und können wählen");
}
else
{
printf("\nSie können grade schon wählen");
}
}
printf("\n");
}

//  Die Seiten eines Dreiecks eingeben
func Eingabe () (s Seiten) {
var (
nochmal bool = true
kriterium1 bool = false
kriterium2 bool = false
)
for nochmal {  // <-- Die Schleife wird nur hier verlassen, Eingang == Ausgang
fmt.Print("1. Seite --> "); fmt.Scan(&s.A);
fmt.Print("2. Seite --> "); fmt.Scan(&s.B);
fmt.Print("3. Seite --> "); fmt.Scan(&s.C);
kriterium1 = ( (s.A > 0) && (s.B > 0) && (s.C > 0) )
kriterium2 = ( (s.A + s.B > s.C) && (s.B + s.C > s.A) && (s.C + s.A > s.B) )
if kriterium1 {
if kriterium2 {
nochmal = false // <-- NO continue, NO break, NO exit, NO return !
} else {
fmt.Println("Fehler - Es existiert kein Dreieck")
}
} else {
fmt.Println("Fehler - Die Seiten muessen positiv sein")
}
}
return s
}
//  Yes, the autor knows that kriterium2 ==> kriterium1
//  This is only an example :-)
//  Man ist sicher:
//  wenn man for-Schleife verlassen hat,
//  dann nur weil die Bedingung nicht mehr wahr ist.

//  Verschachtelte if-Anweisung

if ($meinLohn == 1000)                         if ($meinLohn == 1000)
{                                              {
$ausgabe = "A";                                $ausgabe = "A";
}                                              }
elseif ($meinLohn == 2000)                     elseif ($meinLohn == 2000)
{                                                  {
$ausgabe = "B";                                    $ausgabe = "B";
}                                                  }
elseif ($meinLohn == 3000)                         elseif ($meinLohn == 3000)
{                                                      {
$ausgabe = "C";                                        $ausgabe = "C";
}                                                      }
elseif ($meinLohn == 4000)                             elseif ($meinLohn == 4000)
{                                                          {
$ausgabe = "D";                                            $ausgabe = "D";
}                                                          }
else                                                       else
{                                                          {
$ausgabe = "E";                                            $ausgabe = "E";
}                                                          }
echo $ausgabe;                                 echo $ausgabe;

Prof. Dr. A. Zimmermann
E-Mail: arthur.zimmermann@hwr-berlin.de
Web-Seite: azdom.de/go.htm
