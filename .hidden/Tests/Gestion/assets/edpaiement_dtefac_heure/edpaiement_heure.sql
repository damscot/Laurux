-- Edpaiement : facture de caisse datée avec heure (10:30, absente de l'édition : A01) et facture à minuit.
INSERT INTO Fiches_Bl (numbl, type, cdclibl, cvclibl, nmclibl, pnmclibl, datebl, totalht, totalttc, imp, numfac, dtefac, reg, mtreg, reg2, mtreg2, gestbl) VALUES
('B00101','F','411001','M.','DURAND','Jean','2018-06-10 00:00:00',100,120,1,'F00101','2018-06-15 00:00:00','Cheque','120',NULL,NULL,0.00),
('B00103','F','411002','Mme','MARTIN','Anne','2018-06-15 10:30:00',25,30,1,'F00103','2018-06-15 10:30:00','Cheque','30',NULL,NULL,0.00);
