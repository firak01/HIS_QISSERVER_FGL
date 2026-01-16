select * from lab
limit 100;

--------------------------------
--- gib die leistungen sortiert aus
SELECT * from lab
where lab.mtknr in (64705)
order by pnr::text
limit 100;

-------------------------------
select * from lab
where lab.labnr in (3038043)

-----------------------------------------------------
-- mit lab.pnr mit ::text in Text umwandeln, wg. der Sortierung
SELECT DISTINCT lab.pnr::text AS pnr,
				identroll.identnr AS identnr, lab.labnr AS labnr, lab.mtknr AS mtknr, lab.porgnr AS porgnr, lab.pversuch AS pversuch
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
	            AND lab.mtknr in (64705)
				AND lab.pnr in (302471)
				--and lab.labnr in (3038043)
	            ORDER BY pnr, lab.labnr
			    --ORDER BY lab.labnr, pnr

select * from lab where labnr in (3264741);