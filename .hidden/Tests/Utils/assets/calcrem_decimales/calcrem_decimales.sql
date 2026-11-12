-- Jeu de données CALCREM-T02 : remises 0,1 + 0,2 (somme Float non représentable) sur FD1 ; FD2 dernière
-- facture (non recalculée, CALCREM-A01).
INSERT INTO Fiches_HistoFac (numfac, cdclifac, datefac, remmofac, remartfac) VALUES
 ('FD1', '411001', '2025-03-01 10:00:00', '999', '999'),
 ('FD2', '411001', '2025-03-02 10:00:00', '999', '999');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, typel_ligfac, brut_ligfac, netht_ligfac) VALUES
 ('FD1', '1', '001', 'A', '1,1', '1'),
 ('FD1', '2', '002', 'A', '0,3', '0,1'),
 ('FD1', '3', 'MO', 'M', '0,1', '0'),
 ('FD1', '4', 'MO', 'M', '0,2', '0'),
 ('FD2', '1', '001', 'A', '1', '1');
