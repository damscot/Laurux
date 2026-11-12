-- Jeu de données FSOC-T11 (mode préfixe) : bases pre_Laurux01 et pre_Laurux02 contenant chacune la table
-- Fiches_Societes (structure de Laurux01) avec une ligne (cd_sc 01 et 02, intitulés distincts). Les autres bases
-- du serveur sont supprimées par le framework avant chaque test.
CREATE DATABASE pre_Laurux01 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE pre_Laurux02 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE TABLE pre_Laurux01.`Fiches_Societes` LIKE Laurux01.`Fiches_Societes`;
INSERT INTO pre_Laurux01.`Fiches_Societes` (cd_sc, int_sc) VALUES ('01', 'PREMIERE PREFIXE');
CREATE TABLE pre_Laurux02.`Fiches_Societes` LIKE Laurux01.`Fiches_Societes`;
INSERT INTO pre_Laurux02.`Fiches_Societes` (cd_sc, int_sc) VALUES ('02', 'SECONDE PREFIXE');
