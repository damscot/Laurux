-- EXPCONTACT-T04 : client 411901 avec « ; », « , » et retour à la ligne dans cli_obs, l'adresse et le nom.
INSERT INTO Fiches_Cli (cli_code, cli_nom, cli_pnm, cli_adr1, cli_obs) VALUES (411901, 'DUPONT; FILS', 'Jean, Paul', '1 rue A;B', 'Ligne 1; suite, fin\nLigne 2');
