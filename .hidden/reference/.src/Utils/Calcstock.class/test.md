# Calcstock — Tests

> Source : `.src/Utils/Calcstock.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran : tests **replay** sur MariaDB (jeu de mouvements de CSTOCK) avec dump normalisé de
`Fiches_Art` et diff des lignes `Exec_SQL`. Le calcul lui-même est couvert par les tests de
[`Cstock`](../Cstock.module/test.md).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CALCSTOCK-T01 | replay | Un produit | Menu → Recalcul des stocks ; `Cbx`, code via `Button4`/TriArticles, « Lancer » | `art_qte` de l'article recalculé | `tests/un_produit/` | implémenté (`.hidden/Tests/Utils/assets/calcstock_un_produit/`, code saisi dans TextBox1 au lieu de TriArticles) |
| CALCSTOCK-T02 | replay | Casiers | `Cbx2`, bornes `A01`–`B99` ; puis une borne vide | dump ; figer « bornes » + « terminé » | `tests/casiers/` | implémenté (`.hidden/Tests/Utils/assets/calcstock_casiers/`) |
| CALCSTOCK-T03 | replay | Tous les produits | `Cbx3` | dump complet de `Fiches_Art` | `tests/tous/` | implémenté (`.hidden/Tests/Utils/assets/calcstock_tous/`) |
| CALCSTOCK-T04 | replay | RAZ non stockés | `Cbx4` | `art_qte = 0` pour `art_stocke = 0` | `tests/raz_non_stockes/` | implémenté (`.hidden/Tests/Utils/assets/calcstock_raz_non_stockes/`) |
| CALCSTOCK-T05 | replay | Caisse connectée | `Fiches_Caisses.connecte = 1` | message, aucune écriture | `tests/caisse_connectee/` | xfail : contrôle inopérant sur MySQL (`connecte` tinyint(1) lu comme Booléen, `= "1"` toujours faux) : recalcul exécuté puis « Traitement terminé » (`.hidden/Tests/Utils/assets/calcstock_caisse_connectee/`) |
| CALCSTOCK-T06 | replay | Ticket Z non tiré | `Fiches_EntTickets1` non vide | message, aucune écriture | `tests/ticket_z/` | implémenté (`.hidden/Tests/Utils/assets/calcstock_ticket_z/`) |
| CALCSTOCK-T07 | replay | Moulinage non fait | `Fiches_EntTicketz` non vide | message, aucune écriture | `tests/moulinage/` | implémenté (`.hidden/Tests/Utils/assets/calcstock_moulinage/`) |
| CALCSTOCK-T08 | replay | Produit vide | `Cbx`, `TextBox1` vide, « Lancer » | aucune écriture, « Traitement terminé » | `tests/produit_vide/` | implémenté (`.hidden/Tests/Utils/assets/calcstock_produit_vide/`) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** (`./Laurux -l --logfile …`)
  sur la base restaurée, puis rejouées sur `Laurux_reworked` ; diff vide exigé.
- **Données** : `Laurux01.sql` + jeu dérivé de `Cstock` (`tests/*/data.sql`) ; T05-T07 ajoutent la
  ligne bloquante.
- **Non testable automatiquement** : son, forme du curseur.
- **Scénarios synthétisés (phase 2)** : `.hidden/Tests/Utils/assets/<nom>/` (`scenario.log`, `meta.json`, fichiers d'entrée éventuels, chemins relatifs à la racine du clone) ; jeux dans `.src/Tests/Framework/datasets/`. Attendus produits par `runner replay Utils/<nom> --expected` (rejeu dans ref), comparés par `runner compare`.
  Jeux : `calcstock_mvt` (T01-T04, T08), `calcstock_caisse_connectee` (T05), `calcstock_ticket_z` (T06, crée `Fiches_EntTickets1`), `calcstock_moulinage` (T07).
- **Constat du rejeu (T05, candidat anomalie)** : sur MySQL, `Fiches_Caisses.connecte` (tinyint(1)) est lu comme
  Booléen par gb.db ; `rResult!connecte = "1"` est toujours faux, la pré-condition « caisse connectée » ne bloque
  jamais le traitement (même défaut probable dans `Fcaisses.class` : `rResult!connecte = 1`).
