-- Schritt 1: Eine Sequenz erstellen (hier im Schema 'ich')
CREATE SEQUENCE ich.po_migration_reihenfolge_seq

--Schritt 2: benanntes unique constraint anwenden
CREATE TABLE ich.po_migration (
    reihenfolge INT NOT NULL DEFAULT nextval('ich.po_migration_reihenfolge_seq'::regclass) UNIQUE,
	tubaf_po text NOT NULL,
    bereit boolean NOT NULL DEFAULT true,
   	migriert boolean NOT NULL DEFAULT false
);

-- Optional: Die Sequenz mit der Tabelle verknüpfen (empfohlen)
ALTER SEQUENCE ich.po_migration_reihenfolge_seq OWNED BY ich.po_migration.reihenfolge;

--------------------------------
-- ABARBEITUNGSREIHENFOLGE
--------------------------------
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

----------------------------------
--- MIGRIERT STATUS ÄNDERN, alle wieder zurueck ab der Reihenfolge
update ich.po_migration
SET migriert = false
WHERE reihenfolge >= 4;

--- REIHENFOLGE GGFS. ÄNDERN, durch Dreickstauschtausch möglich wenn man keine Lücken in der Reihenfolge haben will.
update ich.po_migration
SET reihenfolge = 99
WHERE reihenfolge = 4;

--- TABELLE FÜLLEN
INSERT INTO ich.po_migration (
    tubaf_po
) VALUES (
    '88-AB8---2024'
);


INSERT INTO ich.po_migration (
    tubaf_po
) VALUES (
    '88-039---2022'
);

INSERT INTO ich.po_migration (
    tubaf_po
) VALUES (
    '88-039---2023'
);

INSERT INTO ich.po_migration (
    tubaf_po
) VALUES (
    '88-039-ING--2023'
);

INSERT INTO ich.po_migration (
    tubaf_po
) VALUES (
    '11-104---2020'
);



