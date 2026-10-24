# CheckProg — Dépendances

> Source : `.src/Utils/CheckProg.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/CheckProg.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Impressions/Editeur.module` | `Chk` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique vérifié par grep : `Gestion/Impressions/Editeur.module:27-28`
  (`Prog_Email`). `Editeur.Prog_Email` n'a **aucun appelant** (grep `Prog_Email`) et calcule
  `$Exec` sans l'utiliser.
- Programme externe : `which`.
- Contrainte d'ordre : la suppression éventuelle de `CheckProg` suit celle de `Editeur.Prog_Email`.
