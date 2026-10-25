# Etiqart — Dépendances

> Source : `.src/Gestion/Etiquettes/Etiqart.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Etiquettes/Etiqart.class` — classe, formulaire associé `Etiqart.form`
- Handlers GUI détectés : 23
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
| `Cetiquettes` | `<type>`, `Barcode`, `Code`, `IntituleA`, `NewPage`, `PrixTTC` |
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

`Fiches_Art`, `Fiches_Etiquettes`, `Fiches_Fam`, `Fiches_Four`

### Membres Public sans usage externe détecté (portée réductible ?)

`init_ComboBox`, `SelectionArt`, `Art_man`, `Art1_man`, `Art2_man`, `ChkInput`, `Button2_Click`, `fin_impression`, `Imprime`, `pos_Etiq`, `pos_Etiq2`, `Connect`, `Import_Portable`, `Gridbart_Update`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants** (vérifiés) : `Fmenu.Menu157_Click` (`Fmenu.class:1574-1577`) et
  `Fmenu.Menu161_Click` (`Fmenu.class:1592-1595`), deux entrées de menu identiques avec
  `New Etiqart("")` ; `Articles.Btn_click` (`Articles.class:1422`, `1465-1466`) avec
  `New Etiqart(Code.text)`. Toujours en `ShowModal`.
- **Écritures externes** : `TriArticles` écrit `Bsel` et `Bval` par `Object.SetProperty`
  (`TriArticles.class:30-31`, `165-166`) : ces deux membres doivent rester `Public`, et ne sont pas
  vus par `deps.py` comme utilisés (ils ne figurent pas en `scope_reducible` car déclarés comme
  variables, mais à ne pas réduire).
- **`unused`** : `Art1_man` (aucun appel, grep) et `Connect` (aucun appel ; seule écriture de
  `ConnZbr = True`) — confirmés. Conséquence non vue par `deps.py` : la branche `If ConnZbr = True`
  d'`Imprime` et l'appel `Zebra.Gondole1` (`Etiqart.class:951`) sont morts.
- **`replay_dynamic`** : `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click`,
  `Gridbart_Click` → `Public` obligatoire (rejeu `Object.Call`, REPLAYOBSERVER-A06).
  `replay_missing`, `arity_errors`, `handlers_inactifs`, `unused_transitive` : vides.
- **`scope_reducible`** : la liste de `deps.py` est confirmée par grep, hors `Art1_man` et
  `Connect` (code mort/anomalie) ; `Button2_Click` n'est pas un handler (le contrôle `Button2`
  appartient au groupe `Btn`).
- **Tables** : `Fiches_Art` (`TabArt`), `Fiches_Fam`, `Fiches_Four` (via `Cbase`),
  `Fiches_Etiquettes` (littéral), `Fiches_CdBarre` (via `Utils.Find_Cbarre`), et la table de
  travail **`Etiquettes`** (nom par variable `Tab`/`Tab2`, non détectée par `deps.py`), aussi
  écrite par `Portable.Import` et créée sous le même nom par `Etigond`, `Etiqcasier` et `Eticli`.
- **Homonymes** : le RadioButton `Dymo` masque le module `Dymo` ; le contrôle `Code` n'existe pas
  ici (le membre `code` est une chaîne).
- **Dépendances externes** : `Visualiseur.Prog` (Shell `CmdVis` ou `Desktop.Open`/`xdg-open`),
  `Editeur.Prog_Editeur` (Shell `CmdEditor` ou `Desktop.Open`), `Doc.Open` (`xdg-open`),
  `Shell "cd ~"`, fichiers `~/tmp/EtiqArt.pdf`, `~/tmp/ImpT.txt`, `~/Portable/inventaire.txt`,
  `Socket` gb.net (code mort).
- **Ordre de rework** : socle `PlancheEtiquettes` (ETIQART-010) dans le même commit que
  FCLIENT-014 / FFOURNISSEUR-013 ou après eux ; module `EtiqArticles` (ETIQART-003 à 005) dans le
  même commit que ETIGOND-003..005 et ETIQCASIER-003..005.
