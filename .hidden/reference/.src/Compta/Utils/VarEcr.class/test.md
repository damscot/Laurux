# VarEcr — Tests

> Source : `.src/Compta/Utils/VarEcr.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de calcul pur : tous les tests sont `gbtest`. Valeurs attendues produites par les mêmes
appels dans le clone Laurux non modifié.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VARECR-T01 | gbtest | `plus`/`nb`/`Max`/`_get` | 3 lignes ajoutées ; `_get(5)` | index 0-2, `nb = 3`, `Max = 2`, `Null` | `tests/conteneur/` | à faire |
| VARECR-T02 | gbtest | `For Each` (`_next`) | conteneur vide, 1 ligne, 3 lignes, racine ajoutée à elle-même | séquence des objets | `tests/enumeration/` | à faire |
| VARECR-T03 | gbtest | `moins` | par index, par objet, objet absent | booléens et contenu restant | `tests/moins/` | à faire |
| VARECR-T04 | gbtest | `trouve`/`reccomp`/`modifi` | index valides/hors bornes, objets, comptes présents/absents, `modifi(-1, …)` | valeurs de retour | `tests/recherche/` | à faire |
| VARECR-T05 | gbtest | `somme` | lignes normales, collectives, `L_sup`, montants à 3 décimales | somme arrondie de référence | `tests/somme/` | à faire |
| VARECR-T06 | gbtest | `newTbl`/`Tlettrage` | deux `newTbl` successifs | `Tbl` distinct à chaque appel | `tests/lettrage/` | à faire |

## Détail des tests

- `_put` n'est pas testé (code mort, supprimé par VARECR-002).
- Couverture visée : 100 % hors `_put`.
