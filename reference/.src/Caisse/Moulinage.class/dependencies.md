# Moulinage — Dépendances

> Source : `.src/Caisse/Moulinage.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Moulinage.class` — classe, formulaire associé `Moulinage.form`
- Handlers GUI détectés : 5

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `Generation_Bl`, `Livre_caisse` |
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cfacture` | `<type>`, `BasPage`, `Entete`, `Level1`, `Level2`, `Level2E`, `Level3`, `Lines2`, `newPage` |
| `Csolde` | `Solde_caisse` |
| `DB_Connection` | `AutoIncrement`, `Create9`, `Engine`, `Exec`, `LockIncrement` |
| `Doc` | `Open` |
| `EcrAuto` | `<type>`, `ecriture` |
| `EcrReg` | `<type>` |
| `Facturergbl` | `<type>`, `Ent_Bl`, `Maj_Parametres` |
| `LDate` | `<type>`, `D`, `G`, `L`, `LT`, `_call` |
| `LPrix` | `G`, `Mnt`, `TotBTC` |
| `LTaxe` | `<type>` |
| `Mreglement` | `CodeCais`, `Laision_Reg`, `RegCais`, `RegMode2CodeCaisse` |
| `ObjFac` | `facture`, `journal`, `magasin`, `nbexplemplaire`, `numbl`, `numerodef`, `numeroecr`, `numfac`, `saisreg`, `tsaisreg` |
| `ObjFacB` | `<type>`, `comptmat`, `editef` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `ProgBar` | `<type>`, `Avancement` |
| `Sha1Calc` | `CalcSha1`, `CalcSha1T` |
| `Start` | `LocalSettings` |
| `Utils` | `Bip`, `Cdate_Dbase`, `Find_nbdec`, `MouseDefault`, `MouseProcessing`, `Option`, `PointBase`, `Replace`, `arrondi`, `cpoint`, `db` |
| `VarEcr` | `<type>`, `L_caisse`, `Treso`, `compte`, `dte`, `dtee`, `etat`, `intitul`, `libelle`, `montantc`, `montantd`, `numdoc`, `numlot`, `type` |
| `Visualiseur` | `Prog` |
| `calculdroit1` | `<type>`, `accise_droit`, `drsurfac`, `opt` |

### Tables SQL référencées

`Fiches_AdrlivBL`, `Fiches_Art`, `Fiches_Bl`, `Fiches_BordereauxC`, `Fiches_Caisses`, `Fiches_Cli`, `Fiches_ClientCaisse`, `Fiches_Comptes`, `Fiches_Echeances`, `Fiches_EntTicketz`, `Fiches_Fam`, `Fiches_FamDep`, `Fiches_HisEntTickets`, `Fiches_HisLigTickets`, `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_Journaux`, `Fiches_LibelFac`, `Fiches_LigTicketz`, `Fiches_Ligbl`, `Fiches_Mvt`, `Fiches_MvtM`, `Fiches_Parametres`, `Fiches_Reglements`, `Fiches_RemTypec`, `Fiches_Societes`, `Fiches_Tleg`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Moulinage_Acomptes_Avoir`, `Moulinage`, `Controle_Moulinage`, `Recup_Art`, `Remises_quantitatives`, `CalcTTC`, `Recup_Tva`, `Decimal`, `arrondi`, `Calc_Marge`, `Ventilation`, `Virements`, `Ecritures`, `Majnum`, `Parametres`, `Maj_Totalisation`, `Verif`, `Maj_Compta`, `Verif_Reglement_Caisse`, `Maj_Tresorerie`, `Maj_Collectif`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants réels** (vérifiés par `grep -rn "Moulinage\." .src`) : `Fmenu.Menu215_Click`
  (`Fmenu.class:1897`, `ShowModal` après contrôle du tunnel de réplication), `Caisse.class:6141`
  (`Generation_BL`, casse différente mais même symbole) et `Caisse.class:6915` (`Livre_caisse`,
  depuis `Defaut_Ticketxz`). Ces deux derniers appels passent par l'**auto-instance** du
  formulaire dans le processus de caisse (`./Laurux -p`) : `_new` y est exécuté et l'état
  d'instance est partagé entre appels. `Fcaisses.class:272` est une variable locale homonyme.
- **Portée réductible** : les 21 membres proposés par `deps.py` sont confirmés (aucun appel
  externe, aucun nom cité en chaîne) ; `Generation_Bl` et `Livre_caisse` restent `Public`.
  Les handlers `form_Open`, `Button1..4_Click` restent `Public`. Aucun `unused`,
  `unused_transitive`, `handlers_inactifs`, `arity_errors`, `replay_dynamic` ni `replay_missing`
  (aucune grille dans `Moulinage.form`).
