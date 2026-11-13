-- Jeu ETIQRECPT-T05 : la file produits contient la référence fournisseur REF002 (art_cfour de l'article 002).
UPDATE Fiches_Art SET art_casier = 'C2', art_cfour = 'REF002' WHERE art_code = '002';
INSERT INTO Fiches_EtiProd (code, nombre) VALUES ('REF002', 1);
