# CFormat — Dépendances

> Source : `.src/Utils/CFormat.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/CFormat.class` — classe
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Copy`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Attrib.class` | `<type>`, `Background`, `Foreground`, `_get` |
| `.src/Gestion/Tables/Remisec.class` | `_get` |
| `.src/Utils/FSetFormat.class` | `<type>` |
| `.src/Utils/RichDataGrid.class` | `<type>`, `Alignment`, `Background`, `Font`, `Foreground`, `Format`, `Padding` |
| `.src/Utils/SetColors.class` | `<type>`, `Alignment`, `Background`, `Font`, `Foreground`, `ToString`, `_get` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Copy`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux négatifs de `deps.py`** : l'opérateur de classe `CFormat[...]` (méthode statique `_Get`)
  n'est pas détecté. Appelants réels de `_Get` (vérifiés par `grep -rnw CFormat`) :
  `Caisse/Attrib.class:129,355`, `Utils/SetColors.class:47,77`, `Utils/CFormat.class:152` (Copy),
  et **`Gestion/Tables/Remisec.class:70-73`**, absent de la liste « Utilisé par » (4 formats de
  colonnes `CFormat["Width: …; Alignment: left"]`).
- `ToString` est appelé par `SetColors.Coul_DblClick:56` ; `Font.ToString()` dans `ToString` est
  un appel à la classe `Font`, pas une récursion.
- Les membres `<inconnu:backcolor>`/`<inconnu:forecolor>` attribués à `CFormat` depuis
  `RichDataGrid:168-170` sont des **propriétés inexistantes** de `CFormat` (voir l'anomalie
  RICHDATAGRID-A03), pas une limite de l'outil.
- `Classes["Align"]` : appel réflexif (dynamique) non signalé par `deps.py`.
- Portée réductible proposée : `Copy` → exact (code mort).
- Pas de dépendance circulaire. Ordre de rework : `CFormat` avant `SetColors`, `FSetFormat`,
  `RichDataGrid` et `Attrib` si la méthode commune `Applique` est créée.
