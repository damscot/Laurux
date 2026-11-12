-- FMENU-T13 : réplication contrôlée (Con-ssh, Replique, Breplique) activée par les préférences globales,
-- appliquées après l'ouverture de la connexion (aucun tunnel monté au démarrage). Utils.ControlTunnel lance
-- « mysql … show slave status » (commande mal formée, pas de « Yes ») : la réplication est toujours vue en échec.
UPDATE Fiches_Parametres SET conf = '[dbase]\nCon-ssh=1\n\n[Soc01]\nReplique=-1\nBreplique=-1\n';
