SELECT DISTINCT  pord.stg, pord.vert, pord.abschl,
			pordnr, pnr, pform, pord.part AS part, pabschn, pdum, lehrsprache as petgp, labgewicht, freivers, pktxt AS ktxt, pltxt1 AS dtxt, pdtxt AS ltxt
			, pltxt2, pltxt3, pversion
			, pltxt4 AS comment, modulcode AS shortcomment, psws, zmadauer, pdauer, diplkz, pord.bendauer AS bendauer, 'D' AS sprache, pvken4, fb
			, bonus, malus, beleg, partngb, ppflicht, pfsem, pmaxver, pmaxvbe, phoesem, pabschn, labgewicht
			, hpnr, vpnr, sonstpnr1, sonstpnr2, sonstpnr3
			, k_part.prfgkz AS prfgkz
			, CASE lehrsprache
           			WHEN  'D' THEN 'de'
           			WHEN  'E' THEN 'en'
					WHEN  'F' THEN 'fr' 
			  END AS lehrspracheOriginalFGL
   			FROM pord
   			JOIN hskonst ON 1=1
  			LEFT OUTER JOIN k_part ON (pord.part = k_part.part)
  			WHERE 1=1
  			AND hskonst.aikz = 'A'
  			AND pordnr NOT IN (SELECT tabpk FROM hisinone_mapping WHERE tabelle='pord') 
  			AND pord.abschl IN (
				select split_part(tubaf_po,'-',1) from tubaf.po_migration
where migriert = false and bereit=true
order by reihenfolge ASC
Limit 1
				) AND pord.stg IN (
				select split_part(tubaf_po,'-',2) from tubaf.po_migration
where migriert = false and bereit=true
order by reihenfolge ASC
Limit 1
				)AND pord.vert IN (
				select case 
	when split_part(tubaf_po,'-',3)=''
    THEN ' '
	ELSE
	   	split_part(tubaf_po,'-',3)
	END 
				from tubaf.po_migration
where migriert = false and bereit=true
order by reihenfolge ASC
Limit 1	
				) AND pord.pversion IN (
				select split_part(tubaf_po,'-',5)::smallint from tubaf.po_migration
where migriert = false and bereit=true
order by reihenfolge ASC
Limit 1
				) 
   			ORDER BY pordnr


			   --------####
)AND pord.vert IN (
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

			   --#############
			   select case 
	when split_part(tubaf_po,'-',3)=''
        THEN ' '
	ELSE
	   	split_part(tubaf_po,'-',3)
	END 
				from tubaf.po_migration
where migriert = false and bereit=true
order by reihenfolge ASC
Limit 1	