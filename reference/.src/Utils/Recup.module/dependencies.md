# Recup — Dépendances

> Source : `.src/Utils/Recup.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Recup.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Group`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/FRestore.class` | `Utilisateur` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Group`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Grep `Recup\.` : un seul appel, `Communs/FRestore.class:67` (`Recup.Utilisateur()`). `Group` n'est
  appelé nulle part.
- Programme externe : `getent` (dans `Group`, mort).
- Aucune contrainte d'ordre.
