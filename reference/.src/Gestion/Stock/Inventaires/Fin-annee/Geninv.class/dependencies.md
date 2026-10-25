# Geninv — Dépendances

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class` — classe, formulaire associé `Geninv.form`
- Handlers GUI détectés : 5

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cstocks` | `<type>`, `BasPage`, `Entete`, `Level1G`, `Level2G`, `Lines` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `LDate` | `_call` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `son` |
| `TextReg` | `<form>`, `EstDate`, `Text`, `Type`, `dte` |
| `Utils` | `Cdate_Dbase`, `Coulfd`, `Observers`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Inv`

### Membres Public sans usage externe détecté (portée réductible ?)

`gen_Inv`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu81_Click` (`Fmenu.class:1052`, `Geninv.Show`, auto-instance).
- `gen_Inv` signalé « portée réductible » : confirmé par `grep -rn gen_Inv .src` (appel interne
  uniquement).
- Tables : `Fiches_Inv` est **créée** ici (DDL l. 94-104) ; c'est la source de toute la chaîne
  fin d'exercice (`SaisieInv`, `Ecarts`, `Ednsaisis`, `Edinv`, `Validinv`, `RazInv`,
  `EditStkDepart`, `Articles`, `Changefam`). Toute évolution du DDL impacte ces fichiers.
- `Cstocks` (`.src/Reports/Cstocks.class`, lot Reports non documenté) : `Level1G`, `Level2G`
  (7 paramètres, arité respectée), `Lines`, `Entete`, `Baspage`.
- Signaux `deps.py` : `scope_reducible` = `gen_Inv` (confirmé) ; aucun `unused`,
  `handlers_inactifs`, `arity_errors`, `replay_*`. `Label1_MouseDown` est un handler réel (vide) :
  `deps.py` ne signale pas les handlers vides.
- Ordre de rework : après la création du module `Inventaire` (GENINV-006), avant `SaisieInv`,
  `Validinv` et les éditions qui l'utiliseront.
