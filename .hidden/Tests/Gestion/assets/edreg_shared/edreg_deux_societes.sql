-- EDREG-T04 (agent 6, vague 5) : seconde société dans Fiches_Societes (la société courante du test reste 01 ;
-- EdReg lit la première ligne renvoyée par SELECT * FROM Fiches_Societes, sans filtre).
UPDATE Fiches_Societes SET type_sc = 'SARL', int_sc = 'Premiere' WHERE cd_sc = '01';
INSERT INTO Fiches_Societes (cd_sc, type_sc, int_sc) VALUES ('02', 'SA', 'Seconde');
