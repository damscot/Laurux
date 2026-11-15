-- Jeu EditcompteA T06 (vague 7) : 607000 ventilé (poste A01 100 %), deux écritures analytiques de l'exercice N-1
-- (2017) dans Fiches_MvtA1 seulement ; Fiches_MvtA vide.
INSERT INTO Fiches_Analytiques (code,compte,pourcent) VALUES ('A01','607000',100);
INSERT INTO Fiches_MvtA1 (numero,compte,intitule,dte,numdoc,libelle,pourcent,montantd,montantc,jour,poste,validee) VALUES
(1,'607000','Achats','2017-02-10 00:00:00','A001','Achat A001','100',200.00,0.00,'60','A01',1),
(2,'607000','Achats','2017-03-15 00:00:00','A002','Achat A002','100',50.00,0.00,'60','A01',1);
