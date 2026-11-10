-- Jeu de données des tests RichDataGrid (écran Remisec, remises par type client) : 5 remises dont des
-- valeurs décimales (0,5 et 12,345) pour figer le format « 0.000 » de la colonne Remise.
INSERT INTO Fiches_RemTypec (lind, coder, codef, remise) VALUES (1, '01', '01', 5.000);
INSERT INTO Fiches_RemTypec (lind, coder, codef, remise) VALUES (2, '01', '02', 0.500);
INSERT INTO Fiches_RemTypec (lind, coder, codef, remise) VALUES (3, '02', '01', 12.345);
INSERT INTO Fiches_RemTypec (lind, coder, codef, remise) VALUES (4, '02', '10', 10.000);
INSERT INTO Fiches_RemTypec (lind, coder, codef, remise) VALUES (5, '03', '03', 2.250);
