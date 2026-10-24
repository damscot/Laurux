# Visreglements — Tests

> Source : `.src/Gestion/Reglements/Visreglements.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VISREGLEMENTS-T01 | gbtest | Compilation sans le couple | suppression de `Visreglements.class` + `.form` | `gbc3 -agt` sans erreur | `tests/suppression/` | à faire |
| VISREGLEMENTS-T02 | replay | Ouverture et liste des clients | écran ouvert par un scénario dédié (`Visreglements.Show` depuis un harnais, aucun menu) ; jeu dérivé : 2 clients avec règlements en journaux `jrnal2`/`jrnal3` | contenu de `Facturefm`/`Detail` et lignes de `Colbl` identiques à la référence | `tests/ouverture/` | à faire |
| VISREGLEMENTS-T03 | replay | Détail d'un client | clic sur un client de `Colbl` | lignes de `Coldetail` ; fige l'erreur d'indice éventuelle de la l. 178 | `tests/detail_client/` | à faire |
| VISREGLEMENTS-T04 | replay | Suppression d'un règlement | Suppr sur une ligne de `Coldetail` → Oui | dump de `Fiches_Mvt` (ligne supprimée, `lettree`), `Fiches_Comptes.solde`, `Detail` identique | `tests/suppression_reglement/` | à faire |
| VISREGLEMENTS-T05 | gbtest | `Calc_solde` | compte avec 3 écritures validées et 1 non validée ; compte sans écriture | `solde` = Σ(débit − crédit) validées ; `0` sinon | `tests/calc_solde/` | à faire |

## Détail des tests

- Écran sans point d'entrée : T02 à T04 n'ont de sens que si VISREGLEMENTS-A01 (suppression) est
  refusée ; ils exigent un lanceur de test (`Visreglements.Show` via `Object.New`) car aucun menu ne
  l'ouvre. Si A01 est acceptée, seul T01 est conservé.
- Valeurs attendues générées dans le clone **Laurux non modifié** ; `Laurux01.sql` n'a aucune
  écriture : utiliser le jeu dérivé commun des éditions comptables
  (`Compta/Impressions/Balance.class/test.md`) enrichi de règlements clients.
- T05 nécessite une base (SQL) : gb.test avec connexion MariaDB Docker.
