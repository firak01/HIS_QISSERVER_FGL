			SELECT DISTINCT pordnr, pnr, pktxt, abschl, stg, pversion, vert, 
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
				--[pord_restriction]
				AND pord.vert in (
						SELECT split_part(tubaf_po,'-',3) 
						from tubaf.po_migration 
						where migriert = false and bereit=true
						order by reihenfolge ASC
						Limit 1
				)
				--AND pord.vert IN(
		--		select case 
	--when split_part(tubaf_po,'-',3)=''
   --     THEN '-'
	--ELSE
	--   	split_part(tubaf_po,'-',3)
--	END 
--from tubaf.po_migration
--where migriert = false and bereit=true
--order by reihenfolge ASC
-- 1
--				)
				ORDER BY abschl, stg, vert, schwp, kzfa, pversion