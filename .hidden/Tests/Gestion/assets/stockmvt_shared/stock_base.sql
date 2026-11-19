-- Stockmvt : mouvements de stock 2018 sur les articles 001 (famille 01) et 002 (famille 02), appliqué après Laurux01.sql.
-- BL en cours (types A/B/F), BL entretien, factures archivées et archivées entretien, réception fournisseur 401001,
-- mouvements exceptionnels, mouvement de produit composé, ticket archivé ; stock de départ et dteinv renseignés.
UPDATE Fiches_Art SET art_stkdep = '5', art_qte = '12', art_marque = 'M1', art_centrale = 'C1' WHERE art_code = '001';
UPDATE Fiches_Art SET art_stkdep = '3', art_qte = '7' WHERE art_code = '002';
UPDATE Fiches_Parametres SET dteinv = '2018-01-01';
INSERT INTO Fiches_Bl (numbl, cdclibl, datebl, type, totalht) VALUES
('B00001', '411003', '2018-03-05 00:00:00', 'B', 20), ('B00002', '411004', '2018-03-20 00:00:00', 'F', 70);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, qte_ligbl, netht_ligbl, typel_ligbl, fam_ligbl, dte_ligbl) VALUES
('B00001', '1', '001', 'Produit 2.10', '2', '20,00', 'A', '01', '2018-03-05 00:00:00'),
('B00002', '1', '002', 'Produit 7.00', '10', '70,00', 'A', '02', '2018-03-20 00:00:00'),
('B00002', '2', NULL, 'Commentaire', NULL, NULL, 'C', NULL, '2018-03-20 00:00:00');
INSERT INTO Fiches_BlM (numbl, cdclibl, datebl, type, totalht) VALUES ('N00001', '411003', '2018-04-05 00:00:00', 'B', 15);
INSERT INTO Fiches_LigblM (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, qte_ligbl, netht_ligbl, typel_ligbl, fam_ligbl, dte_ligbl) VALUES
('N00001', '1', '001', 'Produit 2.10', '1', '15,00', 'A', '01', '2018-04-05 00:00:00');
INSERT INTO Fiches_HistoFac (numfac, cdclifac, datefac) VALUES ('F00001', '411003', '2018-02-10 00:00:00'), ('F00002', '411004', '2018-05-15 00:00:00');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, qte_ligfac, netht_ligfac, typel_ligfac, fam_ligfac, dtligbl_ligfac) VALUES
('F00001', '1', '001', 'Produit 2.10', '3', '30,00', 'A', '01', '2018-02-10 00:00:00'),
('F00002', '1', '001', 'Produit 2.10', '1', '10,00', 'A', '01', '2018-05-15 00:00:00'),
('F00002', '2', '002', 'Produit 7.00', '2', '14,00', 'A', '02', '2018-05-15 00:00:00');
INSERT INTO Fiches_HistoFacM (numfac, cdclifac, datefac) VALUES ('M00001', '411003', '2018-06-05 00:00:00');
INSERT INTO Fiches_HistoLigfacM (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, qte_ligfac, netht_ligfac, typel_ligfac, fam_ligfac, dtligbl_ligfac) VALUES
('M00001', '1', '001', 'Produit 2.10', '1', '10,00', 'A', '01', '2018-06-05 00:00:00');
INSERT INTO Fiches_Entrecpt (four, numrecpt, ddate, montant, validee) VALUES ('401001', 'R00001', '2018-01-20 00:00:00', 100, 1);
INSERT INTO Fiches_Ligrecpt (code, design, numrecpt, four, daterecpt, qte, pbht, paht, prvt, nligne) VALUES
('001', 'Produit 2.10', 'R00001', '401001', '2018-01-20 00:00:00', 20, 5, 5, 10, 1),
('002', 'Produit 7.00', 'R00001', '401001', '2018-01-20 00:00:00', 10, 5, 5, 20, 2);
INSERT INTO Fiches_Mvtexp (code, daterecpt, qtep, qtem, com) VALUES ('001', '2018-07-01 00:00:00', 0, 1, 'Casse'), ('002', '2018-07-02 00:00:00', 2, 0, 'Retour');
INSERT INTO Fiches_Mvtexpdc (code, daterecpt, qtep, qtem, com, type) VALUES ('001', '2018-08-01 00:00:00', 0, 2, 'Composition', 'C');
INSERT INTO Fiches_HisEntTickets (caisse, numero, client, date) VALUES ('1', '900001', '411003', '2018-09-10 10:00:00');
INSERT INTO Fiches_HisLigTickets (numero, numlig, code, intitule, montant, qte, type, fam, mht) VALUES ('900001', '1', '001', 'Produit 2.10', 10, 1, 'A', '01', 10);
