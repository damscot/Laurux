-- Jeu de données DB_SANITY-T02 à T04 : structure dégradée par rapport à db_control.csv.
-- Fiches_Cpostaux : moteur MyISAM (A01), AUTO_INCREMENT absent, NULL et défaut modifiés sur cp, type et
-- collation modifiés sur burdist, champ en trop ; Fiches_Statut : champ manquant ; Docs_Tag : table
-- manquante ; Fiches_Art : index idx_fam manquant ; Zz_Extra : table en trop.
ALTER TABLE Fiches_Cpostaux ENGINE=MyISAM;
ALTER TABLE Fiches_Cpostaux MODIFY lind int(11) NOT NULL;
ALTER TABLE Fiches_Cpostaux MODIFY cp char(5) NOT NULL DEFAULT '00000';
ALTER TABLE Fiches_Cpostaux MODIFY burdist char(40) COLLATE utf8mb4_bin DEFAULT NULL;
ALTER TABLE Fiches_Cpostaux ADD COLUMN extra_col int(11) DEFAULT NULL;
ALTER TABLE Fiches_Statut DROP COLUMN libelle;
DROP TABLE Docs_Tag;
ALTER TABLE Fiches_Art DROP INDEX idx_fam;
CREATE TABLE Zz_Extra (a int(11) DEFAULT NULL) ENGINE=InnoDB;
