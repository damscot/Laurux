-- Jeu de données VERIFDATE-T02/T03/T05/T09 : option boissons (B/T). Tables de régie créées comme
-- Gestion/option/modfichier.module (absentes de Laurux01.sql), colonne Fiches_Parametres.arrete
-- (LauruxMaj, option bois) et Fiches_Art.art_dra. Droit « DS » suspendu, « DA » acquitté ; dernier
-- mouvement I/M : 15/03/2024 (suspendu), 20/02/2024 (acquitté) ; un mouvement « V » ultérieur ignoré.
CREATE TABLE Fiches_regie (code char(2), nom varchar(30), tauxa decimal(9,4), degres integer,
  tauxss decimal(9,4), type char(1), suspendu boolean, ap boolean, drfac boolean, cdcompt integer,
  ttva char(2), PRIMARY KEY (code)) ENGINE = InnoDB;
CREATE TABLE Fiches_ligregie (dtmouv date, num char(15), numlig char(12), type char(1), codeart char(15),
  coderegie char(2), qte decimal(8,3), volume decimal(7,2), degres decimal(5,2), volumeap decimal(6,2),
  montdr decimal(8,2), txtvadr char(5), montss decimal(7,2), txtvass char(5), vignette char(25),
  cloture boolean, code int NOT NULL AUTO_INCREMENT, PRIMARY KEY (code)) ENGINE = InnoDB;
ALTER TABLE Fiches_Parametres ADD arrete char(7);
ALTER TABLE Fiches_Art ADD art_dra char(2);
UPDATE Fiches_Parametres SET arrete = '12.2023';
INSERT INTO Fiches_regie (code, nom, suspendu) VALUES ('DS', 'Droit suspendu', 1), ('DA', 'Droit acquitte', 0);
INSERT INTO Fiches_ligregie (dtmouv, num, numlig, type, codeart, coderegie, qte) VALUES
  ('2024-01-10', 'M1', '1', 'I', '001', 'DS', 1),
  ('2024-03-15', 'M2', '1', 'M', '001', 'DS', 1),
  ('2024-06-01', 'F1', '1', 'V', '001', 'DS', 1),
  ('2024-02-20', 'M3', '1', 'M', '002', 'DA', 1),
  ('2024-01-05', 'M4', '1', 'I', '002', 'DA', 1);
UPDATE Fiches_Art SET art_dra = 'DS' WHERE art_code = '001';
UPDATE Fiches_Art SET art_dra = 'DA' WHERE art_code = '002';
