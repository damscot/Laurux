-- SaiReg : deux factures de vente non lettrées du client 411001 (A Divers) en mai 2018, journal 70, clés control NULL.
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numcol,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,lettree,cloturee,lind,control) VALUES
('70',1,1,'411001',0,'A Divers','2018-05-10 00:00:00','0','F100','L100','Facture F100',120.00,0.00,1,0,0,0,0,0,1,NULL),
('70',1,1,'707000',0,'Ventes','2018-05-10 00:00:00','0','F100','L100','Facture F100',0.00,120.00,1,0,0,0,0,0,2,NULL),
('70',2,2,'411001',0,'A Divers','2018-05-20 00:00:00','0','F101','L101','Facture F101',60.00,0.00,1,0,0,0,0,0,3,NULL),
('70',2,2,'707000',0,'Ventes','2018-05-20 00:00:00','0','F101','L101','Facture F101',0.00,60.00,1,0,0,0,0,0,4,NULL);
UPDATE Fiches_Parametres SET numecriture = 2, numecriture2 = 2;
