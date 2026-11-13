-- Jeu Glcr : deux banques et six LCR (écartée/non écartée, banque vide/1/2, code entrée 0/1/5, bordereau 0/1/2,
-- échéances de mai à août 2018). Fiches_Banques et Fiches_Lcr sont vides dans Laurux01.sql.
INSERT INTO Fiches_Banques (banques_code, banques_nom, banques_nume) VALUES (1, 'BANQUE ALPHA', '123456'), (2, 'CREDIT BETA', '654321');
INSERT INTO Fiches_Lcr (lind, code, nom, montant, date, datech, numfac, acceptee, ecartee, banque, codeentree, bordereau) VALUES
(1, '41100001', 'CLIENT UN', '100.00', '2018-05-02', '2018-05-31', 'F0001', 1, 0, NULL, 0, '0'),
(2, '41100002', 'CLIENT DEUX', '250.50', '2018-05-10', '2018-06-10', 'F0002', 1, 1, NULL, 0, '0'),
(3, '41100003', 'CLIENT TROIS', '75.25', '2018-05-15', '2018-06-30', 'F0003', 0, 0, '1', 1, '0'),
(4, '41100004', 'CLIENT QUATRE', '1200.00', '2018-05-20', '2018-07-15', 'F0004', 1, 1, '2', 5, '2'),
(5, '41100005', 'CLIENT CINQ', '42.00', '2018-06-01', '2018-07-31', 'F0005', 1, 0, '1', 5, '1'),
(6, '41100006', 'CLIENT SIX', '310.10', '2018-06-05', '2018-08-31', 'F0006', 0, 1, '1', 1, '0');
