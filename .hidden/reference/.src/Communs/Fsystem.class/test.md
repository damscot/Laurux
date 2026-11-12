# Fsystem — Tests

> Source : `.src/Communs/Fsystem.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FSYSTEM-T01 | replay | Ouverture | `Fmenu` → « ? > Information système » | `txtInfo` contient les sections `[Version Mysql]` et `[Version Laurux]` (contenu variable masqué) | `tests/ouverture/` | implémenté (gbtest : Form_Open appelé directement, structure comparée) |
| FSYSTEM-T02 | gbtest | `RapportSysteme` (après FSYSTEM-002) | environnement du conteneur de test | chaîne non vide, sections attendues présentes | `tests/rapport/` | à faire : exige l'extraction FSYSTEM-002 (`RapportSysteme` absent) |

## Détail des tests

- **Valeurs attendues** : seule la **structure** du texte est comparée (le contenu dépend de la
  machine) ; capturée dans le clone non modifié.
- **Non testable automatiquement** : exactitude des informations système.
- **Implémentation (phase 2)** : `.src/Tests/Communs/FsystemTest.test` (valeurs : `assets/FsystemTest/`) :
  liste des en-têtes de section, version du serveur et de Laurux, chemin de l'application en fin de texte. La
  section `[Libraries]` dépend de la présence de Qt4/GTK2 dans `/usr/lib` (absente dans le conteneur de test).
