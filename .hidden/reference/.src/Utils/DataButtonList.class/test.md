# DataButtonList — Tests

> Source : `.src/Utils/DataButtonList.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe morte : aucun comportement observable à figer.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DATABUTTONLIST-T01 | gbtest | Absence de référence | `gbc3 -agt` après suppression ; `grep -rni DataButtonList .src` | compilation sans erreur, aucune occurrence | `tests/suppression/` | à faire |

## Détail des tests

- T01 est un contrôle de build, à porter par le script de validation de phase 4.
