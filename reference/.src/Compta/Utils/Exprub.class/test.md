# Exprub — Tests

> Source : `.src/Compta/Utils/Exprub.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`run` affiche deux messages : le test complet est un replay lancé depuis « Appel programme »
(`Prgm`, nom `Exprub`, déjà déclenché par PRGM-T06). Le résultat comparé est le contenu des
fichiers `~/Bcr.txt` et `~/Bcrcpt.txt` (`HOME` de test isolé).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EXPRUB-T01 | replay | Export complet | `Laurux01.sql`, réponse « OUI » | `Bcr.txt` (257 lignes) et `Bcrcpt.txt` (364 lignes) identiques à `expected/` ; base inchangée | `tests/export_complet/` | à faire |
| EXPRUB-T02 | replay | Refus | réponse « NON », fichiers préexistants | fichiers inchangés (horodatage et contenu) | `tests/export_refus/` | à faire |
| EXPRUB-T03 | replay | Valeurs particulières | jeu dérivé : intitulé `NULL`, intitulé contenant `;`, plage `amortissement = 1`, rubrique `L` sans plage | lignes figées (vide, `;` non échappé, `T`) | `tests/export_valeurs/` | à faire |
| EXPRUB-T04 | replay | Export sous SQLite | `Laurux01.sqlite`, « OUI » | contenu figé (représentation du drapeau, à comparer à T01) | `tests/export_sqlite/` | à faire |
| EXPRUB-T05 | gbtest | `Exporte(sRep)` sans GUI (après EXPRUB-003) | base `Laurux01.sql`, répertoire temporaire | fichiers identiques à T01 | `tests/exporte/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites par le clone Laurux non modifié ; T01 sert aussi d'entrée à
  RUBRESULT-T04 (aller-retour export/import).
- **check_output.py** : diff texte exact des deux fichiers (fin de ligne `\n`).
- **Non testable automatiquement** : aucun cas (les messages sont rejoués).
