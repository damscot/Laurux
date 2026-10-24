# LScript — Dépendances

> Source : `.src/Utils/LScript.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/LScript.class` — classe, Create Static, hérite de `Array`
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Utils/LGed.class` | `<type>`, `Run`, `RunA` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `LTaxe` | `<type>` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `Log` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant métier unique** : `Utils/LGed.class:865-928` (numérisation multipage : `echo … >`,
  `xsane`, `scanimage`, `convert`, scripts configurables `/Soc<XX>/scangui|scanbatch|scanconvert`).
- **Harnais de test** : `Start.module:484` force le chargement de la classe ; `Start_Test` appelle
  `Internal_Test` par `Object.Call` (appel dynamique non vu par `deps.py`).
- **`LTaxe`** : dépendance fictive (variable `tx` inutilisée dans `Internal_Test`).
- **`Utils.Log`** → `LLog` → `DB_Connection.Log_Event` : chaque `Run` produit une ligne `Log` dans le
  journal applicatif si le module est actif (`-d`).
- **Ordre de rework** : indépendant de la base ; la conversion d'`Internal_Test` en gb.test (phase 2)
  précède tout rework.
