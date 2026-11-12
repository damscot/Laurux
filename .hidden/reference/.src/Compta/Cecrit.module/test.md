# Cecrit — Tests

> Source : `.src/Compta/Cecrit.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module mort : aucun comportement observable à figer. Le seul risque de la suppression est de
casser un homonyme local (`TriEcritures2.Debn1`…). Le test ci-dessous vérifie l'écran qui porte
ces homonymes.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CECRIT-T01 | replay | Non-régression de `TriEcritures2` après suppression du module | `Laurux01.sql` ; ouverture de la liste des écritures (validées / non validées, tri croissant puis décroissant, saisie d'un filtre) | lignes `Exec_SQL` et contenu de la grille identiques entre les deux clones | `tests/triecritures2_homonymes/` | implémenté (gb.test `.src/Tests/Compta/CecritTest.test`, TriEcritures2 instancié sans affichage : écran sans menu) |

## Détail des tests

- **Génération des valeurs attendues** : capture du scénario dans le clone **Laurux non
  modifié**, puis rejeu dans `Laurux_reworked`. Comme l'écran est en lecture seule, le dump de la
  base doit rester identique et les lignes `Exec_SQL` sont comparées (rework « sans changement
  SQL »).
- **Validation complémentaire** : `gbc3 -agt` sans erreur après suppression (pas de référence
  résiduelle).
- **Non testable** : sans objet.
- **Implémentation (phase 2)** : gb.test `CecritTest.T01TriEcritures2` au lieu du replay : `TriEcritures2` (Affichages)
  n’\est instancié nulle part (aucun menu, replay impossible) ; la fenêtre est créée sans affichage (types "0" et "1",
  trésorerie "1"), puis `JO_Dblclick` (×2), `COM_Click`, `Debe1`…`Debe4` sont appelés ; relevé de `Utils.rs1`. Le test ne
  référence pas `Cecrit`. Jeu `.hidden/Tests/Compta/assets/CecritTest/cecrit_ecritures.sql`.
