# Etiqcasier — Dépendances

> Source : `.src/Gestion/Etiquettes/Etiqcasier.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Etiquettes/Etiqcasier.class` — classe, formulaire associé `Etiqcasier.form`
- Handlers GUI détectés : 22
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Art1_man`, `Connect`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |
| `.src/Gestion/Tables/Articles.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cetiquettes` | `<type>`, `Barcode`, `Code`, `Codec`, `Intitule`, `Intitulec`, `NewPage`, `casier`, `casierc`, `stock`, `stockc` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `PdfWriter` | `Open`, `Output` |
| `Portable` | `Import`, `cpt2` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TriArticles` | `<type>` |
| `Utils` | `Fcolr`, `Find_cbarre`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |
| `Zebra` | `Gondole1` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Etiquettes`, `Fiches_Fam`, `Fiches_Four`

### Membres Public sans usage externe détecté (portée réductible ?)

`init_ComboBox`, `SelectionArt`, `Art_man`, `Art1_man`, `Art2_man`, `ChkInput`, `Button2_Click`, `fin_impression`, `Imprime`, `pos_Etiq`, `Connect`, `Import_Portable`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants** (vérifiés) : `Fmenu.Menu302_Click` (`Fmenu.class:2330-2333`) ; `Articles.Btn_click`
  (`Articles.class:1424`, `1471-1472`). `deps.py` liste aussi des `<hérité:showmodal>` de `Fmenu`
  aux lignes 1577-1604 : ce sont les `MyForm.Showmodal()` de `Etiqart`/`Etigond` (variable homonyme
  `Myform`, typée autrement dans chaque fonction) — **faux positifs** (limite connue : type local
  variable selon la fonction).
- **`unused`** : `Art1_man`, `Connect` — confirmés ; branche Zebra d'`Imprime` (l. 939) morte.
- **`replay_dynamic`** : `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click` →
  `Public`. Autres signaux (`replay_missing`, `arity_errors`, `handlers_inactifs`,
  `unused_transitive`) vides.
- **`scope_reducible`** : confirmé par grep, hors `Art1_man`/`Connect`.
- **Tables** : `Fiches_Art`, `Fiches_Fam`, `Fiches_Four` (Cbase), `Fiches_Etiquettes` (littéral),
  table de travail permanente `Etiquettes` (non vue par `deps.py`), `Fiches_CdBarre` (via
  `Utils.Find_Cbarre`).
- **Dépendances externes** : comme Etiqart ; même PDF `~/tmp/EtiqArt.pdf`.
- **Ordre de rework** : avec Etiqart/Etigond (`EtiqArticles`), après ETIQART-010.
