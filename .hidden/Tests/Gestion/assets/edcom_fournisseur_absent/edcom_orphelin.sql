-- Edcom : commande dont le fournisseur n'existe pas (A03)
INSERT INTO Fiches_Entcom (four,numcom,ddate,montant,reliquat,montantttc,anomalie,commentaire) VALUES
('401001','C1','2018-05-10 00:00:00',30,0,'36',0,NULL),
('999999','C9','2018-04-01 00:00:00',10,0,'12',0,NULL);
INSERT INTO Fiches_Ligcom (code,design,numcom,four,qte,pbht,rm,paht,datecom,nligne) VALUES
('001','Produit 2.10','C1','401001',2,12.5,20,10,'2018-05-10 00:00:00','1'),
('001','Produit 2.10','C9','999999',1,10,0,10,'2018-04-01 00:00:00','1');
