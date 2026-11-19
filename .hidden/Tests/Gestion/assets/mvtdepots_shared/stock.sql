-- Jeu MVTDEPOTS : article 001 stocké (stock magasin 10), dépôt 02 avec 5 de 001, dépôt 03 « Depot 2 » sans stock.
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 10 WHERE art_code = '001';
INSERT INTO Fiches_Depots VALUES ('03','Depot 2','','','','');
INSERT INTO Fiches_StkDepots (coded, codea, qte) VALUES ('02','001',5);
