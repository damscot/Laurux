-- AFacture : BL 900001 en cours (article 001, commentaire sur 3 lignes, article supprimé ZZZ, montants entiers),
-- BL 900002 seulement dans l'archive Fiches_LigblM, BL 900003 en cours avec montants décimaux « 12.50 » et « 7,25 ».
INSERT INTO Fiches_Ligbl (num_ligbl,numlig_ligbl,code_ligbl,libel_ligbl,qte_ligbl,brut_ligbl,rem_ligbl,netht_ligbl,typel_ligbl,com_ligbl) VALUES
('900001','1','001','Produit 2.10','2.5','10','0','25','A',NULL),
('900001','2',NULL,NULL,NULL,NULL,NULL,NULL,'C','Commentaire ligne 1\nCommentaire ligne 2\nCommentaire ligne 3'),
('900001','3','ZZZ','Article supprime','1','15','0','15','A',NULL),
('900003','1','002','Produit 7.00','1','12.50','0','12.50','A',NULL),
('900003','2','002','Produit 7.00','1','7,25','0','7,25','A',NULL);
INSERT INTO Fiches_LigblM (num_ligbl,numlig_ligbl,code_ligbl,libel_ligbl,qte_ligbl,brut_ligbl,rem_ligbl,netht_ligbl,typel_ligbl,com_ligbl) VALUES
('900002','1','003','produit 20.00','4','20','10','72','A',NULL);
