# EtiqRecpt — Dépendances

> Source : `.src/Gestion/Etiquettes/EtiqRecpt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Etiquettes/EtiqRecpt.class` — classe, formulaire associé `EtiqRecpt.form`
- Handlers GUI détectés : 7

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Gestion/Entrées/GesTar.class` | `<hérité>` |
| `.src/Gestion/Stock/Tarifs/Impart.class` | `<hérité>` |
| `.src/Gestion/Stock/Tarifs/MajTarifM.class` | `<hérité>` |
| `.src/Gestion/Stock/Tarifs/MajTarifP.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cetiquettes` | `<type>`, `Barcode`, `Code`, `Codec`, `Intitule`, `IntituleA`, `Intitulec`, `NewPage`, `PrixHt`, `PrixTTC`, `Rectangle2`, `Tva`, `casier`, `casierc`, `stock`, `stockc` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Fcolr`, `Find_nbdec`, `Observers`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_EtiGond`, `Fiches_EtiProd`, `Fiches_Etiquettes`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`init_ComboBox`, `Calc_Etiq`, `pos_Etiq`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants** (vérifiés, tous `EtiqRecpt.Show`) : `Fmenu.class:1616`, `GesTar.class:526`,
  `Impart.class:1316`, `MajTarifM.class:1404`, `MajTarifP.class:255`.
- **Écrivains des tables lues** : `Fiches_EtiProd`/`Fiches_EtiGond` sont alimentées par
  `GesTar.class:730-742` (`Utils.db.Edit`/`Create9`), `MajTarifM.class:1415-1431`,
  `MajTarifP.class:456-472`, `MajFbtarif2.class:299-317`, `Impart.class:1335-1354`, renommées par
  `Changefam.class:522-523` ; **non purgées** par `Articles.art_Suppr` (ARTICLES-A05).
- **Homonyme** : le RadioButton `Etigond` (et son handler `Etigond_Click`) porte le nom de la classe
  `Etigond` ; `deps.py` n'en a pas déduit de dépendance (correct).
- **Signaux `deps.py`** : `unused`, `arity_errors`, `handlers_inactifs`, `replay_dynamic`,
  `replay_missing`, `unused_transitive` vides ; `scope_reducible` (`init_ComboBox`, `Calc_Etiq`,
  `pos_Etiq`) confirmé.
- **Tables** : `Fiches_Etiquettes`, `Fiches_EtiProd`, `Fiches_EtiGond`, `Fiches_Art` (littéraux),
  `Fiches_Tvaav` (Cbase).
- **Dépendances externes** : `Visualiseur.Prog`, `Doc.Open`, `Shell "cd ~"`, `~/tmp/EtiqRecpt.pdf`.
- **Ordre de rework** : après ETIQART-010 et les dessins d'Etigond/Etiqcasier ; à coordonner avec
  les écrivains des files (lots Entrées / Stock).
