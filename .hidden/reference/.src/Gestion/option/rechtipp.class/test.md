# rechtipp — Tests

> Source : `.src/Gestion/option/rechtipp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre en lecture seule, non journalisée : `gbtest` sous Xvfb et replay via l'écran appelant.
Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RECHTIPP-T01 | gbtest | Mode `"N"` | `New Rechtipp("N")` (Xvfb) | 2 colonnes, lignes `cart = '0'` | `tests/mode_n/` | à faire |
| RECHTIPP-T02 | gbtest | Mode `"T"` | `New Rechtipp("T")` ; un article de `Fiches_region` absent de `Fiches_Art` | 4 colonnes, désignations ; erreur figée pour l'article absent | `tests/mode_t/` | à faire |
| RECHTIPP-T03 | gbtest | Sélection | `GridView1.Row = 0` ; `GridView1_Activate` | événement `trouve` avec le code ; fenêtre fermée | `tests/selection/` | à faire |
| RECHTIPP-T04 | replay | Code TIPP d'un client | `FClient` : bouton région ; choix ; enregistrement | `Fiches_Cli.cli_tipp` dans le dump | `tests/client_tipp/` | à faire |

## Détail des tests

- **Données** : jeu dérivé `option_carbu` = `Laurux01.sql` + `modfichier.fichiercarbu` + 3 régions
  (`cart = '0'`) et 2 lignes par article.
- **Rejeu** : T04 sélectionne la région par activation (double-clic/Entrée) ; la fenêtre elle-même
  n'est pas journalisée (RECHTIPP-A01).
