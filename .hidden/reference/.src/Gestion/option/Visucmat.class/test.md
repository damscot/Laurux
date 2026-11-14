# Visucmat — Tests

> Source : `.src/Gestion/option/Visucmat.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de consultation, sans écriture : le critère de comparaison est la suite des lignes
`Exec_SQL` (bloquante pour les reworks « sans changement SQL ») et le contenu affiché. L'écran
n'appelle pas `Utils.Observers(Me)` ; les saisies de dates ne seront rejouables qu'après
instrumentation dans les deux clones (VISUCMAT-A03) ou en test manuel guidé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VISUCMAT-T01 | replay | Ouverture | jeu `cmat_base` ; Caleditcmat → Visu | `Exec_SQL` : `arrete`, `LIMIT 1`, requête `TriGen` avec filtre ; date de début affichée | `tests/ouverture/` | implémenté |
| VISUCMAT-T02 | replay | Filtre par période | saisir `dtdeb`/`dtfin` couvrant un mois du jeu | requête `dtmouv BETWEEN` et lignes `E`/`S` du mois seulement | `tests/filtre_periode/` | implémenté |
| VISUCMAT-T03 | replay | Arrêté non renseigné (A01) | jeu `cmat_base` avec `arrete` NULL | figer la date de début et la requête produites | `tests/arrete_vide/` | implémenté |
| VISUCMAT-T04 | replay | Table vide | option boissons activée, `Fiches_ligregie` vide | figer le comportement de `TriGen` sans colonnes | `tests/table_vide/` | implémenté (code 125 figé) |

## Détail des tests

- **Jeu `cmat_base`** : voir [atribvignette](../atribvignette.class/test.md) (préparation commune
  de l'option boissons).
- **Valeurs attendues** : log `Exec_SQL` et capture du contenu de la grille dans le clone non
  modifié.
- **Cas non testables** : tri par clic sur les en-têtes (`TriGen`), couvert par les tests du lot
  Affichages.
- **Implémentation (vague 6)** : `/Soc01/bois` = -1 ; jeux `visucmat_shared/cmat_base` (copie de
  `modfichier_shared/options_bois_pp` + 5 lignes `Fiches_ligregie`, arrêté `05.2018`), `cmat_arrete_vide`, `cmat_vide`.
  Ouverture par le menu dynamique `cmat` (Caleditcmat) puis `Visu` ; comparaison du sql.log ordonné. Scénarios
  `visucmat_ouverture` (T01), `visucmat_filtre_periode` (T02 : `01.06.2018` / `30.06.2018` tapés avec les points ;
  sans points, la date devient `--`), `visucmat_arrete_vide` (T03 : début au 01.06.2018), `visucmat_table_vide`
  (T04 : `TriGen._new` ligne 88 « Not an object », code 125). Les dates de saisie sont rejouables (ReplayObservers).
