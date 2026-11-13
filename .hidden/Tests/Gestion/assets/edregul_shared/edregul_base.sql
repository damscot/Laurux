-- Edregul : régularisations de stock dans la période par défaut (15.06.2014 - 15.06.2018) et après (20/06/2018) ;
-- l'article 001 a des mouvements des deux côtés (A01), ZZZ n'existe pas dans Fiches_Art.
INSERT INTO Fiches_Mvtexp (code, daterecpt, qtep, qtem, com) VALUES
('001','2018-01-10 00:00:00','5','0','Inventaire janvier'),
('002','2018-03-05 00:00:00','0','2','Casse'),
('ZZZ','2018-04-01 00:00:00','1','0','Article supprime'),
('001','2018-06-20 00:00:00','0','1','Hors periode meme article'),
('003','2018-06-20 00:00:00','3','0','Hors periode');
