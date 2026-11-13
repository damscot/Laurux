-- Jeu TarTypeCli : tarifs croisés (clients 411001/411002 sur l'article 001, type 01/02) ; article 002 avec code
-- équivalent EQ2 et article 003 avec référence centrale RC3 (tables de tarifs vides dans Laurux01.sql).
INSERT INTO Fiches_Tarcli (lind, ccli, cart, coef) VALUES (1, '411001', '001', 1.4000), (2, '411002', '001', 1.6000), (3, '411001', '002', 1.2000);
INSERT INTO Fiches_TarTypcli (lind, type, cart, coef) VALUES (1, '01', '001', 2.5000), (2, '02', '002', 3.0000);
UPDATE Fiches_Art SET art_cequ = 'EQ2' WHERE art_code = '002';
UPDATE Fiches_Art SET art_refcentrale = 'RC3' WHERE art_code = '003';
