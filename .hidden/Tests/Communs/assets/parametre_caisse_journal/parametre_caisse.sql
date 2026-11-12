-- PARAMETRE-T10 : caisse active (/Soc01/Caisse = True par les préférences globales, Fiches_Parametres.conf,
-- appliquées au démarrage par Prefs.ApplyGlobal).
UPDATE Fiches_Parametres SET conf = '[Soc01]\nCaisse=True\n';
