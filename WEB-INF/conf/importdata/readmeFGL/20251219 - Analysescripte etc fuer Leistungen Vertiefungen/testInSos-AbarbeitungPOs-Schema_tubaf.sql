-----------------------
--Sortierung für PO-Migration, die erledigten nach vorne
--Der oberste, unerledigte mit dem Sortierer = 0 wird genommen.
select *, CASE migriert
			WHEN true THEN 1
			ELSE 0
		 END AS sortierer
from tubaf.po_migration
order by sortierer ASC, reihenfolge ASC;

--Sortierung für Studi- und Leistungsmigration, die erledigten nach vorne
--Der oberste, erledigte mit dem sortierer = 1 wird genommen.
select *, CASE migriert
			WHEN true THEN 1
			ELSE 0
		 END AS sortierer
from tubaf.po_migration
order by sortierer DESC, reihenfolge DESC;


--------------------------------------------------------
--------------------------------------------------------
--- MIGRIERT STATUS ÄNDERN, alle wieder zurueck ab der Reihenfolge
update tubaf.po_migration
SET migriert = false
WHERE reihenfolge >= 1;

--- REIHENFOLGE GGFS. ÄNDERN, durch Dreickstauschtausch möglich wenn man keine Lücken in der Reihenfolge haben will.
update tubaf.po_migration
SET reihenfolge = 14
WHERE reihenfolge =98 ;

--------------------------------------------------------------
---------------------------------------------------------------

--------------------------------------------------------
--------------------------------------------------------
select *
from lab
INNER JOIN dipls on (lab.labnr = dipls.labnr)
INNER JOIN sos ON (lab.mtknr = sos.mtknr)
INNER JOIN identroll ON (lab.mtknr = identroll.verbindung_integer AND identroll.rolle = 'S')
WHERE 1=1
--order by pversion DESC, abschl, stg, pnr;
--das erst einmal nicht, obige gefundene PO migrieren, dann sehen wir weiter.
	AND lab.abschl IN (
				select split_part(tubaf_po,'-',1) from tubaf.po_migration
				where migriert = true and bereit=true
				order by reihenfolge DESC
				Limit 1
				) 
	AND lab.stg IN (
				select split_part(tubaf_po,'-',2) from tubaf.po_migration
				where migriert = true and bereit=true
				order by reihenfolge DESC
				Limit 1
				) 
	AND lab.pversion IN (
				select split_part(tubaf_po,'-',5)::smallint from tubaf.po_migration
				where migriert = true and bereit=true
				order by reihenfolge DESC
				Limit 1
				) 
order by abschl, stg, pnr;

------------------- auf der Jagd nach der Vertiefung
select * from pord
WHERE vert IN ('ING')
LIMIT 100;

select split_part(tubaf_po,'-',3) from tubaf.po_migration
where migriert = false and bereit=true
order by reihenfolge ASC
Limit 1	

select case 
	when split_part(tubaf_po,'-',3)=''
        THEN '-'
	ELSE
	   	split_part(tubaf_po,'-',3)
	END 
		from tubaf.po_migration
where migriert = false and bereit=true
order by reihenfolge ASC
Limit 1

--------------------------------
select * from lab where labnr in (3285208);
select vert, * from lab where mtknr in (54239);

	select mtknr,labnr,* from lab
						where lab.abschl IN (				
							select split_part(tubaf_po,'-',1) from tubaf.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						) AND lab.stg IN (
							select split_part(tubaf_po,'-',2) from tubaf.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1	
						)AND lab.vert IN (
							select split_part(tubaf_po,'-',3) from tubaf.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1	
						) AND lab.pversion IN (
							select split_part(tubaf_po,'-',5)::smallint from tubaf.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						)
	ORDER BY mtknr ASC
