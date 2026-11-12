-- Jeu EditcompteA T03 (agent 3, vague 3) : 607000 ventilé (Fiches_Analytiques, poste A01 100 %)
-- avec deux écritures analytiques Fiches_MvtA dans l'exercice 2018.
INSERT INTO Fiches_Analytiques (code,compte,pourcent) VALUES ('A01','607000',100);
INSERT INTO Fiches_MvtA (numero,compte,intitule,dte,numdoc,libelle,pourcent,montantd,montantc,jour,poste,validee) VALUES
(1,'607000','Achats','2018-02-10 00:00:00','A001','Achat A001','100',200.00,0.00,'60','A01',1),
(2,'607000','Achats','2018-03-15 00:00:00','A002','Achat A002','100',50.00,0.00,'60','A01',1);
