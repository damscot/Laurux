-- Jeu de données DB_SANITY-T05 : clé primaire et AUTO_INCREMENT absents sur Fiches_Cpostaux, avec doublons
-- et 0 dans la colonne PRI_AI (lind) ; index secondaire idx_tag de Docs_Tag réduit à une colonne.
ALTER TABLE Fiches_Cpostaux MODIFY lind int(11) NOT NULL;
ALTER TABLE Fiches_Cpostaux DROP PRIMARY KEY;
INSERT INTO Fiches_Cpostaux (lind, cp, burdist) VALUES (0, '35000', 'RENNES'), (0, '44000', 'NANTES'),
 (5, '69001', 'LYON'), (5, '29200', 'BREST'), (7, '75001', 'PARIS 01');
ALTER TABLE Docs_Tag DROP INDEX idx_tag;
CREATE INDEX idx_tag ON Docs_Tag (doc_lind);
