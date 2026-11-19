-- PREPARATION-T08 : jeu Gestion/bordrx_shared/lcr_chaine (copie) + LCR 4 (banque 1) en code entrée 1.
-- Jeu chaîne LCR (Attribution, Preparation, Lcr, Bordrx) : 4 banques (adresses N/O/C, fins d'enregistrement
-- vide/Ws/$0D0A$, une banque avec mail), 4 clients avec RIB et adresses, 12 LCR (non attribuées, écartées,
-- attribuées banque 1/2, en bordereau 1 à 5 ; montants au format virgule produit par EcrAuto), 5 bordereaux (4 non envoyés, 1 envoyé), 2 traites à importer.
INSERT INTO Fiches_Banques (banques_code, banques_nom, banques_dmln, banques_nume, banques_codeb, banques_codeg, banques_numcpt, banques_numsiren, banques_adr, banques_fenrg, banques_mail, banques_ref, banques_reftireur) VALUES
(1, 'BANQUE ALPHA', 'AGENCE CENTRE', '123456', '30001', '00123', '12345678901', '12345', 'N', NULL, NULL, 'R1', 'TIR1'),
(2, 'CREDIT BETA', 'AGENCE NORD', '654321', '30002', '00456', '10987654321', '54321', 'O', 'Ws', NULL, 'R2', 'TIR2'),
(3, 'BANQUE GAMMA', 'AGENCE SUD', '111222', '30003', '00789', '11122233344', '11122', 'C', '$0D0A$', NULL, 'R3', 'TIR3'),
(4, 'BANQUE DELTA', 'AGENCE EST', '333444', '30004', '00999', '55566677788', '33344', 'N', NULL, 'remise@banque.test', 'R4', 'TIR4');
INSERT INTO Fiches_Cli (cli_code, cli_nom, cli_adr1, cli_adr2, cli_cd_ptl, cli_ville, cli_cd_bq, cli_cd_gch, cli_dmln, cli_num_cpt, cli_ref_tir) VALUES
(1001, 'CLIENT UN', '1 RUE DES LILAS', 'BATIMENT A', '75001', 'PARIS', '10001', '20001', 'BANQUE UN', '00000000011', 'RT1001'),
(1002, 'CLIENT DEUX SARL', '22 AVENUE DU PORT', '', '13002', 'MARSEILLE', '10002', '20002', 'BANQUE DEUX', '00000000022', 'RT1002'),
(1003, 'CLIENT TROIS', '3 PLACE CENTRALE', 'ZONE ARTISANALE', '69003', 'LYON', '10003', '20003', 'BANQUE TROIS', '00000000033', 'RT1003'),
(1004, 'CLIENT QUATRE', '4 CHEMIN VERT', '', '33004', 'BORDEAUX', '10004', '20004', 'BANQUE QUATRE', '00000000044', 'RT1004');
INSERT INTO Fiches_Lcr (lind, code, nom, montant, date, datech, numfac, acceptee, ecartee, banque, codeentree, bordereau) VALUES
(1, '1001', 'CLIENT UN', '100,00', '2018-05-02', '2018-06-30', 'F0001', 0, 0, '0', 0, '0'),
(2, '1002', 'CLIENT DEUX SARL', '250,50', '2018-05-10', '2018-07-10', 'F0002', 0, 1, '0', 0, '0'),
(3, '1003', 'CLIENT TROIS', '75,25', '2018-05-15', '2018-07-15', 'F0003', 1, 0, '0', 0, '0'),
(4, '1001', 'CLIENT UN', '120,00', '2018-05-20', '2018-07-20', 'F0004', 0, 0, '1', 0, '0'),
(5, '1002', 'CLIENT DEUX SARL', '42,00', '2018-06-01', '2018-08-31', 'F0005', 0, 0, '2', 1, '0'),
(6, '1003', 'CLIENT TROIS', '310,10', '2018-06-05', '2018-08-15', 'F0006', 0, 1, '1', 0, '0'),
(7, '1001', 'CLIENT UN', '12,50', '2018-04-02', '2018-06-30', 'F0007', 1, 0, '1', 0, '1'),
(8, '1003', 'CLIENT TROIS', '100,00', '2018-04-05', '2018-07-05', 'F0008', 0, 0, '1', 0, '1'),
(9, '1002', 'CLIENT DEUX SARL', '200,00', '2018-04-10', '2018-07-10', 'F0009', 1, 0, '2', 1, '2'),
(10, '1004', 'CLIENT QUATRE', '55,55', '2018-04-12', '2018-07-12', 'F0010', 0, 0, '3', 5, '3'),
(11, '1001', 'CLIENT UN', '66,00', '2018-04-15', '2018-07-15', 'F0011', 0, 0, '4', 0, '4'),
(12, '1004', 'CLIENT QUATRE', '80,00', '2018-03-15', '2018-05-15', 'F0012', 0, 0, '1', 0, '5');
INSERT INTO Fiches_Bordereaux (lind, banque, codeentree, dateremise, refremise, datevaleur, ech1, ech2, bordereau, tot, etat) VALUES
(1, 1, 0, '2018-06-14', 'REMISE01', '2018-06-20', NULL, NULL, 1, 112.50, 0),
(2, 2, 1, '2018-06-14', 'REMISE02', '2018-06-21', NULL, NULL, 2, 200.00, 0),
(3, 3, 5, '2018-06-14', 'REMISE03', '2018-06-22', NULL, NULL, 3, 55.55, 0),
(4, 4, 0, '2018-06-14', 'REMISE04', '2018-06-23', NULL, NULL, 4, 66.00, 0),
(5, 1, 0, '2018-05-10', 'REMISE05', '2018-05-15', NULL, NULL, 5, 80.00, 1);
INSERT INTO Fiches_Traites (lind, code, montant, date, datech, numfac, imp, nom, acceptee, ecartee) VALUES
(1, '1001', '150,00', '2018-06-10', '2018-08-10', 'F0101', 0, 'CLIENT UN', 1, 0),
(2, '1004', '99,90', '2018-06-11', '2018-08-11', 'F0102', 0, 'CLIENT QUATRE', 0, 0);
UPDATE Fiches_Lcr SET codeentree = 1 WHERE lind = 4;
