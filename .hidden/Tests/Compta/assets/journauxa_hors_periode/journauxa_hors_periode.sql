-- Jeu JournauxA T04 (agent 5, vague 3) : 2 postes, écritures analytiques validées datées de 2016 (hors exercice en cours).
INSERT INTO Fiches_Postes (code,intitulep) VALUES ('10','Poste dix'),('20','Poste vingt');
INSERT INTO Fiches_MvtA (numero,compte,intitule,dte,numdoc,libelle,pourcent,montantd,montantc,jour,poste,validee) VALUES
(1,'707000','Ventes','2016-02-10 00:00:00','F001','Facture F001','100',0.00,100.00,'70','10',1),
(2,'606100','Fournitures','2016-04-05 00:00:00','A001','Achat A001','100',40.00,0.00,'60','20',1);
