-- Jeu de données DB_SANITY-T06 : un champ en trop (Fiches_Cpostaux.extra_col, indexé) et une table
-- entièrement en trop (Zz_Extra).
ALTER TABLE Fiches_Cpostaux ADD COLUMN extra_col int(11) DEFAULT NULL;
CREATE INDEX idx_extra ON Fiches_Cpostaux (extra_col);
CREATE TABLE Zz_Extra (a int(11) DEFAULT NULL) ENGINE=InnoDB;
