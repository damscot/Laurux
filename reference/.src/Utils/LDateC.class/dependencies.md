# LDateC — Dépendances

> Source : `.src/Utils/LDateC.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/LDateC.class` — classe, Create Static, formulaire associé `LDateC.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Utils/TextReg.class` | `Select` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `LDate` | `<type>`, `G` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `TextReg.class:144/147/199/202` (`LDateC.Select(dte).L` ou `.LT`), toujours avec
  le seul argument `dte` (objet `LDate` de `TextReg`).
- `Select(…, update = True)` modifie l'objet `TextReg.dte` passé en argument, ce qui déclenche
  `TextReg.dte_change` : effet de bord à préserver.
- Formulaire `LDateC.form` : un seul contrôle `DateChooser1` (handlers `_Change`, `_Activate`,
  `_Cancel`).
- Dépend de [`LDate`](../LDate.class/dependencies.md) (`G`, `_call`). Aucun SQL, aucun appel
  dynamique.
