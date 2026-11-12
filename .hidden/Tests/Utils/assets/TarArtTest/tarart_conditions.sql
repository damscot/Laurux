-- Jeu de données TARART-T01 à T10 (TarArt) : conditions tarifaires isolées par famille / article.
-- Clients : 411001 type '00' (absent de Fiches_Typec), 411002 type '01' (Macon), 411003 type '02' (Plombier).
-- Familles F4, F5, F6 copiées de la famille 03 ; articles TA4, TA5, TA6 copiés de l'article 003
-- (art_pvht 20, art_prvt 12). Conditions :
--   famille 01 (article 001) : remises type client 01 = 10 %, 02 = 5 %        (T02)
--   famille 02 (article 002) : coefficients type client 01 = 1,5, 02 = 1,8   (T03, T09, T10)
--   TA4 (F4) : coefficient type client 02 × article = 2,5                     (T04)
--   TA5 (F5) : remise type 02 × F5 = 5 %, remise client 411003 × F5 = 15 %     (T05)
--   TA6 (F6) : les 5 conditions pour 411003 / type 02                          (T06)
--   promotions PRO1 (001 : 5,00 HT) et PRO2 (001 : 50,00 HT)                  (T07)
UPDATE Fiches_Art SET art_pvht = 15, art_prvt = 8 WHERE art_code = '003'; -- prix de base (T01)
UPDATE Fiches_Cli SET cli_typec = '00' WHERE cli_code = 411001;
UPDATE Fiches_Cli SET cli_typec = '01' WHERE cli_code = 411002;
UPDATE Fiches_Cli SET cli_typec = '02' WHERE cli_code = 411003;

CREATE TEMPORARY TABLE tmp_fam AS SELECT * FROM Fiches_Fam WHERE code_fam = '03';
UPDATE tmp_fam SET code_fam = 'F4', libell_fam = 'Famille F4';
INSERT INTO Fiches_Fam SELECT * FROM tmp_fam;
UPDATE tmp_fam SET code_fam = 'F5', libell_fam = 'Famille F5';
INSERT INTO Fiches_Fam SELECT * FROM tmp_fam;
UPDATE tmp_fam SET code_fam = 'F6', libell_fam = 'Famille F6';
INSERT INTO Fiches_Fam SELECT * FROM tmp_fam;
DROP TEMPORARY TABLE tmp_fam;

CREATE TEMPORARY TABLE tmp_art AS SELECT * FROM Fiches_Art WHERE art_code = '003';
UPDATE tmp_art SET art_pvht = 20, art_prvt = 12, art_cbarre = '';
UPDATE tmp_art SET art_code = 'TA4', art_design = 'Article TA4', art_fam = 'F4';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
UPDATE tmp_art SET art_code = 'TA5', art_design = 'Article TA5', art_fam = 'F5';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
UPDATE tmp_art SET art_code = 'TA6', art_design = 'Article TA6', art_fam = 'F6';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
DROP TEMPORARY TABLE tmp_art;

INSERT INTO Fiches_RemTypec (coder, codef, remise) VALUES ('01', '01', 10), ('02', '01', 5), ('02', 'F5', 5), ('02', 'F6', 8);
INSERT INTO Fiches_CoeffTypec (coder, codef, coeff) VALUES ('01', '02', 1.5), ('02', '02', 1.8), ('02', 'F6', 1.4);
INSERT INTO Fiches_TarTypcli (type, cart, coef) VALUES ('02', 'TA4', 2.5), ('02', 'TA6', 1.6);
INSERT INTO Fiches_RemCliFam (codec, codef, remise) VALUES ('411003', 'F5', 15), ('411003', 'F6', 12);
INSERT INTO Fiches_Tarcli (ccli, cart, coef) VALUES ('411003', 'TA6', 1.3);
INSERT INTO Fiches_Promo (code, libelle, datedeb, datefin) VALUES ('PRO1', 'Promo basse', '2000-01-01', '2099-12-31'), ('PRO2', 'Promo haute', '2000-01-01', '2099-12-31');
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('PRO1', '001', 'Promo basse', 0, 5, 6, 0), ('PRO2', '001', 'Promo haute', 0, 50, 60, 0);
