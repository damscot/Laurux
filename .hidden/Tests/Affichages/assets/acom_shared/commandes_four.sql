-- ACom : commande CA1 du fournisseur 401001 (article 001 décimal, article 002, article supprimé ZZZ),
-- commande CA2 du fournisseur 409999 absent de Fiches_Four (A01), commande CA3 sans ligne.
INSERT INTO Fiches_Entcom (four,numcom,ddate,montant,reliquat,montantttc,anomalie,commentaire) VALUES
('401001','CA1','2018-05-10 00:00:00',57.5,0,'69',0,NULL),
('409999','CA2','2018-05-12 00:00:00',10,0,'12',0,NULL),
('401001','CA3','2018-05-14 00:00:00',0,0,'0',0,NULL);
INSERT INTO Fiches_Ligcom (code,design,numcom,four,qte,pbht,rm,paht,datecom,nligne) VALUES
('001','Produit 2.10','CA1','401001',2.5,12.5,20,10,'2018-05-10 00:00:00','1'),
('002','Produit 7.00','CA1','401001',3,7,0,7,'2018-05-10 00:00:00','2'),
('ZZZ','Article supprime','CA1','401001',1,10.5,0,10.5,'2018-05-10 00:00:00','3'),
('002','Produit 7.00','CA2','409999',1,10,0,10,'2018-05-12 00:00:00','1');
