# FSetFormat — Dépendances

> Source : `.src/Utils/FSetFormat.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/FSetFormat.class` — classe, formulaire associé `FSetFormat.form`
- Handlers GUI détectés : 7

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Attrib.class` | `Run` |
| `.src/Utils/SetColors.class` | `Run` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Attrib` | `fnd` |
| `CFormat` | `<type>` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_Touches`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Formulaire associé : `.src/Utils/FSetFormat.form` (contrôles `ColorButton1`, `ColorButton2`,
  `Button1`-`3`, `lblExemple`, `Panlogo`, `Logo2`, `Lgo2` ; `ColorButton2`, `Button1` et deux
  labels masqués). Ce n'est pas un `UserControl` : aucun autre `.form` ne l'instancie.
- Appelants vérifiés par `grep -rn 'FSetFormat'` : `SetColors.class:48-50` (`Format`, `Run`),
  `Caisse/Attrib.class:130-132,356-358`. `deps.py` ne liste que `Run` ; l'usage de la variable
  statique `Format` (lecture et écriture) n'est pas détecté.
- Dépendance vers le **formulaire** `Attrib` (`Attrib.fnd`) : couplage Utils → Caisse, et
  circularité `Attrib` ↔ `FSetFormat`. Ordre de rework : documenter ensemble ; un changement de
  signature de `Run` doit être fait dans le même commit qu'`Attrib` et `SetColors`.
- Table : `Fiches_Touches` via `Cbase.Table("TabTouches")` (exact).
