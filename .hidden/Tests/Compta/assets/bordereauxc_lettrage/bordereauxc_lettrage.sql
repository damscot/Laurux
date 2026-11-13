-- Jeu BordereauxC T06 (agent 2, vague 4) : lettrage à la remise.
-- Chèque 411001 de 120 (facture F001 : lot F001 débité de 120 → solde exact, lettrage attendu),
-- chèque 411002 de 30 (facture F003 : lot débité de 35 → pas de lettrage),
-- client caisse 411027 (Fiches_ClientCaisse), chèque caisse de 50 dont le lot T001 solde exactement (A05).
INSERT INTO Fiches_ClientCaisse (code,nom) VALUES ('411027','Client caisse');
INSERT INTO Fiches_BordereauxC (lind,banque,dateremise,bordereau,montant,etat,code,nom,nfacture) VALUES
(1,NULL,'2018-06-10',NULL,120.00,0,'411001','A Divers','F001'),
(2,NULL,'2018-06-11',NULL,30.00,0,'411002','B Divers','F003'),
(3,NULL,'2018-06-12',NULL,50.00,0,'411027','Client caisse','T001');
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',0,'A Divers','2018-06-01 00:00:00','F001','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'707000',0,'Ventes','2018-06-01 00:00:00','F001','F001','Facture F001',0.00,120.00,1,0,0,0,NULL,0,0),
('70',2,2,'411002',0,'B Divers','2018-06-02 00:00:00','F003','F003','Facture F003',35.00,0.00,1,0,0,0,NULL,0,0),
('70',2,2,'707000',0,'Ventes','2018-06-02 00:00:00','F003','F003','Facture F003',0.00,35.00,1,0,0,0,NULL,0,0),
('70',3,3,'411027',0,'Client caisse','2018-06-03 00:00:00','T001','T001','Ticket T001',50.00,0.00,1,0,0,0,NULL,0,0),
('70',3,3,'707000',0,'Ventes','2018-06-03 00:00:00','T001','T001','Ticket T001',0.00,50.00,1,0,0,0,NULL,0,0);
