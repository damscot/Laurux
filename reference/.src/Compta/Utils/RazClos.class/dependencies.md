# RazClos — Dépendances

> Source : `.src/Compta/Utils/RazClos.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/RazClos.class` — classe, formulaire associé `RazClos.form`
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Sha1Calc` | `CalcSha1` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Mvt`

### Membres Public sans usage externe détecté (portée réductible ?)

`Raz`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `Fmenu.class:2372` (`Menu311_Click`, « Déblocage écritures », sans contrôle de
  mot de passe) et `Prgm.class:79` (`RazClos.Showmodal()`), auto-instance.
- `Raz` : aucun appelant externe (grep `RazClos.Raz`) ; portée réductible.
- `deps.py` voit `Fiches_Mvt` par littéral ; le passage du nom à `Sha1Calc` (paramètre) n'est pas
  une table détectée en tant que telle.
- Aucune dépendance circulaire.
