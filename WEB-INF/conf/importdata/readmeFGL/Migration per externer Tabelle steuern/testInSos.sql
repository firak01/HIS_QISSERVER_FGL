-----------------------
Select * from ich.po_migration
where bereit = true and migriert = true
order by reihenfolge ASC;

select * from ich.po_migration
where bereit = true and migriert = false
order by reihenfolge ASC;

select *, CASE migriert
			WHEN true THEN 1
			ELSE 0
		 END AS sortierer
from ich.po_migration
order by sortierer DESC, reihenfolge ASC;

-----------------------------------------------------
select * from tubaf.po_migration
where bereit = true and migriert = true
order by reihenfolge ASC;

select * from tubaf.po_migration
where bereit = true and migriert = false
order by reihenfolge ASC;

select *, CASE migriert
			WHEN true THEN 1
			ELSE 0
		 END AS sortierer
from tubaf.po_migration
order by sortierer DESC, reihenfolge ASC;


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
				select split_part(tubaf_po,'-',1) from ich.po_migration
				where migriert = true and bereit=true
				order by reihenfolge DESC
				Limit 1
				) 
	AND lab.stg IN (
				select split_part(tubaf_po,'-',2) from ich.po_migration
				where migriert = true and bereit=true
				order by reihenfolge DESC
				Limit 1
				) 
	AND lab.pversion IN (
				select split_part(tubaf_po,'-',5)::smallint from ich.po_migration
				where migriert = true and bereit=true
				order by reihenfolge DESC
				Limit 1
				) 
order by abschl, stg, pnr;

