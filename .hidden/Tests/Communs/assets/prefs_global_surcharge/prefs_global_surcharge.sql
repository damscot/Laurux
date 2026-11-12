-- PREFS-T06 : préférences globales appliquées au démarrage (Prefs.ApplyGlobal dans Fmenu.Form_Open) :
-- 5 clés différentes de Laurux-test.conf (Exp, Tva550, Taxe, Faca, Taches) et une clé absente du local.
-- Faca et Taches ont un effet observable dans le SQL du démarrage (Abonnement, RecupTaches).
UPDATE Fiches_Parametres SET conf = '[Soc01]\nExp=0\nTva550=-1\nTaxe="TGC"\nFaca=-1\nTaches=-1\nNouvelle="G"\n';
