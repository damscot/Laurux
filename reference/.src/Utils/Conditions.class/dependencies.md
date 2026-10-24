# Conditions — Dépendances

> Source : `.src/Utils/Conditions.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Conditions.class` — classe
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Clear`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Utils/RichDataGrid.class` | `<type>`, `Compute`, `Value` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Condition` | `<type>`, `CompareMode`, `Value` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Clear`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Usage réel : `.src/Utils/RichDataGrid.class:128` (type), `:162` (`Compute`), `:164` (`Value`), dans
  une boucle sur `$aCondFormats` qui est **toujours vide** (propriété `CondFormats` jamais affectée,
  vérifié par `grep -rn CondFormats .src`). Le code est donc compilé mais jamais exécuté.
- Les nombreuses occurrences de « Conditions » ailleurs (`Prefs`, `Fmenu`, `ObjFac`, `OptFac`,
  `LauruxConf`) concernent le réglage `/Soc<XX>/Conditions` ou un contrôle `Conditions` de
  `Prefs.form`, pas cette classe.
- `<inconnu:field>` dans le bloc AUTO : deps.py ne résout pas le membre `{Field}` (nom échappé par
  accolades) de `Condition`.
- Ordre de rework : avec `Condition` et `RichDataGrid` (même décision de suppression).
