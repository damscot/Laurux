-- Raz (RAZ-T01/T02) : deux articles sur trois marqués stockés.
UPDATE Fiches_Art SET art_stocke = 1 ORDER BY art_code LIMIT 2;
