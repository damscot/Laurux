-- FCollectif (FCOLLECTIF-T03, T04) : collectif 453100 au solde non nul et mouvementé (une écriture dans
-- Fiches_Mvt), collectif libre 453200 (aucun mouvement, aucun compte rattaché). 401000 a déjà des comptes
-- rattachés (coll_cc) dans Laurux01 ; 602100 est un compte non collectif sans mouvement.
INSERT INTO Fiches_Comptes (compte_cc, intitule_cc, type_cc, coll, coll_cc, cent_cc, solde, soldep) VALUES
 (453100, 'Collectif mvt', 'B', 1, NULL, 1, 125.5, 0),
 (453200, 'Collectif libre', 'B', 1, NULL, 1, 0, 0);
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('90',1,1,'453100',1,'Collectif mvt','2018-03-01 00:00:00','D1','Ecriture collectif',125.50,0.00,1,0,0,0,NULL,0,0);
