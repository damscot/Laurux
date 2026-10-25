# Attribution — Dépendances

> Source : `.src/Gestion/Lcr/Attribution.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Lcr/Attribution.class` — classe, formulaire associé `Attribution.form`
- Handlers GUI détectés : 32
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Deb3`, `Button5_Click`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColLcr_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CLcr` | `<type>`, `BasPage`, `Entete`, `Level1A`, `Level2A`, `Lines` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `LDate` | `G`, `_call` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TextReg` | `<form>`, `EstDate`, `EstNum`, `Name`, `Select`, `Text`, `Type`, `dte`, `nbdec`, `reg` |
| `TriCpt` | `<type>`, `Avec_Solde`, `Client` |
| `Utils` | `Base`, `Coulfd`, `Fcolr`, `ObsLstf`, `convBool`, `cpoint`, `db`, `rs1` |
| `Visualiseur` | `Prog` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Banques`, `Fiches_Cli`, `Fiches_Comptes`, `Fiches_Lcr`

### Membres Public sans usage externe détecté (portée réductible ?)

`Entete`, `Tris`, `Deb`, `Deb2`, `Deb3`, `Deb4`, `Total`, `Refresh`, `CleanChamps`, `Maj_Zones`, `Button5_Click`, `compte`, `compteman`, `Imp_Lcr`, `sCmpt`, `sdesg`, `Nb`, `sDate`, `iLind`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée : `Fmenu.MenuAbq_Click` (`Attribution.Show`, `Fmenu.class:2512`).
- `unused` vérifiés : `Deb3` (aucun appel), `Button5_Click` (aucun contrôle `Button5` dans
  `Attribution.form`).
- Non détecté par `deps.py` : `Button7` est invisible (`Attribution.form` l. 105-107) et jamais rendu
  visible → `Button7_Click` et `compte` inatteignables (limite « handlers dont le seul contrôle est
  invisible »).
- `replay_dynamic` : `ColLcr_Click` doit rester `Public`. `N_click`/`A_click` sont de vrais handlers
  (radios `N`, `A` non groupées).
- `Bsel`/`Bval` écrits par `TriCpt` via `Object.SetProperty` : `Public` obligatoire ; `scope_reducible`
  ne les liste d'ailleurs pas. `Nb`, `sDate`, `iLind`, `sCmpt`, `sdesg` : aucun usage externe.
- Tables en dur : `Fiches_Lcr`, `Fiches_Banques`. `LOCK TABLES`/`UNLOCK TABLES` neutralisés sous
  SQLite par `DB_Connection`.
- Écran non instrumenté (`Utils.Observers(Me)` absent) : voir ATTRIBUTION-A06.
- Aval : `Preparation` ne voit que les LCR dont `banque <> 0`. Ordre de rework : après `CLcr`,
  conjointement avec `Preparation` et `Lcr` pour les commonalisations.
