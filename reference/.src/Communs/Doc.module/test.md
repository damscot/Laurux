# Doc — Tests

> Source : `.src/Communs/Doc.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`Open` lance `xdg-open` : les tests placent un `xdg-open` factice en tête du `PATH`, qui écrit ses
arguments dans un fichier ; on compare ce fichier.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DOC-T01 | gbtest | Rubrique sans page locale | `Doc.Open("Edtar")` | `xdg-open https://www.laurux.fr/drupal/documentation` | `tests/sans_page/` | à faire |
| DOC-T02 | gbtest | Rubrique avec page locale | fichier `Ecrans/Test.html` créé dans le répertoire de l'application de test ; `Doc.Open("Test")` | `xdg-open <Application.Path>/Ecrans/Test.html` | `tests/page_locale/` | à faire |
| DOC-T03 | gbtest | Paramètre `Module` | `Doc.Open("Test", "Autre")` avec `Autre/Test.html` | chemin dans `Autre/` | `tests/module/` | à faire |
| DOC-T04 | replay | Menu « ? > Aide Html » | `Fmenu` → `Menu63` | `xdg-open` appelé avec l'URL générale | `tests/menu_aide/` | à faire |
| DOC-T05 | gbtest | `CheminAide` (après DOC-003) | mêmes cas que T01-T03 | chaîne attendue | `tests/chemin/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié avec le même `xdg-open` factice.
- T02/T03 nécessitent d'écrire dans `Application.Path` : à faire sur une copie du projet de test.
- **Non testable automatiquement** : l'ouverture réelle du navigateur.
