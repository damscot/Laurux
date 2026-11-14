-- TriHistos : historique de l'article 002, dates relatives au jour courant (CURDATE) car l'écran filtre sur Now.
-- Ventes : BL H00001 en cours (-2 mois), BL H00002 facturé F00009 (-4 mois), BL H00003 hors période d'un an (-26 mois),
-- facture archivée F00100 (-5 mois, quantité décimale « 2.5 »), sortie exceptionnelle (-1 mois, qtem 4).
-- Achats : réceptions R001 (401001, -1 mois), R002 (401002, -6 mois), R003 (401001, -20 mois), entrée exceptionnelle
-- (-3 mois, qtep 6) ; article 003 : réception R009 d'un fournisseur 409999 absent de Fiches_Four (A02).
INSERT INTO Fiches_Bl (numbl,type,cdclibl,nmclibl,pnmclibl,datebl,imp,numfac,dtefac,totalht,totalttc) VALUES
('H00001','B','411001','DUPONT','Jean',DATE_SUB(CURDATE(), INTERVAL 2 MONTH),0,NULL,NULL,21,25.2),
('H00002','F','411002','MARTIN','Paul',DATE_SUB(CURDATE(), INTERVAL 4 MONTH),1,'F00009',DATE_SUB(CURDATE(), INTERVAL 4 MONTH),14,16.8),
('H00003','B','411001','DUPONT','Jean',DATE_SUB(CURDATE(), INTERVAL 26 MONTH),0,NULL,NULL,7,8.4);
INSERT INTO Fiches_Ligbl (num_ligbl,numlig_ligbl,code_ligbl,libel_ligbl,pu_ligbl,qte_ligbl,brut_ligbl,rem_ligbl,netht_ligbl,typel_ligbl,com_ligbl) VALUES
('H00001','1','002','Produit 7.00','7','3','7','0','21','A',NULL),
('H00001','2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'C','Commentaire BL\nsur deux lignes'),
('H00002','1','002','Produit 7.00','7','2','7','0','14','A',NULL),
('H00003','1','002','Produit 7.00','7','1','7','0','7','A',NULL);
INSERT INTO Fiches_HistoFac (numfac,cdclifac,nmclifac,pnmclifac,datefac,totfac,totfacttc) VALUES
('F00100','411002','MARTIN','Paul',DATE_SUB(CURDATE(), INTERVAL 5 MONTH),15,18);
INSERT INTO Fiches_HistoLigfac (num_ligfac,numlig_ligfac,code_ligfac,libel_ligfac,pu_ligfac,qte_ligfac,brut_ligfac,rem_ligfac,netht_ligfac,typel_ligfac,com_ligfac) VALUES
('F00100','1','002','Produit 7.00','6','2.5','6','0','15','A',NULL),
('F00100','2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'C','Commentaire facture');
INSERT INTO Fiches_Mvtexp (code,daterecpt,qtep,qtem,com) VALUES
('002',DATE_SUB(CURDATE(), INTERVAL 1 MONTH),NULL,'4',NULL),
('002',DATE_SUB(CURDATE(), INTERVAL 3 MONTH),'6',NULL,'Retour atelier');
INSERT INTO Fiches_Ligrecpt (code,design,numrecpt,four,daterecpt,qte,pbht,rm,paht,nligne) VALUES
('002','Produit 7.00','R001','401001',DATE_SUB(CURDATE(), INTERVAL 1 MONTH),5,8,10,7.2,'1'),
('001','Produit 2.10','R001','401001',DATE_SUB(CURDATE(), INTERVAL 1 MONTH),2,10,0,10,'2'),
('002','Produit 7.00','R002','401002',DATE_SUB(CURDATE(), INTERVAL 6 MONTH),10,7.5,0,7.5,'1'),
('002','Produit 7.00','R003','401001',DATE_SUB(CURDATE(), INTERVAL 20 MONTH),4,7,0,7,'1'),
('003','produit 20.00','R009','409999',DATE_SUB(CURDATE(), INTERVAL 1 MONTH),1,20,0,20,'1');
