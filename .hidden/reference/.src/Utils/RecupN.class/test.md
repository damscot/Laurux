# RecupN — Tests

> Source : `.src/Utils/RecupN.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RECUPN-T01 | replay | Recopie | jeu dérivé : `Fiches_Mvt1` avec écritures n° 1, 2, 5 (multi-lignes) et 500 ; `Fiches_Mvt` non vide | diff `Fiches_Mvt` : lignes ajoutées, numéros avec trous, `numcol` vide, `lettree`/`numerodef` = 0 | `tests/recopie/` | implémenté (`.hidden/Tests/Utils/assets/recupn_recopie/`) |
| RECUPN-T02 | replay | Double exécution | T01 exécuté deux fois | figer la duplication | `tests/double_execution/` | implémenté (`.hidden/Tests/Utils/assets/recupn_double_execution/`, 14 INSERT) |
| RECUPN-T03 | replay | `Fiches_Mvt` vide | jeu dérivé | figer l'erreur | `tests/mvt_vide/` | implémenté (`.hidden/Tests/Utils/assets/recupn_mvt_vide/`, erreur fatale « Result is not available » RecupN.run.18 figée, code 125) |

## Détail des tests

- Capture dans le clone **Laurux non modifié** via « Appel programme » → `RecupN` ; le `Message.Info`
  est acquitté par le replay. Comparaison du dump de `Fiches_Mvt`.
- `run` est statique : un `gbtest` est possible mais le `Message.Info` impose un affichage ; replay
  préféré jusqu'à la séparation du message.
- **Scénarios synthétisés (phase 2)** : `.hidden/Tests/Utils/assets/<nom>/` (`scenario.log`, `meta.json`, fichiers d'entrée éventuels, chemins relatifs à la racine du clone) ; jeux dans `.src/Tests/Framework/datasets/`. Attendus à produire par `runner replay Utils/<nom> --expected` quand les rejeux seront rétablis.
  Jeux : `recupn_mvt1` (T01, T02), `recupn_mvt_vide` (T03). `Prgm` se ferme après chaque lancement : T02 rouvre « Appel programme ».
