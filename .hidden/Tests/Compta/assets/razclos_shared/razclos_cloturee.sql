-- Jeu de données RazClos (RAZCLOS-T01, T02), appliqué après Laurux01.sql.
-- Écriture 10 (journal 70) à 3 lignes, clôturée, clés « control » factices (re-scellées par RazClos) ;
-- écriture 11 (journal 60) à 2 lignes, clôturée, non concernée.
INSERT INTO Fiches_Mvt (jour, numero, compte, collectif, intitule, dte, numdoc, libelle, montantd, montantc, validee, cloturee, lind, control) VALUES
 ('70', 10, '411001', 1, 'Client Un', '2018-02-05 00:00:00', 'F0010', 'Facture dix', 120.00, 0.00, 1, 1, 1, 'CLE-FACTICE-1'),
 ('70', 10, '706000', 0, 'Ventes', '2018-02-05 00:00:00', 'F0010', 'Facture dix', 0.00, 100.00, 1, 1, 2, 'CLE-FACTICE-2'),
 ('70', 10, '445710', 0, 'TVA collectee', '2018-02-05 00:00:00', 'F0010', 'Facture dix', 0.00, 20.00, 1, 1, 3, 'CLE-FACTICE-3'),
 ('60', 11, '401001', 1, 'Fournisseur', '2018-02-06 00:00:00', 'A0011', 'Achat onze', 0.00, 80.00, 1, 1, 4, 'CLE-FACTICE-4'),
 ('60', 11, '607000', 0, 'Achats', '2018-02-06 00:00:00', 'A0011', 'Achat onze', 80.00, 0.00, 1, 1, 5, 'CLE-FACTICE-5');
