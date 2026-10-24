# Materiel — Rework

> Source : `.src/Gestion/Tables/Materiel.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Materiel.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 2054 |
| Lignes de commentaire | 174 |
| Fonctions | 107 |
| Fonctions Public | 107 |
| Complexité cyclomatique totale | 444 |
| Complexité max (fonction) | 24 (`Histo_Ventes`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 2054 | 444 | 24 | 0 | 107 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MATERIEL-001 — [documentation] En-tête en français : clé `(mat_serie, mat_code)`, cycle de
  vie (réception → vente → interventions), lien avec les tables `*M` et `Fiches_HisentMat`, tags
  du groupe `Cmpt`, rôle de `nv`/`B`/`B2`, `Bsel`/`Bval` écrits par `TriArticles`/`TriCpt` ·
  appelants : aucun · tests : aucun · sources : [Materiel.class:_New](../../../../../.src/Gestion/Tables/Materiel.class#L71-L113), [Materiel.class:Histo_Ventes](../../../../../.src/Gestion/Tables/Materiel.class#L2017-L2152), [Materiel.class:EnrgMat](../../../../../.src/Gestion/Tables/Materiel.class#L1896-L1941)
- [ ] MATERIEL-002 — [code mort] Supprimer `Ta_Click`, `Ta_Dblclick`, `Ta_KeyPress`, `Cof_Click`,
  `Cof_Dblclick`, `Cof_KeyPress`, `TTc_Click`, `TTc_Dblclick`, `TTc_KeyPress` (aucun contrôle de ce
  nom), `Ref`, `reinit`, `Nom_Photo`, `Cli_Man` (jamais appelées), les blocs commentés
  (`Cmpt_Click`, `Desg_GotFocus`, `Maj_Zones`) · appelants : aucun · tests : T01-T09 · sources : [Materiel.class:Ta_Click](../../../../../.src/Gestion/Tables/Materiel.class#L1584-L1598), [Materiel.class:TTc_KeyPress](../../../../../.src/Gestion/Tables/Materiel.class#L1674-L1684), [Materiel.class:Ref](../../../../../.src/Gestion/Tables/Materiel.class#L1805-L1813), [Materiel.class:reinit](../../../../../.src/Gestion/Tables/Materiel.class#L1946-L1963), [Materiel.class:Nom_Photo](../../../../../.src/Gestion/Tables/Materiel.class#L2505-L2517), [Materiel.class:Cli_Man](../../../../../.src/Gestion/Tables/Materiel.class#L2541-L2560), [Materiel.class:1833-1848](../../../../../.src/Gestion/Tables/Materiel.class#L1833-L1848)
- [ ] MATERIEL-003 — [code mort] Supprimer les membres jamais lus (`Tricli`, `Clitable`, `Sens`,
  `Stk`, `Stk2`, `Tvavente`, `Ecotaxe`, `Phot_art`, `CoulZns`, `CoulZnaf`, `CoulFc`) et leurs
  affectations (dont les blocs `Stk` des quatre `Deb*` et les lectures de configuration de
  `_New`), les branches `Case 1/2` de `Rb_Click` (radios aux tags 3/4, jamais vraies), l'affectation
  `tab = "Fiches_Ligcom"` de `Maj_Zones`, `SetObservers` et son appel (observateurs `OBS` sans
  handler) · appelants : aucun · tests : T01-T09 · sources : [Materiel.class:28-65](../../../../../.src/Gestion/Tables/Materiel.class#L28-L65), [Materiel.class:Rb_Click](../../../../../.src/Gestion/Tables/Materiel.class#L797-L816), [Materiel.class:500](../../../../../.src/Gestion/Tables/Materiel.class#L500), [Materiel.class:SetObservers](../../../../../.src/Gestion/Tables/Materiel.class#L2562-L2574), [Materiel.class:119](../../../../../.src/Gestion/Tables/Materiel.class#L119)
- [ ] MATERIEL-004 — [réarchitecture] `Cbase.Table(...)` pour toutes les tables (`TabMat`,
  `TabArt`, `TabFam`, `TabFour`, `TabTvav`, `TabComptes`, `TabCli`, `TabMarq`, `TabLigbl`,
  `TabBl`, `TabHisFac`, `TabHisLigFac`, `TabBlM`, `TabLigblM`, `TabHisFacm`, `TabHisLigFacm`,
  `TabHisEntm`, `TabLigrecpt`) à la place des noms en dur et des membres `Tab`/`Tab2`/`Tabmat`
  (SQL identique) · appelants : aucun · tests : T01-T09, T11 · sources : [Materiel.class:Form_Open](../../../../../.src/Gestion/Tables/Materiel.class#L115-L131), [Materiel.class:Maj_Zones](../../../../../.src/Gestion/Tables/Materiel.class#L494-L570), [Materiel.class:Histo_Ventes](../../../../../.src/Gestion/Tables/Materiel.class#L2017-L2152), [Materiel.class:Colventes_click](../../../../../.src/Gestion/Tables/Materiel.class#L2157-L2240), [Materiel.class:Histo_Achat](../../../../../.src/Gestion/Tables/Materiel.class#L2324-L2397)
- [ ] MATERIEL-005 — [commonalisation] `Deb`/`Deb2`/`Deb3`/`Deb4` → `ChargeGrille(sMotif,
  bContient, bDesc)` (texte SQL identique, y compris l'ordre particulier de `Deb`, voir A04) ; les
  six jeux d'en-têtes (`Co_*`, `Inte_*`, `CLT_*`, `SE_*`, `fourn_*`, `Rcpt_*`) délèguent à
  `ChoixTri(sTri, hEntete)` et `FiltreSaisi(bEtoile)` ; noms de handlers conservés · appelants :
  aucun · tests : T08, T11 · sources : [Materiel.class:Deb](../../../../../.src/Gestion/Tables/Materiel.class#L199-L230), [Materiel.class:Deb2](../../../../../.src/Gestion/Tables/Materiel.class#L232-L268), [Materiel.class:Deb3](../../../../../.src/Gestion/Tables/Materiel.class#L270-L302), [Materiel.class:Deb4](../../../../../.src/Gestion/Tables/Materiel.class#L304-L327), [Materiel.class:Co_Click](../../../../../.src/Gestion/Tables/Materiel.class#L1483-L1497), [Materiel.class:Rcpt_KeyPress](../../../../../.src/Gestion/Tables/Materiel.class#L1788-L1803)
- [ ] MATERIEL-006 — [complexité] `Histo_Ventes` (CC 24) découpée en `HistoBl`, `HistoFac`,
  `HistoBlM`, `HistoFacM` (même ordre de requêtes, même contenu de liste) ; `Maj_Zones` (CC 23) →
  `ChargeMateriel(sSerie, sCode)` + affichage ; `EnrgMat` : liste des colonnes communes construite
  une fois (texte SQL identique) · appelants : aucun · tests : T01, T02, T06 · sources : [Materiel.class:Histo_Ventes](../../../../../.src/Gestion/Tables/Materiel.class#L2017-L2152), [Materiel.class:Maj_Zones](../../../../../.src/Gestion/Tables/Materiel.class#L494-L570), [Materiel.class:EnrgMat](../../../../../.src/Gestion/Tables/Materiel.class#L1896-L1941)
- [ ] MATERIEL-007 — [séparation traitement/GUI] Calculs de prix purs (`PrixRevient`,
  `PrixVenteHT`, `PrixTTC`, `PrixHT`, `TauxMarque`, `CoefDepuisTaux`, `MargeSurCout`) appelés par
  `PaHtLF`, `FraisLF`, `Coeff`, `Pourcent`, `PvhtLF`, `PvTTcLF`, `Tva_Calcul`, `Calc_Marge`,
  `Calc_Percent`, `Calc_coeff`, mêmes formats et même ordre de mise à jour des zones ·
  appelants : aucun · tests : T03, T10 · sources : [Materiel.class:PaHtLF](../../../../../.src/Gestion/Tables/Materiel.class#L1043-L1082), [Materiel.class:FraisLF](../../../../../.src/Gestion/Tables/Materiel.class#L1357-L1391), [Materiel.class:Coeff](../../../../../.src/Gestion/Tables/Materiel.class#L1139-L1170), [Materiel.class:Pourcent](../../../../../.src/Gestion/Tables/Materiel.class#L1175-L1205), [Materiel.class:PvTTcLF](../../../../../.src/Gestion/Tables/Materiel.class#L1243-L1276), [Materiel.class:Calc_Marge](../../../../../.src/Gestion/Tables/Materiel.class#L1323-L1330)
- [ ] MATERIEL-008 — [commonalisation] `arrondi` → `ArrondiPrix(sPrix, sArr, sFormat) As String`
  commune avec `Movr.arrondi` (MOVR-007, même commit ; format `nbdec` passé en paramètre),
  seulement si MATERIEL-T10 et MOVR-T08 sont identiques ; `Calc_Marge` → `MargeSurCout` partagée
  avec `Prodcomposes.Calc_Marge` · appelants : `Movr`, `Prodcomposes` · tests : T03, T10,
  MOVR-T02, MOVR-T08, PRODCOMPOSES-T01 · sources : [Materiel.class:arrondi](../../../../../.src/Gestion/Tables/Materiel.class#L1281-L1318), [Movr.class:arrondi](../../../../../.src/Gestion/Tables/Movr.class#L1599-L1635), [Prodcomposes.class:Calc_Marge](../../../../../.src/Gestion/Tables/Prodcomposes.class#L609-L635)
- [ ] MATERIEL-009 — [séparation traitement/GUI] `EnrgMat` → `EnregistreMateriel(...)` (INSERT /
  Update inchangés) ; `mat_Suppr` → `MaterielFacture(sSerie) As Boolean` + `SupprimeMateriel(sSerie,
  sCode)` ; messages et rafraîchissement dans les appelants · appelants : aucun · tests : T01,
  T02, T05 · sources : [Materiel.class:EnrgMat](../../../../../.src/Gestion/Tables/Materiel.class#L1896-L1941), [Materiel.class:mat_Suppr](../../../../../.src/Gestion/Tables/Materiel.class#L1968-L2012)
- [ ] MATERIEL-010 — [réduction de portée] `Tris`, `Deb`, `Deb2`, `Deb3`, `Deb4`, `art_man`,
  `Maj_Zones`, `Maj_Cli`, `Refresh`, `CleanChamps`, `Fam2`, `fourMan`, `CodePLF`, `CodeLF`,
  `PaHtLF`, `Active_champs`, `Tva_Calcul`, `Coeff`, `Pourcent`, `PvhtLF`, `PvTTcLF`, `arrondi`,
  `Calc_Marge`, `Calc_Percent`, `Calc_coeff`, `FraisLF`, `Dbclk`, `TestenrgMat`, `EnrgMat`,
  `mat_Suppr`, `Histo_Ventes`, `recupfac`, `recupbl`, `Histo_Achat`, `aff_Photo` → `Private`
  (sauf fonctions devenues communes) ; `_New`, `Bsel`/`Bval` et handlers inchangés · appelants :
  aucun · tests : T01-T09 · sources : [Materiel.class:Maj_Zones](../../../../../.src/Gestion/Tables/Materiel.class#L494-L570), [Materiel.class:TestenrgMat](../../../../../.src/Gestion/Tables/Materiel.class#L1853-L1894), [Materiel.class:Histo_Achat](../../../../../.src/Gestion/Tables/Materiel.class#L2324-L2397)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MATERIEL-A01 — [anomalie] `Maj_Zones` charge `mat_four` dans `Cequ` et `mat_paht` dans
  `Prvt`, et ne charge pas `Pmp` (rempli par `Calc_Marge` avec `Prvt`) : ouvrir puis enregistrer
  une fiche écrase `mat_cequ`, `mat_prvt` (frais perdus) et `mat_pmp` · tests : T02 · sources : [Materiel.class:515](../../../../../.src/Gestion/Tables/Materiel.class#L515), [Materiel.class:524](../../../../../.src/Gestion/Tables/Materiel.class#L524), [Materiel.class:1325](../../../../../.src/Gestion/Tables/Materiel.class#L1325), [Materiel.class:1922](../../../../../.src/Gestion/Tables/Materiel.class#L1922), [Materiel.class:1924](../../../../../.src/Gestion/Tables/Materiel.class#L1924)
- [ ] MATERIEL-A02 — [anomalie, à confirmer] Enregistrer (clic) pose `B2 = 1` puis donne le focus à
  `Desg3`, **invisible** : `Dsg_GotFocus` ne serait jamais levé et `B2` resterait à 1 ; ensuite
  Entrée sur le n° de série (`CodeLF`) enregistre directement au lieu de passer à la marque ·
  tests : T01 · sources : [Materiel.class:826-830](../../../../../.src/Gestion/Tables/Materiel.class#L826-L830), [Materiel.class:Dsg_GotFocus](../../../../../.src/Gestion/Tables/Materiel.class#L871-L882), [Materiel.class:1032-1036](../../../../../.src/Gestion/Tables/Materiel.class#L1032-L1036)
- [ ] MATERIEL-A03 — [anomalie] Collision de nom : `Rcpt` est l'en-tête de colonne **et** le groupe
  des 9 zones des panneaux de détail ; focus ou saisie dans ces zones retrie et filtre la grille
  (`Rcpt_GotFocus` → `Rcpt_Click`, `Rcpt_KeyPress` → `Deb2`) · tests : T08 · sources : [Materiel.class:Rcpt_GotFocus](../../../../../.src/Gestion/Tables/Materiel.class#L1464-L1469), [Materiel.class:Rcpt_KeyPress](../../../../../.src/Gestion/Tables/Materiel.class#L1788-L1803)
- [ ] MATERIEL-A04 — [anomalie] `Deb` (ouverture depuis la fiche article) teste `tri = "mat_code "`
  (espace final) : l'ordre `cast(mat_code), cast(mat_serie)` de `Deb2` n'est jamais appliqué ·
  tests : T11 · sources : [Materiel.class:212](../../../../../.src/Gestion/Tables/Materiel.class#L212)
- [ ] MATERIEL-A05 — [anomalie] SQL par concaténation de la saisie (`sel`, `Prd`) dans
  `Deb`/`Deb2`/`Deb3`/`Deb4` : apostrophe ou guillemet → erreur SQL, injection possible · tests :
  T08 · sources : [Materiel.class:222](../../../../../.src/Gestion/Tables/Materiel.class#L222), [Materiel.class:260](../../../../../.src/Gestion/Tables/Materiel.class#L260), [Materiel.class:294](../../../../../.src/Gestion/Tables/Materiel.class#L294), [Materiel.class:319](../../../../../.src/Gestion/Tables/Materiel.class#L319)
- [ ] MATERIEL-A06 — [anomalie] Historiques : un seul bon d'entretien `Fiches_BlM` affiché (pas
  de boucle) sans prix ni quantité ; `recupfac` écrit la quantité formatée dans la colonne 2
  (écrasée) au lieu de la colonne 3 · tests : T06 · sources : [Materiel.class:2116-2133](../../../../../.src/Gestion/Tables/Materiel.class#L2116-L2133), [Materiel.class:2256](../../../../../.src/Gestion/Tables/Materiel.class#L2256)
- [ ] MATERIEL-A07 — [anomalie] Lectures sans test `Available` ni `Catch` → erreur non
  interceptée : fournisseur dans `art_man`, client et bon `Fiches_BlM` dans `Colventes_click`,
  fournisseur dans `Histo_Achat`/`Colachat_click` ; `Fam2` affiche « Cette famille n'existe pas »
  quand c'est le code TVA qui manque · tests : T04, T06, T07 · sources : [Materiel.class:418](../../../../../.src/Gestion/Tables/Materiel.class#L418), [Materiel.class:2187](../../../../../.src/Gestion/Tables/Materiel.class#L2187), [Materiel.class:2215](../../../../../.src/Gestion/Tables/Materiel.class#L2215), [Materiel.class:2381](../../../../../.src/Gestion/Tables/Materiel.class#L2381), [Materiel.class:2433](../../../../../.src/Gestion/Tables/Materiel.class#L2433), [Materiel.class:708](../../../../../.src/Gestion/Tables/Materiel.class#L708)
- [ ] MATERIEL-A08 — [anomalie, à confirmer] Garantie : la date de fin (`DateG2`) n'est ni chargée
  ni enregistrée (aucune colonne) ; l'`Update` d'un matériel non vendu ignore les champs de
  garantie ; la date de vente n'est enregistrée à la création que si la garantie est cochée ·
  tests : T09 · sources : [Materiel.class:1909](../../../../../.src/Gestion/Tables/Materiel.class#L1909), [Materiel.class:1924](../../../../../.src/Gestion/Tables/Materiel.class#L1924), [Materiel.class:DateChooser1_Activate](../../../../../.src/Gestion/Tables/Materiel.class#L2609-L2622)
- [ ] MATERIEL-A09 — [anomalie] `ToggleButton3_Click` remet `Variables.Bsel` à `False` au lieu de
  `Me.Bsel` ; `TriCpt` ne réinitialise pas `Bsel` : une annulation réapplique la dernière valeur
  sélectionnée (article ou client) · tests : T12 · sources : [Materiel.class:2527](../../../../../.src/Gestion/Tables/Materiel.class#L2527), [Materiel.class:2530](../../../../../.src/Gestion/Tables/Materiel.class#L2530)
- [ ] MATERIEL-A10 — [anomalie, à confirmer] Ouvrir une fiche dont la réception est verrouillée
  (`DocActif.Is_Lock`) vide la fiche sans autre explication que le message de verrou, y compris
  pour un matériel déjà vendu (consultation impossible) · tests : T08 · sources : [Materiel.class:755-759](../../../../../.src/Gestion/Tables/Materiel.class#L755-L759)
- [ ] MATERIEL-A11 — [anomalie, à confirmer] `mat_Suppr` ne contrôle que `Fiches_Ligbl.code_ligbl`
  = n° de série : aucun contrôle des bons/factures d'entretien (`*M`) ni de l'historique de
  factures ; le rapprochement code de ligne ↔ n° de série est contredit par `ObjFacB.class:997`
  (code de ligne ↔ `mat_code`) · tests : T05 · sources : [Materiel.class:1982](../../../../../.src/Gestion/Tables/Materiel.class#L1982), [Materiel.class:2065](../../../../../.src/Gestion/Tables/Materiel.class#L2065)
- [ ] MATERIEL-A12 — [anomalie, à confirmer] `EnrgMat` en création d'un matériel divers (`Matdiv`)
  dont le couple (code, série) existe déjà : aucun enregistrement ni message (simple
  `Form_Open`) · tests : T04 · sources : [Materiel.class:1929-1936](../../../../../.src/Gestion/Tables/Materiel.class#L1929-L1936)
