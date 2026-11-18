-- FCloture (jeu brut, clés NULL) : généré par Compta/assets/fcloture_shared/gen_fcloture.py.
UPDATE Fiches_Parametres SET dtepc = '2018-12-31', numecriture2 = 6;
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,cloturee,lind,control) VALUES
('70',30,NULL,'411001',0,'Client','2019-01-10 00:00:00','F030','Ecriture 30',60.00,0.00,1,0,0,1,NULL),
('70',30,NULL,'707000',0,'Ventes','2019-01-10 00:00:00','F030','Ecriture 30',0.00,60.00,1,0,0,2,NULL);
