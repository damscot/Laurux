-- Jeu cielimp_nominal : tables de correspondance Ciel (structure de Cielimp.Btn_Click) avec les deux tiers du fichier.
CREATE TABLE Ciel_Lrx (Cciel Char(10), Intitule Char(30), Clrx Char(10), PRIMARY KEY (Cciel)) ENGINE = InnoDB;
CREATE TABLE Ciel_Lrx_Jo (Cciel Char(10), Intitule Char(30), Clrx Char(2), PRIMARY KEY (Cciel)) ENGINE = InnoDB;
INSERT INTO Ciel_Lrx (Cciel, Intitule, Clrx) VALUES ('411DUP', 'A Divers', '411001'), ('401MAR', 'B Divers', '401002');
