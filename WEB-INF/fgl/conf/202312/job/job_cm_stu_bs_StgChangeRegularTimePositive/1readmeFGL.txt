FGL 20250312:
Beispiele für die Arbeit mit Begründeten Antragstypen.
Hier der Positivfall, also die Genehmigung.

Neben dem Abfragen der Anträge über den ServiceCallModificationStep, gilt für die Ermittlung weiterer möglicherweise abglehnter Anträge:
In der ODT Datei
- Es wird aus der Menge aller Anträge nach dem begründeteten Antragstyp "Regelstudienzeitänderung" gefragt.
  Das passiert mit einer Java StringUtils.contains Abfrage.
  
 - Dann wird auch noch der Antragsstatus herausgefiltert. Hier die "Stornierten" mit "S".
 
 
