# gridvi — Tests

> Source : `.src/Utils/gridvi.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`gridvi` est un composant d'écran sans accès en écriture à la base : le résultat observable est le
**contenu des cellules** (texte des 13 × 12 cellules de l'onglet, puis de la fenêtre de détail).
Les tests `replay` capturent ce contenu (dump texte `ligne;colonne;texte` par le harnais de replay)
au lieu d'un diff de tables. Seule la fonction de calcul de dates devient testable en `gbtest`
après la séparation traitement/GUI (GRIDVI-006).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| GRIDVI-T01 | replay | Type `A` (article) | Fiche article d'un article vendu sur plusieurs exercices (factures, BL, archives `M`) ; onglet Statistiques ; bouton « Calcul » | dump des 156 cellules et des en-têtes | `tests/stat_article/` | à faire |
| GRIDVI-T02 | replay | Type `M` (main d'œuvre) | Fiche main d'œuvre (`Movr`) avec lignes `M` facturées | dump de la grille | `tests/stat_main_oeuvre/` | à faire |
| GRIDVI-T03 | replay | Type `F`/`S` (famille) | Fiche famille (`Famille`) ; calcul en sous-familles (défaut) puis bouton « Familles » | deux dumps (S puis F) | `tests/stat_famille/` | à faire |
| GRIDVI-T04 | replay | Type `C` (client) tableau | Fiche client (`FClient`) ; calcul | dump de la grille | `tests/stat_client/` | à faire |
| GRIDVI-T05 | replay | Type `C` fenêtre de détail | même client ; sélection des lignes mars à juin puis de la ligne TOTAL seule | titre de la fenêtre + dump de la grille de détail (désignations, « INCONNU » compris) | `tests/stat_client_detail/` | à faire |
| GRIDVI-T06 | replay | Type `T` (tournée) | Écran `Ttourne`, tournée avec factures | dump (quantités sans décimale, `dec` non fixé) | `tests/stat_tournee/` | à faire |
| GRIDVI-T07 | replay | Bornes d'exercice | `Fiches_Parametres` : clôture au 31/12 puis au 30/06 ; période en cours dans/au-delà de l'année de clôture | en-têtes « AAAA C.A » / « AAAA/AAAA-1 C.A » et ordre des mois | `tests/stat_exercices/` | à faire |
| GRIDVI-T08 | replay | SQLite, type `S` | base `Laurux01.sqlite`, fiche famille | figer le comportement actuel (erreur `LOCATE`, anomalie A01) | `tests/stat_famille_sqlite/` | à faire |
| GRIDVI-T09 | gbtest | `BornesDetail` / `calcanne` (après GRIDVI-006) | matrice dteclec × dtepec × (ideb, ifin) | dates attendues | `tests/bornes_detail/` | à faire |
| GRIDVI-T10 | replay | Performance détail client | client avec ≥ 200 articles distincts | durée de référence (`gbx3 -p`) de `grdv_MouseUp` | `tests/perf_detail_client/` | à faire |

## Détail des tests

- **Valeurs attendues** : générées en rejouant chaque scénario dans le clone **Laurux non modifié**
  (`expected/` = dump des cellules). Rien n'est déduit de la lecture du code ; les anomalies (A01 à
  A04) sont figées telles quelles.
- **Données** : `Laurux01.sql` ne contient pas forcément d'historique sur 4 exercices. Un jeu dérivé
  (`gen_input.py`) insère des factures, factures archivées, BL et BL archivés répartis sur
  4 exercices pour un article, une main d'œuvre, une famille/sous-famille, un client et une tournée,
  avec des montants à virgule et des `NULL` dans `mrgmo_*`.
- **Locale** : les sommes passent par `Utils.totobs` (locale française) ; les replays tournent avec
  `LANG=fr_FR.UTF-8`.
- **Non testable automatiquement** : l'aspect visuel (couleurs alternées, curseur d'attente,
  icônes) ; vérification manuelle par capture d'écran si nécessaire.
- **Couverture visée** : toutes les branches de `$stype` dans `bouton_Click` (T01-T06), les deux
  formes d'en-tête (T07), `grdv_MouseUp` (T05).
