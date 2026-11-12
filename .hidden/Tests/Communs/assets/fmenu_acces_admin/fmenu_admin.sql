-- FMENU-T12 : gestion de l'administrateur activée par les préférences globales (/Soc01/Admin) avec le mot de
-- passe « Secret1 » chiffré par hexdblKey (valeur produite par PrefsTest.T04MotsDePasse).
UPDATE Fiches_Parametres SET conf = '[Soc01]\nAdmin=-1\nMdpPrefs="12091B0D1D0170"\n';
