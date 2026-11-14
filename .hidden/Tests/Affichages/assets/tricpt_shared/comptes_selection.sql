-- TRICPT (agent 6, vague 6) : sur Laurux01, clients 411001 (actif, divers), 411002 (actif, auto-entrepreneur),
-- 411003 non lettrable ; adresses de livraison et contacts clients/fournisseurs ; un compte de trésorerie.
UPDATE Fiches_Cli SET cli_actif = 1, cli_div = 1, cli_autoent = 0, cli_ville = 'NANTES', cli_cd_ptl = '44000', cli_adr1 = '1 rue Un' WHERE cli_code = 411001;
UPDATE Fiches_Cli SET cli_actif = 1, cli_div = 0, cli_autoent = 1, cli_ville = 'RENNES', cli_cd_ptl = '35000' WHERE cli_code = 411002;
UPDATE Fiches_Comptes SET lettrable = 1 WHERE compte_cc IN (411001, 411002);
UPDATE Fiches_Comptes SET lettrable = 0 WHERE compte_cc = 411003;
UPDATE Fiches_Comptes SET comptr_cc = 1, solde = 123.456 WHERE compte_cc = 512000;
INSERT INTO Fiches_AdrlivC (code, nom, pnm, adr1, adr2, cd_ptl, ville) VALUES
(411001, 'Livraison A', 'Paul', '2 rue Livr', 'Bat B', '44100', 'NANTES'),
(411002, 'Livraison B', 'Jean', '3 rue Livr', '', '35200', 'RENNES');
INSERT INTO Fiches_ContactC (code, nom, pnm, fonction, tel, mail, portable) VALUES
(411001, 'Contact A', 'Anne', 'Achats', '0201020304', 'a@exemple.fr', '0601020304');
INSERT INTO Fiches_ContactF (code, nom, pnm, fonction, tel, mail, portable) VALUES
(401001, 'Contact F', 'Marc', 'Ventes', '0201020305', 'f@exemple.fr', '0601020305');
