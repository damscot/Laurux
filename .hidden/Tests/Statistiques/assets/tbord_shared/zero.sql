-- TBord (phase 2, vague 7) : une facture historisée à totfac = 0 seule en mars 2018, puis un BL F facturé à 0 le même mois.
INSERT INTO Fiches_HistoFac (numfac, datefac, totfac, marge_art, marge_mo) VALUES
('F000009', '2018-03-10 00:00:00', 0.00, 0.00, 0.00);
INSERT INTO Fiches_Bl (numbl, type, dtefac, imp, totalht, remmobl, remartbl, marge_art, marge_mo) VALUES
('B00009', 'F', '2018-03-15 00:00:00', 1, 0, 0, 0, 0, 0);
