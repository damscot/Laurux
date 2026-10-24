# FCalc — Tests

> Source : `.src/Utils/FCalc.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`ManageKeys` est privé : avant FCALC-004 les tests de calcul passent par l'instance du formulaire
sous affichage virtuel (Xvfb, à confirmer) en simulant les clics (`buttons_Click` via `Last` n'est
pas simulable) ; après FCALC-004, par la fonction pure exposée. Les replays vérifient
l'intégration dans les écrans appelants.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FCALC-T01 | gbtest | Évaluation simple | `12+3`, `2*3.5`, `10/4`, `(1+2)*3`, `50%` | `$sResult` de référence | `tests/evaluation/` | à faire |
| FCALC-T02 | gbtest | Formules refusées / erreurs | `)` seul, `((`, `1,5+1`, `1/0`, opérateur en tête | formule filtrée ; résultat `1` en erreur (figé) | `tests/erreurs/` | à faire |
| FCALC-T03 | gbtest | Retour arrière et `C` | `12B`, `C` | formule `1` ; `$sResult = "0."` | `tests/edition/` | à faire |
| FCALC-T04 | gbtest | Export | `$sResult` = `12.5`, `0`, `-3` | `Resultat` = `12,50000`, `0,00000`, `-3,00000` (locale fr) | `tests/export/` | à faire |
| FCALC-T05 | gbtest | `Resultat` non remis à zéro | export `5` puis 2ᵉ ouverture fermée sans export | `Resultat` toujours `5,00000` (A01 figée) | `tests/resultat_persistant/` | à faire |
| FCALC-T06 | replay | Intégration saisie d'écritures | Saisecrit, F5 dans `Montant`, `12+3`, Entrée, Entrée, validation | dump `Fiches_Mvt` avec montant 15,00 | `tests/replay_saisecrit/` | à faire |
| FCALC-T07 | replay | Intégration caisse | Caisse (`-p`), F5 dans `Qte`, `3*2`, export | ligne de ticket qté 6 (dump `Fiches_LigTickets*`) | `tests/replay_caisse/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites dans le clone **Laurux non modifié** sous la locale `fr_FR.UTF-8`
  (le format de `Resultat` dépend de la locale : la fixer dans le runner).
- **Données** : aucune base pour T01-T05 ; `Laurux01.sql` pour T06-T07.
- **Non testable automatiquement** : rendu de la `DrawingArea`, effets de survol.
