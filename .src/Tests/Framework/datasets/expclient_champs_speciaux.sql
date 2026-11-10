-- Jeu de données EXPCLIENT-T02 : client avec champs NULL et « ; » dans la raison sociale et l'adresse.
INSERT INTO Fiches_Cli (cli_code, cli_rs_soc, cli_nom, cli_pnm, cli_adr1, cli_adr2, cli_cd_ptl, cli_ville, cli_pble, cli_email)
VALUES ('411900', 'Durand; Fils & Cie', NULL, NULL, '5 rue ; des Ecoles', NULL, NULL, 'Nantes', NULL, NULL);
