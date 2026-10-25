# commande1 — Dépendances

> Source : `.src/Gestion/Stock/commande1.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/commande1.class` — classe, Create Static, formulaire associé `commande1.form`
- Handlers GUI détectés : 41

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Gestion/Stock/ValidBR.class` | `<type>` |
| `.src/Gestion/Stock/ValidBR1.class` | `<type>` |
| `.src/Gestion/Stockmvt.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Achat` | `<type>`, `Consignes`, `ContMat`, `CreMat`, `CreRec`, `CreReliquat`, `CreaCommande`, `Delete`, `Doublon`, `EnCommande`, `EnrAch`, `FicheArt`, `Import`, `LitCommande`, `Reception`, `Sans`, `Show`, `SupAchat`, `TotHt`, `TotTtc`, `Validee`, `ajout`, `commentaire`, `date`, `fourisseur`, `generer`, `imprime`, `mail`, `ndoc` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec`, `LockIncrement`, `Prepare` |
| `DateTar` | `<type>` |
| `DocActif` | `Free_Lock`, `Get_Lock` |
| `GesTar` | `<type>`, `Delete`, `EnrArt`, `EnrEtiqu`, `EnrTar`, `EnrTarTemp`, `LecArt`, `SupTarTemp`, `TarCli`, `TarTcli`, `ligachat` |
| `LDate` | `<type>`, `Apres`, `D`, `F`, `G`, `L`, `_call` |
| `LGed` | `<type>`, `AddTag`, `AddTags`, `DTE`, `DelAllTag`, `Fournisseurs`, `HT`, `PDFDupli`, `Search`, `String2Array`, `Supprime`, `TTC` |
| `LPrix` | `<type>`, `Qte`, `TotNTC`, `_call` |
| `ObjProp` | `<type>`, `AddChamp`, `cle`, `tri` |
| `SaiTableau` | `Netoyage`, `Tableau`, `VisibleTot`, `ind`, `ligne` |
| `Sailig` | `<type>`, `AutresObj`, `Delete`, `Dernier`, `MonControle`, `Y`, `chain`, `prx` |
| `Start` | `LocalSettings`, `Societe` |
| `TextReg` | `<form>`, `<type>`, `EstDate`, `EstNum`, `MaxLength`, `Text`, `Type`, `Value`, `dte`, `nbdec` |
| `TriCpt` | `<type>`, `Fournisseur`, `Sans_Solde` |
| `TriGen` | `<type>`, `ExtraSel`, `Update` |
| `Utils` | `Option`, `db` |
| `ValidBR1` | `Ecritures` |
| `VarEcr` | `<type>` |
| `VerifDate` | `<type>`, `ClotDroi`, `DateCom` |
| `Visualiseur` | `Prog` |
| `artopt` | `<type>`, `numart` |
| `chainage` | `<type>`, `sup` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Cli`, `Fiches_Entcom`, `Fiches_Entrecpt`, `Fiches_Four`, `Fiches_Ligcom`, `Fiches_Ligrecpt`, `Fiches_Parametres`, `Fiches_TarTemp`, `Fiches_TarTypcli`, `Fiches_Tarcli`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`Update_Req`, `tbl`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés** : `Fmenu.class:1021` (`Commande1.show()`, auto-instance) ;
  `ValidBR1.class:204` (`TriBr_Activate`), `Stockmvt.class:680` (`GridView1_Activate`,
  état `Validee`), `ValidBR.class:328` (écran mort, VALIDBR-A01) : `New Commande1(Null, num,
  four, LDate(...)[, etat])`, `Null` étant le `Parent` du formulaire.
- **Dépendance circulaire** `commande1` ↔ `ValidBR1` (`ValidBR1.Showmodal`, `ValidBR1.Ecritures`
  l. 691/733 ; `New Commande1` dans `ValidBR1`).
- **Objets incrustés et événements** : `Achat` (`As "Achat"` : `Achat_Ajou`, `Achat_LecArt`,
  `Achat_EnrTarTemp`, `Achat_gotfocus`, `Achat_lostfocus`), `GesTar` (`As "Tarif"` :
  `Tarif_EnrTar`, `Tarif_CoulBout`), `Observer` sur les `LPrix` des lignes (`LPrix_change`),
  `TriGen` (`As "ColTri"` : `ColTri_MajSel`, `ColTri_KeyPress`), `Window` (`Window_Close`),
  radios et boutons créés par code (`commande_click`, `reception_click`, `Valide_click`,
  `Bavec_click`, `Bsans_click`, `Ecraban_click`, `Babandon_click`, `Bvalide_click`). Tous restent
  `Public`.
- **Appels dynamiques non vus** : `TriGen` et `TriCpt` écrivent `Bsel`/`Bval` par
  `Object.SetProperty` ; `Last.Tag.Close(n)` sur la fenêtre portée par le `Tag` ;
  `sl.AutresObj[Achat.Consignes].ccd…`, `lg.AutresObj[Achat.FicheArt]["art_dra"]` (objets
  `Variant`).
- **« Portée réductible »** : `Update_Req` confirmé ; `tbl` sans accès externe trouvé (les
  `.tbl` d'`Editfac` sont un autre contrôle), conservé `Public` par prudence.
- **Transaction partagée** : `Begin` ici, `Rollback` dans `Achat.SupAchat`, `Commit` dans
  `Achat.EnrAch` (`Achat.class:895`), tarifs par `GesTar` hors transaction, `Commit`
  supplémentaire dans `ValCom` ; `GesTar.Enreg_Click` → `Tarif_EnrTar` imbriqué. Tout rework de
  ces séquences se fait **conjointement** avec `Achat` et `GesTar` (et leurs tests ACHAT-T*,
  GESTAR-T*).
- **GESTAR-A01** : `commande1.class:508` (`suppr_Click`) appelle `$gestarif.SupTarTemp()` dans
  la boucle des lignes sans changer d'article ; la correction (paramètre article) modifie les deux
  fichiers dans le même commit.
- **Tables** : en dur sauf `TabFour` (dans `ged`) ; requêtes préparées `requ_cli`/`requ_typ`
  lues par `GesTar` (`Fiches_TarTemp`, `Fiches_Tarcli`, `Fiches_TarTypcli`, `Fiches_Typec`,
  `Fiches_Cli`, `Fiches_Art`) ; `Fiches_Parametres.nvign` (colonne créée par
  `modfichier.module:86`, hors `db_control.csv`), `dnbr`, `dncom`.
- **Phase 2** : aucun appel à `Utils.Observers` (ni dans `Achat`, `GesTar`) → les replays
  d'`ACHAT`, `GESTAR`, `TEXTREG-T05` et de ce fichier supposent l'instrumentation par le harnais
  ou COMMANDE1-A08.
- **Ordre de rework** : après `SaiTableau`/`Sailig` ; en même temps que `Achat` et `GesTar` ;
  `ValidBR1` (appel `Ecritures`) ; `LGed` (LGED-007) avant le rework de `ged`.