- **Arité non détectée** : `Error.Raise(msg, type)` à deux arguments (l. 934, fonction native,
  hors contrôle de `deps.py`) → MOULINAGE-A12.
- **Tables surestimées** : `Fiches_BordereauxC`, `Fiches_Tleg`, `Fiches_LibelFac`,
  `Fiches_Echeances`, `Fiches_AdrlivBL`, `Fiches_Societes`, `Fiches_MvtM` (`TabMvtM`) ne sont citées
  que dans le `LOCK TABLES` (l. 1064) : `Moulinage` ne les lit ni ne les écrit directement (elles
  servent aux classes appelées sous verrou). En particulier, `Fiches_BordereauxC` n'est **plus
  alimentée** par le moulinage depuis `d2a027d8` (2020) : l'ancien `INSERT` a été remplacé par la
  trésorerie `EcrReg` (la documentation de `BordereauxC` a été corrigée en ce sens).
- **Tables non détectées** : tables de travail `Totalisation` (clé `Cbase`), `Virements`,
  `Tmp_Caisse` ; tables écrites par les classes appelées : `Fiches_HistoFac`/`Fiches_HistoLigfac`
  et `Fiches_ligregie` (`ObjFacB.comptmat`), `Fiches_Docactif` (`DocActif` via `Ent_Bl`),
  `Fiches_Mvt` (`EcrReg`/`EcrAuto`), `Fiches_Comptes` (`Csolde`), `Fiches_Bl`/`Fiches_Ligbl`
  (`Facturergbl`). `Fiches_HisEntTickets` est atteinte par deux clés `Cbase` (`TabHEntTck`,
  `TabHisEntTck`), idem `Fiches_HisLigTickets`.
- **Dépendances par objet** non résolues par `deps.py` : `fac`/`ccd As ObjFacB` (`editef`,
  `comptmat`, membres hérités d'`ObjFac` : `journal`, `numeroecr`, `numerodef`, `numfac`,
  `numbl`), `RegroupBL As Facturergbl` (`Ent_Bl`, `Maj_Parametres`), `ecr As EcrReg` (`ecriture`
  hérité d'`EcrAuto`), `drt As Calculdroit1` (`mnt`, `G`, `TotBTC`, `accise_droit().Montant`).
  `New EcrReg(code, journal, var)` : `nreg` puis les deux paramètres d'`EcrAuto._new` (ordre
  Gambas : paramètres obligatoires de la classe fille d'abord) — correct.
- **`Facturergbl` instancié** (l. 1007) : son `_New` exécute `Shell "lpc status"`,
  `Utils.Observers(Me)` (instance invisible journalisée par le log de rejeu) et `Music.Load`.
  `Ent_Bl` pose ses propres `LOCK TABLES` via `DocActif` (FACTURERGBL-A03) qui remplacent ceux du
  moulinage.
- **`Mreglement`** : auto-instance du formulaire (`RegCais`, `CodeCais`, `RegMode2CodeCaisse`,
  `Laision_Reg`) ; MREGLEMENT-002 (passage en `Static`) laisse la syntaxe inchangée ici.
- **Anomalies liées dans d'autres fichiers** (à corriger dans le même commit ou à rejouer avec les
  scénarios de moulinage) : CALCULDROIT1-A01 (accise non retirée en option `B`, l. 2812-2860),
  OBJFACB-A02 (`comptmat` sans `Commit`, l. 2870), FACTURERGBL-A03 (verrous), FACTURE-A07 (6e
  tranche de remise), SAISECRIT-A01 (numéro d'écriture sans verrou), BORDEREAUXC-A03
  (`Maj_Collectif`).
- **Dépendance circulaire** : `Caisse` → `Moulinage` (`Generation_Bl`, `Livre_caisse`) ; aucune
  dépendance de `Moulinage` vers `Caisse` (la copie de `arrondi` est locale). `Moulinage` →
  `Facturergbl` → (aucun retour).
- **Ordre de rework** : après `Utils` (`arrondi`, `Cbase`), `Sha1Calc`, `Csolde`, `Mreglement`,
  `Facturergbl`, `ObjFacB`/`calculdroit1`, `EcrReg`/`VarEcr` ; dans le même lot que `BordereauxC`
  pour le service commun d'écritures (BORDEREAUXC-009). Gros fichier : changements minimaux.
