# Saisecrit — Dépendances

> Source : `.src/Compta/Saisecrit.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Saisecrit.class` — classe, formulaire associé `Saisecrit.form`
- Handlers GUI détectés : 37
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `numcompte_LostFocus`, `Dateech_DblClick`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Ecr2`, `Compdate`, `numcompte_LostFocus`, `renlig`, `Masque_Click`, `Dateech_DblClick`, `FileFilter`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Choix1_Click`, `Jour_Click`, `Vtl_Click`, `Libview_Click`, `Colabt_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Ecrit1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |
| `.src/Compta/Extrait.class` | `<type>` |
| `.src/Compta/Utils/Ecritures.class` | `<type>` |
| `.src/Compta/Utils/Fmontant.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Abont` | `Compteur_Incr` |
| `Analytique` | `<type>` |
| `Cbase` | `Table` |
| `Comptabilite` | `Bsel`, `snum` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Extrait` | `<type>` |
| `FCalc` | `<type>`, `Resultat` |
| `FClient` | `<hérité>` |
| `FComptes` | `<hérité>` |
| `FFournisseur` | `<hérité>` |
| `LDate` | `<type>`, `EFin`, `G`, `_call` |
| `LGed` | `<type>`, `AddTag`, `AddTags`, `Comptabilite`, `DTE`, `HT`, `Search`, `String2Array`, `Supprime`, `TTC` |
| `LPrix` | `<type>`, `Abs`, `Add`, `Sub`, `_call` |
| `LVar` | `<type>`, `AddDate`, `Evaluate`, `ParseResult` |
| `Sha1Calc` | `CalcSha1` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TextReg` | `<form>`, `MaxLength`, `Name`, `RechX`, `RechY`, `Select`, `Text`, `champs`, `condition`, `conteneur`, `recherche` |
| `TriCpt` | `<type>`, `Avec_Solde` |
| `TriEcritures` | `<type>` |
| `Utils` | `Calcech`, `Cdate_Aff`, `Cdate_calc`, `Observers`, `Remplace`, `SetEditColor`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Analytiques`, `Fiches_Cli`, `Fiches_Cli_Vtl`, `Fiches_Comptes`, `Fiches_Echeances`, `Fiches_Four`, `Fiches_Four_Vtl`, `Fiches_Journaux`, `Fiches_Libelles`, `Fiches_Ligabon`, `Fiches_Mvt`, `Fiches_MvtA`, `Fiches_MvtM`, `Fiches_Numabon`, `Fiches_Parametres`, `Fiches_Tvaac`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Cleanchamps`, `dateEcheance`, `Movt`, `compte`, `compteman`, `compteGman`, `Leccompteg`, `Journauxman`, `Journaux`, `Ecritures`, `Majnum`, `ecritnv`, `ecritv`, `Ecr1`, `Ecr2`, `ventil`, `ventilAuto`, `Lib`, `Calctva`, `aff_tva`, `Compdate`, `QuitteDate`, `QuitteDate2`, `Type_compte`, `Journal_GotFocus`, `Journal_LostFocus`, `Datej_GotFocus`, `Dateech_GotFocus`, `numcompte_GotFocus`, `Datej_LostFocus`, `Dateech_LostFocus`, `numcompte_LostFocus`, `Montant_GotFocus`, `Montant_LostFocus`, `numdoc_GotFocus`, `numdoc_LostFocus`, `numlot_GotFocus`, `numlot_LostFocus`, `Libelecrit_GotFocus`, `Libelecrit_LostFocus`, `Button4_Click`, `Button2_Click`, `Enrg_Ecr`, `Ventilations_Click`, `Calculsolde`, `Recup_Type`, `renlig`, `DelEcr`, `Ecrit_Click`, `ecrit2`, `Ecrit3`, `Necrit_Click`, `DelMvt`, `DelMvt2`, `clear`, `Masque_Click`, `Sens_Ecr`, `Button1_Click`, `Button3_Click`, `Aff_Mask`, `Deb3`, `LignAbt`, `Dateech_DblClick`
<!-- /AUTO:dependances -->

## Notes d'analyse

### Appelants réels (grep)

| Appelant | Appel | Contexte |
|---|---|---|
| `Fmenu.Menu21_Click` (`Fmenu.class:660`) | `New Saisecrit("")` + `Show` | menu Comptabilité, après contrôle de réplication |
| `Extrait.Appel_Saisie` (`Extrait.class:1237`) | `New Saisecrit("")` + `ShowModal` | nouvelle écriture depuis l'extrait |
| `Extrait.Necrit_Click` (`Extrait.class:1215`) | `New Saisecrit(num, Me.Parent, True)` | modification d'une écriture non trésorerie |
| `Ecritures.Necrit_Click` (`Ecritures.class:397`) | idem | idem |
| `Fmontant` (`Fmontant.class:199`) | `New Saisecrit(Somme.Current[4], Me.Parent, True)` | idem |

Les trois derniers passent trois arguments à `_new(num2, Optional ecrmodif)` (SAISECRIT-A09).

### Ce que l'heuristique surestime ou rate

- **Portée réductible, faux positifs** : `Bsel` et `Bval` sont écrits par `TriCpt` via
  `Object.SetProperty($obj, "Bsel"/"Bval", …)` (`TriCpt.class:112-113`) ; ils restent `Public`.
- **Handlers inactifs** (signalés par `deps.py`, confirmés) : `numcompte_LostFocus` (aucun appel
  direct, code mort) et `Dateech_DblClick` (aucun appel ; `DateChooser1` n'est donc jamais visible,
  ce qui rend aussi `DateChooser1_Activate` inatteignable). En revanche, une vingtaine d'autres
  fonctions nommées `<Contrôle>_<Événement>` pour des contrôles des groupes `Cmpt`/`Btn`
  (`Montant_GotFocus`, `Datej_LostFocus`, `Button4_Click`…) sont classées « handler GUI » alors
  qu'elles ne sont jamais levées : ce sont des méthodes appelées directement (non signalées comme
  inactives parce qu'elles ont des appels internes).
- **Attribution erronée à `LGed`** : `<hérité:showmodal>` ligne 1344 concerne la variable
  d'instance `hForm As FCalc`, masquée dans `Button5_Click` par une locale `hForm As LGed`
  (homonymie de variables, même nom à deux portées). `Delete()` ligne 3133 est la méthode héritée
  du formulaire `LGed` (destruction de la fenêtre), pas une suppression en base.
- **Tables non détectées comme telles** : `Fiches_MvtM` (en dur, 3 requêtes), `Fiches_Echeances`
  (en dur via la variable `Tab4`), `Ecrs` (table de travail, `Cbase.Table("Ecrs")` et en dur dans
  `Ecr2`), `Fiches_Mvt` passé en chaîne à `Sha1Calc.CalcSha1`. La liste `Tables SQL référencées`
  les inclut, mais sans distinguer lecture et écriture : écritures sur `Fiches_Mvt`, `Fiches_MvtA`,
  `Fiches_MvtM`, `Fiches_Comptes` (`solde`), `Fiches_Parametres` (`numecriture`), `Ecrs`.
- **Dépendances par auto-instance de formulaire** : `FComptes.ShowModal()`, `FClient.ShowModal()`,
  `FFournisseur.ShowModal()` (F4), `Abont.Compteur_Incr` (méthode d'un formulaire appelée sur son
  auto-instance), `FCalc.Resultat` (`Static Public`, `FCalc.class:13` : lu par la classe alors que la
  fenêtre affichée est l'instance `hForm`).
- **Retour de sélection par module global** : `Comptabilite.Bsel`/`Comptabilite.snum`, écrits par
  `TriEcritures.class:633` ; dépendance indirecte `Saisecrit` → `TriEcritures` → `Comptabilite`.

### Appels dynamiques entrants

- `ReplayObserver.Replay_Event` appelle `Object.Call(window, <ColumnView|ListBox>.Name & "_Click")`
  pour les `ColumnView`/`ListBox` : `Jour_Click`, `Vtl_Click`, `Libview_Click`, `Colabt_Click`,
  `Choix1_Click` (existent) et `Ecrit1_Click` (**n'existe pas** : le rejeu d'un clic sur `Ecrit1`
  échoue, à confirmer). Ces noms et leur portée `Public` sont intouchables.
- `Utils.Observers(Me)` installe les observateurs de journalisation sur tous les contrôles.

### Dépendances circulaires et ordre de rework

- `Saisecrit` ↔ `Extrait` : `Saisecrit` ouvre `Extrait` (F8) et `Extrait` ouvre `Saisecrit`.
- `Saisecrit` ↔ `TriCpt` (retour par `Object.SetProperty` sur `Me`).
- Ordre conseillé : SAISECRIT-001 à 004 et 011/012 en premier (sans dépendance) ; 005 avec le
  helper `LVar` (lot Utils) ; 010 avec `Tresor`, `Extrait`, `Archives`, `Facture` ; 015 après le
  rework de `Tresor` (phase 3, même lot).
