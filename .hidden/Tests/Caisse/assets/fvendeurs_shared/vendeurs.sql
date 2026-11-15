-- Fvendeurs (phase 2, vague 7) : caisse et vendeurs activés par le blob conf ; vendeurs 1, 12 et 2 (administrateur),
-- mots de passe chiffrés par hexdblKey.crypt("en", …, "Laurux") : abc1, b123, c234.
UPDATE Fiches_Parametres SET conf = '[Soc01]\nCaisse=-1\nVendeurs=-1\n';
INSERT INTO Fiches_Vendeurs (code, nom, mdp, admin) VALUES ('1', 'ALICE', '200E1B4E', 0), ('12', 'BRUNO', '235D4A4C', 0), ('2', 'CHLOE', '225E4B4B', -1);
