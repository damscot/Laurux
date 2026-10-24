# GedR — Dépendances

> Source : `.src/Utils/GedR.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/GedR.class` — classe, formulaire associé `GedR.form`
- Handlers GUI détectés : 17

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `LBox` | `<type>`, `ListEditor`, `ListView`, `TextReg` |
| `LGed` | `<type>`, `AddTag`, `Articles`, `Autres`, `Clients`, `Comptabilite`, `EpurationDocs`, `EpurationTags`, `Fournisseurs`, `Ouvrir` |
| `LTrans` | `<type>`, `List` |
| `ObjProp` | `<type>` |
| `ProgBar` | `<type>`, `Avancement` |
| `TextReg` | `<form>`, `<type>`, `Text`, `path`, `reg` |
| `TriGen` | `<type>`, `ExtraSel`, `FontSize`, `GetAllFiltered`, `GroupBy`, `NoUp`, `Refresh_Data`, `Update` |
| `Utils` | `db` |

### Tables SQL référencées

`Docs_Ged`, `Docs_Tag`, `Fiches_Tag`

### Membres Public sans usage externe détecté (portée réductible ?)

`PB_Epuration`, `Update_Req`, `List`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant non détecté** : `Fmenu.class:2366` (`GedR.Show()`, auto-instance de la fenêtre).
- **Faux positifs de portée** : `Select_Click` est le handler du groupe `Select` (6 boutons radio
  du `.form`) ; `Bsel`/`Bval` sont écrits par `TriGen` via `Object.SetProperty`. `List`,
  `Update_Req`, `PB_Epuration` sont bien internes ou inutilisés.
- **Faux positifs d'usage** : `Doc.<inconnu:supprime>` (l. 143) est en réalité `doc.Supprime` sur
  une variable `LGed` nommée `doc`, homonyme de la classe `Doc` ; seul `Doc.Open("Ged")` (l. 175)
  concerne la classe `Doc`.
- Événements reçus de `TriGen` (`As "TriGen"`) : `MajSel`, `Raz`, `Data`.
- SQL non portable SQLite : `GROUP_CONCAT(… SEPARATOR …)`.
- Ordre de rework : après `LTrans`, `LBox`, `LGed` et `TriGen`.
