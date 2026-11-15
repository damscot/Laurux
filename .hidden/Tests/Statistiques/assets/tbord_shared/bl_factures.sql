-- TBord (phase 2, vague 7) : 2 factures historisées (septembre et octobre 2017) et des BL de type F, imp 0 et 1,
-- dans et hors de la période 01.07.2017-15.06.2018 ; novembre 2017 sans facture historisée (BL seul).
INSERT INTO Fiches_HistoFac (numfac, datefac, totfac, marge_art, marge_mo) VALUES
('F000001', '2017-09-10 00:00:00', 1000.00, 200.00, 100.00),
('F000002', '2017-10-05 00:00:00', 500.00, 50.00, 25.00);
INSERT INTO Fiches_Bl (numbl, type, dtefac, imp, totalht, remmobl, remartbl, marge_art, marge_mo) VALUES
('B00001', 'F', '2017-09-20 00:00:00', 1, 300, 0, 10, 60, 30),
('B00002', 'F', '2017-09-21 00:00:00', 0, 999, 0, 0, 99, 9),
('B00003', 'F', '2017-11-12 00:00:00', 1, 400, 5, 0, 80, 40),
('B00004', 'F', '2017-11-13 00:00:00', 1, 100, 0, 0, 20, 10),
('B00005', 'F', '2017-05-02 00:00:00', 1, 777, 0, 0, 70, 7),
('B00006', 'F', '2018-07-02 00:00:00', 1, 888, 0, 0, 80, 8);
