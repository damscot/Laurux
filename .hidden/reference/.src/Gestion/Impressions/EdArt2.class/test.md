# EdArt2 — Tests

> Source : `.src/Gestion/Impressions/EdArt2.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

L'écran n'est accessible depuis **aucun menu** : un scénario de rejeu ne peut pas l'ouvrir. Le seul
test utile est un contrôle statique de l'absence d'appelant, qui protège la décision EDART2-A01.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDART2-T01 | gbtest | Absence d'appelant (contrôle statique) | `grep -rniw edart2 .src` hors `EdArt2.*` | aucune occurrence (sinon réévaluer A01) | `tests/edart2_mort/` | à faire |

## Détail des tests

- Le test est un script de contrôle lancé par le harnais (pas un module gb.test exécutant du code
  Gambas) ; il est classé `gbtest` faute de type « statique ».
- Si l'utilisateur décide de conserver et réactiver l'écran (refus d'A01), reprendre les scénarios
  EDART1-T01 à T10 sur cet écran avec le jeu `editions_articles`
  ([EdArt1/test.md](../EdArt1.class/test.md#détail-des-tests)) ; les anomalies A02 et A03 seraient
  alors figées par ces scénarios.
