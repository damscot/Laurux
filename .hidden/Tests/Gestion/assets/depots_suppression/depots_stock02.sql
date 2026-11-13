-- Depots : stock et mouvements du dépôt 02 (et une ligne du dépôt 01 conservée).
INSERT INTO Fiches_StkDepots (coded, codea, qte) VALUES ('02','001',5), ('02','002',3), ('01','001',7);
INSERT INTO Fiches_Sdepots (mind, code, cart, date, type, qte, com) VALUES
(1,'02','001','2018-06-01','S','2','Sortie test'),
(2,'01','002','2018-06-02','S','1','Sortie depot 01');
