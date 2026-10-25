# Psms — Tests

> Source : `.src/Gestion/SMS/Psms.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Le formulaire n'est accessible par aucun menu : aucun scénario `replay` ne peut l'atteindre
depuis l'interface. Le seul test utile vérifie le constat de code mort, préalable à l'anomalie
PSMS-A01.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PSMS-T01 | gbtest | Formulaire inaccessible et table absente | recherche statique (`grep -rnw Psms .src`), `SHOW TABLES LIKE 'Fiches_Psms'` sur `Laurux01.sql` importée | aucune référence hors du couple ; table absente | `tests/psms_mort/` | à faire |

## Détail des tests

- **Génération** : exécuté sur le clone Laurux non modifié et sur `Laurux_reworked` ; le résultat
  doit rester identique tant que PSMS-A01 n'est pas validée.
- **Non testable** : les handlers (`api_LostFocus` avec `curl`, `Button3_Click`, `Button2_Click`)
  ne sont pas atteignables par le rejeu ; un test direct échouerait faute de table
  `Fiches_Psms`. L'API Spot-Hit réelle n'est jamais appelée dans les tests (faux `curl` en tête du
  `PATH` si un test ultérieur est ajouté).
