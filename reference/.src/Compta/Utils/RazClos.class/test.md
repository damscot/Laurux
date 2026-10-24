# RazClos — Tests

> Source : `.src/Compta/Utils/RazClos.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZCLOS-T01 | replay | Déblocage d'une écriture clôturée | `Laurux01.sql` + écriture clôturée à 3 lignes ; saisie du numéro, Débloquer | dump `Fiches_Mvt` (`cloturee`, `control`) ; message | `tests/razclos_deblocage/` | à faire |
| RAZCLOS-T02 | replay | Numéro inexistant ou vide | `999999`, `""`, `abc` | dump inchangé ; « Ecriture débloquée ! » figé (A02) | `tests/razclos_numero_invalide/` | à faire |
| RAZCLOS-T03 | replay | Effet sur le contrôle des clés | après T01, modification de la ligne puis `Anomalies` | rapport « Aucune anomalie » figé si la modification passe par une écriture re-scellée (A01) | `tests/razclos_inalterabilite/` | à faire |
| RAZCLOS-T04 | replay | Lancement par `Prgm` | saisie `RazClos` | fenêtre `RazClos` ouverte | `tests/razclos_prgm/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; base restaurée avant
  chaque test.
- T03 dépend du scénario de modification d'écriture (`Saisecrit`) : à préciser en phase 2.
