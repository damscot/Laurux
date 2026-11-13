-- Jeu CONSULTART : famille F8 (code TVA 8 inexistant) et famille F9 (code TVA 9 dont le compte 445799 n'existe pas).
INSERT INTO Fiches_Tvaav (code_tva, taux_tva, cc_tva) VALUES ('9', '5.50', '445799');
INSERT INTO Fiches_Fam (code_fam, libell_fam, compt_fam, coef_fam, cdtva_fam, txtva_fam) VALUES ('F8', 'Famille TVA absente', '707000', 1, '8', 0);
INSERT INTO Fiches_Fam (code_fam, libell_fam, compt_fam, coef_fam, cdtva_fam, txtva_fam) VALUES ('F9', 'Famille compte absent', '707000', 1, '9', 5.5);
INSERT INTO Fiches_Art (art_code, art_design, art_fam, art_four, art_pvht, art_tva, art_pvttc, art_nbd, art_stocke, art_qte) VALUES ('006', 'Article famille F8', 'F8', '401001', 10, 8, 10, '2', 0, 0);
INSERT INTO Fiches_Art (art_code, art_design, art_fam, art_four, art_pvht, art_tva, art_pvttc, art_nbd, art_stocke, art_qte) VALUES ('007', 'Article famille F9', 'F9', '401001', 10, 9, 10.55, '2', 0, 0);
