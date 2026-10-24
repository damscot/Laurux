# Calcstock — Tests

> Source : `.src/Utils/Calcstock.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran : tests **replay** sur MariaDB (jeu de mouvements de CSTOCK) avec dump normalisé de
`Fiches_Art` et diff des lignes `Exec_SQL`. Le calcul lui-même est couvert par les tests de
[`Cstock`](../Cstock.module/test.md).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CALCSTOCK-T01 | replay | Un produit | Menu → Recalcul des stocks ; `Cbx`, code via `Button4`/TriArticles, « Lancer » | `art_qte` de l'article recalculé | `tests/un_produit/` | à faire |
| CALCSTOCK-T02 | replay | Casiers | `Cbx2`, bornes `A01`–`B99` ; puis une borne vide | dump ; figer « bornes » + « terminé » | `tests/casiers/` | à faire |
| CALCSTOCK-T03 | replay | Tous les produits | `Cbx3` | dump complet de `Fiches_Art` | `tests/tous/` | à faire |
| CALCSTOCK-T04 | replay | RAZ non stockés | `Cbx4` | `art_qte = 0` pour `art_stocke = 0` | `tests/raz_non_stockes/` | à faire |
| CALCSTOCK-T05 | replay | Caisse connectée | `Fiches_Caisses.connecte = 1` | message, aucune écriture | `tests/caisse_connectee/` | à faire |
| CALCSTOCK-T06 | replay | Ticket Z non tiré | `Fiches_EntTickets1` non vide | message, aucune écriture | `tests/ticket_z/` | à faire |
| CALCSTOCK-T07 | replay | Moulinage non fait | `Fiches_EntTicketz` non vide | message, aucune écriture | `tests/moulinage/` | à faire |
| CALCSTOCK-T08 | replay | Produit vide | `Cbx`, `TextBox1` vide, « Lancer » | aucune écriture, « Traitement terminé » | `tests/produit_vide/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** (`./Laurux -l --logfile …`)
  sur la base restaurée, puis rejouées sur `Laurux_reworked` ; diff vide exigé.
- **Données** : `Laurux01.sql` + jeu dérivé de `Cstock` (`tests/*/data.sql`) ; T05-T07 ajoutent la
  ligne bloquante.
- **Non testable automatiquement** : son, forme du curseur.
