-- Jeu de données LAURUXCONF-T10 (mode préfixe) : bases pre_Laurux01 et pre_Laurux02 (vides, seuls les noms sont lus
-- par LauruxConf._new) ; les bases Laurux02 à Laurux09 laissées par d'autres scénarios sont supprimées.
DROP DATABASE IF EXISTS Laurux02;
DROP DATABASE IF EXISTS Laurux03;
DROP DATABASE IF EXISTS Laurux04;
DROP DATABASE IF EXISTS Laurux05;
DROP DATABASE IF EXISTS Laurux06;
DROP DATABASE IF EXISTS Laurux07;
DROP DATABASE IF EXISTS Laurux08;
DROP DATABASE IF EXISTS Laurux09;
DROP DATABASE IF EXISTS pre_Laurux01;
DROP DATABASE IF EXISTS pre_Laurux02;
CREATE DATABASE pre_Laurux01 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE pre_Laurux02 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
