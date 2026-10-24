# Fsystem — Tests

> Source : `.src/Communs/Fsystem.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FSYSTEM-T01 | replay | Ouverture | `Fmenu` → « ? > Information système » | `txtInfo` contient les sections `[Version Mysql]` et `[Version Laurux]` (contenu variable masqué) | `tests/ouverture/` | à faire |
| FSYSTEM-T02 | gbtest | `RapportSysteme` (après FSYSTEM-002) | environnement du conteneur de test | chaîne non vide, sections attendues présentes | `tests/rapport/` | à faire |

## Détail des tests

- **Valeurs attendues** : seule la **structure** du texte est comparée (le contenu dépend de la
  machine) ; capturée dans le clone non modifié.
- **Non testable automatiquement** : exactitude des informations système.
