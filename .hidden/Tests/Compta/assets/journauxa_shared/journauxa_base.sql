-- Jeu JournauxA (agent 5, vague 3) : 2 postes analytiques (10, 20), écritures analytiques validées 2018
-- sur les journaux 60 et 70 ; une écriture non validée (ignorée).
INSERT INTO Fiches_Postes (code,intitulep) VALUES ('10','Poste dix'),('20','Poste vingt');
INSERT INTO Fiches_MvtA (numero,compte,intitule,dte,numdoc,libelle,pourcent,montantd,montantc,jour,poste,validee) VALUES
(1,'707000','Ventes','2018-02-10 00:00:00','F001','Facture F001','100',0.00,100.00,'70','10',1),
(2,'707000','Ventes','2018-03-12 00:00:00','F002','Facture F002','100',0.00,50.00,'70','20',1),
(3,'606100','Fournitures','2018-04-05 00:00:00','A001','Achat A001','100',40.00,0.00,'60','10',1),
(4,'606100','Fournitures','2018-05-07 00:00:00','A002','Achat A002','100',20.00,0.00,'60','20',1),
(5,'606100','Fournitures','2018-05-08 00:00:00','A003','Achat A003','100',99.00,0.00,'60','20',0);
