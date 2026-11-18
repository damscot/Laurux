-- FCloture (jeu brut, clés NULL) : généré par Compta/assets/fcloture_shared/gen_fcloture.py.
UPDATE Fiches_Parametres SET dtepc = '2018-11-30', numecriture2 = 6;
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,cloturee,lind,control) VALUES
('70',20,NULL,'411001',0,'Client','2018-12-05 00:00:00','F020','Ecriture 20',15.00,0.00,1,0,0,1,NULL),
('70',20,NULL,'707000',0,'Ventes','2018-12-05 00:00:00','F020','Ecriture 20',0.00,15.00,1,0,0,2,NULL),
('70',21,NULL,'411001',0,'Client','2018-12-31 00:00:00','F021','Ecriture 21',25.00,0.00,1,0,0,3,NULL),
('70',21,NULL,'707000',0,'Ventes','2018-12-31 00:00:00','F021','Ecriture 21',0.00,25.00,1,0,0,4,NULL),
('70',22,NULL,'411001',0,'Client','2019-01-02 00:00:00','F022','Ecriture 22',35.00,0.00,1,0,0,5,NULL),
('70',22,NULL,'707000',0,'Ventes','2019-01-02 00:00:00','F022','Ecriture 22',0.00,35.00,1,0,0,6,NULL);
