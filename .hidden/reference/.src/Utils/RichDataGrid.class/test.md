# RichDataGrid — Tests

> Source : `.src/Utils/RichDataGrid.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Composant d'affichage lié à la base : tests `replay` sur l'écran `Remisec` (seul utilisateur), avec
dump des cellules affichées, plus un `gbtest` sur la construction de la requête après extraction.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RICHDATAGRID-T01 | replay | Affichage initial | `Fiches_RemTypec` avec 5 lignes ; ouverture de `Remisec` | en-têtes, largeurs, dump des cellules (format de la colonne « Remise ») | `tests/affichage/` | à faire : requête de la grille (db.Exec de gb.db, hors Utils.db) non journalisée et cellules non capturées ; scénario rejoué (ouverture sans erreur, fumée) |
| RICHDATAGRID-T02 | replay | Tri | clic sur l'en-tête « Type client » ×2 | ordre des lignes ASC puis DESC | `tests/tri/` | à faire : clic sur en-tête de colonne (ColumnClick) non enregistré ni rejoué par ReplayObserver |
| RICHDATAGRID-T03 | replay | Recherche | clic droit colonne 2 ; saisie « A », « AB », Échap ; saisie d'une apostrophe | lignes filtrées ; apostrophe : grille vide sans message (A01 figée) | `tests/recherche/` | à faire : clic droit (MouseUp) et saisie dans la zone de recherche dynamique non rejoués |
| RICHDATAGRID-T04 | replay | Sélection | clic sur une ligne puis double-clic | `Value` = `lind` ; zones de `Remisec` remplies | `tests/selection/` | à faire : clic de grille sans handler Tabtypec_Click dans Remisec (replay_missing, REPLAYOBSERVER-A06) |
| RICHDATAGRID-T05 | replay | Suppression + rafraîchissement | suppression d'une remise dans `Remisec` | diff `Fiches_RemTypec` et dump de la grille | `tests/suppression/` | à faire : suppression conditionnée par la sélection d'une ligne de grille (même limite que T04) |
| RICHDATAGRID-T06 | gbtest | `Requete` (après RICHDATAGRID-004) | table, filtre, recherche, ordre | chaîne SQL de référence | `tests/requete/` | à faire : après extraction RICHDATAGRID-004 (Requete non publique) |
| RICHDATAGRID-T07 | replay | SQLite | `Laurux01.sqlite`, mêmes scénarios T01-T03 | dump (connexion `DB.Current`, à confirmer) | `tests/sqlite/` | à faire : rejeu sur base SQLite non pris en charge par le runner (base MariaDB seule) |

## Détail des tests

- **Valeurs attendues** : générées dans le clone Laurux non modifié ; jeu dérivé de
  `Laurux01.sql` avec des remises décimales (`0,5`, `12,345`) pour figer l'effet du format
  `"0.000"` (CFORMAT-A01).
- **Non testable** : les formats conditionnels (`CondFormats`) ne sont utilisés par aucun écran ;
  l'anomalie A03 n'est observable que par un test dédié qui fournirait une condition (gbtest avec
  GUI, à prévoir si la correction est validée).
- **Implémentation (phase 2)** : T01 → `.hidden/Tests/Utils/assets/richdatagrid_affichage/` (jeu `richdatagrid_remises.sql`), valeurs attendues à produire.
