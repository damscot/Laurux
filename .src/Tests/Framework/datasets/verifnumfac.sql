-- Jeu de données VERIFNUMFAC-T02 : numéros de facture en historique (000001, 000002, 000004), en BL
-- facturé (000005, 000008) et en matériel (HistoFacM 000003, BlM 000009).
INSERT INTO Fiches_HistoFac (numfac, cdclifac, datefac) VALUES
  ('000001', '411001', '2024-01-10 00:00:00'), ('000002', '411001', '2024-01-11 00:00:00'),
  ('000004', '411002', '2024-01-12 00:00:00');
INSERT INTO Fiches_Bl (numbl, type, cdclibl, numfac) VALUES ('B00010', 'B', '411001', '000005'), ('B00011', 'B', '411002', '000008');
INSERT INTO Fiches_HistoFacM (numfac) VALUES ('000003');
INSERT INTO Fiches_BlM (numbl, numfac) VALUES ('M00001', '000009');
