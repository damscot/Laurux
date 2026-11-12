-- Jeu Jourcent T03 (agent 5, vague 3) : journal 53 (caisse), pièce 1 : 530000 / 706100 ; pièce 2 (même date) :
-- collectif 453000 (compte collectif créé) / 530000. Tri dte, numero, compte : le 453000 suit la ligne 706100.
INSERT INTO Fiches_Comptes (compte_cc,intitule_cc,type_cc,coll,coll_cc,cent_cc,comptr_cc,solde,soldep) VALUES (453000,'Collectif divers','B',1,NULL,0,0,0,0);
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('53',1,1,'530000',0,'Caisse','2018-02-10 00:00:00','C001','Caisse C001',80.00,0.00,1,0,0,0,NULL,0,0),
('53',1,1,'706100',0,'Ventes MO','2018-02-10 00:00:00','C001','Caisse C001',0.00,80.00,1,0,0,0,NULL,0,0),
('53',2,2,'453000',1,'Collectif divers','2018-02-10 00:00:00','C002','Caisse C002',30.00,0.00,1,0,0,0,NULL,0,0),
('53',2,2,'530000',0,'Caisse','2018-02-10 00:00:00','C002','Caisse C002',0.00,30.00,1,0,0,0,NULL,0,0);
