-- Fcaisses (agent 6, vague 6) : gestion des caisses activée (blob conf), 2 caisses au poste fixe « postetest »
-- (caisse 1 connectée, caisse 2 Z tirée) et un dépôt au code long DEP003.
UPDATE Fiches_Parametres SET conf = '[Soc01]\nCaisse=-1\n';
INSERT INTO Fiches_Caisses (code, intitule, tkz, connecte, imp, typeimp, type, ecole, poste, depot, fndtotp, fndtotg) VALUES
('1', 'Caisse un', 1, 1, 'Défaut80', '', 'Monoposte', 0, 'postetest', '', 0, 0),
('2', 'Caisse deux', 1, 0, 'Défaut80', '', 'Réseau', 0, 'postetest', '', 0, 0);
INSERT INTO Fiches_Depots (code, libelle) VALUES ('DEP003', 'Depot long');
