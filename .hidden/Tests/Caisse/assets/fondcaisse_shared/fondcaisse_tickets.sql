-- Jeu fondcaisse_tickets (agent 10, vague 9) : copie de cmenu_shared/caisse_base (caisses, vendeurs, client caisse) ;
-- caisse 1 connectée par le vendeur 1 (ouverte le 15/06/2018 08:00, fond 150,00, tkz = 0) ; tickets non validés de
-- la caisse 1 : T000001 (espèces N 80.00, rendu Q « 12,50 », ligne U 30.00 ignorée) ; à exclure : T000002 supprimé
-- (suppr = 1, N 100.00), T000003 validé (statut 1, N 50.00), T000004 de la caisse 2 (N 40.00).
UPDATE Fiches_Parametres SET conf = '[Soc01]\nCaisse=-1\nVendeurs=-1\n';
INSERT INTO Fiches_Caisses (code, intitule, dtefm, fndc, tkz, connecte, imp, typeimp, type, ecole, poste, depot, fndtotp, fndtotg, vdr_code) VALUES
('1', 'Caisse un', '2018-06-14 18:30:00', 150.00, 0, 0, 'Défaut80', '', 'Monoposte', 0, 'postetest', '', 0, 0, ''),
('2', 'Caisse deux', '2018-06-13 18:00:00', 80.00, 0, 0, 'Défaut80', '', 'Monoposte', 0, 'postetest', '', 0, 0, ''),
('3', 'Caisse ecole', '2018-06-12 18:00:00', 50.00, 0, 1, 'Défaut80', '', 'Monoposte', -1, 'postetest', '', 0, 0, '1'),
('10', 'Caisse dix', '2018-06-11 18:00:00', 10.00, 0, 0, 'Défaut80', '', 'Monoposte', 0, 'autreposte', '', 0, 0, '');
INSERT INTO Fiches_Vendeurs (code, nom, mdp, admin) VALUES ('1', 'ALICE', '200E1B4E', 0), ('12', 'BRUNO', '235D4A4C', 0), ('2', 'CHLOE', '225E4B4B', -1);
INSERT INTO Fiches_ClientCaisse (code, nom) VALUES ('411027', 'Client caisse');
UPDATE Fiches_Caisses SET connecte = 1, vdr_code = '1', dteov = '2018-06-15 08:00:00' WHERE code = '1';
INSERT INTO Fiches_EntTicketz (caisse, numero, date, statut, suppr, mttc) VALUES
('1', 'T000001', '2018-06-15 09:00:00', '0', 0, '67.50'),
('1', 'T000002', '2018-06-15 09:10:00', '0', 1, '100.00'),
('1', 'T000003', '2018-06-14 09:20:00', '1', 0, '50.00'),
('2', 'T000004', '2018-06-15 09:30:00', '0', 0, '40.00');
INSERT INTO Fiches_LigTicketz (numero, numlig, code, intitule, montant, type, date) VALUES
('T000001', '1', '', 'Especes', '80.00', 'N', '2018-06-15 09:00:00'),
('T000001', '2', '', 'Rendu', '12,50', 'Q', '2018-06-15 09:00:00'),
('T000001', '3', '', 'Article', '30.00', 'U', '2018-06-15 09:00:00'),
('T000002', '1', '', 'Especes', '100.00', 'N', '2018-06-15 09:10:00'),
('T000003', '1', '', 'Especes', '50.00', 'N', '2018-06-14 09:20:00'),
('T000004', '1', '', 'Especes', '40.00', 'N', '2018-06-15 09:30:00');
