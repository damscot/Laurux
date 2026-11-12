-- PARAMETRE-T08 : option boisson (B). Colonnes ajoutées par modfichier.fichierboisson sur Fiches_Parametres
-- et Fiches_Societes, et préférence /Soc01/bois activée par les préférences globales (Fiches_Parametres.conf,
-- appliquées au démarrage par Prefs.ApplyGlobal : la configuration de test ne peut pas être surchargée).
ALTER TABLE Fiches_Parametres ADD conscli char(8);
ALTER TABLE Fiches_Parametres ADD consfou char(8);
ALTER TABLE Fiches_Parametres ADD nvign char(25);
ALTER TABLE Fiches_Parametres ADD css char(8);
ALTER TABLE Fiches_Parametres ADD tvass char(2);
ALTER TABLE Fiches_Parametres ADD arrete char(7);
ALTER TABLE Fiches_Societes ADD ident varchar(20);
ALTER TABLE Fiches_Societes ADD caution varchar(25);
UPDATE Fiches_Parametres SET conf = '[Soc01]\nbois=True\n';
