# LBox — Dépendances

> Source : `.src/Utils/LBox.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/LBox.class` — classe, formulaire associé `LBox.form`
- Handlers GUI détectés : 7

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Utils/GedR.class` | `<type>`, `ListEditor`, `ListView`, `TextReg` |
| `.src/Utils/LGed.class` | `<type>`, `FileSelect` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `son` |
| `TextReg` | `<form>`, `Text`, `dte`, `reg` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`ListSelection`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Surestimation** : les membres `TextReg`, `ListView`, `ListEditor`, `FileSelect` « utilisés »
  par `GedR`/`LGed` sont les valeurs de l'énumération `LBox.<mode>`, pas les contrôles.
- **Accès dynamiques non résolus** : `$obj As Object` reçoit un `LTrans` (`GedR` l. 441, 488 ;
  `LGed` l. 951) ou un `TextReg` (`GedR` l. 371, 383) ; `LBox` y écrit `.Text` ou `.List`. Les
  propriétés `LTrans.List` et `TextReg.Text` sont donc des dépendances réelles.
- Lecture des propriétés `reg`, `dte`, `dat`, `numerique`, `Text` de l'objet `Inp` (un `TextReg`)
  en mode `TextReg` : couplage à l'API de [`TextReg`](../TextReg.class/dependencies.md).
- Événement `MajOut` : aucun observateur.
- `ListSelection` est bien interne (réductible) ; les handlers listés sont tous liés au `.form`.
- Aucun SQL.
