-- Edpaiement : factures du 15/06/2018 en Fiches_Bl (atelier/vente) et Fiches_BlM (entretien), modes Cheque et Especes ;
-- une facture du 14/06/2018 (hors date).
INSERT INTO Fiches_Bl (numbl, type, cdclibl, cvclibl, nmclibl, pnmclibl, datebl, totalht, totalttc, imp, numfac, dtefac, reg, mtreg, reg2, mtreg2, gestbl) VALUES
('B00101','F','411001','M.','DURAND','Jean','2018-06-10 00:00:00',100,120,1,'F00101','2018-06-15 00:00:00','Cheque','120',NULL,NULL,0.00),
('B00102','F','411002','Mme','MARTIN','Anne','2018-06-11 00:00:00',25,30,1,'F00102','2018-06-15 00:00:00','Especes','30',NULL,NULL,0.00),
('B00104','F','411001','M.','DURAND','Jean','2018-06-12 00:00:00',10,12,1,'F00104','2018-06-14 00:00:00','Cheque','12',NULL,NULL,0.00);
INSERT INTO Fiches_BlM (numbl, type, cdclibl, cvclibl, nmclibl, pnmclibl, datebl, totalht, totalttc, imp, numfac, dtefac, reg, mtreg, reg2, mtreg2, gestbl) VALUES
('M00201','F','411003','M.','PETIT','Luc','2018-06-13 00:00:00',66.67,80,1,'F00201','2018-06-15 00:00:00','Cheque','80',NULL,NULL,0.00),
('M00202','F','411003','M.','PETIT','Luc','2018-06-13 00:00:00',8.33,10,1,'F00202','2018-06-15 00:00:00','Especes','10',NULL,NULL,0.00);
