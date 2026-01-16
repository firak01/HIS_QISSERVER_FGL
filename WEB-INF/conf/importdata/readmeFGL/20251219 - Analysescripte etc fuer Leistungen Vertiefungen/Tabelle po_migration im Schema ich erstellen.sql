-- Vorbereitend: Per PGAdmin das Schema ichzzz erstellen. Merke: Schemata können wohl nur kleingeschrieben werden.
-- Schritt 1: Eine Sequenz erstellen (hier im Schema 'ichzzz'). 
CREATE SEQUENCE ichzzz.po_migration_reihenfolge_seq;

--Schritt 2: benanntes unique constraint anwenden
CREATE TABLE ichzzz.po_migration (
    reihenfolge INT NOT NULL DEFAULT nextval('ichZZZ.po_migration_reihenfolge_seq'::regclass) UNIQUE,
	tubaf_po text NOT NULL,
    bereit boolean NOT NULL DEFAULT true,
   	migriert boolean NOT NULL DEFAULT false
);

-- Optional: Die Sequenz mit der Tabelle verknüpfen (empfohlen)
ALTER SEQUENCE ichzzz.po_migration_reihenfolge_seq OWNED BY ichzzz.po_migration.reihenfolge;

-------------------------------------------
-- ABARBEITUNGSREIHENFOLGE DER MIGRATIONEN
-------------------------------------------
--Sortierung für PO-Migration, die erledigten nach vorne
--Der oberste mit dem Sortierer = 0 wird genommen.
select *, CASE migriert
			WHEN true THEN 1
			ELSE 0
		 END AS sortierer
from ichzzz.po_migration
order by sortierer ASC, reihenfolge ASC;

--Sortierung für Studi- und Leistungsmigration, die erledigten nach vorne
--Der oberste mit dem sortierer = 1 wird genommen.
select *, CASE migriert
			WHEN true THEN 1
			ELSE 0
		 END AS sortierer
from ichzzz.po_migration
order by sortierer DESC, reihenfolge DESC;

----------------------------------
--- MIGRIERT STATUS ÄNDERN, alle wieder zurueck ab der Reihenfolge
update ichzzz.po_migration
SET migriert = false
WHERE reihenfolge >= 2;

update ichzzz.po_migration
SET migriert = false
WHERE reihenfolge = 2;

--- REIHENFOLGE GGFS. ÄNDERN, durch Dreickstauschtausch möglich wenn man keine Lücken in der Reihenfolge haben will.
update ichzzz.po_migration
SET reihenfolge = 2
WHERE reihenfolge = 97;

--- TABELLE FÜLLEN
INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '88-039---2022'
);

INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '88-039---2023'
);

INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '88-039-ING--2023'
);

INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '88-039-MIN--2023'
);

INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '88-039-HG--2023'
);

INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '88-039-LSL--2023'
);

INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '88-039-SP--2023'
);

INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '88-039-TS--2023'
);


INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '11-104---2020'
);

INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '11-104-ANL--2020'
);

INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '11-104-MAS--2020'
);

INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '11-104-MET--2020'
);


----------------------
INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '88-AB8---2024'
);

INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '82-AB8---2024'
);

-----------------
INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '82-C11---2018'
);

INSERT INTO ichzzz.po_migration (
    tubaf_po
) VALUES (
    '88-C11---2018'
);

