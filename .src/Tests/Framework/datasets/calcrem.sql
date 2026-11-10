-- Jeu de données CALCREM-T01 : 3 factures de l'historique (remises à 999 avant recalcul) ; lignes M (main
-- d'œuvre), A (article) et texte. FA3, dernière facture, n'est pas recalculée (CALCREM-A01).
INSERT INTO Fiches_HistoFac (numfac, cdclifac, datefac, remmofac, remartfac) VALUES
 ('FA1', '411001', '2025-03-01 10:00:00', '999', '999'),
 ('FA2', '411001', '2025-03-02 10:00:00', '999', '999'),
 ('FA3', '411001', '2025-03-03 10:00:00', '999', '999');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, typel_ligfac, brut_ligfac, netht_ligfac) VALUES
 ('FA1', '1', 'MO', 'M', '100', '90'),
 ('FA1', '2', '001', 'A', '50,50', '45,25'),
 ('FA1', '3', '', 'T', '7', '1'),
 ('FA2', '1', '002', 'A', '200', '150'),
 ('FA2', '2', '003', 'A', '10', '10'),
 ('FA3', '1', 'MO', 'M', '30', '20');
