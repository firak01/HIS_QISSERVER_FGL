--Merke: Nur in Ausnahmefällen hat die PO selbst eine Vertiefung.
--       Wenn die PO Keine Vertriefung hat, wird bei angegebenener Vertiefung das Aufhängerelement auch nicht erstellt.
--       Die PO Elemente müssen dann woanders angehängt worden sein.
DISTINCT pordnr, pnr, pktxt, abschl, stg, pversion,
				case  vert
					when  ' ' then '-'
					when null then '-'
					else vert
				end AS vert, 
				case  schwp
					when  ' ' then '-'
					when null then '-'
					else schwp
				end AS schwp,
				case  kzfa
					when  ' ' then '-'
					when null then '-'
					else kzfa
				end AS kzfa
				, fb
				FROM pord 
				WHERE pversion NOT IN (- 1)
				AND abschl IS NOT NULL AND NOT TRIM(abschl) = '' 
				AND stg IS NOT NULL AND NOT TRIM(stg) = '' 
				AND (pord.pnr IN (Select hpnr from hskonst WHERE aikz = 'A') 
				OR pord.pnr IN (Select vpnr from hskonst WHERE aikz = 'A') 
				OR pord.pnr IN (Select sonstpnr1 from hskonst WHERE aikz = 'A') 
				OR pord.pnr IN (Select sonstpnr2 from hskonst WHERE aikz = 'A') 
				OR pord.pnr IN (Select sonstpnr3 from hskonst WHERE aikz = 'A'))

				AND pord.abschl IN (
				select split_part(tubaf_po,'-',1) from ichzzz.po_migration
where migriert = false and bereit=true
order by reihenfolge ASC
Limit 1)
				AND pord.stg IN (
				select split_part(tubaf_po,'-',2) from ichzzz.po_migration
where migriert = false and bereit=true
order by reihenfolge ASC
Limit 1)
				AND pord.pversion IN (
				select split_part(tubaf_po,'-',5)::smallint from ichzzz.po_migration
where migriert = false and bereit=true
order by reihenfolge ASC
Limit 1)


				AND pord.vert IN(
							select case 
							when split_part(tubaf_po,'-',3)=''							
								THEN ''
									ELSE
	   								split_part(tubaf_po,'-',3)
									END  
							from ichzzz.po_migration
							where migriert = false and bereit=true
							order by reihenfolge ASC
							Limit 1	)

