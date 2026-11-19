-- SaiReg (filtres) : factures F100 et F101 non lettrées du client 411001 (mai 2018) et facture F099 lettrée (avril 2018), clés control NULL.
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numcol,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,lettree,cloturee,lind,control) VALUES
('70',1,1,'411001',0,'A Divers','2018-05-10 00:00:00','0','F100','L100','Facture F100',120.00,0.00,1,0,0,0,0,0,1,NULL),
('70',1,1,'707000',0,'Ventes','2018-05-10 00:00:00','0','F100','L100','Facture F100',0.00,120.00,1,0,0,0,0,0,2,NULL),
('70',2,2,'411001',0,'A Divers','2018-05-20 00:00:00','0','F101','L101','Facture F101',60.00,0.00,1,0,0,0,0,0,3,NULL),
('70',2,2,'707000',0,'Ventes','2018-05-20 00:00:00','0','F101','L101','Facture F101',0.00,60.00,1,0,0,0,0,0,4,NULL),
('70',3,3,'411001',0,'A Divers','2018-04-02 00:00:00','0','F099','L099','Facture F099',45.00,0.00,1,0,0,0,1,0,5,NULL),
('70',3,3,'707000',0,'Ventes','2018-04-02 00:00:00','0','F099','L099','Facture F099',0.00,45.00,1,0,0,0,0,0,6,NULL);
UPDATE Fiches_Parametres SET numecriture = 3, numecriture2 = 3;
