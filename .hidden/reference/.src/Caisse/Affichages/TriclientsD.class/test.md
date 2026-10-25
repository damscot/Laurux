# TriclientsD — Tests

> Source : `.src/Caisse/Affichages/TriclientsD.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

L'écran n'est ouvert par aucun chemin de l'application : aucun scénario ne peut l'exercer. Les tests
servent à prouver que sa suppression (TRICLIENTSD-A01) ne change rien.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRICLIENTSD-T01 | replay | Non-régression de la caisse sans TriclientsD | caisse (`./Laurux -p`) : vente simple, Ctrl+N (liste `Tricartes(-1)`), F8 (cartes), validation du ticket | dump et lignes `Exec_SQL` identiques entre clone non modifié et clone sans la classe | `tests/caisse_sans_triclientsd/` | à faire |
| TRICLIENTSD-T02 | replay | Purge `Fiches_Clid` inchangée | Archivages › `RazClientd`, date limite, validation | dump de `Fiches_Clid` identique (table seulement purgée) | `tests/raz_clientd/` | à faire |

## Détail des tests

- T01 reprend les scénarios TRICARTES-T01/T04 (même jeu `cartes_base`) ; il suffit de les rejouer sur
  le clone où le couple `.class`/`.form` a été supprimé.
- Le défaut `Caisse.Clicoded` (A02) n'est pas testable sans modifier le code pour ouvrir l'écran.
- Contrôle complémentaire hors tests : `gbc3 -agt` sans erreur après suppression et `grep -rni
  triclientsd .src` vide.
