# TriTest — Tests

> Source : `.src/Tests/TriTest.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

**TriTest est lui-même l'implémentation d'un test de [`TriGen`](../../Affichages/TriGen.class/test.md)**
(décision utilisateur). Les tests ci-dessous sont des tests de TriGen pilotés par ce formulaire ;
l'enrichissement prévu (TRITEST-002) doit reprendre les scénarios TRIGEN-T01 à T09.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRITEST-T01 | replay | Création en mode Panel + sélection simple | ouverture de TriTest, clic sur un article, fermeture | `TextBox1` = code ; sortie `form_Close` = `True` / code | `tests/tritest_selection/` | implémenté (gb.test ; fige TRITEST-A01 : construction en erreur) |
| TRITEST-T02 | replay | Filtre imposé `ExtraSel` | cocher puis décocher « en stock » | grille limitée aux articles stockés en stock, puis complète ; requêtes `Exec_SQL` identiques entre clones | `tests/tritest_extrasel/` | implémenté (gb.test ; fige TRITEST-A01 : construction en erreur) |
| TRITEST-T03 | replay | Annulation | Échap sans choix | `TextBox1` vide (`Stop Event`), `Bsel` = `False` | `tests/tritest_annulation/` | implémenté (gb.test ; fige TRITEST-A01 : construction en erreur) |

## Détail des tests

- **Données** : jeu dérivé `liste_paginee` de TriGen (.hidden/reference/.src/Affichages/TriGen.class/test.md),
  complété d'articles stockés, non stockés, suspendus et à stock négatif (couleurs `bgcolor`).
- **Valeurs attendues** : produites dans le clone Laurux non modifié ; comparaison de la sortie
  standard de `form_Close`, des lignes `Exec_SQL` du journal et d'une capture de la grille.
- **Lancement** : TriTest n'est ouvert par aucun menu ; le point d'entrée de test est à définir en
  phase 2. TriTest appelle-t-il `Utils.Observers(Me)` ? Non : à ajouter dans l'enrichissement pour
  rendre ces scénarios rejouables.

- T01 à T03 : gb.test `.src/Tests/Tests/TriTestTest.test` (jeu `Affichages/trigen_shared/liste_paginee`) : TriTest n'a ni
  menu ni appelant (pas de rejeu possible) ; le formulaire est instancié sans affichage, la TriGen est retrouvée comme
  observateur de la grille (`Object.Parent`), `Coltri_Click` et `Close(Null)` (effet d'Échap) sont appelés directement,
  la case « en stock » est cochée par sa valeur. Aujourd'hui chaque test fige l'erreur de construction (A01) ; la suite
  du test s'exécutera dès la correction.
