-- Jeu AnalytiqueTest : postes analytiques, ventilations par défaut et une écriture déjà ventilée.
INSERT INTO `Fiches_Postes` (`code`, `intitulep`) VALUES ('01', 'Atelier'), ('02', 'Bureau'), ('03', 'Commercial');
-- 606100 ventilé 60/40, 613200 ventilé 50/50, 625100 ventilé 33/33/34
INSERT INTO `Fiches_Analytiques` (`code`, `compte`, `pourcent`) VALUES
  ('01', '606100', 60), ('02', '606100', 40),
  ('01', '613200', 50), ('03', '613200', 50),
  ('01', '625100', 33), ('02', '625100', 33), ('03', '625100', 34);
-- écriture 900002 déjà ventilée sur 606100 (70/30)
INSERT INTO `Fiches_MvtA` (`numero`, `compte`, `intitule`, `dte`, `numdoc`, `libelle`, `pourcent`, `montantd`, `montantc`, `jour`, `poste`, `validee`) VALUES
  (900002, '606100', 'Achats fournitures', '2018-06-15 00:00:00', 'F002', 'Facture 2', '70.00', 140.00, 0.00, 'AC', '01', 0),
  (900002, '606100', 'Achats fournitures', '2018-06-15 00:00:00', 'F002', 'Facture 2', '30.00', 60.00, 0.00, 'AC', '02', 0);
