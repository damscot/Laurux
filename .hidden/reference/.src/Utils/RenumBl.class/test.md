# RenumBl — Tests

> Source : `.src/Utils/RenumBl.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RENUMBL-T01 | gbtest | `run` sur base de référence | `Laurux01.sql` (BL facturés, lignes de factures de types variés) | dump de référence de `Fiches_HistoLigfac`, `Fiches_Bl`, `Fiches_Ligbl` (comportement destructeur figé) | `tests/renumerotation/` | à faire |
| RENUMBL-T02 | gbtest | Locale | T01 avec `LANG=fr_FR.UTF-8` puis `C` | montants `Fiches_Ligbl` avec `,` puis `.` (figé) | `tests/locale/` | à faire |
| RENUMBL-T03 | gbtest | Suppression (si A01 validée) | suppression du fichier et de l'entrée `Prgm` | `gbc3 -agt` sans erreur | `tests/suppression/` | à faire |

## Détail des tests

- `run` est statique et sans GUI : appel direct depuis gb.test avec connexion à la base Docker ;
  valeurs attendues générées dans le clone **Laurux non modifié**.
