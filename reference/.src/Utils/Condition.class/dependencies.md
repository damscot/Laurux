# Condition — Dépendances

> Source : `.src/Utils/Condition.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Condition.class` — classe
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Utils/Conditions.class` | `<type>`, `CompareMode`, `Value` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul utilisateur : `.src/Utils/Conditions.class:43-81`. `grep -rniw condition .src` renvoie aussi
  `TextReg.condition` (propriété homonyme) et des commentaires : sans rapport.
- `<inconnu:field>` : deps.py ne résout pas le nom échappé `{Field}`.
- Rework lié à `Conditions` et `RichDataGrid`.
