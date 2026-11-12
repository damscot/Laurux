# Doc — Tests

> Source : `.src/Communs/Doc.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`Open` lance `xdg-open` : les tests placent un `xdg-open` factice en tête du `PATH`, qui écrit ses
arguments dans un fichier ; on compare ce fichier.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DOC-T01 | gbtest | Rubrique sans page locale | `Doc.Open("Edtar")` | `xdg-open https://www.laurux.fr/drupal/documentation` | `tests/sans_page/` | implémenté |
| DOC-T02 | gbtest | Rubrique avec page locale | fichier `Ecrans/Test.html` créé dans le répertoire de l'application de test ; `Doc.Open("Test")` | `xdg-open <Application.Path>/Ecrans/Test.html` | `tests/page_locale/` | implémenté |
| DOC-T03 | gbtest | Paramètre `Module` | `Doc.Open("Test", "Autre")` avec `Autre/Test.html` | chemin dans `Autre/` | `tests/module/` | implémenté |
| DOC-T04 | replay | Menu « ? > Aide Html » | `Fmenu` → `Menu63` | `xdg-open` appelé avec l'URL générale | `tests/menu_aide/` | implémenté (gbtest : `Doc.Open("LauruxIndexParCategories")` appelé par `Menu63_Click`, dans DOC-T01 ; le replay n'observe pas xdg-open) |
| DOC-T05 | gbtest | `CheminAide` (après DOC-003) | mêmes cas que T01-T03 | chaîne attendue | `tests/chemin/` | à faire : exige l'extraction DOC-003 (`CheminAide` absent) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié avec le même `xdg-open` factice.
- T02/T03 nécessitent d'écrire dans `Application.Path` : à faire sur une copie du projet de test.
- **Non testable automatiquement** : l'ouverture réelle du navigateur.
- **Implémentation (phase 2)** : `.src/Tests/Communs/DocTest.test` (valeurs : `.hidden/Tests/Communs/assets/DocTest/`).
  `xdg-open` factice en tête du `PATH` (trace de ses arguments, chemin de l'application remplacé par `<app>`).
  T02/T03 créent `Ecrans/LauruxTestDoc.html` et `LauruxTestDocModule/LauruxTestDoc.html` sous `Application.Path`
  (supprimés dans `_Teardown`) et vérifient aussi le repli sur l'URL générale quand la page n'est pas dans le
  module demandé. DOC-T04 : la rubrique de `Menu63_Click` (`LauruxIndexParCategories`, sans page locale) est
  vérifiée dans T01 ; un rejeu du menu n'observerait rien (aucune requête, `xdg-open` non tracé au rejeu).
