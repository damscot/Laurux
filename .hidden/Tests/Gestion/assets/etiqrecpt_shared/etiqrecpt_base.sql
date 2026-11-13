-- Jeu ETIQRECPT : files d'étiquettes préparées (3 lignes produits/casiers, 2 lignes gondoles), casiers renseignés.
UPDATE Fiches_Art SET art_casier = 'C1' WHERE art_code = '001';
UPDATE Fiches_Art SET art_casier = 'C2', art_cfour = 'REF002' WHERE art_code = '002';
INSERT INTO Fiches_EtiProd (code, nombre) VALUES ('001', 2), ('002', 1), ('003', 1);
INSERT INTO Fiches_EtiGond (code, nombre) VALUES ('001', 1), ('002', 2);
