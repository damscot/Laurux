# RazEcr — Dépendances

> Source : `.src/Compta/Utils/RazEcr.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/RazEcr.class` — classe, formulaire associé `RazEcr.form`
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Raz`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : uniquement `Prgm.class:78` (`RazEcr.Showmodal()`), vérifié par grep.
- Aucune table : le seul SQL est commenté.
- La suppression du couple implique de retirer l'entrée `RazEcr` de `Prgm` (même commit) et de
  mettre à jour PRGM-T02 (liste des écrans).
