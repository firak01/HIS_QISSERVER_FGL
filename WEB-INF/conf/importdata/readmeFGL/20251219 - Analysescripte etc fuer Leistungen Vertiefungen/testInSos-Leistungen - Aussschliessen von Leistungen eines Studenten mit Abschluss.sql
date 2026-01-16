--
-- aus dem Migrationsscrip
-- <param active="n" name="pord_restriction" value="AND pord.pnr IN (9999, 9910, 9920, 9990) " /> <!-- Migration Prüfungen -->

-- Merke 9999 ist kein Konto, nur erfolgreiche Absolventen haben dort einen Abschluss
select * from pord
where 1=1
AND pord.pnr IN (9999)
Limit 100;

-- und nun die Leistungen
select * from lab
where 1=1
and lab.pnr IN (9999)
LIMIT 100;




--################################################################################------
-- Ermittle die Matrikelnummern der Studis, die einen Abschluss haben
select distinct mtknr from lab
where 1=1
and lab.pnr in (9999)
order by mtknr
Limit 100;

-- Ermittle die Matrikelnummern der Studis, die keinen Abschluss haben
select distinct mtknr from lab
where 1=1
and lab.mtknr not in(
	select distinct mtknr from lab
	where lab.pnr in (9999)
)
order by mtknr
Limit 100;


--#######################################################################################
-- Leistungen für einen konkreten Studiengang, mit Abschlusse
select * from lab
where 1=1
and lab.pnr IN (9999)
and lab.abschl IN ('88')
and lab.stg IN ('039')
and lab.vert IN (' ')
and lab.pversion IN ('2023')
order by lab.mtknr desc
LIMIT 100;

-- Leistungen des Studiengangs von mtknr, ohne abschluss
select * from lab
where 1=1
--and lab.pnr IN (9999)
and lab.abschl IN ('88')
and lab.stg IN ('039')
and lab.vert IN (' ')
and lab.pversion IN ('2023')
and lab.mtknr not in(
	select distinct mtknr from lab
	where lab.pnr in (9999)
)
order by lab.mtknr desc
Limit 100

--######################################################################################
-- A) Bringe das zusammen --  Nur Leistungen von Studenten ohne Abschluss, d.h. Leistungen eine Studenten mit Abschluss nicht berücksichtigen
select * from lab
where 1=1
AND lab.abschl IN (
				select split_part(tubaf_po,'-',1) from ichZZZ.po_migration
where migriert = true and bereit=true
order by reihenfolge DESC
Limit 1
				) AND lab.stg IN (
				select split_part(tubaf_po,'-',2) from ichZZZ.po_migration
where migriert = true and bereit=true
order by reihenfolge DESC
Limit 1
                )AND lab.vert IN (
select split_part(tubaf_po,'-',3) from ichZZZ.po_migration
where migriert = true and bereit=true
order by reihenfolge DESC
Limit 1	
				) AND lab.pversion IN (
				select split_part(tubaf_po,'-',5)::smallint from ichZZZ.po_migration
where migriert = true and bereit=true
order by reihenfolge DESC
Limit 1
				)
--Schliesse nun die Studenten mit Abschlus aus				
and lab.mtknr not in(
	select distinct mtknr from lab
	where lab.pnr in (9999)
)
order by mtknr desc
Limit 100

--############################################################################################
-- B) Bringe das zusammen -- Nur Leistungen eine Studenten mit Abschluss
--                        -- Nur die Abschlussleistungen
select * from lab
where 1=1
AND lab.abschl IN (
				select split_part(tubaf_po,'-',1) from ichZZZ.po_migration
where migriert = true and bereit=true
order by reihenfolge DESC
Limit 1
				) AND lab.stg IN (
				select split_part(tubaf_po,'-',2) from ichZZZ.po_migration
where migriert = true and bereit=true
order by reihenfolge DESC
Limit 1
                )AND lab.vert IN (
select split_part(tubaf_po,'-',3) from ichZZZ.po_migration
where migriert = true and bereit=true
order by reihenfolge DESC
Limit 1	
				) AND lab.pversion IN (
				select split_part(tubaf_po,'-',5)::smallint from ichZZZ.po_migration
where migriert = true and bereit=true
order by reihenfolge DESC
Limit 1
				)
				
--Schliesse nun nur die Abschlussleistung ein				
and lab.pnr in (9999)	
Limit 100

---###################
--## Beispiel 
--## mtknr 67669 hat einen Abschluss 88-039---2023
select * from sos
where mtknr in (67669)
Limit 100


