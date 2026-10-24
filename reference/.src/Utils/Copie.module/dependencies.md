# Copie — Dépendances

> Source : `.src/Utils/Copie.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Copie.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prefs.class` | `<hérité>` |
| `.src/Gestion/Facturation/FacturefmA.class` | `spiece` |
| `.src/Gestion/Impressions/Edbr.module` | `Dupli` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`schemin`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants vérifiés par grep : `Copie.Dupli` → `Gestion/Impressions/Edbr.module:226` ;
  `Copie.spiece` → `Gestion/Facturation/FacturefmA.class:554,560`. `Copie.schemin` : aucun.
- **Faux positifs** possibles de l'heuristique : `Copie.Value` dans `FClient` (445, 657, 1550, 1726),
  `FFournisseur` (262, 335, 1381, 1404, 1624) et `Prefs` (1044) désigne une `CheckBox` nommée
  `Copie` dans le `.form`, pas ce module.
- Couplage temporel caché : `FacturefmA` dépend d'un appel antérieur à `Dupli` par un autre écran.
- Programme externe : `cp`.
