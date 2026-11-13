-- Edregulprdc : fabrications 1 et 2 (produit 003, composant 001 commun) dans la période par défaut
-- (15.06.2014 - 15.06.2018), fabrication 3 après la période utilisant aussi le composant 001 (A01).
INSERT INTO Fiches_Mvtexpdc (mind, code, daterecpt, qtep, qtem, com, type) VALUES
(1,'003','2018-05-02 00:00:00','1','0','Fabrication 1','P'),
(1,'001','2018-05-02 00:00:00','0','2','Fabrication 1','C'),
(1,'002','2018-05-02 00:00:00','0','1','Fabrication 1','C'),
(2,'003','2018-06-01 00:00:00','1','0','Fabrication 2','P'),
(2,'001','2018-06-01 00:00:00','0','2','Fabrication 2','C'),
(3,'003','2018-06-20 00:00:00','1','0','Fabrication 3','P'),
(3,'001','2018-06-20 00:00:00','0','2','Fabrication 3','C');
