-- Jeu de données CSTOCK-T09 (validation d'inventaire de fin d'année, écran Validinv) : inventaire Fiches_Inv
-- (structure créée par Geninv) avec un article compté (I1 : 7) et un non compté (I2) ; un BL après la date
-- d'inventaire pour I1 (qu'un recalcul Cstock retrancherait) ; un inventaire tournant (vidé par Validinv).
UPDATE Fiches_Parametres SET dteinv = '2025-12-31';
INSERT INTO Fiches_Art (art_code, art_design, art_stocke, art_casier, art_qte, art_stkdep, art_txconv) VALUES
 ('I1', 'Inventorie compte', 1, 'A01', 10, 10, 1),
 ('I2', 'Inventorie non compte', 1, 'A02', 4, 4, 1);
CREATE TABLE Fiches_Inv (inv_nlig char(9) NOT NULL, inv_code Char(15), inv_qtestock Decimal(12,2),
 inv_qtecomptee Decimal(12,2), inv_date date, inv_comptee TINYINT, inv_valid Integer, inv_design VARCHAR(50),
 inv_casier Char(8), PRIMARY KEY (inv_nlig)) ENGINE = InnoDB;
INSERT INTO Fiches_Inv (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_design, inv_casier) VALUES
 ('1', 'I1', 10, 7, '2025-12-31', 1, 'Inventorie compte', 'A01'),
 ('2', 'I2', 4, NULL, '2025-12-31', 0, 'Inventorie non compte', 'A02');
INSERT INTO Fiches_Bl (numbl, type, cdclibl, datebl) VALUES ('900001', 'B', 'C1', '2026-01-10 10:00:00');
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, qte_ligbl, typel_ligbl, dte_ligbl) VALUES
 ('900001', '1', 'I1', '2', 'A', '2026-01-10 10:00:00');
INSERT INTO Fiches_HisInvT (inv_num, inv_code, inv_qtestock, inv_qtecomptee, inv_date) VALUES (1, 'I1', 9, 9, '2025-11-01');
