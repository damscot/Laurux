-- Jeu de données SERVEUR-T01 à T04, T07 : article accentué à décimales et champs Null, article dont la désignation
-- contient « ; » et un retour à la ligne, client sans ligne Fiches_Comptes, contacts fournisseur et client.
INSERT INTO Fiches_Art (art_code, art_design, art_fam, art_four, art_pbht, art_paht, art_coef, art_pvht, art_tva,
  art_pvttc, art_cdarr, art_nbd, art_ect, art_pmp, art_pauaht, art_design2)
  VALUES ('SRV1', 'Crème brûlée à l''érable', '01', '401001', 12.345, 12.345, 1.7500, 21.60, 1, 22.79, '0,01', 2,
  1.5, 12.345, 12.345, NULL);
INSERT INTO Fiches_Art (art_code, art_design, art_fam, art_four, art_pbht, art_paht, art_coef, art_pvht, art_tva,
  art_pvttc, art_cdarr, art_nbd, art_ect)
  VALUES ('SRV2', 'Lot A;B\nsuite', '01', '401001', 1, 1, 1, 1, 1, 1.06, '0,01', 2, 0);
INSERT INTO Fiches_Cli (cli_code, cli_nom, cli_pnm, cli_ville, cli_typec) VALUES ('411900', 'Sans compte', 'Élodie', 'Nîmes', '2');
INSERT INTO Fiches_ContactF (num, code, nom, pnm, fonction, tel, mail, portable)
  VALUES (1, 401001, 'Dupont', 'Jérôme', 'Achats', '0102030405', 'achats@exemple.invalid', NULL);
INSERT INTO Fiches_ContactC (num, code, nom, pnm, fonction, tel, mail, portable)
  VALUES (1, 411001, 'Martin', 'Anaïs', 'Compta', '0600000000', 'compta@exemple.invalid', '0700000000');
