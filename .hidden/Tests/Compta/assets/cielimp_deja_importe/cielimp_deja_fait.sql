-- Jeu cielimp_deja_fait : import Ciel déjà effectué (colonne imp_ciel ajoutée comme par Utils.Ciel, valeur "1").
ALTER TABLE Fiches_Parametres ADD (imp_ciel char(1));
UPDATE Fiches_Parametres SET imp_ciel = '1';
