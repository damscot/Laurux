-- Jeu Commerciaux T02/T04 : commercial 01 (comm 5,50) et 02 ; client 411001 rattaché au commercial 01.
INSERT INTO Fiches_Commerciaux (lind, code, nom, prenom, comm) VALUES (1, '01', 'Durand', 'Paul', 5.50), (2, '02', 'Martin', 'Luc', 3.00);
UPDATE Fiches_Cli SET cli_comm = '01' WHERE cli_code = '411001';
