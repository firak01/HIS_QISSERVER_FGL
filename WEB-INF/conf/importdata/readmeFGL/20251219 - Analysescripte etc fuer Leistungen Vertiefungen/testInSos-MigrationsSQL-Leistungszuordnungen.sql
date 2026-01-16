  SELECT labzuord.mtknr as mtknr, labzuord.labnr as labnr, labzuord.labnrzu as labnrzu, labzuord.bonus as bonus, labzuord.malus as malus
            , labzuord.artzuordnung as artzuordnung, labzuord.pordnrzu as pordnrzu, lab.psem AS semester, lab.ptermin, lab.prueck AS prueck
            	FROM lab, labzuord, identroll , pord, sos
				WHERE sos.mtknr = lab.mtknr
				AND lab.mtknr = identroll.verbindung_integer AND identroll.rolle = 'S' 
				AND pord.pordnr = lab.pordnr 
				AND lab.labnr = labzuord.labnr 
				AND lab.prueck < 2
            	---	[sos_restriction]
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


				
            	--	[lab_restriction] 
AND lab.abschl IN (
				select split_part(tubaf_po,'-',1) 
from ichZZZ.po_migration
where migriert = true and bereit=true
order by reihenfolge DESC
Limit 1
				) AND lab.stg IN (
				select split_part(tubaf_po,'-',2) 
from ichZZZ.po_migration
where migriert = true and bereit=true
order by reihenfolge DESC
Limit 1
                )AND lab.vert IN (select case 
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
				select split_part(tubaf_po,'-',5)::smallint 
from ichZZZ.po_migration
where migriert = true and bereit=true
order by reihenfolge DESC
Limit 1
				) 								
and lab.mtknr not in(
	select distinct mtknr from lab
	where lab.pnr in (9999)
)

				
            	--	[labzuord_restriction]
 AND (labzuord.artzuordnung like 'F%' OR labzuord.artzuordnung IN ('wp', 'Q')) 

				------------------
                ORDER BY lab.mtknr, lab.psem desc, lab.ptermin desc