# Articles — Dépendances

> Source : `.src/Gestion/Tables/Articles.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Articles.class` — classe, formulaire associé `Articles.form`
- Handlers GUI détectés : 66
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Dsg1_GotFocus`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Refresh`, `ToggleButton66_Click`, `Dsg1_GotFocus`, `Ec0LF`, `Stocke_MouseUp2`, `TvaMan`, `Tnom_Photo`, `Codart`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Composants_Click`, `fourList_Click`, `FamList_Click`, `ColMarque_Click`
- ⚠️ Accès par l'auto-instance du formulaire alors que la classe est aussi ouverte par `New` (la fenêtre affichée n'est pas celle modifiée) : `SupprArt:377` → `art_Suppr`, `SupprArt:423` → `art_Suppr`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Colcom`, `Coltype`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Gestion/Entrées/Achat.class` | `<hérité>` |
| `.src/Gestion/Entrées/GesTar.class` | `<type>` |
| `.src/Gestion/Facturation/Facture.class` | `<hérité>` |
| `.src/Gestion/SupprArt.class` | `art_Suppr` |
| `.src/Gestion/Tables/Prodcomposes.class` | `<hérité>` |
| `.src/Gestion/Tables/TarTypeCli.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `ACom` | `<type>` |
| `AFacture` | `<type>` |
| `ArtPromo` | `art_Promo` |
| `CPrix` | `CTva`, `Cascade` |
| `Cbase` | `Table` |
| `CoefTypeC` | `<hérité>` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Etigond` | `<type>` |
| `Etiqart` | `<type>` |
| `Etiqcasier` | `<type>` |
| `FFournisseur` | `<hérité>` |
| `Famille` | `<hérité>` |
| `LCoul` | `<type>`, `Art_DB_bgcolor` |
| `LDate` | `_call` |
| `LGed` | `<type>`, `AddTag`, `Articles`, `HT`, `Ouvrir`, `Supprime`, `TTC` |
| `LPrix` | `<type>`, `Add`, `_call` |
| `MajEqu` | `Maj` |
| `Materiel` | `<type>` |
| `ObjProp` | `<type>`, `AddChamp`, `tri` |
| `Serveur` | `Pass` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TarTypeCli` | `<type>`, `client`, `type` |
| `TextReg` | `<form>`, `MaxLength`, `RechX`, `RechY`, `Text`, `champs`, `conteneur`, `recherche` |
| `TriGen` | `<type>`, `Close`, `ExtraSel`, `Refresh_Height`, `Show`, `Update` |
| `TriHistos` | `<type>` |
| `Utils` | `Bip`, `CDec`, `Calcode`, `Cdate_Aff`, `Cdate_Dbase`, `Commande`, `Fcolr`, `Find_cbarre`, `Find_nbdec`, `Next_Code`, `ObsGotf`, `ObsLstf`, `Observers`, `Option`, `Remplace`, `SetEditColor`, `convBool`, `cpoint`, `db` |
| `Variables` | `ArtCode`, `ArtHt`, `ArtTva`, `Artintitule`, `OrgCoefTypeCli`, `SMajArt`, `Sexport`, `Sprix` |
| `artopt` | `<type>`, `affmab`, `enregiste`, `numart`, `prixachat`, `prixrev` |
| `gridvi` | `<type>`, `bouton_Click`, `code`, `dec`, `razcol` |
| `textfamille` | `<form>`, `Clear`, `Select`, `setfocus`, `text` |

### Tables SQL référencées

