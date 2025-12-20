select * from labzuord
limit 100;

-------------------------------------
select * from labzuord
where mtknr in (64705);

--pnr holen 
select pnr, * from lab
where mtknr in (64705)
order by pnr::text

-- ++++++++++++++++++++++++++++++++++++++++++
--1. Versuch: Nun testweise eine Leistungszuordnung erstellen, die ich vermisse für eine vorhandene Leistung
--!!! Fehler, das ist die Zuordnung auf sich selbst.
insert into labzuord (mtknr, labnr, artzuordnung, pordnrzu, labnrzu)
VALUES (64705, 3264741, 'F1',47331,3264741 );

--wenn das aber irgendwie nicht richtig passt, dann hängt sich der Hierarchieaufbau beim Öffnen der Leistungen eines Studen auf, mit einem StackOverflow auf im HISinOne.
delete from labzuord 
WHERE labnrzu in (3264741);

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--2. Versuch: (NICHT SO ERFOLGEICH) Neuer Versuch mit anders ermittelten pnrzuord, labnrzuord

--######################################################
--### Ermittle die Daten für den korrekten, neu zu erstellenden Datensatz in der Tabelle labzuord
--######################################################
-- mit 47331 als pnr -aus lab - den Datensatz aus pnrzuord holen (was aber einem Modul entspricht)
select pordnrzu, * from pnrzuord
where pordnr in (47331);

-- das sind mehrerer
-- pordnrzu aus den lab des Studenten filtern
-- nun bekommt man eine labnr, die dann die labnrzu wird. hier 3252785
select labnr, * from lab where mtknr in (64705)
and pordnr in (
                select pordnrzu from pnrzuord
                 where pordnr in (47331)
			  );

--und die gefundene "eindeutige!" labnr liefert dann eine pordnr, die dann zu pordnrzu wird. hier 47851
select pordnr, * from lab
where mtknr in (64705)
and labnr in (3252785)
Limit 100;


--korrekte pornrzu, labnrzu
insert into labzuord (mtknr, labnr, artzuordnung, pordnrzu, labnrzu)
VALUES (64705, 3264741, 'F1',47851, 3252785 );

--#############################################################################################################
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--3. Versuch: (ERFOLGREICH) Neuer Versuch, verwende aber als Ausgangspunkt einen 6stellige pnr (was einer Prüfung entspricht)
--Wähle also aus allen Leistungen des Studenten aus, wofür die Prüfung im Leistungsbaum fehlt ...
select pnr, pordnr,labnr, * from lab
where mtknr in (64705)
order by pnr::text
--Entscheidung fällt auf pnr=302311, labnr=3252779

--hole die pordnr für die ausgewählte pnr=302311
select pordnr, pnr, * from lab
where mtknr in (64705)
and pnr in (302311);
--Ergebnis ist pordnr=47313

--######################################################
--### Ermittle die Daten für den korrekten, neu zu erstellenden Datensatz in der Tabelle labzuord
--######################################################
-- mit 302471 als pnr -aus lab - den Datensatz aus pnrzuord holen (was einer Prüfung entspricht)
select pordnrzu, * from pnrzuord
where pordnr in (47313);
-- Datensatz hat eine pordnrzu=47313

-- das sind ggfs. mehrerer (hier aber nicht)...
-- pordnrzu aus den lab des Studenten filtern
select labnr, * from lab where mtknr in (64705)
and pordnr in (
                select pordnrzu from pnrzuord
                 where pordnr in (47313)
			  );
-- nun bekommt man eine labnr, die dann die labnrzu wird. hier labnrzu=3264719

--und die gefundene "eindeutige!" labnr liefert dann eine pordnr, die dann zu pordnrzu wird.
select pordnr, * from lab
where mtknr in (64705)
and labnr in (3264719)
--pordnrzu=47315

--########################################################
--### Insert mit dem der fehlenden labzurord-Datensatz erstellt wird
--########################################################
--korrekte pordnrzu, labnrzu verwenden!!! wichtig labnr aus der Auswahl der Leistungen auch anpassen!!!
insert into labzuord (mtknr, labnr, artzuordnung, pordnrzu, labnrzu)
VALUES (64705, 3252775, 'F1',47315, 3264719 );



--####################################################################################################
---repariere mal die falschen zuordnungsdatensätze in sospos, bzw. zum neuen durchführen vorbereiten
delete from labzuord
where labnr in (3264741)
and pordnrzu in (47315)

--++++++++++++
select  from labzuord
where labnr in (3252775)
and pordnrzu in (47315)

delete from labzuord
where labnr in (3252775)
and pordnrzu in (47315)


--+++++++++++++++++++++++++++++++++++++++++
--Passende Zuoordnungsart ggfs. korregieren.
--Laut Aussage soll das eine F1 Zuordnung sein.
--Aber damit POS nicht beeinträchtigt wird , sollten wir später eine nicht verwendete FX oder FZZZ Zuordnung nutzen.
update labzuord
SET artzuordnung ='F1'
WHERE labnrzu in (3264741);

-- +++++++++++++++++++++++++++++++++++++++
--SQL für die Migration der Leistungszuordnung 
SELECT labzuord.mtknr as mtknr, labzuord.labnr as labnr, labzuord.labnrzu as labnrzu, labzuord.bonus as bonus, labzuord.malus as malus
            , labzuord.artzuordnung as artzuordnung, labzuord.pordnrzu as pordnrzu, lab.psem AS semester, lab.ptermin, lab.prueck AS prueck
            	FROM lab, labzuord, identroll , pord, sos
				WHERE sos.mtknr = lab.mtknr
				AND lab.mtknr = identroll.verbindung_integer AND identroll.rolle = 'S' 
				AND pord.pordnr = lab.pordnr 
				AND lab.labnr = labzuord.labnr 
				AND lab.prueck < 2
            		--[sos_restriction]
            		--[lab_restriction] 
            		--[labzuord_restriction]
				AND lab.mtknr in (64705)
                ORDER BY lab.mtknr, lab.psem desc, lab.ptermin desc


