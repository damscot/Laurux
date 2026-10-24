# Materiel — Dépendances

> Source : `.src/Gestion/Tables/Materiel.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Materiel.class` — classe, formulaire associé `Materiel.form`
- Handlers GUI détectés : 57
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Ta_Click`, `Ta_Dblclick`, `Ta_KeyPress`, `Cof_Click`, `Cof_Dblclick`, `Cof_KeyPress`, `TTc_Click`, `TTc_Dblclick`, `TTc_KeyPress`, `Ref`, `reinit`, `Nom_Photo`, `Cli_Man`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColMarque_Click`, `colmat_Click`, `Colventes_click`, `Colachat_click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Colrcp`, `Colrcp2`, `Colrcp3`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |
| `.src/Gestion/Tables/Articles.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `DocActif` | `Is_Lock` |
| `LDate` | `_call` |
| `Start` | `Epuises`, `LocalSettings`, `Musique`, `Societe`, `Stockes`, `son` |
| `TriArticles` | `<type>` |
| `TriCpt` | `<type>`, `Client`, `Sans_Solde` |
| `Utils` | `Base`, `CDec`, `Cdate_Aff`, `Cdate_Dbase`, `Fcolr`, `Find_nbdec`, `ObsGotf`, `ObsLstf`, `Observers`, `Remplace`, `SetEditColor`, `cpoint`, `db`, `rs1` |
| `Variables` | `Bsel` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_BlM`, `Fiches_Cli`, `Fiches_Comptes`, `Fiches_Fam`, `Fiches_Four`, `Fiches_HisentMat`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Ligcom`, `Fiches_Ligrecpt`, `Fiches_Marques`, `Fiches_Materiels`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Tris`, `Deb`, `Deb2`, `Deb3`, `Deb4`, `art_man`, `Maj_Zones`, `Maj_Cli`, `Refresh`, `CleanChamps`, `Fam2`, `fourMan`, `CodePLF`, `CodeLF`, `PaHtLF`, `Active_champs`, `Tva_Calcul`, `Coeff`, `Pourcent`, `PvhtLF`, `PvTTcLF`, `arrondi`, `Calc_Marge`, `Calc_Percent`, `Calc_coeff`, `FraisLF`, `Dbclk`, `Ta_Click`, `Ta_Dblclick`, `Ta_KeyPress`, `Cof_Click`, `Cof_Dblclick`, `Cof_KeyPress`, `TTc_Click`, `TTc_Dblclick`, `TTc_KeyPress`, `Ref`, `TestenrgMat`, `EnrgMat`, `reinit`, `mat_Suppr`, `Histo_Ventes`, `recupfac`, `recupbl`, `Histo_Achat`, `aff_Photo`, `Nom_Photo`, `Cli_Man`, `SetObservers`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Points d'entrée (instances créées par `New`, constructeur `_New(code As String)` obligatoire) :
  `Fmenu.Menu190_Click` et `Fmenu.lblMat_MouseDown` (`.src/Communs/Fmenu.class:1745-1756`,
  `New Materiel("")`), `Articles.ToggleButton2_Click` (`.src/Gestion/Tables/Articles.class:4407`,
  `New Materiel(Code.Text)`, membre `hmat` ligne 56). Aucun membre appelé de l'extérieur.
- **Appels dynamiques entrants** : `TriArticles` (`.src/Affichages/TriArticles.class:30-31`,
  `165-166`) et `TriCpt` (`.src/Affichages/TriCpt.class:112-113`) écrivent `Bsel`/`Bval` par
  `Object.SetProperty`. `TriCpt` ne les remet pas à `False` à l'ouverture (contrairement à
  `TriArticles`) : voir MATERIEL-A09.
- `New TriArticles(…)` avec 9 arguments pour 8 paramètres : correct (le 6ᵉ, `Null`, est le
  `Parent` du constructeur hérité de `Form` ; règle vérifiée par un essai `gbc3`/`gbx3`).
- **Tables `*M`** (voir architecture.md, « Lien avec les tables `*M` ») : cet écran **lit**
  `Fiches_BlM`, `Fiches_LigblM`, `Fiches_HistoFacM`, `Fiches_HistoLigfacM`, `Fiches_HisentMat`
  par (`numserie`, `codep`) ; elles sont écrites par la facturation (`Facture.class:1671-1681`
  pour `Fiches_BlM`/`Fiches_EntMat`) et l'archivage. `Fiches_EntMat` n'est pas lue ici.
- Écrivains de `Fiches_Materiels` hors de ce fichier : `Achat` (création à la réception,
  `.src/Gestion/Entrées/Achat.class:1542`, suppression `800`, `1530`), `Facture` (vente :
  `7009-7011`, annulation : `8190`, `8348`), `ObjFacB.class:997` (n° de facture dans `mat_bl`),
  `Changefam.class:447-549` (famille/code). Lecteurs : `FClient.class:484`, `EdMat`, `TriMat`,
  `Articles`. Le rapprochement « code de ligne de BL = n° de série » est utilisé par `Facture`
  (8190, 8348) et par `mat_Suppr`/`Histo_Ventes` ici, mais `ObjFacB.class:997` rapproche
  `code_ligbl` de `mat_code` : incohérence à trancher dans le lot Facturation.
- Tables listées par `deps.py` : `Fiches_Ligcom` est seulement affectée à la variable `tab` dans
  `Maj_Zones` sans être interrogée (surestimation) ; `Fiches_Comptes` et `Fiches_Tvaav` ne sont
  lues que par `Fam2`/`art_man`. Aucune table n'est écrite hormis `Fiches_Materiels`.
- `Utils.rs1` est partagé : `Articles` l'utilise pour sa grille `Coltaches`
  (`Articles.class:2744`, `2763`) ; après fermeture de `Materiel` ouvert depuis `Articles`, cette
  grille relit le résultat de `Materiel` jusqu'à son prochain rechargement (à confirmer,
  MATERIEL-T11).
- `deps.py` : les 9 handlers `Ta_*`, `Cof_*`, `TTc_*` sont classés `unused` à juste titre
  (aucun contrôle de ce nom). En revanche il ne détecte pas la **collision** entre le groupe
  `Rcpt` et le contrôle `Rcpt` (A03), ni que `Dsg_GotFocus` ne peut pas être levé (seul contrôle
  du groupe invisible, A02), ni que `SetObservers` crée des observateurs `OBS` sans handler.
  `Rb_Click` : branches `Case 1/2` mortes (radios aux tags 3/4), non détectables par l'outil.
- Rejeu dynamique (REPLAYOBSERVER-A06) : `ColMarque_Click`, `colmat_Click`, `Colventes_click`,
  `Colachat_click` restent `Public`.
- Ordre de rework : `ArrondiPrix` avec `Movr` (MATERIEL-008/MOVR-007) ; la chaîne de calcul de
  prix est à aligner avec `Articles` (même lot `Gestion/Tables`).
