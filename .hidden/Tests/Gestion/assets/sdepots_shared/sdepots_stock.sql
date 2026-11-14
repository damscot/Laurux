-- Sdepots/Edsdepots : stock du dépôt 02 et mouvements E/S de juin 2018.
INSERT INTO Fiches_StkDepots (coded, codea, qte) VALUES ('02','001',5), ('02','002',2), ('01','001',7);
INSERT INTO Fiches_Sdepots (mind, code, cart, date, type, qte, com) VALUES
(1,'02','001','2018-06-01','E','5','Entree test'),
(2,'02','002','2018-06-02','E','4','Entree test 2'),
(3,'02','002','2018-06-05','S','2','Sortie test'),
(4,'02','999','2018-06-06','S','1','Sortie article inconnu');
