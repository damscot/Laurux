-- Jeu de données Fmontant (agent 4, phase 2, vague 4) : écritures validées de l'exercice 2018 (Fiches_Mvt)
-- n°1 facture 411001 de 12,00 (montants proches 12 / 12,5 / 125 / 120), n°2 achat 401001 de 12,50 au libellé
-- avec apostrophe, n°3 règlement de trésorerie 411002 de 125,00, n°4 facture 411003 de 120,00 clôturée,
-- n°5 écriture sur le compte collectif 401000 (coll = 1) de 12,00.
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee,control) VALUES
('70',1,1,'411001',NULL,'A Divers','2018-02-10 00:00:00','FAC12','Facture FAC12',12.00,0.00,1,0,0,0,NULL,0,0,NULL),
('70',1,1,'707000',NULL,'Ventes','2018-02-10 00:00:00','FAC12','Facture FAC12',0.00,10.00,1,0,0,0,NULL,0,0,NULL),
('70',1,1,'445730',NULL,'Tva','2018-02-10 00:00:00','FAC12','Facture FAC12',0.00,2.00,1,0,0,0,NULL,0,0,NULL),
('60',2,2,'401001',NULL,'A Divers','2018-02-15 00:00:00','FA125','L''achat fournisseur',0.00,12.50,1,0,0,0,NULL,0,0,NULL),
('60',2,2,'607000',NULL,'Achats','2018-02-15 00:00:00','FA125','L''achat fournisseur',12.50,0.00,1,0,0,0,NULL,0,0,NULL),
('50',3,3,'411002',NULL,'B Divers','2018-03-05 00:00:00','CHQ125','Reglement client',0.00,125.00,1,0,1,0,NULL,0,0,NULL),
('50',3,3,'512000',NULL,'Banque','2018-03-05 00:00:00','CHQ125','Reglement client',125.00,0.00,1,0,1,0,NULL,0,0,NULL),
('70',4,4,'411003',NULL,'C Divers','2018-04-20 00:00:00','FAC120','Facture cloturee',120.00,0.00,1,0,0,0,NULL,0,1,NULL),
('70',4,4,'707000',NULL,'Ventes','2018-04-20 00:00:00','FAC120','Facture cloturee',0.00,120.00,1,0,0,0,NULL,0,1,NULL),
('90',5,5,'401000',NULL,'Collectif','2018-05-02 00:00:00','OD12','Ecriture collectif',12.00,0.00,1,0,0,0,NULL,0,0,NULL),
('90',5,5,'512000',NULL,'Banque','2018-05-02 00:00:00','OD12','Ecriture collectif',0.00,12.00,1,0,0,0,NULL,0,0,NULL);
