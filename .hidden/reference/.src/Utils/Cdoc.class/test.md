# Cdoc — Tests

> Source : `.src/Utils/Cdoc.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CDOC-T01 | — | Écran inaccessible | aucun chemin d'IHM ne l'ouvre | aucun test automatisable ; vérification `grep` de l'absence d'appelant avant toute suppression | `tests/absence_appelant/` | à faire |

## Détail des tests

- L'écran ne peut pas être atteint depuis l'application : pas de scénario `replay` possible, et la
  classe n'a pas de logique testable en `gbtest`.
- Le « test » CDOC-T01 est un contrôle statique (script `check_output.py` qui exécute
  `grep -rni cdoc .src` et attend uniquement les fichiers `Cdoc.class`/`Cdoc.form`), à repasser
  avant la suppression éventuelle (CDOC-A01).
