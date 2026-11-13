-- Jeu ETICLI : clients typés (A, B, C), codes postaux variés et codes « limites » (5, 9000, 41100005, 411000050).
INSERT INTO Fiches_Cli (cli_code, cli_rs_soc, cli_nom, cli_pnm, cli_adr1, cli_adr2, cli_cd_ptl, cli_ville, cli_typec) VALUES (411101, 'SARL', 'Martin', 'Paul', '1 rue des Lilas', '', '44000', 'Nantes', 'A');
INSERT INTO Fiches_Cli (cli_code, cli_rs_soc, cli_nom, cli_pnm, cli_adr1, cli_adr2, cli_cd_ptl, cli_ville, cli_typec) VALUES (411102, '', 'Durand', 'Anne', '2 place Royale', 'Bat B', '85000', 'La Roche', 'B');
INSERT INTO Fiches_Cli (cli_code, cli_rs_soc, cli_nom, cli_pnm, cli_adr1, cli_adr2, cli_cd_ptl, cli_ville, cli_typec) VALUES (411103, '', 'Petit', 'Luc', '3 quai Ceineray', '', '44300', 'Nantes', 'A');
INSERT INTO Fiches_Cli (cli_code, cli_rs_soc, cli_nom, cli_pnm, cli_adr1, cli_adr2, cli_cd_ptl, cli_ville, cli_typec) VALUES (411104, 'SA', 'Bernard', '', '4 bd Foch', '', '49000', 'Angers', 'C');
INSERT INTO Fiches_Cli (cli_code, cli_rs_soc, cli_nom, cli_pnm, cli_adr1, cli_adr2, cli_cd_ptl, cli_ville, cli_typec) VALUES (411105, '', 'Moreau', 'Julie', '5 rue Crebillon', '', '44100', 'Nantes', 'B');
INSERT INTO Fiches_Cli (cli_code, cli_rs_soc, cli_nom, cli_pnm, cli_adr1, cli_adr2, cli_cd_ptl, cli_ville, cli_typec) VALUES (5, '', 'Cinq', '', '6 rue Courte', '', '44200', 'Nantes', 'A');
INSERT INTO Fiches_Cli (cli_code, cli_rs_soc, cli_nom, cli_pnm, cli_adr1, cli_adr2, cli_cd_ptl, cli_ville, cli_typec) VALUES (9000, '', 'Neuf Mille', '', '7 rue Longue', '', '35000', 'Rennes', 'B');
INSERT INTO Fiches_Cli (cli_code, cli_rs_soc, cli_nom, cli_pnm, cli_adr1, cli_adr2, cli_cd_ptl, cli_ville, cli_typec) VALUES (41100005, '', 'Huit Chiffres', '', '8 allee Verte', '', '44800', 'Herblain', 'A');
INSERT INTO Fiches_Cli (cli_code, cli_rs_soc, cli_nom, cli_pnm, cli_adr1, cli_adr2, cli_cd_ptl, cli_ville, cli_typec) VALUES (411000050, '', 'Neuf Chiffres', '', '9 allee Bleue', '', '56000', 'Vannes', 'C');
INSERT INTO Fiches_Etiquettes (code, nblargeur, nbhauteur, largeur, hauteur, mrghaut, mrgauche, esplargeur, esphauteur, libelle, page) VALUES ('Z', 3, 8, 700, 370, 0, 0, 0, 0, 'Test', 'A4 Portrait');
