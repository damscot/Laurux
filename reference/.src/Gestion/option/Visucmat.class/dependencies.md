# Visucmat — Dépendances

> Source : `.src/Gestion/option/Visucmat.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/Visucmat.class` — classe, formulaire associé `Visucmat.form`
- Handlers GUI détectés : 5

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/Caleditcmat.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LDate` | `D` |
| `ObjProp` | `<type>`, `AddChamp` |
| `TextReg` | `<form>`, `EstDate`, `Text`, `Type`, `dte` |
| `TriGen` | `<type>`, `ExtraSel`, `Show`, `Update` |
| `Utils` | `db` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Parametres`, `Fiches_ligregie`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `Caleditcmat.Visu_Click` (`Caleditcmat.class:268`, `Visucmat.Show`) ; c'est
  l'auto-instance du formulaire qui est affichée.
- **Appels dynamiques entrants** : `TriGen` écrit `Bsel`/`Bval` par `Object.SetProperty` et lève
  `MajSel` (handler `coltri_MajSel`) : non vus par l'heuristique comme dépendance « utilisé par ».
- `TriGen`, `ObjProp`, `Chainage`, `TextReg` : composants génériques (lots Affichages/Utils) ;
  leur rework doit garder l'API utilisée ici (`New TriGen(…, Me)`, `ExtraSel`, `Update`, `Show`,
  `ObjProp.AddChamp`, `TextReg.dte.D`).
- Table `Fiches_ligregie` sans clé `Cbase`, absente de `db_control.csv`.
