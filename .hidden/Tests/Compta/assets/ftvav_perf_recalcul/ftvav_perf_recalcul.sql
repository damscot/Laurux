-- FTVAV-T07 : performance du recalcul. 500 BL non facturés (910001 à 910500) de 10 lignes au code TVA 3,
-- soit 5 000 lignes : 4 lignes article TP05 (arrondi 0,05), 4 lignes article TP50 (arrondi 0,50) et 2 lignes
-- main-d'oeuvre 04 (M). Montants HT variables (1,00 à 50,99) pour exercer les branches de l'arrondi.
-- Lignes générées par la table de séquences de MariaDB (moteur Sequence : seq_1_to_N).
INSERT INTO Fiches_Art (art_code, art_design, art_stocke, art_tva, art_pvht, art_pvttc, art_cdarr, art_nbd) VALUES
 ('TP05', 'Perf arrondi 0,05', '0', '3', 10.37, 12.44, '0,05', '2'),
 ('TP50', 'Perf arrondi 0,50', '0', '3', 8.30, 9.96, '0,50', '2');
INSERT INTO Fiches_Bl (numbl, type, imp, datebl)
 SELECT CAST(910000 + b.seq AS CHAR), 'B', 0, '2026-01-10 10:00:00' FROM seq_1_to_500 b;
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, netht_ligbl, tx_ligbl, nettc_ligbl, typel_ligbl)
 SELECT CAST(910000 + b.seq AS CHAR), CAST(l.seq AS CHAR),
        CASE WHEN l.seq <= 4 THEN 'TP05' WHEN l.seq <= 8 THEN 'TP50' ELSE '04' END,
        CAST(1 + MOD(b.seq * 7 + l.seq * 13, 50) + MOD(b.seq + l.seq, 100) / 100 AS DECIMAL(10,2)),
        '3', '0', CASE WHEN l.seq <= 8 THEN 'A' ELSE 'M' END
 FROM seq_1_to_500 b CROSS JOIN seq_1_to_10 l;
