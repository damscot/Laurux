-- Jeu cielimp_treso (CIELIMP-T09, vague 7) : copie de cielimp_shared/cielimp_nominal + compte 51210000 (8 caractères).
-- Jeu cielimp_nominal : tables de correspondance Ciel (structure de Cielimp.Btn_Click) avec les deux tiers du fichier.
CREATE TABLE Ciel_Lrx (Cciel Char(10), Intitule Char(30), Clrx Char(10), PRIMARY KEY (Cciel)) ENGINE = InnoDB;
CREATE TABLE Ciel_Lrx_Jo (Cciel Char(10), Intitule Char(30), Clrx Char(2), PRIMARY KEY (Cciel)) ENGINE = InnoDB;
INSERT INTO Ciel_Lrx (Cciel, Intitule, Clrx) VALUES ('411DUP', 'A Divers', '411001'), ('401MAR', 'B Divers', '401002');
INSERT INTO Fiches_Comptes (compte_cc, intitule_cc, type_cc, coll, cent_cc, comptr_cc, gen_tv, gen_ta, solde, soldep) VALUES (51210000, 'Banque 8', 'B', 0, 0, 1, 0, 0, 0, 0);
