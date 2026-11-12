# FPostes — Tests

> Source : `.src/Compta/Tables/FPostes.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie : `replay` avec diff de `Fiches_Postes`. Valeurs attendues produites dans le clone
**Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FPOSTES-T01 | replay | Création | menu Postes ; `A01`, `Atelier` ; Enregistrer | ligne ajoutée | `tests/creation/` | implémenté |
| FPOSTES-T02 | replay | Modification | sélection `A01`, intitulé modifié | UPDATE `intitulep` | `tests/modification/` | implémenté |
| FPOSTES-T03 | replay | Suppression d'un poste utilisé | poste référencé dans `Fiches_Analytiques` | poste supprimé, répartition orpheline (A01 figée) | `tests/suppression/` | implémenté |
| FPOSTES-T04 | replay | Code trop long | `ATELIER1` (8 caractères) | comportement figé (troncature ou erreur SQL selon le mode MariaDB, A02) | `tests/code_long/` | implémenté |

## Détail des tests

- **Données** : `Laurux01.sql` (table vide) ; jeu dérivé pour T03 (poste et ligne `Fiches_Analytiques`).
- **Comparaison** : dump normalisé de `Fiches_Postes` et `Fiches_Analytiques`.
- **Mode SQL** : le résultat de T04 dépend du `sql_mode` du conteneur MariaDB, à fixer dans
  `.hidden/reference/tools/db/`.

- **Implémentation (phase 2)** : scénarios `.hidden/Tests/Compta/assets/fpostes_creation` (T01),
  `fpostes_modification` (T02), `fpostes_suppression` (T03), `fpostes_code_long` (T04 : la base de test tronque
  le code à `ATE` sans erreur). Jeu partagé `fpostes_shared/fpostes.sql` (postes A01, B02 ; B02 utilisé dans
  `Fiches_Analytiques`).
