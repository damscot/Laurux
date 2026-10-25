# ValidBR — Dépendances

> Source : `.src/Gestion/Stock/ValidBR.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/ValidBR.class` — classe, formulaire associé `ValidBR.form`
- Handlers GUI détectés : 17
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Quittedate`, `FileFilter`, `Bl_Sup`, `ard`, `Button16_Click`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colbl_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Coldetail`

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Create9`, `Edit`, `Engine`, `Exec` |
| `Doc` | `Open` |
| `Edbr` | `Ed`, `Init` |
| `LDate` | `_call` |
| `LGed` | `<type>`, `AddTag`, `AddTags`, `Comptabilite`, `DTE`, `Fournisseurs`, `HT`, `String2Array`, `TTC` |
| `LPrix` | `<type>`, `Add`, `_call` |
| `LVar` | `<type>`, `AddDate`, `Evaluate`, `ParseResult` |
| `Sha1Calc` | `CalcSha1` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TriCpt` | `<type>`, `Fournisseur`, `Sans_Solde` |
| `Utils` | `Calcech`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Coulfd`, `Fcolr`, `Observers`, `Option`, `convBool`, `cpoint`, `db`, `totobs` |
| `Variables` | `inumr` |
| `calculdroit` | `<type>`, `droit`, `drsurfac` |
| `commande1` | `<type>` |

### Tables SQL référencées

`Docs_Ged`, `Docs_Tag`, `Fiches_Art`, `Fiches_Comptes`, `Fiches_Echeances`, `Fiches_Entrecpt`, `Fiches_Fam`, `Fiches_Four`, `Fiches_HistoFac`, `Fiches_Ligrecpt`, `Fiches_Mo`, `Fiches_Mvt`, `Fiches_MvtM`, `Fiches_Parametres`, `Fiches_Societes`, `Fiches_Tag`, `Fiches_Tleg`, `Fiches_Tvaac`, `Fiches_Tvaav`, `Fiches_ligcons`, `Fiches_ligregie`, `Fiches_regie`

### Membres Public sans usage externe détecté (portée réductible ?)

`recup_bl`, `Quittedate`, `Gen_ecr`, `Parametres`, `Ventilation`, `Raz_Ventilation`, `Maj_Totalisation`, `Verif_solde`, `Maj_Compta`, `Ecritures`, `Majnum`, `Bl_Sup`, `ard`, `Button16_Click`, `Exo`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** (`used_by` vide, confirmé par `grep -rnw ValidBR .src .project`) : seul
  `Edbr.module:216` compare son paramètre `Org` à la chaîne `"ValidBR"`, valeur passée
  uniquement par `ValidBR.class:693`. Si ValidBR est supprimé (VALIDBR-A01), la branche
  `If Org == "ValidBR"` d'`Edbr.Ed` devient morte (à reporter dans la doc d'`Edbr`, lot
  Impressions).
- **Historique** : `Fmenu.Menu232_Click` appelait `ValidBR.ShowModal()` jusqu'au commit
  `a06ada7a` (2022-04-23), remplacé par `ValidBR1.ShowModal()`.
- **`unused` vérifiés** : `Quittedate`, `FileFilter`, `Bl_Sup`, `ard`, `Button16_Click` (pas de
  `Button16` dans le `.form`). Les 15 noms « portée réductible » sont réductibles **si** le
  fichier est conservé ; `Exo` est une variable `Public` sans lecteur externe.
- **`replay_dynamic`** : `Colbl_Click` (ColumnView) appelé via `Object.Call` par le rejeu : à
  garder `Public`. **`replay_missing`** : `Coldetail` sans `Coldetail_Click`.
- **Tables** : nombreuses tables métier en écriture (`Fiches_Entrecpt.validee`, `Fiches_Mvt`,
  `Fiches_Comptes.solde`, `Fiches_Parametres`) et trois tables de travail créées à l'exécution
  (`BRfm`, `Br`, `Totalisation`, hors `db_control.csv`, non vues par `deps.py`).
- **Dépendances sortantes notables** : `commande1` (`Coldetail_Activate`), `Edbr`, `Sha1Calc`,
  `LGed`, `LVar` (LVAR-004 le cite comme appelant), `Calculdroit`, `TriCpt`. Les docs de `LVar`,
  `LGed` listent `ValidBR` parmi leurs appelants : ces mentions deviendront caduques si A01 est
  validée.
