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
	            AND identroll.rolle IN ('S') 
-----[sos_restriction]
AND (sos.exmdat IS null or sos.exmdat >= DATE '2019-10-01')  
         	AND identroll.verbindung_integer IN (
					   	select mtknr from lab
						where lab.abschl IN (				
							select split_part(tubaf_po,'-',1) from ichZZZ.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						) AND lab.stg IN (
							select split_part(tubaf_po,'-',2) from ichZZZ.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						--)AND lab.vert IN (' '
						)AND lab.vert IN (
							select case 
									when split_part(tubaf_po,'-',3)=''
        							THEN ''
									ELSE
	   								split_part(tubaf_po,'-',3)
									END  
							from ichZZZ.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1							
						) AND lab.pversion IN (
							select split_part(tubaf_po,'-',5)::smallint from ichZZZ.po_migration
							where migriert = true and bereit=true
							order by reihenfolge DESC
							Limit 1
						)
			 )
---------------------------					   
	            ORDER BY identnr