`Docs_Ged`, `Fiches_Art`, `Fiches_Bl`, `Fiches_CdBarre`, `Fiches_Centrales`, `Fiches_Cequ`, `Fiches_Comptes`, `Fiches_Depots`, `Fiches_Entcom`, `Fiches_Entrecpt`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Inv`, `Fiches_InvT`, `Fiches_LigTicketz`, `Fiches_Ligbl`, `Fiches_Ligcom`, `Fiches_Ligrecpt`, `Fiches_Marques`, `Fiches_Materiels`, `Fiches_Mo`, `Fiches_Mvtexp`, `Fiches_Mvtexpdc`, `Fiches_Parametres`, `Fiches_PrdComp`, `Fiches_Promo`, `Fiches_Rpl1`, `Fiches_Rpl2`, `Fiches_StkDepots`, `Fiches_TarTypcli`, `Fiches_Tvaav`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`Maj_Zones`, `Maj_Composant`, `Refresh`, `CleanChamps`, `RdimColArts`, `AfficheArt`, `ToggleButton66_Click`, `Dsg1_GotFocus`, `ArtLF`, `CfourLF`, `FamLF`, `fourLF`, `pbhtLF`, `TrC`, `PaUAGF`, `PaUALF`, `TxLF`, `FraisLF`, `Coeff`, `Pourcent`, `PvhtLF`, `PvTTcLF`, `PvconsLF`, `Pds_LF`, `Bonus_LF`, `ColVteLF`, `PVHT2LF`, `Ec0LF`, `EcoLF`, `Eco2LF`, `CoppLF`, `Tva_Calcul`, `arrondi`, `RefCentraleLF`, `Reaff`, `Calc_Marge`, `Calc_Percent`, `Calc_coeff`, `Calc_coeff2`, `Stocke_MouseUp2`, `TvaMan`, `FamMan`, `fourMan`, `CtrlArt`, `CtrlCfour`, `CtrlCfourbl`, `CtrlRefCentrale`, `CtrlCbarre`, `codeBarre`, `Gencode`, `Calc_barre`, `Decimal`, `Stockmini_LF`, `Stockmaxi_LF`, `Mincom_LF`, `MoveToCol`, `ShowTextBox`, `HideTextBox`, `EnrgArt`, `Maj_CodeBarre`, `Del_CodeBarre`, `Maj_Rpl1`, `Del_Rpl1`, `Maj_Rpl2`, `Del_Rpl2`, `Del_Codequ`, `Button1_Click`, `ChkPrx`, `aff_Photo`, `Tnom_Photo`, `Aff_Centrale`, `Codart`, `Maj_Dssr`, `Maj_ColType`, `Filter_Calc`, `Update_Req`
<!-- /AUTO:dependances -->

## Notes d'analyse

### Appelants réels (grep)

| Appelant | Appel | Contexte |
|---|---|---|
| `Fmenu.Menu15_Click` (`Fmenu.class:625`) | `Articles.Show()` | menu Gestion, auto-instance non modale |
| `Achat.Code_KeyPress` (`Achat.class:258`) | `articles.ShowModal()` | F3 dans la saisie d'achat |
| `Facture` (`Facture.class:5566`) | `Articles.ShowModal()` | F4 en saisie de facture |
| `TarTypeCli` (`TarTypeCli.class:265`) | `Articles.ShowModal()` | F4 |
| `Prodcomposes` (`Prodcomposes.class:261`, `265`) | `Articles.ShowModal()` | produits composés |
| `GesTar.ButArt_Click` (`GesTar.class:535`) | `New Articles(Null, code)` + `ShowModal` | instance explicite, le `Null` est le parent de la fenêtre (même convention que `New LGed(Null, …)`) |
| `SupprArt.button8_Click` (`SupprArt.class:377`), `SupprArt.Suppression` (`423`) | `Articles.art_Suppr(code, False)` | suppression en masse **sur l'auto-instance** : construit le formulaire sans l'afficher (`_New` complet, dont la requête de liste) ; si l'écran est ouvert, c'est la même instance (voir ARTICLES-A04) |

Les quatre appels `ShowModal()`/`Show()` sur l'auto-instance partagent l'état de l'écran ouvert depuis
le menu (article affiché, drapeaux `b`, `nouveau`, `Dne`…).

### Ce que l'heuristique surestime ou rate

- **Portée réductible, faux positifs** :
  - `art_Suppr` n'est pas dans la liste (appelant `SupprArt` détecté) : correct.
  - `Bsel` et `Bval` (non listés comme fonctions) sont écrits par `TriGen` via
    `Object.SetProperty(Obj, "Bsel"/"Bval", …)` (`TriGen.class:138-139`, `228-232`), `Me` étant passé
    en paramètre `ob` à `New TriGen(…, Me)` : ils doivent rester `Public`.
  - `Refresh` : aucun appel explicite, mais le nom surcharge la méthode héritée du formulaire ; à
    ne pas rendre `Private` sans vérification (`gbc3`).
  - `Button1_Click` est listé « portée réductible » à juste titre : `Button1` appartient au groupe
    `Btn`, Gambas lève `Btn_Click` et non `Button1_Click`, appelé seulement par `Btn_click` cas 9.
- **Code mort confirmé par grep** : `ToggleButton66_Click` (aucun contrôle `ToggleButton66` dans le
  `.form`), `Dsg1_GotFocus` (handler inactif : `Dsg1` est rattaché au groupe `Dsg`), `Ec0LF`,
  `TvaMan` (homonymes dans `Movr` et `FTvac`, appels locaux à ces fichiers), `Tnom_Photo` (homonyme
  dans `Fcaras`), `Codart` (le mot n'apparaît ailleurs que comme paramètre de `Utils.Commande`).
  `Stocke_MouseUp2` est aussi sans appel, mais contient le seul contrôle « stocké » contre les BL et
  l'inventaire : classé en anomalie (ARTICLES-A15).
- **Handler non vu** : `$opt_recalculpx` (événement `recalculpx` de `Artopt`, `artopt.class:21` et
  `313`) n'apparaît ni dans les handlers ni dans la table des fonctions : le parseur ignore les noms
  commençant par `$`.
- **Variables non vues** : les 40 déclarations sans mot-clé (lignes 26-65) ne figurent pas dans le
  bloc « Déclarations ».
- **Tables non détectées comme telles** : `Fiches_Parametres` (`dnart`, en dur, lu par `CleanChamps`,
  écrit par `EnrgArt`), `Fiches_Comptes` (via la variable `tvan`), `Fiches_Mvtexpdc` (via `TabM`),
  `Fiches_Marques` (paramètre de `marque.champs`) sont bien listées, mais la liste ne distingue pas
  lecture et écriture. **Écritures** : `Fiches_Art`, `Fiches_Parametres.dnart`, `Fiches_CdBarre`,
  `Fiches_Rpl1`, `Fiches_Rpl2`, `Fiches_Cequ` (et via `MajEqu.Maj`), `Fiches_Mvtexp`, `Fiches_Inv`,
  `Fiches_InvT`, `Fiches_Ligrecpt`, `Docs_Ged`, `Docs_Tag`, `Fiches_Tag` (via `LGed`) ; tables de
  l'option (`$opt.enregiste`) ; fichiers d'échange `Serveur`.
- **`Fiches_LigTicketz` / `Fiches_Materiels`** : atteints par `Cbase.Table("TabLigTck")` et
  `Cbase.Table("TabMat")` dans `art_Suppr` (lecture seule).
- **Dépendance `LPrix`** : `Button8_Click` utilise `New LPrix(0)` + `Add(LPrix(…))` pour passer les
  montants à `LGed` ; aucune autre dépendance de calcul (les prix sont calculés sur les chaînes).
- **`TextReg` / `textfamille`** : contrôles personnalisés du `.form` (`marque`, `fam`).

### Appels dynamiques entrants

- `ReplayObserver.Replay_Click` appelle `Object.Call(window, <Grille>.Name & "_Click")` pour les
  `ColumnView`/`GridView`/`ListBox` : `Composants_Click`, `fourList_Click`, `FamList_Click`,
  `ColMarque_Click` existent ; les `ColumnView` `Colcom` et `Coltype` n'ont pas de `_Click`
  (`Colcom_Click`, `Coltype_Click` **n'existent pas** : le rejeu d'un clic sur ces listes échouerait,
  à confirmer en phase 2) ; `tbrem_Click` existe pour la `TableView` `Tbrem` (prise en charge par le
  rejeu à confirmer). Ces noms et leur portée
  `Public` sont intouchables.
- `TriGen` lève `MajSel`/`Resize` sur les objets `ColTri` et `ColTriGenDoc` ; `Artopt` lève
  `recalculpx` sur `$opt`.
- `Utils.Observers(Me)` installe les observateurs de journalisation (aussi à chaque changement
  d'onglet).

### Dépendances circulaires et ordre de rework

- `Articles` ↔ `Materiel` (`ToggleButton2_Click` ouvre `Materiel` ; `Materiel` contient des appels
  commentés à `Articles.EnrgArt`/`AfficheArt`, lignes 836-837).
- `Articles` ↔ `TarTypeCli` (F4 de `TarTypeCli` ouvre `Articles` ; `Button6/13` ouvrent `TarTypeCli`).
- `Articles` ↔ `Prodcomposes`, `Articles` → `SupprArt` → `Articles` (bibliothèque).
- `Articles` → `CoefTypeC` par l'état global `Variables.OrgCoefTypeCli`/`Art*` (couplage implicite).
- Ordre conseillé : ARTICLES-001 à 005 et 007 sans dépendance ; 006 après SERVEUR-008 ; 012 avec
  `Movr`, `Materiel`, `FTvav` ; 013 avec `Famille` ; 014 après ARTPROMO-004 ; 015 avec la décision
  sur LGED-A07 / ARTICLES-A07 ; 017 avant toute correction de A04/A05/A06 ; 018 en dernier
  (couverture par les replays T01-T14 requise).
