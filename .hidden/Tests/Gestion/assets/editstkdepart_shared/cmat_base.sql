-- Jeu EditStkDepart : colonnes et tables de l'option boisson (structure de modfichier.fichierboisson, absentes de
-- Laurux01.sql) ; régies A1 (alcool pur, seuil 18°, TVA 2) et B1 (volume, TVA 1) ; articles 001/002 en A1, 003 en B1 ;
-- tables d'inventaire minimales Fiches_Inv / Fiches_InvT (une ligne chacune).
CREATE TABLE Fiches_regie (code char(2), nom varchar(30), tauxa decimal(9,4), degres integer, tauxss decimal(9,4), type char(1), suspendu boolean, ap boolean, drfac boolean, cdcompt integer, ttva char(2), PRIMARY KEY (code));
INSERT INTO Fiches_regie VALUES ('A1', 'Spiritueux', 1700.0000, 18, 50.0000, 'A', 0, 1, 0, 0, '2'), ('B1', 'Bières', 4.0000, NULL, 0.0000, 'B', 0, 0, 0, 0, '1');
ALTER TABLE Fiches_Parametres ADD tvass char(2);
UPDATE Fiches_Parametres SET tvass = '2';
ALTER TABLE Fiches_Art ADD art_dra char(2), ADD art_volm decimal(7,2) DEFAULT 0.00, ADD art_deg decimal(5,2) DEFAULT 0.00;
UPDATE Fiches_Art SET art_dra = 'A1', art_volm = 70, art_deg = 40, art_qte = 10, art_stkdep = 5 WHERE art_code = '001';
UPDATE Fiches_Art SET art_dra = 'A1', art_volm = 75, art_deg = 12, art_qte = 6, art_stkdep = 2 WHERE art_code = '002';
UPDATE Fiches_Art SET art_dra = 'B1', art_volm = 33, art_deg = 5, art_qte = 24, art_stkdep = 12 WHERE art_code = '003';
CREATE TABLE Fiches_Inv (inv_code char(15), inv_qtecomptee double);
INSERT INTO Fiches_Inv VALUES ('001', 8), ('003', 20);
CREATE TABLE Fiches_InvT (inv_code char(15), inv_qtecomptee double);
INSERT INTO Fiches_InvT VALUES ('002', 3);
