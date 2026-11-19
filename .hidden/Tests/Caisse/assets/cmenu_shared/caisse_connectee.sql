-- Jeu caisse_connectee (agent 10, vague 9) : caisse_base (voir caisse_base.sql) avec la caisse 1 connectée par le
-- vendeur 1 (connecte = 1, vdr_code = '1') ; le verrou ~/Caisse1.lock est déposé par les « entrees » du scénario.
UPDATE Fiches_Parametres SET conf = '[Soc01]\nCaisse=-1\nVendeurs=-1\n';
INSERT INTO Fiches_Caisses (code, intitule, dtefm, fndc, tkz, connecte, imp, typeimp, type, ecole, poste, depot, fndtotp, fndtotg, vdr_code) VALUES
('1', 'Caisse un', '2018-06-14 18:30:00', 150.00, 0, 0, 'Défaut80', '', 'Monoposte', 0, 'postetest', '', 0, 0, ''),
('2', 'Caisse deux', '2018-06-13 18:00:00', 80.00, 0, 0, 'Défaut80', '', 'Monoposte', 0, 'postetest', '', 0, 0, ''),
('3', 'Caisse ecole', '2018-06-12 18:00:00', 50.00, 0, 1, 'Défaut80', '', 'Monoposte', -1, 'postetest', '', 0, 0, '1'),
('10', 'Caisse dix', '2018-06-11 18:00:00', 10.00, 0, 0, 'Défaut80', '', 'Monoposte', 0, 'autreposte', '', 0, 0, '');
INSERT INTO Fiches_Vendeurs (code, nom, mdp, admin) VALUES ('1', 'ALICE', '200E1B4E', 0), ('12', 'BRUNO', '235D4A4C', 0), ('2', 'CHLOE', '225E4B4B', -1);
INSERT INTO Fiches_ClientCaisse (code, nom) VALUES ('411027', 'Client caisse');
UPDATE Fiches_Caisses SET connecte = 1, vdr_code = '1' WHERE code = '1';
