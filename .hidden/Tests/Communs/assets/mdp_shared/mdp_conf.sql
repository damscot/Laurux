-- MDP : préférences globales (blob conf de Fiches_Parametres, appliqué aux préférences locales par Fmenu)
-- Admin/AdminG activés, mot de passe « laurux » chiffré par hexdblKey.Crypt("en", "laurux", "Laurux").
UPDATE Fiches_Parametres SET conf = '[Soc01]\nAdmin=1\nMdpPrefs="2D0D0D0D0D0D"\nAdminG=1\nMdpPrefsG="2D0D0D0D0D0D"\n';
