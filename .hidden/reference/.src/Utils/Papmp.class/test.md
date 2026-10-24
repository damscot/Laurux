# Papmp — Tests

> Source : `.src/Utils/Papmp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PAPMP-T01 | replay | Copie du prix de revient | `Laurux01.sql` ; « Appel programme » `Papmp`, « Oui » | diff `Fiches_Art` : `art_pmp` = `art_prvt` | `tests/pmp_prvt/` | à faire |
| PAPMP-T02 | replay | Refus | « Non » | aucune modification | `tests/refus/` | à faire |

## Détail des tests

- Capture dans le clone **Laurux non modifié** ; comparaison du dump de `Fiches_Art`. Le résultat doit
  être identique à RAZART-T02.
