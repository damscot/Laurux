# EntreeItem — Tests

> Source : `.src/Gestion/Lcr/EntreeItem.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ENTREEITEM-T01 | gbtest | Libellés des codes 1 à 5 | `"1"` … `"5"` | les 5 libellés exacts (`"1- Escompte"` …) | `tests/libelles/` | implémenté |
| ENTREEITEM-T02 | gbtest | Codes hors plage | `"0"`, `""`, `"6"`, `"x"` | `""` ; pour `"x"` figer le résultat ou l'erreur observée | `tests/hors_plage/` | implémenté (« x » rend une chaîne vide, sans erreur) |

## Détail des tests

- Valeurs attendues capturées dans le clone **Laurux non modifié** (`expected/` = une ligne
  `entrée;sortie` par cas). Pas de base nécessaire.
- Couverture visée : 100 % des lignes.
- Le comportement de `Preparation.Maj_Zones` (affichage du libellé dans `Entree2`) est couvert par
  les replays de [`Preparation`](../Preparation.class/test.md).

### Implémentation (phase 2, vague 5)
- Module `.src/Tests/Gestion/EntreeItemTest.test` (T01, T02) ; valeurs dans `assets/EntreeItemTest/expected.txt`.
