# Facture — Rework

> Source : `.src/Gestion/Facturation/Facture.class` · Message de commit (phase 4) : `reference/.src/Gestion/Facturation/Facture.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 10446 |
| Lignes de commentaire | 712 |
| Fonctions | 331 |
| Fonctions Public | 323 |
| Complexité cyclomatique totale | 3116 |
| Complexité max (fonction) | 166 (`Coldetail_KeyRelease`) |
| Variables globales | 0 |
| Variables Public | 8 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 10446 | 3098 | 166 | 0 | 319 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Fichier legacy à haut risque de régression (AGENTS.md règle 21) : chaque étape est **minimale et
ciblée**, sans réécriture de la logique de saisie. Les replays FACTURE-T01 à T24 (à valider par
l'utilisateur avant la phase 2, voir test.md) doivent donner un dump identique. Les handlers
(`Objet_Evenement`) gardent leur nom et leur portée `Public`.

- [ ] FACTURE-001 — [documentation] En-tête de classe en français : rôle, deux modes
  (`Fiches_Bl` / `Fiches_BlM`), types de document (C, B, D, P, F, A, T) et de ligne (M, A, C, R, O,
  T, E, D, P), colonnes cachées de `Coldetail` et décalage `i` de l'option boisson, drapeaux
  implicites (`B`, `ChkFocus`, `Modif`, `N`, `Nvart`, `Impfac`, `Numtk`), cycle du stock
  (réintégration à l'ouverture de la saisie, sortie à la fermeture), délégation à `ObjFacB`/`OptFac` ;
  commentaires `'''` sur les fonctions de G04, G05, G13, G15 et G16 · appelants : aucun · tests :
  aucun (commentaires seuls) · sources : [Facture.class:_New](../../../../../.src/Gestion/Facturation/Facture.class#L259-L504), [Facture.class:Lignes_Bon](../../../../../.src/Gestion/Facturation/Facture.class#L1115-L1205), [Facture.class:Button15_Click](../../../../../.src/Gestion/Facturation/Facture.class#L1207-L1274), [Facture.class:Maj_Base](../../../../../.src/Gestion/Facturation/Facture.class#L9126-L9189)
- [ ] FACTURE-002 — [documentation] Tableau des raccourcis clavier en commentaire d'en-tête de
  `Entete2_KeyPress`, `mo_KeyPress`, `Art_KeyPress`, `com_KeyPress`, `Coldetail_KeyRelease`,
  `Button10_Keypress`, `Button11_Keypress` (F1-F12, Ctrl+A/D/H/P/R, `*`, `+`, `-`, Espace, Suppr,
  lettres de navigation) · appelants : aucun · tests : aucun · sources : [Facture.class:Entete2_KeyPress](../../../../../.src/Gestion/Facturation/Facture.class#L726-L919), [Facture.class:Art_KeyPress](../../../../../.src/Gestion/Facturation/Facture.class#L5342-L5690), [Facture.class:Coldetail_KeyRelease](../../../../../.src/Gestion/Facturation/Facture.class#L8292-L8655)
- [ ] FACTURE-003 — [code mort] Supprimer les 14 fonctions jamais appelées (vérifié par `grep` sur
  `.src`) : `ChkPrx`, `modifblopt`, `aff_cp`, `ChkCp`, `Ref`, `Art_Equ2`, `Tarifclient` (seul appel
  commenté l. 4631), `Artnet_GF` (`handlers_inactifs` : `Artnet` est dans le groupe `Art`, `_GF`
  n'est pas un événement), `CalcHt`, `Bl_Sup`, `Ecritures`, `Majnum`, `SetObservers`,
  `Recup_EncoursBl` (≈ 600 lignes). `OBS_KeyPress` est conservé (handler du contrôle `obs`) · appelants
  : aucun · tests : tous les replays · sources : [Facture.class:ChkPrx](../../../../../.src/Gestion/Facturation/Facture.class#L713-L721), [Facture.class:modifblopt](../../../../../.src/Gestion/Facturation/Facture.class#L1753-L1759), [Facture.class:aff_cp](../../../../../.src/Gestion/Facturation/Facture.class#L2599-L2626), [Facture.class:ChkCp](../../../../../.src/Gestion/Facturation/Facture.class#L2665-L2673), [Facture.class:Ref](../../../../../.src/Gestion/Facturation/Facture.class#L2869-L2874), [Facture.class:Art_Equ2](../../../../../.src/Gestion/Facturation/Facture.class#L4547-L4647), [Facture.class:Tarifclient](../../../../../.src/Gestion/Facturation/Facture.class#L4649-L4729), [Facture.class:Artnet_GF](../../../../../.src/Gestion/Facturation/Facture.class#L6116-L6139), [Facture.class:CalcHt](../../../../../.src/Gestion/Facturation/Facture.class#L7541-L7579), [Facture.class:Bl_Sup](../../../../../.src/Gestion/Facturation/Facture.class#L9813-L9836), [Facture.class:Ecritures](../../../../../.src/Gestion/Facturation/Facture.class#L9841-L9858), [Facture.class:Majnum](../../../../../.src/Gestion/Facturation/Facture.class#L9863-L9872), [Facture.class:SetObservers](../../../../../.src/Gestion/Facturation/Facture.class#L10658-L10670), [Facture.class:Recup_EncoursBl](../../../../../.src/Gestion/Facturation/Facture.class#L10836-L10852)
- [ ] FACTURE-004 — [code mort] Supprimer les membres `Public` jamais référencés (`Codearticle`,
  `CodeClient`, `bRemise`, `Codepostal`, `Bureaudistributeur` : les sélecteurs écrivent dans
  `Variables.*`), les variables locales mortes (`Frmt` de `_New`, `i` de `Btn_Click`, `l` de
  `com_Click`, `Remtypec`/`Tresult`/`cdr`/`Tbrlt`/`Tartpu` de `Maj_zonesArt`, `T` de
  `Art_KeyPress`, `TabEcr` de `ToggleButton7_MouseDown`), le paramètre écrasé de `Rprodcomposes`
  (signature conservée si un appel le passe) et les blocs commentés de `calculfindoc`, `ChkInput2`,
  `Artnet_LF`, `Artbrut_LF`, `Calc_Brut` · appelants : aucun (vérifié par `grep`, y compris les
  chaînes `Object.SetProperty`) · tests : T01, T07, T08, T18 · sources : [Facture.class:185-190](../../../../../.src/Gestion/Facturation/Facture.class#L185-L190), [Facture.class:211-212](../../../../../.src/Gestion/Facturation/Facture.class#L211-L212), [Facture.class:Maj_zonesArt](../../../../../.src/Gestion/Facturation/Facture.class#L4867-L5107), [Facture.class:calculfindoc](../../../../../.src/Gestion/Facturation/Facture.class#L2533-L2566), [Facture.class:ChkInput2](../../../../../.src/Gestion/Facturation/Facture.class#L11669-L11720)
- [ ] FACTURE-005 — [commonalisation] Contrôle de réplication de `Button2_Click` (l. 1520) remplacé
  par `Utils.ReplicationOK()` (FMENU-005, sans message ; même message d'erreur local conservé) ·
  appelants : aucun · prérequis : FMENU-004/005 · tests : T01 · sources : [Facture.class:1520](../../../../../.src/Gestion/Facturation/Facture.class#L1520), [Fmenu.class:Menu42_Click](../../../../../.src/Communs/Fmenu.class#L921-L947)
- [ ] FACTURE-006 — [commonalisation] Numéro du client suivant (l. 1841-1847, passages 411999 →
  4111000 et 4119999 → 41110000) par le helper pur d'IMPCLIENT-008 (`ProchainCodeClient`),
  résultat identique y compris la conversion entière · appelants : aucun · prérequis : IMPCLIENT-008
  · tests : T02, T25 · sources : [Facture.class:1841-1847](../../../../../.src/Gestion/Facturation/Facture.class#L1841-L1847), [Impclient.class:Compteur](../../../../../.src/Utils/Exports-Imports/Impclient.class#L154-L170), [ImpSage.class:Compteur](../../../../../.src/Compta/Utils/ImpSage.class#L823-L839)
- [ ] FACTURE-007 — [commonalisation] Largeurs de colonnes `/Soc<XX>/Col/LcolF` (lecture dans
  `lcoldetail`, écriture dans `Btn_Click` Tag 6) et `LcolEqu` (écriture dans `hcol_click`) par
  `Utils.LitLargeurs`/`SauveLargeurs` (SAISECRIT-010), avec le décalage `i` de l'option boisson et
  la colonne `col10` non relue conservés · appelants : aucun · prérequis : SAISECRIT-010 · tests :
  T23 · sources : [Facture.class:lcoldetail](../../../../../.src/Gestion/Facturation/Facture.class#L561-L618), [Facture.class:1046](../../../../../.src/Gestion/Facturation/Facture.class#L1046), [Facture.class:hcol_click](../../../../../.src/Gestion/Facturation/Facture.class#L4731-L4742)
- [ ] FACTURE-008 — [séparation traitement/GUI] Extraire l'algorithme d'arrondi au pas (`0,05`,
  `0,10`, `0,50`, `1,00`) de `arrondi` et `arrondimo` dans une fonction privée pure
  `ArrondiPas(sMontant, sPas, sFormat) As String` appelée par les deux (format `ar$` pour les
  articles, `"0.00"` pour la MO ; test rétrocession laissé dans `arrondi` ; anomalie FACTURE-A12
  conservée) ; base d'une commonalisation future avec `FTvav.ArrondiPrix` · appelants : aucun ·
  tests : T08, T09, T25 · sources : [Facture.class:arrondi](../../../../../.src/Gestion/Facturation/Facture.class#L7621-L7662), [Facture.class:arrondimo](../../../../../.src/Gestion/Facturation/Facture.class#L3756-L3792), [FTvav.class:Maj_Zones](../../../../../.src/Compta/Tables/FTvav.class#L89-L106)
- [ ] FACTURE-009 — [commonalisation] `dateEcheance` → helper partagé avec
  `Saisecrit.dateEcheance` (même `SELECT Fiches_Echeances` + `Utils.Calcech`), par exemple
  `Utils.DateEcheance(sCodeEch, sDate) As String` ; `Facture.dateEcheance` devient un appel d'une
  ligne avec `dtef.Text` · appelants : `Saisecrit` (dans le même commit) · tests : T01, T26 et
  replays Saisecrit (SAISECRIT-T02) · sources : [Facture.class:dateEcheance](../../../../../.src/Gestion/Facturation/Facture.class#L9610-L9640), [Saisecrit.class:dateEcheance](../../../../../.src/Compta/Saisecrit.class#L179-L208)
- [ ] FACTURE-010 — [commonalisation] `Ecot`, `Ecot2`, `Txpp` (3 × ~70 lignes) → une procédure
  privée `LigneTaxeAnnexe(sType, sLibelle, fValeur, sFmtPu, sFmtTtc, bPrxdec, bN1)` reproduisant
  exactement les différences actuelles (format `"0.000"` du PU DEA, TTC `ar$` ou `"0.00"`, `Prxdec`
  et `N = 1` absents de `Txpp`) · SQL inchangé · appelants : aucun · tests : T10, T11 · sources : [Facture.class:Ecot](../../../../../.src/Gestion/Facturation/Facture.class#L7215-L7285), [Facture.class:Ecot2](../../../../../.src/Gestion/Facturation/Facture.class#L7290-L7360), [Facture.class:Txpp](../../../../../.src/Gestion/Facturation/Facture.class#L7365-L7422)
- [ ] FACTURE-011 — [commonalisation] `Maj_Quantite`, `Maj_Quantite2`, `Maj_QteDep`,
  `Maj_QteDep2` → une procédure privée `MajStock(iSens, bDepot)` + une fonction pure
  `DeltaStock(fQte, fColisage, iSens, bDepot) As Float` qui fige les règles actuelles (signes de
  FACTURE-A09, `cpoint` absent de `Maj_QteDep`, arrêt sur « Pièces en reliquat » pour les dépôts
  seulement) ; `Maj_QuantiteD` utilise son paramètre `refd` au lieu de `Coldetail.current[1]`
  (identique dans l'unique appel, `DupliDoc`) · SQL identique · appelants : aucun · tests : T01,
  T03, T06, T13, T14, T25 · sources : [Facture.class:Maj_Quantite](../../../../../.src/Gestion/Facturation/Facture.class#L9238-L9277), [Facture.class:Maj_Quantite2](../../../../../.src/Gestion/Facturation/Facture.class#L9317-L9356), [Facture.class:Maj_QteDep](../../../../../.src/Gestion/Facturation/Facture.class#L9361-L9401), [Facture.class:Maj_QteDep2](../../../../../.src/Gestion/Facturation/Facture.class#L9406-L9446), [Facture.class:9301](../../../../../.src/Gestion/Facturation/Facture.class#L9301)
- [ ] FACTURE-012 — [commonalisation] `Bcomde_Click`, `Bbon_Click`, `Bdevis_Click`, `Bprof_Click`,
  `Bfac_Click` → procédure privée `ChangeTypeDoc(sType, bTestImpfac)` (le test `Impfac` absent de
  `Bfac_Click` et les messages « numéros de série » de B/F conservés) ; les handlers restent
  `Public`, avec le même nom, et deviennent des appels d'une ligne · appelants : aucun · tests : T03,
  T15 · sources : [Facture.class:Bcomde_Click](../../../../../.src/Gestion/Facturation/Facture.class#L3906-L3926), [Facture.class:Bbon_Click](../../../../../.src/Gestion/Facturation/Facture.class#L3928-L3958), [Facture.class:Bdevis_Click](../../../../../.src/Gestion/Facturation/Facture.class#L3960-L3980), [Facture.class:Bprof_Click](../../../../../.src/Gestion/Facturation/Facture.class#L3982-L4002), [Facture.class:Bfac_Click](../../../../../.src/Gestion/Facturation/Facture.class#L4004-L4033)
- [ ] FACTURE-013 — [commonalisation] `Enrg_Ligcar2`, `Enrg_Ligcar`, `Enrg_LigArt2`, `Enrg_Promo` →
  procédure privée `EnrgLigneTexte(sNumlig, sColonne, sTexte, sType)` (SELECT/UPDATE/INSERT puis
  rechargement ; `Bloc` toujours ignoré à l'`UPDATE`) · SQL identique · appelants : aucun · tests :
  T01, T07, T08 · sources : [Facture.class:Enrg_Ligcar2](../../../../../.src/Gestion/Facturation/Facture.class#L8899-L8917), [Facture.class:Enrg_Ligcar](../../../../../.src/Gestion/Facturation/Facture.class#L9001-L9019), [Facture.class:Enrg_LigArt2](../../../../../.src/Gestion/Facturation/Facture.class#L8980-L8998), [Facture.class:Enrg_Promo](../../../../../.src/Gestion/Facturation/Facture.class#L8959-L8977)
- [ ] FACTURE-014 — [commonalisation] `Colbl_com`, `Colbl_art`, `Colbl_libel`, `Colbl_refl` →
  procédure privée `Colbl_Recherche(sColonne, sType, bCommentaire)` (anomalie FACTURE-A20
  conservée) · SQL identique · appelants : aucun · tests : T18 · sources : [Facture.class:Colbl_com](../../../../../.src/Gestion/Facturation/Facture.class#L11545-L11574), [Facture.class:Colbl_art](../../../../../.src/Gestion/Facturation/Facture.class#L11576-L11599), [Facture.class:Colbl_libel](../../../../../.src/Gestion/Facturation/Facture.class#L11601-L11624), [Facture.class:Colbl_refl](../../../../../.src/Gestion/Facturation/Facture.class#L11626-L11649)
- [ ] FACTURE-015 — [commonalisation] Petits blocs dupliqués → procédures privées :
  `button6_Click`/`button8_Click` (`BasculeObservations`), « type de document par défaut »
  (`_New`, `Button2_Click`, `Recup_ligfac` → `TypeParDefaut`), colonnes de `Coldetail3`
  (`Colbl_Activate`, `Creation` → `PrepareColdetail3`), « numéro de ligne suivant » (`Form_Open`,
  `Motm_Click`, `BArt_Click`, `com_Click`, `Cleanart` → `NumeroLigneSuivant() As String`), libellé
  HT/TTC (`sFacht_Click`, `Tvar_Click`, `Lignes_Bon`, `init` → `MajSaisieHT`) · appelants : aucun ·
  tests : T01, T05, T06, T09 · sources : [Facture.class:button6_Click](../../../../../.src/Gestion/Facturation/Facture.class#L1764-L1787), [Facture.class:button8_Click](../../../../../.src/Gestion/Facturation/Facture.class#L1792-L1814), [Facture.class:Recup_ligfac](../../../../../.src/Gestion/Facturation/Facture.class#L9988-L10225), [Facture.class:Creation](../../../../../.src/Gestion/Facturation/Facture.class#L12054-L12118), [Facture.class:Motm_Click](../../../../../.src/Gestion/Facturation/Facture.class#L1372-L1408), [Facture.class:init](../../../../../.src/Gestion/Facturation/Facture.class#L6736-L6754)
- [ ] FACTURE-016 — [séparation traitement/GUI] `Colbl_Data` : fonction pure privée
  `FormatDocument(sType, sImp) As String` (choix du format couleur `Start.Facture/Bon/…`) remplaçant
  les 9 copies du bloc `Utils.FColr` ; affectation des couleurs inchangée · appelants : aucun ·
  tests : T18 · sources : [Facture.class:Colbl_Data](../../../../../.src/Gestion/Facturation/Facture.class#L11387-L11487)
- [ ] FACTURE-017 — [séparation traitement/GUI] `CalculTotal` : extraire le cumul dans une
  fonction privée pure `CumulLigne(sType, sBrut, sNetHt, sNetTtc, fTaux)` qui met à jour les totaux
  (conversions `Val`/`cpoint` d'origine conservées, y compris `Val(Totalmottc)` sans `cpoint`) ;
  `CalculTotal` garde la lecture de `Rligbl` et le `SELECT` du taux · SQL identique · appelants :
  aucun · tests : T01, T07, T27 · sources : [Facture.class:CalculTotal](../../../../../.src/Gestion/Facturation/Facture.class#L2501-L2531)
- [ ] FACTURE-018 — [séparation traitement/GUI] Fonctions pures privées
  `RemiseTranche(fQte, Rms) As Variant` (bornes de boucle actuelles, FACTURE-A07 figée) pour
  `Remises_quantitatives`, et `InverseSigne(sValeur, sFormat) As String` pour les quatre inversions
  de `Importlig` · appelants : aucun · tests : T05, T07, T25 · sources : [Facture.class:Remises_quantitatives](../../../../../.src/Gestion/Facturation/Facture.class#L5963-L5987), [Facture.class:Importlig](../../../../../.src/Gestion/Facturation/Facture.class#L10412-L10500)
- [ ] FACTURE-019 — [complexité] `Coldetail_KeyRelease` (CC 166) : découper en procédures
  privées par touche (`Detail_Supprimer`, `Detail_Monter`, `Detail_Descendre`,
  `Detail_MarquerDuplication`), corps déplacés sans modification ; le handler garde le calcul de
  `l`/`l4`/`l6`, l'aiguillage et le `Catch` (CC visée ≤ 30 pour le handler) · appelants : aucun ·
  tests : T12, T11, T16 · sources : [Facture.class:Coldetail_KeyRelease](../../../../../.src/Gestion/Facturation/Facture.class#L8292-L8655)
- [ ] FACTURE-020 — [commonalisation] Chargement du client dupliqué entre `ColblSelection` et
  `Cli_man` (regroupement `cli_regr`, catégorie `Fiches_Typec`, couleur du solde) → procédures
  privées `AfficheRegroupement(sRegr)`, `AfficheCategorie(sTypec)` · SQL identique · appelants :
  aucun · tests : T01, T26 · sources : [Facture.class:ColblSelection](../../../../../.src/Gestion/Facturation/Facture.class#L1934-L2262), [Facture.class:Cli_man](../../../../../.src/Gestion/Facturation/Facture.class#L10699-L10833)
- [ ] FACTURE-021 — [documentation] Noms de tables en dur ayant une clé `Cbase` → `Cbase.Table`
  (`TabLigbl`, `TabLigblM`, `TabBl`, `TabBlM`, `TabParam`, `TabTvav`, `TabMat`, `TabCli`, `TabArt`,
  `TabMo`, `TabTypec`, `TabFam`, `TabCom`, `TabHisFac`, `TabHisFacm`, `TabHisLigFac`,
  `TabHisLigFacm`, `TabRemTypec`, `TabFour`, `TabEch`, `TabComptes`) ; les tables sans clé
  (`Fiches_Taches`, `Fiches_ligcons`, `Fiches_EntMat`, `Fiches_consigne`, `Fiches_Users`,
  `Fiches_tourne`, `Fiches_region`, `Fiches_ligtarpp`, `Fiches_ligregie`) restent en dur et sont
  signalées en commentaire. Chaque remplacement produit la même chaîne · sans changement SQL ·
  appelants : aucun · tests : tous les replays (diff `Exec_SQL` bloquant) · sources : [Facture.class:Button4_Click](../../../../../.src/Gestion/Facturation/Facture.class#L1630-L1751), [Facture.class:Maj_Base](../../../../../.src/Gestion/Facturation/Facture.class#L9126-L9189), [Facture.class:Enrg_LigArt](../../../../../.src/Gestion/Facturation/Facture.class#L8920-L8956), [Facture.class:QuitteDate](../../../../../.src/Gestion/Facturation/Facture.class#L9571-L9607)
- [ ] FACTURE-022 — [réduction de portée] `Public` → `Private` pour les fonctions non-handlers sans
  appelant externe listées dans architecture.md (« Réduction de portée ») et pour le membre
  `numeroFac` ; **exclus** : tous les handlers, les `<Grille>_Click` du rejeu (`Colcp_Click`,
  `Colmo_Click`, `hcol_click`, `NumsList_Click`, `Colfam_Click`, `Colcom_Click`, `Colal_Click`), les
  handlers d'observateurs et d'événements (`trf_selec`, `option_recalcul`, `to1_trouve`,
  `tr1_trouve`, `Txtb_*`, `Matlist_*`, `$text*`), `Bsel`/`Bval` (`Object.SetProperty` depuis
  `TriCpt`/`TriArticles`) ; seulement pour les fonctions couvertes par un replay (PLAN §6) ·
  appelants : aucun · tests : tous les replays · sources : [Facture.class:lcoldetail](../../../../../.src/Gestion/Facturation/Facture.class#L561-L618), [Facture.class:ColblSelection](../../../../../.src/Gestion/Facturation/Facture.class#L1934-L2262), [Facture.class:Maj_zonesArt](../../../../../.src/Gestion/Facturation/Facture.class#L4867-L5107), [Facture.class:187](../../../../../.src/Gestion/Facturation/Facture.class#L187)

- [ ] FACTURE-023 — [commonalisation] Les trois ouvertures du suivi d'affaire par F12
  (`mo_KeyPress`, `Art_KeyPress`, `com_KeyPress`, même `New Suivi(code, Cv, Nom, Pnm, Num, datej,
  "", "", Bdevis, Bfac, Impfac)`) → procédure privée `OuvreSuivi()` · appelants : aucun · tests :
  T17 · sources : [Facture.class:3331](../../../../../.src/Gestion/Facturation/Facture.class#L3331), [Facture.class:5664](../../../../../.src/Gestion/Facturation/Facture.class#L5664), [Facture.class:7865](../../../../../.src/Gestion/Facturation/Facture.class#L7865), [Suivi.class:_new](../../../../../.src/Gestion/Suivi.class#L33-L125)
- [ ] FACTURE-024 — [commonalisation] Requête « promotion du jour » de `Form_Open` remplacée par
  `ArtPromo.PromoDuJour()` (ARTPROMO-004, partagée avec `Articles` et `Caisse`), même SQL ·
  appelants : aucun · prérequis : ARTPROMO-004 · tests : T07 · sources : [Facture.class:508](../../../../../.src/Gestion/Facturation/Facture.class#L508), [Facture.class:Form_Open](../../../../../.src/Gestion/Facturation/Facture.class#L506-L559)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FACTURE-A01 — [anomalie] `BfacA_Click` appelle `Wrg()` **sans argument** (signature
  `Wrg(numtick As String)`, `deps.py` : `arity_errors`) quand on clique « Facture abonnement » sur un
  document imprimé : erreur d'exécution probable (« Not enough arguments ») au lieu du message
  « facture imprimée » ; correction : `Wrg(Numtk)` · tests : T03 · sources : [Facture.class:4055](../../../../../.src/Gestion/Facturation/Facture.class#L4055), [Facture.class:Wrg](../../../../../.src/Gestion/Facturation/Facture.class#L4111-L4124)
- [ ] FACTURE-A02 — [anomalie] `Button11_Click` appelle `VerifDate.ClotDroi` sur l'auto-instance
  (date et paramètres figés au premier appel) alors que `$vdate = New VerifDate(Now)` est créé en
  option boisson (VERIFDATE-A02) · tests : T21 · sources : [Facture.class:6511](../../../../../.src/Gestion/Facturation/Facture.class#L6511), [Facture.class:411](../../../../../.src/Gestion/Facturation/Facture.class#L411), [VerifDate.class:ClotDroi](../../../../../.src/Utils/VerifDate.class#L148-L154)
- [ ] FACTURE-A03 — [anomalie] `DocActif.Free_Lock` renvoie toujours `False` (DOCACTIF-A01) : les
  branches « verrou libéré → désélection et sortie » de `Button2_Click` et `ColblSelection` ne sont
  jamais prises ; corriger `Free_Lock` changerait le comportement de ces deux fonctions (à valider
  avec DOCACTIF-A01, même commit) · tests : T01, T18 · sources : [Facture.class:1523](../../../../../.src/Gestion/Facturation/Facture.class#L1523), [Facture.class:1946](../../../../../.src/Gestion/Facturation/Facture.class#L1946), [DocActif.class:Free_Lock](../../../../../.src/Communs/DocActif.class#L138-L173)
- [ ] FACTURE-A04 — [anomalie] `Button4_Click`, création en mode entretien : l'`UPDATE Fiches_BlM
  SET numserie = &1, codep = &2, desg1 = &3 … WHERE numbl = &1` reçoit (numéro, série, code, desg,
  desg2, marque, type) → `numserie` ← n° de BL, `codep` ← n° de série, etc. (rattrapé au
  2e enregistrement) ; de plus `mreg` est lu dans `Regmt` (BlM) au lieu de `Mrgt` (Bl) et l'`UPDATE`
  BlM n'écrit ni `htbl`, `cdep`, `livraison` · tests : T15 · sources : [Facture.class:1674](../../../../../.src/Gestion/Facturation/Facture.class#L1674), [Facture.class:1671](../../../../../.src/Gestion/Facturation/Facture.class#L1671), [Facture.class:1658](../../../../../.src/Gestion/Facturation/Facture.class#L1658)
- [ ] FACTURE-A05 — [anomalie] `Enrg_Pdc`, branche `UPDATE` : `code_ligbl` ← `Bloc`, `libel_ligbl`
  ← code du composant, `qte_ligbl` ← libellé (paramètres décalés ; l'`INSERT` est correct) ·
  tests : T11 · sources : [Facture.class:9060](../../../../../.src/Gestion/Facturation/Facture.class#L9060), [Facture.class:Enrg_Pdc](../../../../../.src/Gestion/Facturation/Facture.class#L9050-L9066)
- [ ] FACTURE-A06 — [anomalie] `Bl_Suppr` : le refus de suppression d'un BL contenant des matériels
  teste `left(libel_ligbl,9) = "Numero de"` sans accent : fonctionne sous MySQL (collation
  `utf8mb4_unicode_ci` insensible aux accents), jamais sous SQLite (BL supprimé, matériels remis en
  stock) · tests : T13, T16, T24 · sources : [Facture.class:9469](../../../../../.src/Gestion/Facturation/Facture.class#L9469)
- [ ] FACTURE-A07 — [anomalie] `Remises_quantitatives` : `For i = 0 To Rms.Bounds[0] - 1` ne
  parcourt que 5 tranches sur 6 (`qte11`/`qte12`/`rem6` jamais appliquées) · tests : T07 · sources : [Facture.class:5970](../../../../../.src/Gestion/Facturation/Facture.class#L5970)
- [ ] FACTURE-A08 — [anomalie] `Calc_MargeMo`, MO au forfait : prix de revient × `tx` (variable
  `1 + TVA/100` laissée par une autre fonction) au lieu de × `Txo` (nombre d'unités) → marge MO
  fausse ; `PrvtMo` vaut 1 en cas d'erreur ici mais 0 dans `mo_man` · tests : T08 · sources : [Facture.class:3891](../../../../../.src/Gestion/Facturation/Facture.class#L3891), [Facture.class:3874](../../../../../.src/Gestion/Facturation/Facture.class#L3874), [Facture.class:3080](../../../../../.src/Gestion/Facturation/Facture.class#L3080)
- [ ] FACTURE-A09 — [anomalie] `Maj_QteDep`/`Maj_QteDep2` (stock par dépôt) : une quantité
  négative (ligne d'avoir) **diminue** le stock du dépôt à la sortie, contrairement à `Maj_Quantite` ;
  le colisage est lu dans `TabStkDepots.art_colvte` (colonne absente → toujours 0) · tests : T14 ·
  sources : [Facture.class:9381-9388](../../../../../.src/Gestion/Facturation/Facture.class#L9381-L9388), [Facture.class:9426-9433](../../../../../.src/Gestion/Facturation/Facture.class#L9426-L9433)
- [ ] FACTURE-A10 — [anomalie] `ColTaches_KeyPress` : **toute** touche sur la grille des tâches
  propose la suppression ; `ALTER TABLE Fiches_Taches ORDER BY lind` est propre à MySQL (erreur sous
  SQLite) ; `RecupTaches` concatène `User.name` entre guillemets doubles · tests : T20, T24 · sources : [Facture.class:ColTaches_KeyPress](../../../../../.src/Gestion/Facturation/Facture.class#L2723-L2734), [Facture.class:2730](../../../../../.src/Gestion/Facturation/Facture.class#L2730), [Facture.class:RecupTaches](../../../../../.src/Gestion/Facturation/Facture.class#L2750-L2777)
- [ ] FACTURE-A11 — [anomalie] Commentaires : `Button12_keypress` valide le commentaire sur
  **toute** touche ; en modification (`N <> 1`), `Button12_Click` sort de la boucle après la première
  ligne (`Break` inconditionnel) : la grille n'est mise à jour que si la ligne modifiée est la
  première · tests : T12, T17 · sources : [Facture.class:Button12_keypress](../../../../../.src/Gestion/Facturation/Facture.class#L7894-L7898), [Facture.class:7933](../../../../../.src/Gestion/Facturation/Facture.class#L7933)
- [ ] FACTURE-A12 — [anomalie] `arrondi` : un TTC vide reçoit la chaîne littérale `"ar$"` au lieu
  du format `ar$` (puis `Val("ar$")`) · tests : T09 · sources : [Facture.class:7624](../../../../../.src/Gestion/Facturation/Facture.class#L7624)
- [ ] FACTURE-A13 — [anomalie, à confirmer] `QuitteDate` : la borne basse est construite avec
  `Right$(dte, 4) & Left$(dte, 2)` (année + jour si `dtepc` est au format `jj.mm.aaaa`) alors que la
  date saisie est comparée en année + mois ; `ye2` (fin de l'exercice suivant) est calculé mais
  aucune borne haute n'est contrôlée (contrairement à `Saisecrit.QuitteDate`) · tests : T01 ·
  sources : [Facture.class:9578](../../../../../.src/Gestion/Facturation/Facture.class#L9578), [Facture.class:9583](../../../../../.src/Gestion/Facturation/Facture.class#L9583), [Facture.class:QuitteDate](../../../../../.src/Gestion/Facturation/Facture.class#L9571-L9607)
- [ ] FACTURE-A14 — [anomalie] `ChiffreA` affiche « CA sur 12 mois » mais additionne les factures
  des 4 dernières années (`Val(année) - 4`) · tests : T26 · sources : [Facture.class:10917](../../../../../.src/Gestion/Facturation/Facture.class#L10917), [Facture.class:10930](../../../../../.src/Gestion/Facturation/Facture.class#L10930)
- [ ] FACTURE-A15 — [anomalie] `Verif_Encours` : `encours > "0"` compare des chaînes (un plafond
  `"0,5"` ou `"-1"` est traité comme non nul) ; `Raz_client` remet les remises à `"0.00"` (point) ·
  tests : T26 · sources : [Facture.class:974](../../../../../.src/Gestion/Facturation/Facture.class#L974), [Facture.class:1006-1007](../../../../../.src/Gestion/Facturation/Facture.class#L1006-L1007)
- [ ] FACTURE-A16 — [anomalie] `Artqte_LF` : le refus des décimales sur un article sans décimale ne
  porte que sur une saisie commençant par une virgule (`InStr(…, ",") = 1`), quel que soit `Dec` ·
  tests : T07 · sources : [Facture.class:5917](../../../../../.src/Gestion/Facturation/Facture.class#L5917)
- [ ] FACTURE-A17 — [anomalie, à confirmer] `Coldetail_Activate` : le simple rappel d'une ligne
  d'article matériel remet son numéro de série en « non vendu » en base (`UPDATE Fiches_Materiels`)
  et réécrit le document (`Maj_Base`) avant toute modification ; si l'utilisateur abandonne, le
  matériel reste libéré alors que la ligne existe · tests : T16 · sources : [Facture.class:8184-8197](../../../../../.src/Gestion/Facturation/Facture.class#L8184-L8197)
- [ ] FACTURE-A18 — [anomalie, à confirmer] `ToggleButton7_MouseDown` rappelle `Utils.Observers(Me)`
  (nouveaux observateurs de journal/rejeu à chaque clic, événements probablement journalisés en
  double) et `Me.Center` (la fenêtre se recentre) ; le choix de la branche teste `Me.mouse =
  Mouse.Left` (forme du curseur) au lieu de `Mouse.Left` · tests : T26, T17 · sources : [Facture.class:10967-10969](../../../../../.src/Gestion/Facturation/Facture.class#L10967-L10969)
- [ ] FACTURE-A19 — [anomalie] Numérotation sous `LOCK TABLES` : `button1_Click` ne libère pas le
  verrou si `dnc` est invalide ; `DupliDoc` ne fait `UNLOCK` que si la ligne de paramètres existe ;
  `Button2_Click` crée `ObjFacB` avec un `$numbl` périmé quand le numéro est déjà attribué · tests :
  T01, T02, T06 · sources : [Facture.class:1832-1851](../../../../../.src/Gestion/Facturation/Facture.class#L1832-L1851), [Facture.class:8692-8703](../../../../../.src/Gestion/Facturation/Facture.class#L8692-L8703), [Facture.class:1589](../../../../../.src/Gestion/Facturation/Facture.class#L1589)
- [ ] FACTURE-A20 — [anomalie] `Colbl_art`, `Colbl_libel`, `Colbl_refl` insèrent le nom du client
  dans la colonne `pnmclibl` de `Blcom` (8 colonnes, `nmclibl` absent) : le nom s'affiche dans la
  colonne prénom de la liste · tests : T18 · sources : [Facture.class:11589](../../../../../.src/Gestion/Facturation/Facture.class#L11589), [Facture.class:11614](../../../../../.src/Gestion/Facturation/Facture.class#L11614), [Facture.class:11639](../../../../../.src/Gestion/Facturation/Facture.class#L11639)
- [ ] FACTURE-A21 — [anomalie] `Recup_ligfac` appelle `Maj_libelle` à chaque ligne de la facture
  d'origine : parcours et `UPDATE` des lignes du document **courant** (préfixes casier) N fois,
  et déplacement du curseur de `Coldetail` · tests : T05, T06, T27 · sources : [Facture.class:10093](../../../../../.src/Gestion/Facturation/Facture.class#L10093), [Facture.class:10166](../../../../../.src/Gestion/Facturation/Facture.class#L10166)
- [ ] FACTURE-A22 — [anomalie] Affichage : `modifpanel5` écrit une trace de débogage sur la sortie
  standard (`Print lab.x …`) et élargit `Coldetail` de `120 + cw` au lieu de `120 * cw` ;
  `ToggleButton9_Click` dimensionne deux fois `Columns[1]` (la colonne 2 jamais) · tests : T21, T16 ·
  sources : [Facture.class:12333](../../../../../.src/Gestion/Facturation/Facture.class#L12333), [Facture.class:12301](../../../../../.src/Gestion/Facturation/Facture.class#L12301), [Facture.class:6895-6896](../../../../../.src/Gestion/Facturation/Facture.class#L6895-L6896)
- [ ] FACTURE-A23 — [anomalie, à confirmer] F5 dans l'entête ouvre `ConVendeurs` (auto-instance) ;
  la validation (`ConVendeurs.Button1_Click`) crée et affiche **une deuxième** `Facture(False)`
  (fenêtre modale imbriquée, et toujours en mode standard même depuis la facturation entretien) ·
  tests : T26 · sources : [Facture.class:889](../../../../../.src/Gestion/Facturation/Facture.class#L889), [ConVendeurs.class:Button1_Click](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L85-L116)
- [ ] FACTURE-A24 — [anomalie, à confirmer] `Colbl_Data` colore en « devis périmé » tout devis
  antérieur à `date2doc`, calculé dans `_New` par `date1doc - n` alors que `n` vaut 0 (durée de
  validité jamais appliquée) · tests : T18 · sources : [Facture.class:292](../../../../../.src/Gestion/Facturation/Facture.class#L292), [Facture.class:11478](../../../../../.src/Gestion/Facturation/Facture.class#L11478)
- [ ] FACTURE-A25 — [anomalie] Aucune transaction : `Maj_Base` (DELETE de toutes les lignes puis
  ré-INSERT), `Bl_Suppr`, `DupliDoc`, la création d'un client (`Button4_Click`) laissent la base dans
  un état intermédiaire en cas d'erreur ; ajouter `Utils.db.Begin/Commit/Rollback` ne change le
  résultat qu'en cas d'échec · tests : T12, T13, T06, T02 · sources : [Facture.class:Maj_Base](../../../../../.src/Gestion/Facturation/Facture.class#L9126-L9189), [Facture.class:Bl_Suppr](../../../../../.src/Gestion/Facturation/Facture.class#L9451-L9531), [Facture.class:DupliDoc](../../../../../.src/Gestion/Facturation/Facture.class#L8660-L8841)
- [ ] FACTURE-A26 — [anomalie] `GenFacPort` : le message « article inexistant » est écrit pour une
  ligne vide (mauvaise branche) et non pour un code inconnu ; le fichier de rejets n'est pas fermé si
  `inventaire.txt` est absent ; `If cle <> 0` compare une chaîne · tests : T22 · sources : [Facture.class:10567](../../../../../.src/Gestion/Facturation/Facture.class#L10567), [Facture.class:10586](../../../../../.src/Gestion/Facturation/Facture.class#L10586), [Facture.class:10550](../../../../../.src/Gestion/Facturation/Facture.class#L10550)
- [ ] FACTURE-A27 — [anomalie, à confirmer] `RefLongue` lit `Settings["/Soc<XX>/Refl"]` (fichier de
  configuration par défaut) et non `Start.LocalSettings` : la préférence est ignorée si Laurux est
  lancé avec `-c` · tests : T23 · sources : [Facture.class:5308](../../../../../.src/Gestion/Facturation/Facture.class#L5308)
- [ ] FACTURE-A28 — [anomalie, à confirmer] Précédence de `… And Val(sk) <= 0 And If Tp = "B" Or
  Tp = "F"` (contrôle de stock dans `Maj_zonesArt` et `Art_Rpl`) : selon la précédence de
  `And If`/`Or`, le contrôle pourrait s'appliquer sur toute facture `F` quel que soit le stock ; à
  établir en replay avant toute correction (parenthésage) · tests : T07, T03 · sources : [Facture.class:4903](../../../../../.src/Gestion/Facturation/Facture.class#L4903), [Facture.class:4450](../../../../../.src/Gestion/Facturation/Facture.class#L4450)
- [ ] FACTURE-A29 — [anomalie] Option boisson : la touche `+` de la grille déplace les consignes
  (`$opt.deplig`) **avant** le refus du déplacement (produits composés), contrairement à `-` ·
  tests : T12, T21 · sources : [Facture.class:8533-8539](../../../../../.src/Gestion/Facturation/Facture.class#L8533-L8539)
- [ ] FACTURE-A30 — [anomalie, à confirmer] Mode entretien (`Fiches_BlM`/`Fiches_LigblM`) : plusieurs
  fonctions utilisent `Fiches_Ligbl`/`Fiches_Bl` en dur (`Enrg_Numserie`, `Tot_Remises`, tournée
  dans `ColblSelection`, recherches `Colbl_*`, `Maj_Quantite*` via `TabLigbl` dans `LOCK TABLES`,
  `recdate`) : remises, numéros de série et recherches ne portent pas sur les bonnes tables · tests :
  T15 · sources : [Facture.class:7025](../../../../../.src/Gestion/Facturation/Facture.class#L7025), [Facture.class:9780](../../../../../.src/Gestion/Facturation/Facture.class#L9780), [Facture.class:2032](../../../../../.src/Gestion/Facturation/Facture.class#L2032), [Facture.class:Colbl_com](../../../../../.src/Gestion/Facturation/Facture.class#L11545-L11574)
- [ ] FACTURE-A31 — [anomalie] `Coldetail_Activate` relit l'article avec la jointure `TabArt left
  join TabFour on art_code = fo_cdech` (condition fausse ; sans effet aujourd'hui car seules les
  colonnes `art_*` sont lues, mais `Frm12` est appelé à part) ; F10 sur la désignation modifie la
  fiche article (`UPDATE Fiches_Art`) sans confirmation ni contrôle d'impression · tests : T17 ·
  sources : [Facture.class:8139](../../../../../.src/Gestion/Facturation/Facture.class#L8139), [Facture.class:5643](../../../../../.src/Gestion/Facturation/Facture.class#L5643)
- [ ] FACTURE-A32 — [anomalie, à confirmer] F11 (`Art_KeyPress`) ouvre `New FFournisseur` : le code
  postal choisi dans `Tricp` est écrit dans l'auto-instance de `FFournisseur` (perdu pour la fiche
  ouverte) et `Bsel` n'y est jamais remis à faux (une sélection annulée recopie le choix précédent) ;
  défaut porté par `FFournisseur`/`Tricp` (FFOURNISSEUR-A07), à corriger avec lui · tests : T17 ·
  sources : [Facture.class:5658](../../../../../.src/Gestion/Facturation/Facture.class#L5658), [Tricp.class:colco_Click](../../../../../.src/Affichages/Tricp.class#L128-L150)
- [ ] FACTURE-A33 — [anomalie, à confirmer] Libération des matériels (`Coldetail_Activate` l. 8190,
  suppression de ligne l. 8348) : `UPDATE Fiches_Materiels … WHERE mat_serie = <code de la ligne T>`
  sans `mat_code` (un même numéro de série chez deux produits serait libéré deux fois), alors que
  `ObjFacB` (l. 997) rapproche `code_ligbl` de `mat_code` ; rapprochement code de ligne ↔ n° de série
  à harmoniser avec `Materiel.mat_Suppr` (MATERIEL-A11) · tests : T16 · sources : [Facture.class:8190](../../../../../.src/Gestion/Facturation/Facture.class#L8190), [Facture.class:8348](../../../../../.src/Gestion/Facturation/Facture.class#L8348), [ObjFacB.class:997](../../../../../.src/Gestion/option/ObjFacB.class#L997)
