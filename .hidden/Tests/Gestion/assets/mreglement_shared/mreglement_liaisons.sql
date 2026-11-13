-- Jeu de données MREGLEMENT-T03/T07 : liaisons caisse posées sur deux modes de règlement
-- (caisse = 0 partout dans Laurux01.sql) : 05 Chèque lié à « Chèque » (4), 10 Carte lié à « Carte » (3).
UPDATE Fiches_Reglements SET caisse = 4 WHERE code = '05';
UPDATE Fiches_Reglements SET caisse = 3 WHERE code = '10';
