-- Jeu CcomptesTest : comptes 41xxxx et 512xxx supplémentaires (dont un intitulé accentué et une banque de trésorerie).
INSERT INTO `Fiches_Comptes` (`compte_cc`, `intitule_cc`, `type_cc`, `coll`, `coll_cc`, `cent_cc`, `comptr_cc`, `solde`, `soldep`, `cprincipal`, `lettrable`) VALUES
  (418100, 'Clients factures a etablir', 'G', 0, NULL, 0, 0, 0, 0, 0, NULL),
  (416100, 'Clients litigieux', 'G', 0, NULL, 0, 0, 12.5, 0, 0, NULL),
  (512100, 'Banque Populaire', 'B', 0, NULL, 0, 1, 1520.75, 0, 0, NULL),
  (512200, 'Réserve banque postale', 'B', 0, NULL, 0, 0, -30, 0, 0, NULL);
