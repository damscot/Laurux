-- FClientcarte (phase 2, vague 5) : 3 cartes de fidélité, gestion des caisses activée par le blob conf.
UPDATE Fiches_Parametres SET conf = '[Soc01]\nCaisse=-1\n';
INSERT INTO Fiches_Carte (code, rs_soc, nom, pnm, adr1, adr2, cd_ptl, ville, email, tel_bur, tel_dom, tel_poste, pble, fx1, fx2, datec, datef, rem, promo, tp1, tp2, tg1, tg2, obs, cb, divers) VALUES
('000001', '', 'DURAND', 'Paul', '1 rue A', '', '44000', 'NANTES', '', '0240000001', '0240000002', '', '', '', '', '2018-01-10', '2038-01-10', 0, 0, 1.000, 10.000, 0.000, 0.000, '', '2999990000013', 0),
('000002', '', 'DUPUIS', 'Anne', '2 rue B', '', '35000', 'RENNES', '', '', '', '', '', '', '', '2018-02-10', '2038-02-10', 0, 0, 1.000, 20.000, 0.000, 0.000, '', '', 0),
('000003', '', 'MARTIN', 'Luc', '3 rue C', '', '75001', 'PARIS', '', '', '', '', '', '', '', '2018-03-10', '2038-03-10', 0, 0, 1.000, 0.000, 0.000, 0.000, '', '', -1);
