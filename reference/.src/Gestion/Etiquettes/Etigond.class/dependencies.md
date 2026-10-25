# Etigond — Dépendances

> Source : `.src/Gestion/Etiquettes/Etigond.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Etiquettes/Etigond.class` — classe, formulaire associé `Etigond.form`
- Handlers GUI détectés : 24
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Art1_man`, `Connect`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click`, `Gridbart_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |
| `.src/Gestion/Tables/Articles.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cetiquettes` | `<type>`, `Barcode`, `Code`, `IntituleA`, `IntituleB`, `NewPage`, `Poids`, `PrixHt`, `PrixTTC`, `PrixTTCB`, `Rectangle2`, `Refour`, `Tva`, `volm` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `PdfWriter` | `Open`, `Output` |
| `Portable` | `Import`, `cpt2` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TriArticles` | `<type>` |
| `Utils` | `Fcolr`, `Find_cbarre`, `Find_nbdec`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |
| `Zebra` | `Gondole1` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Etiquettes`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`init_ComboBox`, `SelectionArt`, `Art_man`, `Art1_man`, `Art2_man`, `ChkInput`, `Button2_Click`, `fin_impression`, `Imprime`, `pos_Etiq`, `Connect`, `Import_Portable`, `Init`, `Gridbart_Update`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants** (vérifiés) : `Fmenu.Menu158_Click` (`Fmenu.class:1583-1586`), `Fmenu.Menu162_Click`
  (`Fmenu.class:1601-1604`), `Articles.Btn_click` (`Articles.class:1423`, `1468-1469`).
- **Homonyme** : `EtiqRecpt` a un RadioButton nommé `Etigond` (`EtiqRecpt.Etigond.value`,
  `Etigond_Click`) : ce n'est pas un usage de cette classe ; `deps.py` l'a correctement ignoré.
- **`unused`** : `Art1_man`, `Connect` — confirmés. La branche `ConnZbr = True` d'`Imprime` et les
  deux appels `Zebra.Gondole1` (l. 987, 989) sont morts par conséquence (non vu par `deps.py`).
- **`replay_dynamic`** : `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click`,
  `Gridbart_Click` → `Public`. `replay_missing`, `arity_errors`, `handlers_inactifs`,
  `unused_transitive` : vides.
- **`scope_reducible`** : confirmé par grep (hors `Art1_man`, `Connect`) ; `Init` n'est appelée
  que par `Button2_Click`.
- **`Bsel`/`Bval`** : écrits par `TriArticles` via `Object.SetProperty` → `Public`.
- **Tables** : `Fiches_Art`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Tvaav` (via `Cbase`),
  `Fiches_Etiquettes` (littéral), table de travail temporaire `Etiquettes` (variable, non vue par
  `deps.py`), `Fiches_CdBarre` (via `Utils.Find_Cbarre`). La présence de `Fiches_Tvaav` dans les
  tables de `deps.py` vient aussi du littéral `Tab2 = "Fiches_Tvaav"`, jamais utilisé.
- **Dépendances externes** : comme Etiqart (`Visualiseur`, `Editeur`, `Doc.Open`, `Shell`, fichiers
  `~/tmp/EtiqGond.pdf`, `ImpT.txt`, `inventaire.txt`, `Socket` mort).
- **Ordre de rework** : avec Etiqart et Etiqcasier (module `EtiqArticles`), après le socle
  `PlancheEtiquettes` (ETIQART-010).
