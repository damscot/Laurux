-- ETIGOND-T11 : article 006 dont le code TVA « 9 » est absent de Fiches_Tvaav.
INSERT INTO Fiches_Etiquettes (code, nblargeur, nbhauteur, largeur, hauteur, mrghaut, mrgauche, esplargeur, esphauteur, libelle, page) VALUES ('Z', 3, 8, 700, 370, 0, 0, 0, 0, 'Test', 'A4 Portrait');
INSERT INTO Fiches_Art (art_code, art_design, art_design2, art_fam, art_four, art_cbarre, art_pvht, art_tva, art_pvttc, art_nbd, art_stocke, art_qte, art_etiq) VALUES ('006', 'Article TVA inconnue', '', '01', '401001', '', 10, '9', 12, '2', 0, 0, 1);
