-- Jeu de données LDATE-T12 : exercices décalés clôturés au 30/06 ; le plus ancien (dteclec4, du 01/01/2020
-- au 30/06/2021) dure 18 mois. Appliqué après Laurux01.sql (une seule ligne dans Fiches_Parametres).
UPDATE Fiches_Parametres SET dteclec = '2025-06-30', dteclec1 = '2024-06-30', dteclec2 = '2023-06-30',
  dteclec3 = '2022-06-30', dteclec4 = '2021-06-30', dteclec5 = '2019-12-31';
