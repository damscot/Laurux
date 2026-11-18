-- FCloture (T04 : dtepc 30/11/2018, écritures 20 et 21 en décembre 2018, clés valides) : généré par Compta/assets/fcloture_shared/gen_fcloture.py.
UPDATE Fiches_Parametres SET dtepc = '2018-11-30', numecriture2 = 6;
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,cloturee,lind,control) VALUES
('70',20,NULL,'411001',0,'Client','2018-12-05 00:00:00','F020','Ecriture 20',15.00,0.00,1,0,0,1,'+e4zoMKgqSHFL6jcWRuzs1xa+8E='),
('70',20,NULL,'707000',0,'Ventes','2018-12-05 00:00:00','F020','Ecriture 20',0.00,15.00,1,0,0,2,'vXNcSjM0RyHYhWSuNywoCWgIEIs='),
('70',21,NULL,'411001',0,'Client','2018-12-31 00:00:00','F021','Ecriture 21',25.00,0.00,1,0,0,3,'h6GfUVRXs9BGlURrl77hLd/vJ5U='),
('70',21,NULL,'707000',0,'Ventes','2018-12-31 00:00:00','F021','Ecriture 21',0.00,25.00,1,0,0,4,'L2gweFnzI2icZxpZggqShIeXli0='),
('70',22,NULL,'411001',0,'Client','2019-01-02 00:00:00','F022','Ecriture 22',35.00,0.00,1,0,0,5,'eqEutp79wrj+HujdTBjk7b6cB+4='),
('70',22,NULL,'707000',0,'Ventes','2019-01-02 00:00:00','F022','Ecriture 22',0.00,35.00,1,0,0,6,'uLbhbL4W1P0hmeVqVrkM6hV4UkA=');
