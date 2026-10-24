# Exprub — Dépendances

> Source : `.src/Compta/Utils/Exprub.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/Exprub.class` — classe
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `run` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_RubCompt`, `Fiches_Rubriques`
<!-- /AUTO:dependances -->

## Notes d'analyse
- **Appelant unique** : `Prgm.Button1_Click` (`Prgm.class:58`, `If Prog = "Exprub" Then Exprub.run`),
  c'est-à-dire la saisie du nom « Exprub » dans Gestion > Outils > Appel programme.
- **Fichiers produits** : `~/Bcr.txt` (une ligne par rubrique) et `~/Bcrcpt.txt` (une ligne par
  plage des rubriques de type `L`), relus par `Rubresult.BcrSelect_Activate`. Ce couplage par format
  de fichier n'apparaît pas dans `deps.py`.
- **Tables** : `Fiches_Rubriques`, `Fiches_RubCompt` (lecture seule), noms en dur.
- Variables `Static` de classe (`Tab1Rslt`, `hfil`, `hfil2`, `Tab3Rslt`, `Tab1`, `Tab3`) :
  utilisées uniquement dans `run`.
- Contrainte d'ordre : à traiter avec `Rubresult` (import du même format) ; `Prgm` n'appelle que
  `run` (signature à conserver).
