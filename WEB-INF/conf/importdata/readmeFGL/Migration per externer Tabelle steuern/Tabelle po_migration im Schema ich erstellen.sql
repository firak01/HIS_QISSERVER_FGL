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


----------------------------------
--- TABELLE FÜLLEN
INSERT INTO ich.po_migration (
    tubaf_po
) VALUES (
    '88-AB8---2024'
);

