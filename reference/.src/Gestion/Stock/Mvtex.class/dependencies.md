# Mvtex — Dépendances

> Source : `.src/Gestion/Stock/Mvtex.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Mvtex.class` — classe, formulaire associé `Mvtex.form`
- Handlers GUI détectés : 9
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `rcppt_keypress`, `Quantite`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Colrcp`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Comment` | `<hérité>` |
| `DB_Connection` | `Create9`, `Edit`, `Exec` |
| `Doc` | `Open` |
| `LDate` | `D`, `G`, `L` |
| `Start` | `B`, `G`, `Musique`, `R`, `son` |
| `TextReg` | `<form>`, `EstDate`, `EstNum`, `Name`, `Select`, `Text`, `Type`, `Value`, `dte`, `nbdec` |
| `TriArticles` | `<type>` |
| `Utils` | `CDec`, `Find_cbarre`, `Observers`, `Option`, `cpoint`, `db`, `totobs` |
| `VerifDate` | `<type>`, `ClotDroi` |
| `Visualiseur` | `Prog` |
| `calculdroit` | `<type>`, `droit`, `secu`, `tauxtvadr`, `tauxtvass`, `vol`, `volap`, `volumess` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Mvtexp`, `Fiches_Parametres`, `Fiches_Tvaav`, `Fiches_ligregie`, `Fiches_regie`

### Membres Public sans usage externe détecté (portée réductible ?)

`CleanChamps`, `RazBl`, `rcppt_keypress`, `art_man`, `SelectionArt`, `Quantite`, `qterecue_LF`, `Maj_qte`, `Maj_colrcp`, `Enrgbl`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.class:1001` (`Menu79_Click`, `Mvtex.showModal()` après contrôle du
  tunnel de réplication).
- **`unused` vérifiés** : `Quantite` (aucun appel) et `rcppt_keypress` (aucun groupe ni contrôle
  `rcppt` dans `Mvtex.form` ; le groupe est `Rcpt`) ; le second est un handler mal nommé
  (MVTEX-A01).
- **Faux positif « portée réductible »** : aucun ; les 10 noms listés sont soit réductibles
  (MVTEX-005), soit code mort.
- **`Bsel`/`Bval`** : écrits dynamiquement par `TriArticles` via `Object.SetProperty` (non vus
  par l'heuristique) : rester `Public`.
- **Tables** : `Fiches_Mvtexp` (écriture), `Fiches_Art` (lecture, `art_qte` modifié),
  `Fiches_regie`/`Fiches_ligregie` et `Fiches_Parametres.nvign` (option boissons) ;
  `Fiches_Tvaav` n'est citée que dans une affectation inutilisée (`Tab2`, faux positif de table).
- **Colonne hors référence** : `Fiches_Parametres.nvign` est créée par `modfichier.module:86`
  (`ALTER TABLE … ADD nvign`), absente de `db_control.csv`.
- **Lecteurs des données produites** : `Cstock`, `Stockmvt`, `TriHistos`, `Edregul`,
  `ValidinvT` (`Fiches_Mvtexp`) ; éditions de régie (`Fiches_ligregie`).
- **Replay** : `replay_missing = Colrcp` confirmé (pas de `Colrcp_Click`) : utiliser le
  double-clic/Entrée (`Activate`) ou le clavier, jamais un simple clic.
- **Ordre de rework** : indépendant ; la commonalisation « saisie d'article » se fait avec
  `MvtProdcomp`, `MvtDepots`, `Sdepots` ; le helper vignette avec `commande1`.
