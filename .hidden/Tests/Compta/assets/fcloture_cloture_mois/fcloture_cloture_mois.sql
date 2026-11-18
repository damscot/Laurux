-- FCloture (T01 : clôture de juin 2018, clés valides ; 10 et 12 sans numerodef, 11 avec numerodef 4) : généré par Compta/assets/fcloture_shared/gen_fcloture.py.
UPDATE Fiches_Parametres SET dtepc = '2018-05-31', numecriture2 = 6;
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,cloturee,lind,control) VALUES
('70',9,6,'411001',0,'Client','2018-05-20 00:00:00','F009','Ecriture 9',10.00,0.00,1,0,1,1,'DyYWM4sQwuyyt2BUJLRJGKJKKxs='),
('70',9,6,'707000',0,'Ventes','2018-05-20 00:00:00','F009','Ecriture 9',0.00,10.00,1,0,1,2,'o9gsRPgzsPNZtgvM7mUr6CerKAw='),
('70',10,NULL,'411001',0,'Client','2018-06-03 00:00:00','F010','Ecriture 10',20.00,0.00,1,0,0,3,'2Fcv1TkCb3hDhtEOSeqoG4C/4/M='),
('70',10,NULL,'707000',0,'Ventes','2018-06-03 00:00:00','F010','Ecriture 10',0.00,20.00,1,0,0,4,'ttK2tkW+IMdF20+xT0r9Vz+YYL4='),
('70',11,4,'411001',0,'Client','2018-06-10 00:00:00','F011','Ecriture 11',30.00,0.00,1,0,0,5,'e91a9agLIWruAqQnyKyIhk/Uvqc='),
('70',11,4,'707000',0,'Ventes','2018-06-10 00:00:00','F011','Ecriture 11',0.00,30.00,1,0,0,6,'ww7CFMaE7aP9hBpL914cyJiMu/E='),
('70',12,NULL,'411001',0,'Client','2018-06-25 00:00:00','F012','Ecriture 12',40.00,0.00,1,0,0,7,'+BjQFHuaeqm0h7qHe6RKey9DhQM='),
('70',12,NULL,'707000',0,'Ventes','2018-06-25 00:00:00','F012','Ecriture 12',0.00,40.00,1,0,0,8,'RjTWIQBRA8Ow3J2+QakxaRjv5wI='),
('70',13,NULL,'411001',0,'Client','2018-07-02 00:00:00','F013','Ecriture 13',50.00,0.00,1,0,0,9,'NbrQ7GCttuPTb0OHrXQG5rmJ2Jk='),
('70',13,NULL,'707000',0,'Ventes','2018-07-02 00:00:00','F013','Ecriture 13',0.00,50.00,1,0,0,10,'shmoVDj6TwOvLUd4G7bT/GRnu88=');
