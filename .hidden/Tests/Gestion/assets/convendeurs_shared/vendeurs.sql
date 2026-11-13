-- ConVendeurs : deux vendeurs (code 1 mdp « secret », code 12 mdp « martin »), chiffrés par hexdblKey.crypt("en", mdp, "Laurux").
INSERT INTO Fiches_Vendeurs (lind, code, nom, mdp, admin) VALUES (1, '1', 'DUPONT', '32091B0D1D01', 0);
INSERT INTO Fiches_Vendeurs (lind, code, nom, mdp, admin) VALUES (2, '12', 'MARTIN', '2C0D0A0B111B', 0);
