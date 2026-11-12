-- Jeu de données FComptes (agent 5, phase 2) : comptes libres, compte mouvementé (Fiches_Mvt3), sous-compte, postes.
INSERT INTO Fiches_Comptes (compte_cc,intitule_cc,type_cc,coll,cent_cc,comptr_cc,code_tvente,taux_tvente,gen_tv,code_tachat,taux_tachat,gen_ta,solde,soldep,cprincipal) VALUES
('606900','Compte libre','G',0,0,0,'','',0,'','',0,0,0,0),
('606950','Compte libre 2','G',0,0,0,'','',0,'','',0,0,0,0);
INSERT INTO Fiches_SousComptes (code,code_vtl,intitule_vtl) VALUES ('606900','606100','Fournitures non stockables');
INSERT INTO Fiches_Mvt3 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,lettree,cloturee) VALUES
('10',1,1,'604000',0,'Achats de sous-traitance','2015-06-15 00:00:00','1','Essai',100.00,0.00,1,0,0,0,0,1);
INSERT INTO Fiches_Postes (code,intitulep) VALUES ('01','Atelier'),('02','Magasin');
