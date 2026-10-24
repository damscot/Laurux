# Facture — Dépendances

> Source : `.src/Gestion/Facturation/Facture.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Facturation/Facture.class` — classe, formulaire associé `Facture.form`
- Handlers GUI détectés : 177
- ⚠️ Appels avec un nombre d'arguments incompatible avec la signature : l. 4055 `Facture.Wrg` (0 donnés, attendus 1)
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `ChkPrx`, `modifblopt`, `aff_cp`, `ChkCp`, `Ref`, `Art_Equ2`, `Tarifclient`, `Artnet_GF`, `CalcHt`, `Bl_Sup`, `Ecritures`, `Majnum`, `SetObservers`, `Recup_EncoursBl`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colcp_Click`, `Colmo_Click`, `hcol_click`, `NumsList_Click`, `Colfam_Click`, `Colcom_Click`, `Colal_Click`
- ⚠️ Requêtes dont les arguments ne correspondent pas aux marqueurs `&N` : l. 11099 (1 argument(s), marqueurs aucun)
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Colbl`, `Coldetail`, `Coldetail2`, `Coldetail3`, `Coltaches`
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [2087](../../../../../.src/Gestion/Facturation/Facture.class#L2087), [2088](../../../../../.src/Gestion/Facturation/Facture.class#L2088), [2089](../../../../../.src/Gestion/Facturation/Facture.class#L2089), [2090](../../../../../.src/Gestion/Facturation/Facture.class#L2090), [2091](../../../../../.src/Gestion/Facturation/Facture.class#L2091), [2092](../../../../../.src/Gestion/Facturation/Facture.class#L2092)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |
| `.src/Gestion/Facturation/ConVendeurs.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `AFacture` | `<type>` |
| `ArtPromo` | `Maj_qtemoins`, `Maj_qteplus`, `art_Promo` |
| `Articles` | `<hérité>` |
| `CPrix` | `CTva` |
| `Cbase` | `Table` |
| `Cdocuments2` | `<type>` |
| `Comment` | `<hérité>` |
| `ConVendeurs` | `<hérité>` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `DocActif` | `Free_Lock`, `Get_Lock`, `Is_Lock` |
| `Editeur` | `Prog_Editeur` |
| `Enrgcp` | `Ecp` |
| `FCalc` | `<type>`, `Resultat` |
| `FClient` | `<hérité>` |
| `FFournisseur` | `<type>` |
| `Fcaras` | `<type>` |
| `LDate` | `DateFilterDB`, `_call` |
| `LGed` | `<type>`, `Clients`, `Search`, `Supprime` |
| `LPrix` | `_call` |
| `Listecom` | `<type>` |
| `Listextcpt` | `<type>`, `resext` |
| `Movr` | `<hérité>` |
| `ObjFac` | `atelier`, `bl`, `choix`, `commande`, `devis`, `facture`, `montht`, `montttc`, `monttva`, `numcli`, `proforma` |
| `ObjFacB` | `<type>`, `calcul`, `transblfac` |
| `OptFac` | `<type>` |
| `Start` | `Bon`, `Commande`, `Devis`, `Devis2`, `Facture`, `LocalSettings`, `Musique`, `Proform`, `Societe`, `son` |
| `Suivi` | `<type>` |
| `Syntheses` | `Message` |
| `TarArt` | `<type>`, `detail`, `prixht`, `prixrht`, `promo` |
| `TextReg` | `<form>`, `EstNum`, `MaxLength`, `Name`, `RechX`, `RechY`, `Select`, `Text`, `Type`, `champs`, `commence_par`, `conteneur`, `lke`, `recherche` |
| `TriArticles` | `<type>` |
| `TriCpt` | `<type>`, `Avec_Solde`, `Client`, `Fournisseur`, `Sans_Solde` |
| `TriEqu` | `<type>` |
| `TriFac` | `<type>` |
| `TriFac2` | `<type>` |
| `Tricp` | `<type>` |
| `Utils` | `Base`, `Base3`, `Base4`, `Calcech`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Commande`, `ControlTunnel`, `Fcolr`, `Find_cbarre`, `Find_nbdec`, `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `Option`, `PointBase`, `Remplace`, `ReplaceLb`, `SetEditColor`, `cpoint`, `db`, `rs1`, `rs3`, `rs4`, `totobs` |
| `Variables` | `$Codearticle`, `Bsel`, `Bureaudistributeur`, `FMateriel`, `bRemise`, `codepostal`, `numeroFac` |
| `VerifDate` | `<type>`, `ClotDroi` |
| `Visualiseur` | `Prog` |
| `calculdroit` | `<type>` |
| `facopt` | `<type>`, `affcons`, `affdecons`, `affdroit`, `clicons`, `copdecons`, `deplig`, `imprime`, `majlig`, `numbl`, `suplig` |
| `rechtipp` | `<type>` |
| `rechtour` | `<type>` |

### Tables SQL référencées

`Fiches_AdrlivC`, `Fiches_Art`, `Fiches_ArtPromo`, `Fiches_Bl`, `Fiches_BlM`, `Fiches_Cequ`, `Fiches_Cli`, `Fiches_CoeffTypec`, `Fiches_Commentaires`, `Fiches_Comptes`, `Fiches_ContactC`, `Fiches_Cpostaux`, `Fiches_Depots`, `Fiches_Echeances`, `Fiches_EntMat`, `Fiches_Fam`, `Fiches_Four`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Materiels`, `Fiches_Mo`, `Fiches_Mvt`, `Fiches_Parametres`, `Fiches_PrdComp`, `Fiches_Promo`, `Fiches_RemTypec`, `Fiches_Rpl1`, `Fiches_StkDepots`, `Fiches_Taches`, `Fiches_TarTypcli`, `Fiches_Tarcli`, `Fiches_Tvaav`, `Fiches_Typec`, `Fiches_Users`, `Fiches_consigne`, `Fiches_ligcons`, `Fiches_ligregie`, `Fiches_ligtarpp`, `Fiches_region`, `Fiches_tourne`, `Mails_Cli`

### Membres Public sans usage externe détecté (portée réductible ?)

`lcoldetail`, `CleanChamps`, `ChkPrx`, `Verif_Encours`, `Raz_client`, `Lignes_Bon`, `Button15_Click`, `Button2_Click`, `Button4_Click`, `RdimColbl`, `ColblSelection`, `Recup_ligbl`, `CalculTotal`, `calculfindoc`, `Cpman`, `aff_cp`, `ChkCp`, `RecupTaches`, `SelectionMo`, `TriMo`, `Deb7`, `Deb8`, `Ref`, `Dbclkmo`, `ChkInput3`, `mo_man`, `Chg`, `Razmo`, `Calc_Net`, `Calc_Txhr`, `Calc_Brut`, `Calc_Tmont`, `Calc_Puht`, `Calc_Rem`, `arrondimo`, `Calc_TC`, `Calc_moHt`, `Calc_MargeMo`, `Wrg`, `Maj_typeBL`, `MajColdetailMo`, `MajColdetailMo2`, `SelectionArt`, `Art_Rpl`, `Art_Equ`, `Art_Equ2`, `Tarifclient`, `Art_man`, `Maj_zonesArt`, `Quantite`, `Calc_Marge`, `ComArt`, `aff_photo`, `RefLongue`, `Artpu_LF`, `Artqte_LF`, `Remises_quantitatives`, `Cart_LF`, `Artbrut_LF`, `Artrm_LF`, `Artnet_GF`, `Artnet_LF`, `Arttc_LF`, `ChgArt`, `fourman`, `SelectionFour`, `Frm12`, `MajColdetailArt`, `Enrg_Art`, `init`, `Recup_Pdc`, `Num_serie`, `Enrgnum`, `Enrg_Numserie`, `SelectionFam`, `fam_man`, `Ecot`, `Ecot2`, `Txpp`, `MajColdetailEco`, `Cleanart`, `Decimal`, `CalcHt`, `CalcTTC`, `Recup_Tva`, `arrondi`, `Tbremq_Create`, `SelectionCom`, `com_man`, `DupliDoc`, `Rprodcomposes`, `Enrg_LigMo`, `Enrg_Ligcar2`, `Enrg_LigArt`, `Enrg_Promo`, `Enrg_LigArt2`, `Enrg_Ligcar`, `Enrg_Ligcom`, `Enrg_Pdc`, `Ren_ligbl`, `Maj_Base`, `Maj_libelle`, `Maj_Quantite`, `Maj_QuantiteD`, `Maj_Quantite2`, `Maj_QteDep`, `Maj_QteDep2`, `Bl_Suppr`, `Bl_Edit`, `QuitteDate`, `dateEcheance`, `AffDoc`, `Tot_Remises`, `Lig_Archives`, `Bl_Sup`, `Ecritures`, `Majnum`, `EntFac`, `Recup_ligfac`, `Majligbl`, `Importlig`, `GenFacPort`, `Verif_acompte`, `SetObservers`, `Cli_man`, `Recup_EncoursBl`, `Recup_Mail`, `Recup_type`, `ChiffreA`, `SelectionClient`, `Button7_Click`, `Aff_AdrC`, `CleanChampsAdr`, `matman`, `CleanChampsMat`, `Deb1`, `Deb2`, `Colbl_com`, `Colbl_art`, `Colbl_libel`, `Colbl_refl`, `ChkInput2`, `Dbclkcli`, `Titre`, `Creation`, `Codearticle`, `CodeClient`, `numeroFac`, `bRemise`, `Codepostal`, `Bureaudistributeur`
<!-- /AUTO:dependances -->

## Notes d'analyse
- **Appelants vérifiés** (`grep New Facture`) : `Fmenu.Menu42_Click` (`New Facture(False)`, l. 934),
  `Fmenu.Menu193_Click` (`New Facture(True)`, facturation entretien, l. 1781),
  `ConVendeurs.Button1_Click` (`New Facture(False)`, l. 89, même lorsque `Fmenu` a ouvert
  `New ConVendeurs(True)` depuis Menu193 alors que `ConVendeurs._new` n'a pas de paramètre : à
  traiter dans ConVendeurs). Aucun autre fichier n'accède aux membres de `Facture`.
- **Dépendance circulaire** `Facture` ↔ `ConVendeurs` : F5 dans l'entête ouvre
  `ConVendeurs.ShowModal()` (auto-instance), qui crée une nouvelle `Facture` à la validation
  (FACTURE-A23).
- **Retours par `Object.SetProperty`** (non vus comme appels) : `TriCpt` (client, fournisseur) et
  `TriArticles` écrivent `Bsel`/`Bval` dans `Me` → ces deux membres doivent rester `Public`.
  `Tricp`, `TriEqu`, `TriFac`, `TriFac2` répondent par `Variables.Bsel`, `Variables.codepostal`,
  `Variables.Bureaudistributeur`, `Variables.$Codearticle`, `Variables.numeroFac`.
- **Handlers d'événements d'objets** (non vus par l'heuristique) : `trf_selec` (événement `selec`
  de `TarArt`, observateur `"trf"`), `option_recalcul` (`recalcul` de `facopt`, `"option"`),
  `to1_trouve`/`tr1_trouve` (`trouve` de `rechtour`/`rechtipp`) ; contrôles créés par code :
  `Txtb_*` (`hTxtb`), `Matlist_*` (`$Matlist`), `$textpal_*`/`$textcol_*` (non détectés par le
  parseur) et groupe `Art` pour ces deux TextBox ; observateurs `"Entete2"` sur `Textto1`,
  `Texttr1`, `Textfrais` (leurs `Entete2_*` sont donc aussi levés).
- **Appels dynamiques** l. 2087-2092 : `Object.Detach`/`Object.Attach` des boutons de type (pas
  d'appel par nom de méthode).
- **Rejeu** : `Colcp_Click`, `Colmo_Click`, `hcol_click`, `NumsList_Click`, `Colfam_Click`,
  `Colcom_Click`, `Colal_Click` appelés par `ReplayObserver.Replay_Click` (`replay_dynamic`) ;
  `Colcp_Click`/`Colcp_KeyPress` sont inatteignables en pratique (`Colcp` n'est rempli que par
  `aff_cp`, mort) mais restent `Public`.
- **Heuristique surestimée** : `scope_reducible` liste des handlers (`Button15_Click`,
  `Button2_Click`, `Button4_Click`, `Button7_Click`…) et les membres `Bsel`/`Bval` : à exclure ;
  `unused` liste `Artnet_GF` (correct, code mort) mais pas `OBS_KeyPress` (handler vide du
  contrôle `obs`, conservé).
- **Heuristique ratée** : table temporaire `Blcom` ; tables désignées par variable (`Tmat`,
  `Tabmo`, `Tab3`, `TabMat`, `Lgbl`, `hgbl`) ; clé `Cbase` `RemCliFam` (utilisée seulement par
  `Tarifclient`, mort) ; colonnes ajoutées à l'exécution par `Gestion/option/modfichier.module`
  (`tipp_ligbl`, `cli_tipp`, `cli_cons`).
- **Parseur** : ~110 variables d'instance déclarées sans mot-clé (l. 23-139) et les 4 fonctions
  `$textpal_*`/`$textcol_*` absentes des tableaux AUTO.
- **Contraintes d'ordre de rework** : FACTURE-005 après FMENU-004/005 ; FACTURE-006 après
  IMPCLIENT-008 ; FACTURE-007 après SAISECRIT-010 ; FACTURE-009 dans le même commit que la
  modification de `Saisecrit.dateEcheance` ; FACTURE-A02 avec VERIFDATE-A02, FACTURE-A03 avec
  DOCACTIF-A01, FACTURE-A32 avec FFOURNISSEUR-A07, FACTURE-A33 avec MATERIEL-A11 ; les reworks de
  `ObjFacB`/`OptFac` (archivage, impression) se valident par les replays T04 et T05 de ce fichier.
