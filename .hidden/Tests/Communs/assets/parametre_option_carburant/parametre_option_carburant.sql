-- PARAMETRE-T09 : option carburant (P). Table Art_Tipp et colonne Fiches_Societes.tipp créées comme par
-- modfichier.fichiercarbu, deux articles associés, /Soc01/pp activée par les préférences globales
-- (Fiches_Parametres.conf, appliquées au démarrage par Prefs.ApplyGlobal).
CREATE TABLE Art_Tipp (code char(15), ticpe integer, PRIMARY KEY(code)) ENGINE = InnoDB;
INSERT INTO Art_Tipp (code, ticpe) VALUES ('001', 0), ('002', 1);
ALTER TABLE Fiches_Societes ADD tipp char(2);
UPDATE Fiches_Parametres SET conf = '[Soc01]\npp=True\n';
