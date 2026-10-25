# Visucmat — Tests

> Source : `.src/Gestion/option/Visucmat.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de consultation, sans écriture : le critère de comparaison est la suite des lignes
`Exec_SQL` (bloquante pour les reworks « sans changement SQL ») et le contenu affiché. L'écran
n'appelle pas `Utils.Observers(Me)` ; les saisies de dates ne seront rejouables qu'après
instrumentation dans les deux clones (VISUCMAT-A03) ou en test manuel guidé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VISUCMAT-T01 | replay | Ouverture | jeu `cmat_base` ; Caleditcmat → Visu | `Exec_SQL` : `arrete`, `LIMIT 1`, requête `TriGen` avec filtre ; date de début affichée | `tests/ouverture/` | à faire |
| VISUCMAT-T02 | replay | Filtre par période | saisir `dtdeb`/`dtfin` couvrant un mois du jeu | requête `dtmouv BETWEEN` et lignes `E`/`S` du mois seulement | `tests/filtre_periode/` | à faire |
| VISUCMAT-T03 | replay | Arrêté non renseigné (A01) | jeu `cmat_base` avec `arrete` NULL | figer la date de début et la requête produites | `tests/arrete_vide/` | à faire |
| VISUCMAT-T04 | replay | Table vide | option boissons activée, `Fiches_ligregie` vide | figer le comportement de `TriGen` sans colonnes | `tests/table_vide/` | à faire |

## Détail des tests

- **Jeu `cmat_base`** : voir [atribvignette](../atribvignette.class/test.md) (préparation commune
  de l'option boissons).
- **Valeurs attendues** : log `Exec_SQL` et capture du contenu de la grille dans le clone non
  modifié.
- **Cas non testables** : tri par clic sur les en-têtes (`TriGen`), couvert par les tests du lot
  Affichages.
