--################################################################
-- SQL aus hisinone-examrelation.hisinone_addmissing_examrelation
SELECT identroll.identnr AS identnr, lab.mtknr AS mtknr
	            FROM lab 
	            INNER JOIN pord ON (pord.pordnr = lab.pordnr)
	            INNER JOIN identroll ON (lab.mtknr = identroll.verbindung_integer AND identroll.rolle = 'S') 
	            INNER JOIN sos ON (lab.mtknr = sos.mtknr)
	            WHERE 1=1
	            --[sos_restriction][lab_restriction] 
				AND lab.mtknr in (64769)
	            GROUP BY lab.mtknr, identroll.identnr
	            ORDER BY lab.mtknr