# Glcr — Dépendances

> Source : `.src/Gestion/Lcr/Glcr.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Lcr/Glcr.class` — classe, formulaire associé `Glcr.form`
- Handlers GUI détectés : 7
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `A1_Click`, `A2_Click`, `T2_Click`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `CheckBox1_Click`, `A1_Click`, `A2_Click`, `T2_Click`, `Level2`, `Level3`, `Level4`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `ColLcr`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CLcr` | `<type>`, `BasPage`, `Entete`, `Level1A`, `Level2A` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `LDate` | `D` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe` |
| `TextReg` | `<form>`, `EstDate`, `Name`, `Type`, `dte` |
| `Utils` | `Cdate_Aff`, `Fcolr`, `Observers`, `convBool`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Lcr`

### Membres Public sans usage externe détecté (portée réductible ?)

`Deb`, `CheckBox1_Click`, `A1_Click`, `A2_Click`, `T2_Click`, `Level2`, `Level3`, `Level4`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée unique : `Fmenu.Menuis_Click` (`Glcr.Show`, `Fmenu.class:2530`), menu
  « Impression / suppression LCR ».
- `handlers_inactifs` vérifiés : `A1`, `A2`, `T2` appartiennent au groupe `Btn` (`Glcr.form`
  l. 76-87) ; Gambas lève `btn_click` et jamais `A1_Click`… → code mort.
- `unused` vérifiés par `grep` : `CheckBox1_Click` (aucun contrôle `CheckBox1` dans le `.form`),
  `Level2`, `Level3`, `Level4` (aucun appel ; homonymes dans `CLcr` sans rapport).
- `replay_missing` : `ColLcr` (`ColumnView`) sans `ColLcr_Click` → ne pas cliquer dans la grille
  pendant les scénarios (ou REPLAYOBSERVER-A06).
- `Cbase.Table("TabBanques")` : clé absente de `Cbase.module` (CBASE-A01) ; la table réelle est
  `Fiches_Banques`, écrite en dur ailleurs dans le lot. `deps.py` ne signale pas les clés `Cbase`
  inconnues.
- Tables écrites en dur : `Fiches_Lcr` (lecture, suppression).
- `Button1`, `Button4` du `.form` sans handler : non détecté par `deps.py`.
- Aucune dépendance circulaire ; dépend de `CLcr` (impression). Ordre : après `CLcr`.
