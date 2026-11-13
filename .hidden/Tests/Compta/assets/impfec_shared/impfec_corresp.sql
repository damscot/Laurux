-- IMPFEC-T05 : tables de correspondance de l'import Ciel (créées ici avec le schéma de Utils.Ciel) :
-- comptes auxiliaires trop long / non numérique et journal VT -> 70
CREATE TABLE IF NOT EXISTS Ciel_Lrx (Cciel Char(15), Intitule Char(30), Clrx Char(10), PRIMARY KEY (Cciel)) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS Ciel_Lrx_Jo (Cciel Char(10), Intitule Char(30), Clrx Char(2), PRIMARY KEY (Cciel)) ENGINE = InnoDB;
INSERT INTO Ciel_Lrx (Cciel, Intitule, Clrx) VALUES ('123456', 'Aux trop long', '411002'), ('AB1', 'Aux non numerique', '411003');
INSERT INTO Ciel_Lrx_Jo (Cciel, Intitule, Clrx) VALUES ('VT', 'Ventes Ciel', '70');
