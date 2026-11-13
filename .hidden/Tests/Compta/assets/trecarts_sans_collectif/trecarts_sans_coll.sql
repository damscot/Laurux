-- TRECARTS-T06 : compte client sans collectif (coll_cc NULL) avec un lot d'écart +0,01 (seuil 0,05).
UPDATE Fiches_Parametres SET ecart = 0.05, numecriture = 100;
INSERT INTO Fiches_Comptes (compte_cc, intitule_cc, type_cc, coll, coll_cc, cent_cc, comptr_cc, solde, soldep, cprincipal, lettrable) VALUES
(411099,'Client sans collectif','C',0,NULL,0,0,0.01,0,0,1);
INSERT INTO Fiches_Mvt (jour, numero, compte, collectif, intitule, dte, numdoc, numlot, libelle, montantd, montantc, validee, provisoire, tresorerie, pointee, lettree, cloturee) VALUES
('01',11,'411099',0,'Client sans collectif','2018-03-05','F7','L000000007','Facture F7',10.00,0.00,1,0,0,0,0,0),
('03',12,'411099',0,'Client sans collectif','2018-03-26','R7','L000000007','Reglement F7',0.00,9.99,1,0,0,0,0,0);
