# ObjFacB — Dépendances

> Source : `.src/Gestion/option/ObjFacB.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/ObjFacB.class` — classe, hérite de `ObjFac`
- Handlers GUI détectés : 1

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Moulinage.class` | `<type>`, `comptmat`, `editef` |
| `.src/Gestion/ClotureF.class` | `<type>`, `calcul`, `transblfac` |
| `.src/Gestion/Facturation/Facture.class` | `<type>`, `calcul`, `transblfac` |
| `.src/Gestion/Facturation/OptFac.class` | `<type>`, `editebl`, `editef`, `editefm`, `mail`, `visualisation` |
| `.src/Gestion/Stockmvt.class` | `<type>`, `visualisation` |
| `.src/Gestion/option/Caleditcmat.class` | `<type>`, `calcul` |
| `.src/Gestion/option/EditfacB.class` | `<type>`, `aimprimer`, `ascise`, `borientation`, `consigne`, `decons`, `deconsigne`, `droit`, `nbdecons`, `poid`, `secu`, `totap`, `totvolume` |
| `.src/Reports/Editfac.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `ComMail` | `<type>` |
| `DB_Connection` | `Create9`, `Edit`, `Exec` |
| `DocActif` | `Free_Lock`, `Get_Lock` |
| `EditfacB` | `<type>` |
| `EnvMail` | `Envoi`, `Envoi2` |
| `Impression` | `Facture` |
| `LDate` | `<type>`, `_call` |
| `ObjFac` | `<type>`, `AffClient`, `CopieGedFac`, `adrfac`, `archive`, `bl`, `calcul`, `choix`, `code`, `commande`, `condvent`, `devis`, `dtedoc`, `dteech`, `dtmouv`, `ecrit`, `ecriture`, `ecriturecompt`, `edit`, `facture`, `finmois`, `gestion`, `gmateriel`, `imp`, `joinfac`, `ligne`, `lignetva`, `magasin`, `montart`, `montht`, `montmo`, `montttc`, `monttva`, `nbexplemplaire`, `nom`, `num`, `numbl`, `numcli`, `numfac`, `pdf`, `proforma`, `qte`, `remart`, `remmo`, `rescli`, `resent`, `reslig`, `saisreg`, `tab`, `testchem`, `tva`, `type`, `verifdat` |
| `ProgBar` | `<type>`, `Avancement` |
| `SaiReg` | `<type>`, `Form_Close` |
| `Utils` | `Option`, `arrondi`, `db`, `totobs` |
| `VarEcr` | `Caisse` |
| `Variables` | `sTexte` |
| `VerifDate` | `<type>`, `ClotDroi`, `ClotFac` |
| `Visualiseur` | `Prog` |
| `calculdroit` | `<type>`, `codetva`, `cptreg`, `droit`, `drsurfac`, `famille`, `secu`, `suspendu`, `tauxtvadr`, `tauxtvass`, `tvadroit`, `tvasec`, `type`, `vol`, `volap`, `volumess` |

### Tables SQL référencées

`Fiches_AdrlivBL`, `Fiches_Art`, `Fiches_Bl`, `Fiches_Cli`, `Fiches_Comptes`, `Fiches_Fam`, `Fiches_HisentMat`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_Ligbl`, `Fiches_Materiels`, `Fiches_Parametres`, `Fiches_Sdepots`, `Fiches_Tvaav`, `Fiches_TxtMail`, `Fiches_consigne`, `Fiches_ligcons`, `Fiches_ligregie`, `Fiches_regie`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Héritage** : `Inherits ObjFac`. `calcul` redéfinit la méthode parente (`Super.calcul`,
  l. 71) ; `verifdat` la masque en `Private` (`Super.verifdat`, l. 923). `ObjFac.calcul` et
  `ObjFac.verifdat` doivent rester `Public`. Les membres hérités utilisés par `Me.` sont listés
  dans architecture.md ; ils contraignent toute réduction de portée d'`ObjFac` (voir
  [ObjFac/dependencies.md](../../Facturation/ObjFac.class/dependencies.md)).
- **`_call` surestimé** : `deps.py` compte les `New ObjFacB(…)` (`Moulinage:1310/1368/2869`,
  `ClotureF:136`, `Facture:1589/2124`, `OptFac:40`, `Stockmvt:673/676`, `Caleditcmat:106`) comme
  des appels de `_call`. Vérifié par `grep` : aucun appel `ObjFacB(…)` hors commentaire
  (`ClotureF:135`) → `_call` est du code mort.
- **Appelants réels des méthodes** (variables typées `ObjFacB`) : `calcul` (`Facture:2553/9804`,
  `ClotureF:138`, `Caleditcmat:108`), `transblfac` (`Facture:9805`, `ClotureF:139`), `editef`
  (`OptFac:505`, `Moulinage:1314`), `editefm` (`OptFac:501`), `editebl` (`OptFac:508`),
  `visualisation` (`OptFac:527`, `Stockmvt:674/677`), `mail` (`OptFac:546`), `comptmat`
  (`Moulinage:2870`), `borientation`, `poid` et les propriétés de cumul (`EditfacB`).
  Propriétés `totht`, `clotmat` : aucun lecteur.
- **Instanciation par `Moulinage`** (`ccd = New ObjFacB(snfac, ObjFac.magasin)`) sans `calcul` :
  `$borientation` reste faux, ce qui conditionne le chemin de `comptmat` (A02).
- **Événements** : `$sreg = New SaiReg(…) As "win"` → `win_close` reçoit l'événement `Close`
  du formulaire `SaiReg` (aucun gestionnaire `win_RegCaisse`, voir SAIREG-A01).
- **Tables non vues** (concaténation `& Me.tab`, tables de travail) : `Fiches_HistoLigfacM`,
  `Fiches_BlM`, `Fiches_LigblM`, `Facturefm`, `Bl` (détail dans architecture.md).
- **Schéma hors référence** : `Fiches_ligcons`, `Fiches_consigne`, `Fiches_ligregie`,
  `Fiches_regie` et les colonnes d'option sont créées par `modfichier` (pas dans
  `db_control.csv`).
- **Dépendance circulaire** : `ObjFacB` ↔ `EditfacB` (`New EditfacB(Me, Me)` / `$cal As ObjFacB`)
  et `ObjFacB` ↔ `Editfac` (`Editfac._new(vfac As ObjFacB)`).
- **Ordre de rework** : `ObjFac` → `ObjFacB` → `EditfacB`/`Editfac`, `OptFac` ; prérequis
  externes `TLEG-003` (texte unique) et `Calculdroit` (lot option).
