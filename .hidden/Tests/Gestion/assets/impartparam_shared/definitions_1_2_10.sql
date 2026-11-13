-- ImpartParam : trois définitions d'import tarif numérotées 1, 2 et 10 (Fiches_ImpArtDef vide dans Laurux01).
INSERT INTO Fiches_ImpArtDef (num, nom, cfour, nfour, cfam, nfam, adrfic, typesep, sep) VALUES
(1, 'Def un', '401001', 'Fournisseur', '01', 'Famille', '/tmp/tarif1.csv', 'S', ';'),
(2, 'Def deux', '401001', 'Fournisseur', '01', 'Famille', '/tmp/tarif2.csv', 'S', ';'),
(10, 'Def dix', '401001', 'Fournisseur', '01', 'Famille', '/tmp/tarif10.csv', 'S', ';');
