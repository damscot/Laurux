# HistoCom — Tests

> Source : `.src/Utils/HistoCom.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| HISTOCOM-T01 | gbtest | `run` | jeu dérivé de `Laurux01.sql` : lignes `C` avec libellé, avec libellé vide, avec `com_ligfac` déjà rempli ; lignes non `C` | diff `Fiches_HistoLigfac` de référence | `tests/deplacement/` | implémenté |
| HISTOCOM-T02 | gbtest | Idempotence | `run` appelé deux fois | état identique après le 2ᵉ appel | `tests/idempotence/` | implémenté |

## Détail des tests

- `run` est `Static Public` sans GUI : appelable depuis gb.test avec une connexion `Utils.db` sur la
  base Docker. Valeurs attendues produites dans le clone **Laurux non modifié** (dump normalisé).
- **Implémentation (phase 2)** : `.src/Tests/Utils/HistoComTest.test`, jeu `.src/Tests/Framework/datasets/histocom_lignes.sql` (lignes C/A/M, libellé NULL, vide, `com_ligfac` déjà rempli). Un libellé vide est lu NULL par gb.db : la ligne n'est pas déplacée.
