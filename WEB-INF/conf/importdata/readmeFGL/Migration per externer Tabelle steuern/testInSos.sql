-----------------------
--Sortierung für PO-Migration, die erledigten nach vorne
--Der oberste mit dem Sortierer = 0 wird genommen.
select *, CASE migriert
			WHEN true THEN 1
			ELSE 0
		 END AS sortierer
from ich.po_migration
order by sortierer ASC, reihenfolge ASC;

--Sortierung für Studi- und Leistungsmigration, die erledigten nach vorne
--Der oberste mit dem sortierer = 1 wird genommen.
select *, CASE migriert
			WHEN true THEN 1
			ELSE 0
		 END AS sortierer
from ich.po_migration
order by sortierer DESC, reihenfolge DESC;


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
	AND lab.stg IN (
				select split_part(tubaf_po,'-',3) from ich.po_migration
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

--########################################
------------------- auf der Jagd nach der Vertiefung, alle Vertiefungen die es gibt... in den Leistungen.
select * from lab 
where vert!=''
Limit 100;

select distinct vert from lab 
where vert!=''
Limit 100;

--Auswahl aller Vertiefungen uns Studierenden der zuletzt migrierten PO
--Merke: Vertiefungsauswahl über split_part ist rausgenommen, ggfs. hart coded Vertiefung suchen...
select distinct vert from lab
						where lab.abschl IN (				
							select split_part(tubaf_po,'-',1) from ichzzz.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						) AND lab.stg IN (
							select split_part(tubaf_po,'-',2) from ichzzz.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1	
						) AND lab.pversion IN (
							select split_part(tubaf_po,'-',5)::smallint from ichzzz.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						)
						AND vert!=''
						
	
	ORDER BY vert ASC


-- Auswahl der Auswahl der Studenten mit der Vertiefungen der zuletzt migrierten PO
--Merke: Vertiefungsauswahl über split_part ist rausgenommen...
select distinct mtknr from lab
						where lab.abschl IN (				
							select split_part(tubaf_po,'-',1) from ichzzz.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						) AND lab.stg IN (
							select split_part(tubaf_po,'-',2) from ichzzz.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1	
						) AND lab.vert IN (
							select split_part(tubaf_po,'-',3) from ichzzz.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1	
						) AND lab.pversion IN (
							select split_part(tubaf_po,'-',5)::smallint from ichzzz.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1	
						) 
	ORDER BY mtknr ASC



--#########################################
--Auswahl der aktuell bei der Migration betrachteten Vertiefung
select * from pord
WHERE vert IN ('ING')
LIMIT 100;

select split_part(tubaf_po,'-',3) from ichzzz.po_migration
where migriert = false and bereit=true
order by reihenfolge ASC
Limit 1;

select case 
	when split_part(tubaf_po,'-',3)=''
        THEN '-'
	ELSE
	   	split_part(tubaf_po,'-',3)
	END 
		from ichzzz.po_migration
where migriert = false and bereit=true
order by reihenfolge ASC
Limit 1

--

--###############################


--------------------------------
select * from lab where labnr in (3285208);
select vert, * from lab where mtknr in (54239);

	select mtknr,labnr,* from lab
						where lab.abschl IN (				
							select split_part(tubaf_po,'-',1) from ich.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						) AND lab.stg IN (
							select split_part(tubaf_po,'-',2) from ich.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1	
						)AND lab.vert IN (
							select split_part(tubaf_po,'-',3) from ich.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1	
						) AND lab.pversion IN (
							select split_part(tubaf_po,'-',5)::smallint from ich.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						)
	ORDER BY mtknr ASC


--------------------------------------------------------
--STUDENTEN DER PO
SELECT ident.identnr AS identnr, ident.vorname AS firstname, ident.name as surname				
					, CASE ident.geschl
						WHEN 'O'
							THEN 'U'						 
						ELSE
							ident.geschl
					  END AS gender
					, ident.anti as title_academicdegree, ident.antizudtxt as nameprefix
					, gebdat AS birthdate, gebort AS birthcity, gebname AS birthname, gebland AS birthcountry, k_akfz3.astat AS birthcountry_astat
					, sos.titel_nachgestellt AS namesuffix
					, sos.staat AS nationality_country_plate, k_akfz.astat AS nationality, sos.zweitstaat AS nationality2_country_plate, k_akfz2.astat AS nationality2
					, dokvorname AS allfirstnames, ord_kuenstname AS artistname
					, identroll.rolle AS rolle
					, identroll.verbindung_integer AS mtknr
					, identroll.verbindung_integer AS doctoral_registrationnumber
					, k_hrst.his_hrst AS his_hrst
					, sos.status AS status
					, wahlfb, immdat, hmkfzkz, hmkfz, anschri.anschrkz AS s_anschrift,  semkfzkz, semkfz  
					, sos.immdat AS valid_from
					, sos.hssem AS hssem, sos.urlsem AS urlsem, sos.praxsem AS praxsem, sos.kolsem AS kolsem, sos.semester AS semester
					, sos.hssemgewicht AS hssemgewicht, sos.urlsemgewicht AS urlsemgewicht
					, sos.bafnr AS bafnr, sos.bvanr AS bvanr, sos.bafamt AS bafamt, k_bland.astat AS bafland_astat
					, CASE sos.sperrart1
						WHEN '1' THEN 'BE'
						WHEN '14' THEN 'BE'
						WHEN '21' THEN 'WV'
						WHEN '7'  THEN 'WV'
						WHEN '3'  THEN 'FP'
						WHEN '6' THEN 'TZ'
						WHEN '8' then 'ZV'
						WHEN '10' THEN 'GA'						
						WHEN '11' THEN 'ZU'
						WHEN '12' then 'DS'
						WHEN '15' then 'SG'
						WHEN '18' then 'VB'
						WHEN '22' then 'FS'
						WHEN '23' then 'MO'
						ELSE 
							sos.sperrart1
						END as sperrart1
					, sos.sperrsem1 AS sperrsem1
					, CASE sos.sperrart2
							WHEN '1' THEN 'BE'
						WHEN '14' THEN 'BE'
						WHEN '21' THEN 'WV'
						WHEN '7'  THEN 'WV'
						WHEN '3'  THEN 'FP'
						WHEN '6' THEN 'TZ'
						WHEN '8' then 'ZV'
						WHEN '10' THEN 'GA'						
						WHEN '11' THEN 'ZU'
						WHEN '12' then 'DS'
						WHEN '15' then 'SG'
						WHEN '18' then 'VB'
						WHEN '22' then 'FS'
						WHEN '23' then 'MO'
						ELSE 
							sos.sperrart2
						END as sperrart2
					, sos.sperrsem2 AS sperrsem2
					, sos.berufab AS berufab, sos.prakt1 AS prakt1
					, sos.bibnr AS bibnr
					, sos.datlnacherfassung AS datlnacherfassung
	
				FROM sos 
	     		INNER JOIN identroll ON (sos.mtknr = identroll.verbindung_integer)
	            INNER  JOIN ident ON (ident.identnr = identroll.identnr)
	            LEFT OUTER JOIN k_hrst ON (sos.hrst = k_hrst.hrst)
	            LEFT OUTER JOIN k_akfz ON (sos.staat = k_akfz.akfz) 
	            LEFT OUTER JOIN k_akfz AS k_akfz2 ON (sos.zweitstaat = k_akfz2.akfz)
	            LEFT OUTER JOIN k_akfz AS k_akfz3 ON (sos.gebland = k_akfz3.akfz)
	            LEFT OUTER JOIN k_bland ON (sos.bafland = k_bland.bland)
	            LEFT OUTER JOIN anschri AS anschri ON (sos.mtknr = anschri.mtknr AND anschri.anschrkz = 'S')
	            WHERE ident.name IS NOT NULL AND TRIM(ident.name) != ''
	           AND identroll.verbindung_integer IN (
					   	select mtknr from lab
						where lab.abschl IN (				
							select split_part(tubaf_po,'-',1) from ich.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						) AND lab.stg IN (
							select split_part(tubaf_po,'-',2) from ich.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						)AND lab.vert IN (
							select split_part(tubaf_po,'-',3) from ich.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1							
						) AND lab.pversion IN (
							select split_part(tubaf_po,'-',5)::smallint from ich.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						)
					)
	            ORDER BY identnr;


--#############################################
select * from lab
LIMIT 100;

select * from pnrzuord
where vert= ' ' --is not null
LIMIT 100;

select * from lab
where pnr in (35702)
and mtknr in (64769)
Limit 100;

select * from pord 
where pordnr in(47343)
Limit 100;


select * from hisinone_mapping;

-- Die Zuordnung
SELECT DISTINCT
					CASE
						WHEN pnrzuord.pordnr != hisinone_mapping.kopf
							THEN hisinone_mapping.kopf
						ELSE 
							pnrzuord.pordnr
					END AS pordnr,
					pnrzuord.pordnrzu as pordnrzu, pnrzuord.bonus as bonus, pnrzuord.malus as malus, 'AZ' as artzuord
					, lfdnr, freivsem, pnrzuord.ppflicht as ppflicht, pord.pnr as pnr
					FROM pord, pnrzuord
					LEFT OUTER JOIN hisinone_mapping ON (pnrzuord.pordnr = hisinone_mapping.tabpk  AND hisinone_mapping.tabelle = 'pord')
					WHERE pord.pordnr = pnrzuord.pordnr 
					AND artzuord NOT IN ('KOH', 'BFV', 'akv', 'grp', 'aq')						
						--[pord_restriction]
				UNION
				SELECT 	
					pnrzuord.pordnr,
					pnrzuord.pordnrzu as pordnrzu, pnrzuord.bonus as bonus, pnrzuord.malus as malus, 'AZ' as artzuord
					, lfdnr, freivsem, pnrzuord.ppflicht as ppflicht, child_pord.pnr as pnr
					FROM pord
					JOIN pnrzuord ON (pord.pordnr = pnrzuord.pordnrzu) 
					JOIN pord AS child_pord ON (child_pord.pordnr = pnrzuord.pordnr)
						WHERE 1 = 1
						AND artzuord NOT IN ('KOH', 'BFV', 'akv', 'grp', 'aq')
						--[artzuord_restriction] 
						--[pord_restriction]
						AND lab.abschl IN (				
							select split_part(tubaf_po,'-',1) from ich.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						) AND lab.stg IN (
							select split_part(tubaf_po,'-',2) from ich.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						)AND lab.vert IN (
							select split_part(tubaf_po,'-',3) from ich.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1							
						) AND lab.pversion IN (
							select split_part(tubaf_po,'-',5)::smallint from ich.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						)--
				 ORDER BY 1

				 ----
---suche alle Leistungen eines Studenten, hier mit der prüfungsnummer
SELECT DISTINCT
				identroll.identnr AS identnr, lab.labnr AS labnr, lab.mtknr AS mtknr, lab.pnr AS pnr, lab.porgnr AS porgnr, lab.pversuch AS pversuch
				, lab.prueck AS prueck, lab.pnote AS pnote, lab.pdatum AS pdatum, lab.pform AS pform, lab.psem AS semester, lab.ptermin AS ptermin
				, identroll2.identnr AS identnr_ppruef1, identroll3.identnr AS identnr_ppruef2
				, identroll4.identnr AS identnr_betreu1, identroll5.identnr AS identnr_betreu2, identroll6.identnr AS identnr_pgut
				, lab.psws AS psws, lab.praum AS praum, lab.pbeginn AS pbeginn, lab.ppunkte AS ppunkte, lab.bonus AS bonus, lab.malus AS malus
				, lab.freiverm AS freiverm , lab.beleg AS beleg, lab.panerk AS panerk, lab.pvermerk AS pvermerk, lab.aendkz AS aendkz, dipl.labnr
				, dipl.antrdat, dipl.beabeg, dipl.abdat, dipl.tabdat, dipl.verldat, dipl.thema, dipl.betreu1, dipl.betreu2, dipl.vermint
				, dipl.diabltxt, dipl.diablnr, dipl.pnote1 AS pnote1, dipl.pnote2 AS pnote2, dipl.pnotegut AS pnotegut
				, hskonst.hpnr AS hpnr, hskonst.vpnr AS vpnr, hskonst.sonstpnr1 AS sonstpnr1, hskonst.sonstpnr2 AS sonstpnr2, hskonst.sonstpnr3 AS sonstpnr3
				, pord.pvken4 AS pvken4, pord.lehrsprache AS petgp, pord.partngb AS partngb
                ,  CASE lab.pstatus
                    WHEN 'AN' THEN 'ZU'
                    ELSE lab.pstatus
                  END AS pstatus,
                  CASE
                  	WHEN lab.pordnr!= hisinone_mapping.kopf
                  		THEN  hisinone_mapping.kopf
                  	ELSE lab.pordnr
                  END AS pordnr
	            FROM lab 
	            INNER JOIN hskonst ON (hskonst.aikz = 'A')
	            INNER JOIN pord ON (pord.pordnr = lab.pordnr)
	            INNER JOIN identroll ON (lab.mtknr = identroll.verbindung_integer AND identroll.rolle IN ('S', '4'))
	            INNER JOIN sos ON (lab.mtknr = sos.mtknr)
	            LEFT OUTER JOIN identroll AS identroll2 ON (identroll2.verbindung_char = lab.ppruef1 AND identroll2.rolle = 'P')
	            LEFT OUTER JOIN identroll AS identroll3 ON (identroll3.verbindung_char = lab.ppruef2 AND identroll3.rolle = 'P')
	            LEFT OUTER JOIN dipl ON (lab.labnr = dipl.labnr) 
	            LEFT OUTER JOIN identroll AS identroll4 ON (identroll4.verbindung_char = dipl.betreu1 AND identroll4.rolle = 'P')
	            LEFT OUTER JOIN identroll AS identroll5 ON (identroll5.verbindung_char = dipl.betreu2 AND identroll5.rolle = 'P')
	            LEFT OUTER JOIN identroll AS identroll6 ON (identroll6.verbindung_char = dipl.pgut AND identroll6.rolle = 'P')
	            LEFT OUTER JOIN hisinone_mapping ON (hisinone_mapping.tabpk=lab.pordnr AND hisinone_mapping.tabelle='pord')
	            WHERE lab.psem != 0 AND lab.psem IS NOT NULL  
	            AND lab.prueck < 2
	           AND lab.mtknr in (64769) 
			   AND lab.pnr in (357041)
	            ORDER BY lab.mtknr, lab.labnr