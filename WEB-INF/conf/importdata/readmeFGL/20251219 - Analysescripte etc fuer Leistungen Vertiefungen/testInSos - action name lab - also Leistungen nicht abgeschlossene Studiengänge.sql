--Leistungen der Studenten -Migrationsaction
--nicht abgeschlossene Studiengänge
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
	            
--[sos_restriction]
AND (sos.exmdat IS null or sos.exmdat >= DATE '2019-10-01')  
         	AND identroll.verbindung_integer IN (
					   	select mtknr from lab
						where lab.abschl IN (				
							select split_part(tubaf_po,'-',1) from ichzzz.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1)
						AND lab.stg IN (
							select split_part(tubaf_po,'-',2) from ichzzz.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1)
						AND lab.vert IN (
							select case 
								when split_part(tubaf_po,'-',3)=''							
								THEN ''
									ELSE
	   								split_part(tubaf_po,'-',3)
									END  
							from ichzzz.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1) 
						AND lab.pversion IN (
							select split_part(tubaf_po,'-',5)::smallint from ichzzz.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1)
			 )	           

--[lab_restriction]
AND lab.abschl IN (
				select split_part(tubaf_po,'-',1) 
				from ichzzz.po_migration
				where migriert = true and bereit=true
				order by reihenfolge DESC
				Limit 1) 
			AND lab.stg IN (
				select split_part(tubaf_po,'-',2) 
				from ichzzz.po_migration
				where migriert = true and bereit=true
				order by reihenfolge DESC
				Limit 1)
			AND lab.vert IN (
         		     select case 
         		     when split_part(tubaf_po,'-',3)=''         		     
						THEN ''
							ELSE
  								split_part(tubaf_po,'-',3)
							END  
					from ichzzz.po_migration
					where migriert = true and bereit=true
					order by reihenfolge DESC
					Limit 1)
			AND lab.pversion IN (
				select split_part(tubaf_po,'-',5)::smallint 
				from ichzzz.po_migration
				where migriert = true and bereit=true
				order by reihenfolge DESC
				Limit 1) 	
--[unfinishedStgZZZ_lab_restriction]
and lab.mtknr not in(
				select distinct mtknr from lab
				where lab.pnr in (9999) 
				AND lab.abschl IN (
					select split_part(tubaf_po,'-',1) 
					from ichZZZ.po_migration
					where migriert = true and bereit=true
					order by reihenfolge DESC
					Limit 1) 
				AND lab.stg IN (
					select split_part(tubaf_po,'-',2) 
					from ichZZZ.po_migration
					where migriert = true and bereit=true
					order by reihenfolge DESC
					Limit 1)
		)

--
 ORDER BY lab.mtknr, lab.labnr
