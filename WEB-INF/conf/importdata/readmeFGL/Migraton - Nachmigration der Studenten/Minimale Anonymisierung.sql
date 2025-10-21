-- ALLGEMEIN:
--
set search_path ='hisinone';

-- ## Alle E-Mails Adressen auf eine andere umstellen ##
-- alle E-Mail-Adressen auf eigene Adresse umbiegen
UPDATE address SET eaddress = 'unbekannter.benutzer@mailinator.com' WHERE addresstype = 'EMail';
 
-- prüfen, ob noch Mails falsch eingegeben wurden
SELECT eaddress FROM address WHERE eaddress LIKE '%@%' AND addresstype <> 'EMail';
-- und ggf. auch anpassen
UPDATE address SET eaddress = 'unbekannter.benutzer@mailinator.com' WHERE eaddress LIKE '%@%' AND addresstype <> 'EMail';
 
 
-- ## Alle Passwörter auf ein eigenes Klartextpasswort setzen ##
--UPDATE hisinone.account SET passwordhash = 'xxx';
