Importiere als Konfigurationspaket die Datenselektionsdefinition
Binde diese ein im Auftrag im ServiceCallModificationStep ServiceCall "Datenselektion (zeilenabhängig)" 

Im ODT stehen dann neue Platzhalter zur Verfügung, die auch im XMLDump zu finden sind. 
$$dataSelection.fruehStudiumBrd[0].jahrBrd
$$dataSelection.fruehStudiumBrd[0].semBrd
$$dataSelection.fruehStudiumBrd[0].EnSemBrd

