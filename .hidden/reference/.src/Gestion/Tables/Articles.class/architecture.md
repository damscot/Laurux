# Articles — Architecture

> Source : `.src/Gestion/Tables/Articles.class`

## Vue d'ensemble

`Articles` est l'**écran de gestion de la fiche article** (table `Fiches_Art`) : consultation,
création, modification et suppression d'un article, avec ses tables satellites (codes-barres
`Fiches_CdBarre`, équivalences `Fiches_Cequ`, remplacements `Fiches_Rpl1`/`Fiches_Rpl2`, documents GED
`Docs_Ged`), la chaîne de calcul des prix (prix de base → remise fournisseur → remises en cascade →
prix d'achat net → taux de conversion → frais → prix de revient → coefficient / taux de marque →
PV HT → PV TTC avec arrondi), les remises quantitatives (grille `Tbrem`, 6 tranches), les écotaxes
(TEE, TEA, copie privée), le stock (stock initial `Stkdep`, mini/maxi, minimum de commande), les
photos, la centrale d'achat et les statistiques (onglet `Gridvi`).

Fichier **legacy** (4757 lignes, 3775 LOC, CC 1127, 144 fonctions dont 143 `Public`), écrit en 2004
et enrichi par couches. Il est **mixte** de bout en bout : presque toutes les fonctions lisent et
écrivent directement les contrôles du formulaire ; les calculs de prix se font sur les chaînes des
`TextBox` (`Format$`/`Val`, locale française supposée, voir `Utils.cpoint` qui remplace `.` par `,`).

Le formulaire est utilisé **par son auto-instance** (`Articles.Show()` depuis `Fmenu.Menu15_Click`,
`Articles.ShowModal()` sur F3/F4 depuis `Achat`, `Facture`, `TarTypeCli`, `Prodcomposes`), par une
instance explicite (`New Articles(Null, code)` dans `GesTar.ButArt_Click` : le `Null` est le parent de
la fenêtre, convention relevée pour `LGed`), et comme **bibliothèque** : `SupprArt` appelle
`Articles.art_Suppr(code, False)` sur l'auto-instance, ce qui construit le formulaire (et exécute
`_New`) sans l'afficher.

### Navigation et drapeaux d'état

La saisie est pilotée par trois groupes d'événements et par le `Tag` des contrôles :

| Groupe | Contrôles (`Tag`) | Handlers |
|---|---|---|
| `Cmpt` / `cmpt` | `Code` 1, `Desg` 2, `fam` 3, `Four` 4, `Cequ`/`Cequ2` 5, `Cfour` 6, `Cbarre` 7, `PbHt` 8, `Tr` 9, `PaUA` 10, `Txconv` 11, `Frais` 12, `Coef` 13, `Percent` 14, `PvHt` 15, `PvTTc` 16, `Desg2` 17, `Eco` 18, `copp` 19, `Pvcons` 20, `Pbfbt`/`ddatefbt` 21, `Datefbt` 22, `RefCentrale` 23, `Bonus`/**`Artlie`** 24, `ColVte` 25, `PVHT2` 26, `Eco2`/**`Prvt`** 27 | `Cmpt_KeyPress`, `Cmpt_GotFocus`, `Cmpt_Change`, `Cmpt_lostFocus`, `Cmpt_dblclick` |
| `Stock` / `stock` | `Stkmini` 1, `Stkmaxi` 2, `Mincom` 3, `Poids2`/`Uembvente` 4, `Poids` 5, `Casier` 6, `Rpl1` 7, `Rpl2` 8, `Uembachat` (sans tag) | `Stock_KeyPress`, `Stock_GotFocus` |
| `Btn` | `Button3` 1 (Supprimer), `Button4` 2 (Enregistrer), `Button5` 3 (Fermer), `Button2` 4 (Histo ventes), `Button11` 5 (Histo achats), `Button15` 7 (Étiquette), `Button1` 9 (Créer) | `Btn_click`, `Btn_keyPress`, `Btn_Enter`, `Btn_Leave` |
| `Ard` / `ard` | `Arr` 1 (arrondi), `Nbd` 2 (décimales des prix), `Dec` 3 (décimales des quantités), `Centrale` | `Ard_click`, `Ard_GotFocus` |
| `Rem` | `Rem1` 1, `Rem2` 2, `Rem3` 3 | `Rem_KeyPress` |
| `Rb` | `RadioButton1` à `RadioButton7` (filtres de la liste) | `Rb_Click` |
| `Dsg` | `Dsg1` | aucun (`Dsg1_GotFocus` n'est jamais levé) |

Tags en double (⚠️, ARTICLES-A14) : `Artlie` partage le tag 24 de `Bonus`, `Prvt` le tag 27 de
`Eco2`, `ddatefbt` le tag 21 de `Pbfbt`.

Drapeaux d'instance qui gouvernent la navigation (sans `$`, déclarés implicitement `Private`) :

| Drapeau | Rôle |
|---|---|
| `b` | erreur de saisie du dernier champ validé (1 = rester sur le champ) ; testé par `Btn_click` avant `EnrgArt` |
| `Chkfocus` | autorise la validation au `LostFocus` (mis à `False` à l'entrée des boutons pour ne pas valider deux fois) |
| `Chkf` | 1 après le premier `Cmpt_Change` (active `Cmpt_Change` et `Cmpt_lostFocus`, et la mise à jour de `art_ddatefbt`) |
| `Reaf` | 1 = article déjà affiché (évite un réaffichage dans `ArtLF`) ; `Maj_Zones(…, 1)` n'affiche presque rien (ARTICLES-A09) |
| `nouveau` | `"1"` code saisi inconnu (création), `"0"` article existant |
| `ibarre`, `sbarre` | lecture d'un code-barre préfixé `*` dans `Code` |
| `Fml`, `Fcfour`, `Txc` | valeurs de `fam`, `Cfour`, `Txconv` à l'entrée dans le champ (détection de changement) |
| `Tvavente` | 1 si le compte de TVA de la famille n'existe pas (bloque l'enregistrement) |
| `Promo`, `Cpromo`, `Apromo` | promotion du jour (`Fiches_Promo`) et appartenance de l'article |
| `$soption`, `$opt` | option métier `Utils.Option()` (`N`, `B` boisson, `P`, `T`) et onglet `Artopt` |

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `ComResult` | var | Private |  | Result | 26 |
| `n` | var | Private |  | Integer | 27 |
| `Tri` | var | Private |  | String | 28 |
| `sel` | var | Private |  | String | 29 |
| `Arttable` | var | Private |  | New String[8] | 30 |
| `montante` | var | Private |  | String | 31 |
| `B` | var | Private |  | Integer | 32 |
| `B2` | var | Private |  | Integer | 33 |
| `Stk` | var | Private |  | Integer | 34 |
| `Stk2` | var | Private |  | Integer | 35 |
| `Spd` | var | Private |  | Integer | 36 |
| `Dne` | var | Private |  | String | 37 |
| `nbdec` | var | Private |  | String | 38 |
| `Reaf` | var | Private |  | Integer | 39 |
| `Tvavente` | var | Private |  | Integer | 40 |
| `Ecotaxe` | var | Private |  | String | 41 |
| `Dbl` | var | Private |  | String | 42 |
| `Fml` | var | Private |  | String | 43 |
| `Fcfour` | var | Private |  | String | 44 |
| `Txc` | var | Private |  | String | 45 |
| `CoulB` | var | Private |  | Integer | 46 |
| `CoulF` | var | Private |  | Integer | 47 |
| `CoulZns` | var | Private |  | Integer | 48 |
| `CoulZnaf` | var | Private |  | Integer | 49 |
| `CoulFc` | var | Private |  | Integer | 50 |
| `Fnt` | var | Private |  | String | 51 |
| `sKey` | var | Private |  | String | 52 |
| `nouveau` | var | Private |  | String | 53 |
| `Gmateriel` | var | Private |  | Boolean | 54 |
| `Gpvcons` | var | Private |  | Boolean | 55 |
| `hmat` | var | Private |  | Materiel | 56 |
| `$iRow` | var | Private |  | Integer | 57 |
| `$iColumn` | var | Private |  | Integer | 58 |
| `Chkfocus` | var | Private |  | Boolean | 59 |
| `Chkf` | var | Private |  | Integer | 60 |
| `ibarre` | var | Private |  | Integer | 61 |
| `sbarre` | var | Private |  | String | 62 |
| `Promo` | var | Private |  | Boolean | 63 |
| `Cpromo` | var | Private |  | String | 64 |
| `Apromo` | var | Private |  | Boolean | 65 |
| `sCentrale` | var | Private |  | String | 66 |
| `$cequ` | var | Private |  | String | 67 |
| `Bequ` | var | Private |  | Boolean | 68 |
| `$code` | var | Private |  | String | 69 |
| `$cbarre` | var | Private |  | String | 70 |
| `Bbarre` | var | Private |  | Boolean | 71 |
| `$rpl1` | var | Private |  | String | 72 |
| `$rpl2` | var | Private |  | String | 73 |
| `Brpl1` | var | Private |  | Boolean | 74 |
| `Brpl2` | var | Private |  | Boolean | 75 |
| `NbEnreg` | var | Private |  | Integer | 76 |
| `NbEnregTot` | var | Private |  | Integer | 77 |
| `hImage` | var | Private |  | Image | 78 |
| `hColArts` | var | Private |  | Boolean | 79 |
| `lg` | var | Private |  | Integer | 80 |
| `typed` | var | Private |  | String | 81 |
| `Bsel` | var | Public |  | Boolean | 83 |
| `Bval` | var | Public |  | String | 84 |
| `Tableau` | var | Private |  | String[] | 86 |
| `$grdv` | var | Private |  | Gridvi | 87 |
| `$ipr` | var | Private |  | Integer[] | 88 |
| `$soption` | var | Private |  | String | 90 |
| `$opt` | var | Private |  | Artopt | 91 |
| `trb` | var | Private |  | TriGen | 93 |
| `Col` | var | Private |  | Collection | 94 |
| `Col2` | var | Private |  | Collection | 95 |
| `CB1Conv` | var | Private |  | Collection | 96 |
| `SmallPanel` | var | Private |  | Integer | 97 |
| `Coul` | var | Private |  | LCoul | 98 |
<!-- /AUTO:declarations -->

⚠️ Le bloc ci-dessus ne liste pas les 40 variables déclarées **sans mot-clé** (lignes 26 à 65 :
`ComResult`, `n`, `Tri`, `sel`, `Arttable`, `montante`, `B`, `B2`, `Stk`, `Stk2`, `Spd`, `Dne`,
`nbdec`, `Reaf`, `Tvavente`, `Ecotaxe`, `Dbl`, `Fml`, `Fcfour`, `Txc`, `CoulB`, `CoulF`, `CoulZns`,
`CoulZnaf`, `CoulFc`, `Fnt`, `sKey`, `nouveau`, `Gmateriel`, `Gpvcons`, `hmat`, `Chkfocus`, `Chkf`,
`ibarre`, `sbarre`, `Promo`, `Cpromo`, `Apromo`) : elles sont `Private` (limite du parseur, signalée
dans le compte rendu d'outillage). Inutilisées ou écrites sans être lues : `Arttable`, `Spd`, `Dbl`,
`CoulB`, `CoulF`, `Fnt`, `NbEnreg`, `hColArts`, `Tableau`, `lg` (masquée par les locales `Lg`), `sel`,
`Stk`, `Stk2`, `NbEnregTot`, `CoulZns`, `CoulFc`, `sKey`, `B2` (lue seulement par le code mort
`Dsg1_GotFocus`). `Bsel`/`Bval` ne sont pas lues dans le fichier mais sont **écrites par `TriGen`**
via `Object.SetProperty(Obj, "Bsel"/"Bval", …)` (`TriGen.class:138-139`, `228-232`, `Me` passé en
paramètre `ob`) : elles doivent rester `Public`.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 101-225 | Public | 19 | 112 | 0 | méthode spéciale |
| `Form_Open` | 227-252 | Public | 5 | 21 | 0 | handler GUI |
| `Tabstrip1_click` | 254-258 | Public | 1 | 3 | 0 | handler GUI |
| `Maj_Zones` | 260-510 | Public | 96 | 229 | 0 | portée réductible ? |
| `Maj_Composant` | 512-538 | Public | 4 | 24 | 0 | portée réductible ? |
| `Composants_Click` | 540-553 | Public | 3 | 11 | 0 | handler GUI |
| `Refresh` | 556-561 | Public | 1 | 4 | 0 | portée réductible ? |
| `CleanChamps` | 563-676 | Public | 2 | 107 | 0 | portée réductible ? |
| `RdimColArts` | 678-688 | Public | 3 | 9 | 0 | portée réductible ? |
| `AfficheArt` | 690-734 | Public | 6 | 37 | 0 | portée réductible ? |
| `Qte_DblClick` | 736-784 | Public | 3 | 46 | 0 | handler GUI |
| `ToggleButton66_Click` | 786-808 | Public | 7 | 20 | 0 | portée réductible ? |
| `ToggleButton6_Click` | 813-866 | Public | 11 | 51 | 0 | handler GUI |
| `Cmpt_KeyPress` | 868-1307 | Public | 84 | 398 | 0 | handler GUI |
| `Btn_keyPress` | 1309-1320 | Public | 4 | 10 | 0 | handler GUI |
| `Rb_Click` | 1322-1369 | Public | 8 | 39 | 0 | handler GUI |
| `Ard_click` | 1371-1385 | Public | 4 | 11 | 0 | handler GUI |
| `Btn_Enter` | 1387-1402 | Public | 7 | 10 | 0 | handler GUI |
| `Btn_Leave` | 1404-1416 | Public | 3 | 8 | 0 | handler GUI |
| `Btn_click` | 1418-1480 | Public | 13 | 48 | 0 | handler GUI |
| `Cmpt_GotFocus` | 1485-1531 | Public | 18 | 39 | 0 | handler GUI |
| `Cmpt_Change` | 1533-1552 | Public | 17 | 17 | 0 | handler GUI |
| `Cmpt_lostFocus` | 1554-1802 | Public | 76 | 202 | 0 | handler GUI |
| `Dsg1_GotFocus` | 1804-1837 | Public | 5 | 18 | 0 | portée réductible ? |
| `ArtLF` | 1839-1872 | Public | 9 | 31 | 0 | portée réductible ? |
| `CfourLF` | 1874-1892 | Public | 5 | 13 | 0 | portée réductible ? |
| `FamLF` | 1894-1918 | Public | 5 | 22 | 0 | portée réductible ? |
| `fourLF` | 1920-1929 | Public | 2 | 8 | 0 | portée réductible ? |
| `pbhtLF` | 1934-1963 | Public | 9 | 28 | 0 | portée réductible ? |
| `TrC` | 1968-2001 | Public | 10 | 31 | 0 | portée réductible ? |
| `Cmpt_dblclick` | 2003-2020 | Public | 3 | 15 | 0 | handler GUI |
| `Rem_KeyPress` | 2022-2062 | Public | 16 | 34 | 0 | handler GUI |
| `PaUAGF` | 2067-2071 | Public | 3 | 3 | 0 | portée réductible ? |
| `PaUALF` | 2073-2130 | Public | 13 | 54 | 0 | portée réductible ? |
| `TxLF` | 2135-2170 | Public | 11 | 34 | 0 | portée réductible ? |
| `FraisLF` | 2175-2204 | Public | 8 | 28 | 0 | portée réductible ? |
| `Coeff` | 2209-2232 | Public | 7 | 22 | 0 | portée réductible ? |
| `Pourcent` | 2237-2261 | Public | 8 | 23 | 0 | portée réductible ? |
| `PvhtLF` | 2266-2303 | Public | 10 | 36 | 0 | portée réductible ? |
| `PvTTcLF` | 2308-2350 | Public | 13 | 40 | 0 | portée réductible ? |
| `PvconsLF` | 2355-2383 | Public | 11 | 27 | 0 | portée réductible ? |
| `Pds_LF` | 2388-2412 | Public | 9 | 23 | 0 | portée réductible ? |
| `Bonus_LF` | 2417-2441 | Public | 9 | 23 | 0 | portée réductible ? |
| `ColVteLF` | 2446-2470 | Public | 9 | 23 | 0 | portée réductible ? |
| `PVHT2LF` | 2475-2499 | Public | 9 | 23 | 0 | portée réductible ? |
| `Ec0LF` | 2504-2525 | Public | 5 | 19 | 0 | portée réductible ? |
| `EcoLF` | 2530-2551 | Public | 5 | 19 | 0 | portée réductible ? |
| `Eco2LF` | 2556-2577 | Public | 5 | 19 | 0 | portée réductible ? |
| `CoppLF` | 2582-2603 | Public | 5 | 20 | 0 | portée réductible ? |
| `Tva_Calcul` | 2608-2620 | Public | 4 | 10 | 0 | portée réductible ? |
| `arrondi` | 2625-2662 | Public | 10 | 33 | 0 | portée réductible ? |
| `Ard_GotFocus` | 2664-2670 | Public | 1 | 5 | 0 | handler GUI |
| `RefCentraleLF` | 2672-2678 | Public | 2 | 5 | 0 | portée réductible ? |
| `Reaff` | 2683-2691 | Public | 1 | 7 | 0 | portée réductible ? |
| `Calc_Marge` | 2696-2712 | Public | 7 | 14 | 0 | portée réductible ? |
| `Calc_Percent` | 2717-2724 | Public | 2 | 3 | 0 | portée réductible ? |
| `Calc_coeff` | 2729-2734 | Public | 2 | 3 | 0 | portée réductible ? |
| `Calc_coeff2` | 2739-2743 | Public | 2 | 3 | 0 | portée réductible ? |
| `CB1_Click` | 2745-2749 | Public | 1 | 3 | 0 | handler GUI |
| `Cb1_LostFocus` | 2751-2756 | Public | 2 | 4 | 0 | handler GUI |
| `Mat_Click` | 2758-2768 | Public | 3 | 9 | 0 | handler GUI |
| `Stocke_Click` | 2770-2778 | Public | 2 | 7 | 0 | handler GUI |
| `Stocke_MouseUp2` | 2780-2820 | Public | 16 | 38 | 0 | portée réductible ? |
| `Ect_Click` | 2822-2848 | Public | 6 | 25 | 0 | handler GUI |
| `Ect2_Click` | 2850-2872 | Public | 4 | 21 | 0 | handler GUI |
| `Cpp_Click` | 2874-2896 | Public | 4 | 21 | 0 | handler GUI |
| `ToggleButton1_Enter` | 2901-2905 | Public | 1 | 3 | 0 | handler GUI |
| `ToggleButton1_Leave` | 2907-2911 | Public | 1 | 3 | 0 | handler GUI |
| `ToggleButton1_click` | 2913-2948 | Public | 5 | 32 | 0 | handler GUI |
| `fourList_Click` | 2953-2961 | Public | 1 | 7 | 0 | handler GUI |
| `fourList_KeyPress` | 2966-2980 | Public | 5 | 13 | 0 | handler GUI |
| `TvaMan` | 2985-3000 | Public | 3 | 13 | 0 | portée réductible ? |
| `FamMan` | 3005-3051 | Public | 12 | 44 | 0 | portée réductible ? |
| `fourMan` | 3056-3078 | Public | 7 | 20 | 0 | portée réductible ? |
| `ToggleButton3_Enter` | 3083-3087 | Public | 1 | 3 | 0 | handler GUI |
| `ToggleButton3_Leave` | 3089-3093 | Public | 1 | 3 | 0 | handler GUI |
| `ToggleButton3_Click` | 3095-3135 | Public | 5 | 37 | 0 | handler GUI |
| `FamList_Click` | 3140-3156 | Public | 3 | 14 | 0 | handler GUI |
| `FamList_KeyPress` | 3161-3177 | Public | 5 | 13 | 0 | handler GUI |
| `ToggleButton4_Click` | 3182-3210 | Public | 4 | 26 | 0 | handler GUI |
| `ColMarque_Click` | 3215-3221 | Public | 1 | 5 | 0 | handler GUI |
| `ColMarque_KeyPress` | 3226-3237 | Public | 5 | 10 | 0 | handler GUI |
| `Pmp_DblClick` | 3242-3252 | Public | 3 | 9 | 0 | handler GUI |
| `CtrlArt` | 3257-3268 | Public | 2 | 9 | 0 | portée réductible ? |
| `CtrlCfour` | 3273-3296 | Public | 8 | 21 | 0 | portée réductible ? |
| `CtrlCfourbl` | 3301-3318 | Public | 5 | 15 | 0 | portée réductible ? |
| `CtrlRefCentrale` | 3323-3345 | Public | 6 | 20 | 0 | portée réductible ? |
| `CtrlCbarre` | 3350-3368 | Public | 5 | 16 | 0 | portée réductible ? |
| `codeBarre` | 3374-3397 | Public | 10 | 21 | 0 | portée réductible ? |
| `Gencode` | 3402-3416 | Public | 5 | 13 | 0 | portée réductible ? |
| `Calc_barre` | 3421-3452 | Public | 6 | 28 | 0 | portée réductible ? |
| `Stock_GotFocus` | 3457-3469 | Public | 3 | 11 | 0 | handler GUI |
| `Stock_KeyPress` | 3475-3553 | Public | 22 | 69 | 0 | handler GUI |
| `Decimal` | 3558-3576 | Public | 4 | 17 | 0 | portée réductible ? |
| `Stockmini_LF` | 3578-3594 | Public | 4 | 15 | 0 | portée réductible ? |
| `Stockmaxi_LF` | 3599-3615 | Public | 4 | 15 | 0 | portée réductible ? |
| `Mincom_LF` | 3617-3634 | Public | 5 | 16 | 0 | portée réductible ? |
| `Stkdep_DblClick` | 3636-3649 | Public | 5 | 12 | 0 | handler GUI |
| `Stkdep_KeyPress` | 3651-3655 | Public | 1 | 3 | 0 | handler GUI |
| `Stkdep_LostFocus` | 3657-3666 | Public | 3 | 8 | 0 | handler GUI |
| `Button10_click` | 3672-3699 | Public | 19 | 24 | 0 | handler GUI |
| `tbrem_Click` | 3702-3713 | Public | 2 | 9 | 0 | handler GUI |
| `tbxrem_KeyPress` | 3716-3748 | Public | 5 | 24 | 0 | handler GUI |
| `MoveToCol` | 3751-3764 | Public | 5 | 12 | 0 | portée réductible ? |
| `ShowTextBox` | 3767-3790 | Public | 12 | 21 | 0 | portée réductible ? |
| `HideTextBox` | 3793-3824 | Public | 15 | 28 | 0 | portée réductible ? |
| `EnrgArt` | 3829-3978 | Public | 68 | 143 | 0 | portée réductible ? |
| `Maj_CodeBarre` | 3980-3988 | Public | 5 | 6 | 0 | portée réductible ? |
| `Del_CodeBarre` | 3990-3997 | Public | 4 | 6 | 0 | portée réductible ? |
| `Maj_Rpl1` | 3999-4009 | Public | 6 | 8 | 0 | portée réductible ? |
| `Del_Rpl1` | 4011-4020 | Public | 7 | 8 | 0 | portée réductible ? |
| `Maj_Rpl2` | 4022-4032 | Public | 6 | 8 | 0 | portée réductible ? |
| `Del_Rpl2` | 4034-4043 | Public | 7 | 8 | 0 | portée réductible ? |
| `Del_Codequ` | 4045-4054 | Public | 4 | 7 | 0 | portée réductible ? |
| `art_Suppr` | 4060-4155 | Public | 27 | 85 | 1 |  |
| `Button1_Click` | 4160-4181 | Public | 4 | 15 | 0 | portée réductible ? |
| `ToggleButton5_Click` | 4186-4239 | Public | 11 | 51 | 0 | handler GUI |
| `Colcom_Activate` | 4244-4257 | Public | 2 | 11 | 0 | handler GUI |
| `Colcom_KeyPress` | 4259-4266 | Public | 6 | 6 | 0 | handler GUI |
| `ChkPrx` | 4268-4276 | Public | 7 | 7 | 0 | portée réductible ? |
| `Phot_Click` | 4281-4303 | Public | 6 | 20 | 0 | handler GUI |
| `FileFilter` | 4305-4313 | Private | 1 | 6 | 0 |  |
| `aff_Photo` | 4315-4350 | Public | 14 | 33 | 0 | portée réductible ? |
| `Tnom_Photo` | 4352-4364 | Public | 2 | 10 | 0 | portée réductible ? |
| `Button12_Click` | 4366-4375 | Public | 2 | 8 | 0 | handler GUI |
| `DateChooser1_Activate` | 4377-4384 | Public | 1 | 6 | 0 | handler GUI |
| `Aff_Centrale` | 4386-4400 | Public | 5 | 12 | 0 | portée réductible ? |
| `ToggleButton2_Click` | 4405-4410 | Public | 1 | 4 | 0 | handler GUI |
| `Codart` | 4415-4420 | Public | 1 | 4 | 0 | portée réductible ? |
| `Maj_Dssr` | 4425-4458 | Public | 2 | 28 | 0 | portée réductible ? |
| `ColTriGenDoc_MajSel` | 4460-4470 | Public | 2 | 8 | 0 | handler GUI |
| `Button8_Click` | 4472-4507 | Public | 4 | 30 | 0 | handler GUI |
| `Button7_Enter` | 4512-4516 | Public | 1 | 3 | 0 | handler GUI |
| `Button7_Leave` | 4518-4522 | Public | 1 | 3 | 0 | handler GUI |
| `Button7_Click` | 4524-4528 | Public | 1 | 3 | 0 | handler GUI |
| `Button13_Click` | 4530-4540 | Public | 2 | 7 | 0 | handler GUI |
| `Button6_Click` | 4542-4550 | Public | 2 | 7 | 0 | handler GUI |
| `Button9_Click` | 4552-4563 | Public | 2 | 10 | 0 | handler GUI |
| `Button16_Click` | 4565-4578 | Public | 2 | 12 | 0 | handler GUI |
| `Maj_ColType` | 4580-4613 | Public | 5 | 31 | 0 | portée réductible ? |
| `$opt_recalculpx` | 4615-4619 | Public | 1 | 3 | 0 | handler GUI |
| `ColTri_MajSel` | 4621-4647 | Public | 2 | 12 | 0 | handler GUI |
| `ColTri_Resize` | 4649-4654 | Public | 1 | 3 | 0 | handler GUI |
| `Filter_Calc` | 4657-4687 | Public | 9 | 26 | 0 | portée réductible ? |
| `Update_Req` | 4689-4757 | Public | 7 | 63 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

⚠️ La table ci-dessus omet le handler `$opt_recalculpx()` (lignes 4615-4619), levé par l'événement
`recalculpx` de `Artopt` (`artopt.class:21`, `Raise` ligne 313) : le parseur ignore les noms de
fonction qui commencent par `$`.

## Description des fonctions

### Construction, ouverture, liste des articles

- **`_New(Optional prod)`** [portée : nécessaire] [nature : mixte]. Centre, charge la musique,
  configure `marque` (`TextReg` sur `Fiches_Marques` **en dur**), lit `/Soc<XX>/Materiel`, `/Pvcons`,
  `/Caisse`, `/Taxe`, les couleurs `/Coul/*`, installe les observateurs (`Utils.Observers`),
  configure les grilles `Tbrem` (6 × 3) et `Tbrem2` (boucle qui affecte six fois la même valeur),
  remplit `Centrale` (`Cbase.Table("TabCentrales")`), compte les articles (`SELECT art_code` sur
  `TabArt`, résultat `NbEnregTot` jamais lu), crée l'onglet `Artopt` si `Utils.Option() <> "N"`, crée
  `Gridvi` (statistiques), lit `/Soc<XX>/ipr` (⚠️ s'il est vide : `Message.Error` puis `Me.Close`
  **dans le constructeur**, l'exécution continue, ARTICLES-A17), remplit `CB1`/`CB1Conv` (colonne
  supplémentaire de la liste), puis `Update_Req()`. Si `prod` est fourni, l'écrit dans `code`.
- **`Form_Open()`** [handler] [mixte]. Cherche **la première** promotion active du jour
  (`TabPromo`, `datedeb <= aujourd'hui <= datefin`) ; affiche l'article de `code` (`AfficheArt` +
  `Maj_ColType`) ou vide les champs. Même requête dans `Caisse.class:218` et `Facture.class:508`.
- **`Tabstrip1_click()`** [handler] [GUI] : réinstalle les observateurs.
- **`Update_Req()`** [portée : réductible] [mixte]. Construit les colonnes `ObjProp` et la liste
  `TriGen` (`Panel1`, événement `ColTri`) sur `select *, <Coul.Art_DB_bgcolor()> from TabArt` ; la
  6ᵉ colonne dépend de `CB1` (`CB1Conv`). La branche `mo_code` (`TabMo`) et `Default`
  (`Error.Raise`) sont **inatteignables** : `Tri` vaut toujours `"art_code"` (lignes 217 et 238).
  Ferme l'ancienne liste (`trb.Close(Null)`) puis applique `Filter_Calc`.
- **`Filter_Calc()`** [réductible] [mixte] : filtre SQL de la liste selon les radios
  (stockés, non stockés, tous, en stock > 0, épuisés ≤ 0, suspendus, produits composés) via
  `trb.ExtraSel`.
- **`Rb_Click()`** [handler] [GUI] : vide la fiche, positionne `Stk`/`Stk2` (jamais relus) et appelle
  `Filter_Calc`.
- **`CB1_Click()`** / **`Cb1_LostFocus()`** [handler] : reconstruisent la liste (`Update_Req`).
- **`ColTri_MajSel(val)`** [handler de `TriGen`] [GUI] : sélection dans la liste → réduit la liste,
  `AfficheArt`, `Maj_Dssr`, `Maj_ColType`. **`ColTri_Resize()`** → `RdimColArts`.
- **`RdimColArts(ForceSmall)`** [réductible] [GUI] : bascule la hauteur de `Panel1` (F2 sur `Code`
  ou `Desg`).
- **`Refresh()`** [portée : à confirmer] : `sel = ""` puis `Form_Open()`. Aucun appel explicite
  trouvé (grep) ; le nom **surcharge la méthode héritée `Refresh` du formulaire** : ne pas la
  supprimer ni la rendre `Private` sans vérifier l'effet sur `Form.Refresh` (à confirmer).

### Affichage d'un article

- **`AfficheArt(Prod)`** [réductible] [GUI] : `CleanChamps`, `Maj_Zones(Prod, 0)`,
  `Maj_Composant`, affiche `Panel6` (remises en cascade) si `Rem1 > 0`, colore `qte` si stock ≤ 0.
  `Catch` vide. Les locales `chkf` et `Fml` masquent les membres de même nom (affectations sans effet).
- **`Maj_Zones(Prod, Reaf)`** (CC 96, max du fichier) [réductible] [mixte]. Lit la fiche
  (`TabArt`) et remplit ~80 contrôles ; charge les listes `Cbarre` (`TabCdBarre`), `Rpl1`
  (`TabRpl1`), `Rpl2` (`TabRpl2`), `Cequ` (`TabCequ`) par quatre boucles identiques ; quantité en
  commande fournisseur (`Utils.Commande` si une ligne `TabLigcom` existe) ; centrale
  (`Aff_Centrale`) ; marges (`Calc_Percent`, `Calc_Marge`) ; grille `Tbrem` (18 `Try` identiques à
  `Button10_click`) ; photo ; statistiques (`$grdv.bouton_Click`) ; option (`$opt.numart`) ;
  promotion (`ArtPromo.art_Promo` + `Balloon`). Article inconnu : `nouveau = "1"`, `Stocke` coché,
  focus sur `Desg`.
  ⚠️ Tout le remplissage est dans `If Reaf <> 1` : appelée avec `Reaf = 1` (par `Reaff`, sur
  changement de `Nbd`), elle **vide seulement `Cbarre` et `Cequ`** (ARTICLES-A09). Les tests
  `If Reaf <> 1` (327) et `If reaf <> "1"` (481) internes sont donc toujours vrais, et l'avertissement
  de changement de famille (278-285) est **inatteignable** : `CleanChamps()` (273) vient de vider
  `Fam`. Ligne 437 : `If Error` redondant. `Catch` : son + `Message.Error`.
- **`Maj_Composant()`** [réductible] [mixte] : si `Prdcomp`, liste les composants (`TabPrdComp`).
- **`Composants_Click()`** [handler, appelé dynamiquement par le rejeu] [mixte] : si `Qte > 0`,
  affiche la date de dernière entrée en stock lue dans `Fiches_Mvtexpdc` (**en dur**) pour
  **l'article affiché** (`code.Text`), et non pour le composant cliqué (ARTICLES-A12, à confirmer).
- **`CleanChamps()`** [réductible] [GUI + 1 requête] : remet à blanc ~100 contrôles ; relit
  `dnart` (dernier article créé) dans `Fiches_Parametres` (**en dur**) vers `Dera`.
- **`Aff_Centrale(sCentrale)`** [réductible] [mixte] : libellé de la centrale (`TabCentrales`).
- **`Maj_ColType()`** [réductible] [mixte] : grille `Coltype` des prix par type de client. Lit
  **toute** la jointure `Fiches_TarTypcli` × `Fiches_Typec` (**en dur**) et filtre côté client sur
  `cart = code`, puis relit `Fiches_Art` (en dur) pour chaque ligne retenue ; PV HT = `art_prvt × coef`,
  TTC via `CPrix.CTva`.
- **`Maj_Dssr()`** [réductible] [mixte] : liste `TriGen` (`PanelGedDoc`, événement `ColTriGenDoc`)
  des documents GED de l'article (`TabDocGed`, filtre `code` + `type = LGed.Articles` par
  `Utils.db.Subst`). **`ColTriGenDoc_MajSel(val)`** [handler] : ouvre le document (`LGed.Ouvrir`).

### Saisie : navigation clavier et focus

- **`Cmpt_KeyPress()`** (CC 84, 398 LOC) [handler] [mixte]. Entrée/Retour/Tab : `Select Case
  Last.Tag` (25 cas) qui valide le champ (fonction `*LF`/`*C` correspondante) puis déplace le focus
  sur le champ suivant, ou reste sur le champ si `b = 1`. Effets de bord notables : cas 5 (`Cequ`)
  écrit **immédiatement** l'équivalence en base (`MajEqu.Maj`) avant tout enregistrement ; cas 13/14
  recalculent toute la chaîne de prix. Autres touches : `ChkPrx` sur `Pbfbt` ; **Suppr** sur `Cequ`
  → `Del_Codequ`, sur `Cbarre` → `Del_CodeBarre` (⚠️ ARTICLES-A01/A02 : la touche Suppr sert aussi à
  effacer un caractère) ; F1 aide ; F2 liste (`RdimColArts`, familles, fournisseurs, calendrier) ;
  F4 `Famille.ShowModal()` / `FFournisseur.ShowModal()` (auto-instances) ; F9 `Gencode`.
- **`Cmpt_GotFocus()`** [handler] : observateur, couleur de `qte`, mémorise `Fml`/`Fcfour`/`Txc`,
  affiche `Panel6`, `PaUAGF` ; remet `b = 0`.
- **`Cmpt_Change()`** [handler] : détecte un changement de `Code` (`Reaf = 0`), `Cequ` (`Bequ`),
  `Cbarre` (`Bbarre`) ; transmet `PaUA`/`Prvt` à l'option (`$opt.prixachat`, `$opt.prixrev`, ce
  dernier aussi levé par `Eco2`, même tag 27).
- **`Cmpt_lostFocus()`** (CC 76) [handler] : même aiguillage que `Cmpt_KeyPress` au départ du
  champ (si `Chkfocus` et `Chkf = 1`), sans déplacement de focus sauf erreur. Cas 24 sans `Stop Event`.
- **`Cmpt_dblclick()`** [handler] : double clic sur `Tr` → bascule le panneau des remises en cascade.
- **`Btn_keyPress()`** [handler] : Entrée sur `Button4` → `EnrgArt` **sans tester `b`**.
- **`Btn_Enter()` / `Btn_Leave()`** [handlers] : `Chkfocus` ; entrée sur Enregistrer avec famille
  ou fournisseur vide → `b = 1` (l'enregistrement par clic est alors ignoré silencieusement).
- **`Btn_click()`** [handler] [mixte] : 1 suppression (`art_Suppr` + message, ou remise à blanc et
  liste), 2 enregistrement (`EnrgArt` si `b <> 1`), 3 fermeture, 4/5 historiques ventes/achats
  (`TriHistos`), 7 étiquettes (`Etiqart`, `Etigond`, `Etiqcasier`), 9 création (`Button1_Click`).
- **`Stock_GotFocus()`** / **`Stock_KeyPress()`** (CC 22) [handlers] : navigation du groupe stock
  (stock mini/maxi, minimum de commande, poids), mémorisation et suppression (Suppr) des
  remplacements `Rpl1`/`Rpl2`, filtrage numérique (`ChkPrx`). Cas 3 à 6 sans `Stop Event`.
- **`Ard_click()`** [handler] : `Arr` → `arrondi` + `PvTTcLF` ; `Nbd` → `Reaff`. **`Ard_GotFocus()`** :
  couleur d'édition.
- **`ChkPrx()`** [réductible] [GUI] : bloque les touches non numériques (hors `,` `.` et touches
  d'édition).
- **`Dsg1_GotFocus()`** — **code mort** : `Dsg1` appartient au groupe `Dsg` du `.form`, l'événement
  nominal n'est jamais levé (`handlers_inactifs` de `deps.py`, confirmé) ; aucun appel (grep). Il
  serait le seul lecteur de `b2`.

### Validation des champs (`*LF`, `*C`)

Toutes [portée : réductible] [nature : mixte]. Schéma commun : `cpoint`, `Val(...) = Null` →
son + « Veuillez verifier votre saisie SVP ! » + `b = 1`, sinon reformatage et calculs dérivés ;
`Catch` : son + `Message.Error(Error.Text & " " & Error.Where)` + `b = 1`.

- **`ArtLF()`** : code préfixé `*` → recherche par code-barre (`Utils.Find_cbarre`) puis
  `Maj_Zones` ; sinon `Maj_Zones` si `nouveau = "0"` et `Reaf <> 1`.
- **`FamLF()`** : changement de famille saisi au clavier. ⚠️ ARTICLES-A08 : l'appel
  `Message.Warning("…sauvegarder." "Oui", "Non")` contient deux littéraux **adjacents sans virgule**
  (concaténés par le compilateur, vérifié avec `gbs3`) : le message se termine par « Oui » et n'a
  qu'un bouton « Non », donc `r = 1` toujours ; la branche « Oui » applique les paramètres de la
  famille (`FamMan(True)`) puis **remet l'ancien code** `fam.text = Fml` quand il n'y a pas
  d'erreur. Comparer avec `FamList_Click`, correct.
- **`fourLF()`** → `fourMan`. **`CfourLF()`** → `CtrlArt`, `CtrlCfour`, `CtrlCfourbl` si la référence
  change. **`RefCentraleLF()`** → `CtrlRefCentrale`.
- **`pbhtLF()`** (prix de base HT) → `TrC` ou `Tr = 0`, puis `PaUALF`.
- **`TrC()`** (remise fournisseur) : `PaUA = pbht × (1 − Tr/100)`, puis cascade `CPrix.Cascade`
  avec `Rem1..3` si `Rem1 > 0`, `montante`, `PaUALF`.
- **`Rem_KeyPress()`** [handler] : remises en cascade 1 à 3 (même calcul que `TrC`, par étape).
- **`PaUAGF()`** : mémorise le PA net (`montante`) à l'entrée du champ.
- **`PaUALF()`** (PA net) : `paht = PaUA / Txconv`, `Prvt = paht + Frais`, `Pvht = Prvt × Coef`, TVA,
  arrondi, marge, `PvTTcLF` ; si le PA net a changé, question « Modifier la remise / le prix de
  base » qui recalcule `Tr` (formaté avec `nbdec` au lieu de `0.00`) ou `pbht`. PA nul : remise à
  zéro de toute la chaîne (article générique). ⚠️ `Val(PaUA.Text) <> "0"` compare un Float à une
  chaîne. Appelée aussi par l'événement `$opt_recalculpx`.
- **`TxLF()`** (taux de conversion) : recalcule `paht` et `Pmp` si la quantité en stock est nulle,
  refus (`Balloon`) sinon pour un article stocké.
- **`FraisLF()`**, **`Coeff()`**, **`Pourcent()`**, **`PvhtLF()`** (alerte PV < PA, `Me.Visible =
  True` sans effet utile), **`PvTTcLF()`** (PV HT = TTC / (1 + TVA), alerte PV < PA via
  `Utils.Bip`), **`PvconsLF()`** (alerte PV conseillé < PV TTC).
- **`Pds_LF()`**, **`Bonus_LF()`**, **`ColVteLF()`** (formaté `"0"` même si `Dec` autorise des
  décimales), **`PVHT2LF()`**, **`EcoLF()`**, **`Eco2LF()`**, **`CoppLF()`** : formatage simple
  (sans `Catch` pour les trois dernières).
- **`Ec0LF()`** — **code mort** (variante de `EcoLF` au format `nbdec`, aucun appel).
- **`Stockmini_LF()`**, **`Stockmaxi_LF()`** (via `Decimal`), **`Mincom_LF()`** (via `Utils.CDec`).
- **`Decimal(Stk)`** : formate une quantité selon `Dec` (0, 2 ou 3 décimales) ; même code dans
  `ConsultArt.Decimal` (mort là-bas).
- **`Stkdep_DblClick()` / `Stkdep_KeyPress()` / `Stkdep_LostFocus()`** [handlers] : saisie du stock
  initial, seulement pour un nouvel article stocké ; recopie dans `qte`.

### Calculs de prix et de marge

[portée : réductible] [nature : calcul sur les chaînes des contrôles].

- **`Tva_Calcul()`** : reformate `Txtva` (`"00.00"`) et `PvTTc = Pvht × (1 + Txtva/100)`.
- **`arrondi()`** : arrondi du PV TTC **par manipulation de chaîne** selon `Arr` : `0,05` (dernier
  caractère dans `[34567]` → `5`, sinon arrondi au dixième), `0,10`, `0,50` (seuils `.25`/`.75`/`.76`,
  rien entre `.75` et `.76` exclus), `1,00`. Le « dernier caractère » dépend de `nbdec` (avec 3
  décimales, c'est le millième qui est testé). Même idiome dans [`Movr.arrondi`](../Movr.class/architecture.md),
  [`Materiel.arrondi`](../Materiel.class/architecture.md),
  [`FTvav.arrondi`](../../../Compta/Tables/FTvav.class/architecture.md),
  [`LPrix.Arrondi_Calc`](../../../Utils/LPrix.class/architecture.md) et
  [`Utils.arrondi`](../../../Utils/Utils.module/architecture.md).
- **`Calc_Marge()`** : marge brute `Pvht − Pmp`, taux `/ paht`, marge sur revient `Pvht − Prvt` ;
  `Pmp` initialisé à `Prvt` s'il est vide.
- **`Calc_Percent()`** : taux de marque `(Pvht − Prvt) / Pvht × 100`.
- **`Calc_coeff()`** : `Coef = 1 / (1 − Percent/100)`. **`Calc_coeff2()`** : `Coef2 = PvTTC / Prvt`.
- **`Reaff()`** : changement de `Nbd` → `Maj_Zones(code, 1)` (voir A09) puis `pbhtLF`.
- **`Pmp_DblClick()`** [handler] : remplace le PMP par le PA HT après confirmation.

### Famille, fournisseur, marque, TVA

- **`FamMan(Update_all_fields)`** [réductible] [mixte] : lit la famille (`TabFam`), recopie le code
  exact, libellé, TVA ; si `Update_all_fields`, applique coefficient, remise et écotaxe de la famille
  puis `TrC`. Vérifie que le compte de TVA (`TabTvav.cc_tva`) existe dans `Fiches_Comptes` (**en
  dur**, variable `tvan`) → sinon `Tvavente = 1`. ⚠️ `Tvav!cc_tva` est lu sans test `Available`
  (code TVA inconnu → `Catch`).
- **`fourMan()`** [réductible] : nom du fournisseur (`TabFour`), `b = 1` s'il est inconnu.
- **`TvaMan()`** — **code mort** (aucun appel ; ses homonymes `Movr`/`FTvac` sont des copies).
- **`ToggleButton1_click()` / `ToggleButton3_Click()` / `ToggleButton4_Click()`** [handlers] [mixte] :
  listes déroulantes des fournisseurs, familles et marques (`TabFour`, `TabFam`, `TabMarq`). Avec
  `Dne` non vide (positionné par F2, **jamais remis à vide**), filtre par
  `left(code,'<n>') = '<texte>'` **concaténé** (apostrophe → erreur SQL, ARTICLES-A11).
  `ToggleButton1/3_Enter/_Leave` : `Chkfocus`. Ils écrivent `b2`, lu seulement par du code mort.
- **`fourList_Click()` / `FamList_Click()` / `ColMarque_Click()`** [handlers, appelés
  dynamiquement par le rejeu] : reprise de la sélection ; `FamList_Click` demande s'il faut
  appliquer les paramètres de la nouvelle famille (`FamMan(True)`) ou garder l'ancienne.
  **`*_KeyPress`** associés : Entrée = clic, Échap/F2 = fermeture.

### Contrôles d'unicité et codes-barres

[réductible] [mixte]. Chacun positionne le membre `b = 1` en cas de doublon.

- **`CtrlArt()`** : `nouveau` selon l'existence du code.
- **`CtrlCfour()`** : référence fournisseur déjà utilisée pour ce fournisseur, ou égale au code
  d'un autre article. **`CtrlCfourbl()`** : refuse de changer la référence fournisseur d'un article
  présent dans une commande (`TabLigcom`). **`CtrlRefCentrale()`** : référence centrale déjà
  attribuée. **`CtrlCbarre()`** : code-barre principal déjà attribué (`art_cbarre`).
- **`codeBarre()`** : longueur 8/12/13 et clé EAN13 (`Utils.Calcode`).
- **`Gencode()`** (F9) → **`Calc_barre()`** : code « 2 » + code article (si 12 premiers caractères
  numériques) ou nombre aléatoire (`Rnd`), complété à 12 chiffres + clé. Non déterministe.

### Enregistrement

- **`EnrgArt()`** (CC 68) [réductible] [mixte]. Normalise les désignations (`Utils.Remplace`),
  revalide écotaxes, stock initial, poids, minimum de commande, rejoue les contrôles d'unicité, vérifie
  qu'un changement de famille n'affecte pas un article présent dans des BL, revérifie le code-barre,
  puis, si `Tvavente = 0` :
  - **création** (article absent + confirmation) : `INSERT` de 61 colonnes dans `TabArt`, puis
    `UPdate` de 23 colonnes (`art_pvcons`… `art_cdate = LDate(Now).DT`), `UPdate Fiches_Parametres
    SET dnart` (**en dur**), export `Serveur.Pass("Art","C")`, codes-barres, remplacements,
    option (`$opt.enregiste`), équivalence (`MajEqu.Maj`) ;
  - **modification** : deux `UPdate` (37 + 47 colonnes ; les paramètres `&18` quantité et `&19`
    stock initial sont passés mais non utilisés : `art_qte` n'est jamais réécrite), export
    `Serveur.Pass("Art","M")`, `art_ddatefbt = Format$(Now,"yyyymmdd")` si `Chkf = 1`, option, puis
    mêmes mises à jour satellites si `Not Error` (⚠️ `Error` reflète le dernier `Try` exécuté, ligne
    3925 seulement si `Chkf = 1`).
  ⚠️ **ARTICLES-A03** : `Dim b As Integer` (3835) masque le membre `b`. Les contrôles
  `CtrlCfour`/`CtrlCbarre`/`CtrlCfourbl`/`CtrlRefCentrale` positionnent le membre et **ne bloquent
  pas** l'enregistrement ; la revérification du code-barre positionne le `b` local mais n'est pas
  testée avant l'écriture ; le refus de changement de famille (BL) affiche le message puis
  **enregistre la nouvelle famille**. ⚠️ **ARTICLES-A18** : à la création, `art_refcentrale` est forcé
  à `""` (paramètre littéral), `art_pbfbt`, `art_datefbt`, `art_crpl1` ne sont pas écrits ; le test
  `If nouveau = 0` (3896) n'est jamais vrai (`nouveau = "1"` dans cette branche).
- **`Maj_CodeBarre()`** : ajoute le code-barre dans `TabCdBarre` s'il est absent ; export `CB/M`.
- **`Del_CodeBarre()`** : ⚠️ **ARTICLES-A01** : `DELETE FROM TabCdBarre WHERE codeb` puis
  **`DELETE FROM Fiches_Art WHERE art_code = &1 and art_cbarre = &2`** (en dur) : si le code-barre
  supprimé est le code-barre principal, **la fiche article entière est supprimée**, sans
  confirmation ni contrôle (stock, documents), sur simple appui de Suppr dans `Cbarre`. Export `CB/S`.
- **`Maj_Rpl1()` / `Maj_Rpl2()`** : lien de remplacement **bidirectionnel** (`Rpl1(code, x)` +
  `Rpl2(x, code)`, et inversement) ; export `Rpl1/C`, `Rpl2/C`.
- **`Del_Rpl1()` / `Del_Rpl2()`** : suppression confirmée des deux sens ; export `Rpl2/S` dans les
  deux cas (à confirmer pour `Del_Rpl1`).
- **`Del_Codequ()`** : ⚠️ **ARTICLES-A02** : déclenchée par Suppr dans `Cequ` (le test
  `If Not IsNull(Cequ)` porte sur l'objet, toujours vrai), sans confirmation ; vide `art_cequ`, puis
  `DELETE FROM TabCequ WHERE codequ = &2 or codep = &2` (le paramètre `&1` code n'est pas utilisé :
  supprime **toutes** les équivalences de l'article équivalent) ; export `Serveur.Pass("Rpl1","S",
  code, Rpl1.Text)` au lieu d'une notification d'équivalence. Le résultat d'un `UPDATE` est affecté à
  un `Result` (`Rbarre`).

### Suppression

- **`art_Suppr(art_code, Confirm)`** [portée : **nécessaire**, appelée par `SupprArt` lignes 377 et
  423] [nature : mixte]. Confirmation si `Confirm` ; refus (message renvoyé) si l'article est inconnu,
  stocké avec quantité ≠ 0, présent dans un BL/document en cours (`TabLigbl` × `TabBl`, `typel_ligbl =
  'A'`), une commande fournisseur (`TabLigcom` × `TabEntcom`), une réception non validée
  (`TabLigrecpt` × `TabEntrecpt`), une fiche matériel (`TabMat`) ou un ticket non archivé
  (`TabLigTck`). Sinon : export `Art/S`, suppression des documents GED (`New LGed(Null, lind)` +
  `Supprime(False)` par document, puis `LGed.Supprime(True)` sur l'auto-instance), `DELETE` dans
  `TabArt`, `DELETE IGNORE` dans `TabMvtexp`, `TabInv`/`TabInvT` (si `SHOW TABLES LIKE`),
  `TabLigrecpt`, `TabCdBarre`, `TabRpl1`, `TabRpl2` (`codep` seulement), `TabCequ`. Renvoie `""` en
  cas de succès.
  ⚠️ **ARTICLES-A04** : le contrôle de stock lit **les contrôles du formulaire** (`stocke.value`,
  `qte.Text`), pas l'article `art_code` : appelée par `SupprArt` sur l'auto-instance, elle supprime des
  articles **en stock** (le message de `SupprArt` annonce le contraire), et si l'écran Articles est
  ouvert (même auto-instance), c'est le stock de l'article affiché qui est testé.
  ⚠️ **LGED-A07 / ARTICLES-A07** : `LGed.Supprime(True)` (4126) s'exécute sur l'auto-instance de
  `LGed` (`$index = 0`) : seule l'épuration des tags (`EpurationTags`) a lieu, ce qui correspond au
  commentaire de la ligne 4125 ; les enregistrements `Docs_Ged`/`Docs_Tag` sont bien supprimés par la
  boucle `Lg.Supprime(False)`. Le fichier du document reste sur le disque (comportement de `LGed`).
  L'anomalie LGED-A07 (« le document n'est pas supprimé ») est donc **à requalifier** (voir rework.md).
  ⚠️ **ARTICLES-A05** : nettoyage incomplet par rapport à la liste des tables portant un code article
  tenue par [`Changefam.Modifart`](../../../Utils/Changefam.class/architecture.md) : restent orphelins
  `Fiches_PrdComp` (`codep`, `codec`), `Fiches_ArtPromo`, `Fiches_CdFour`, `Fiches_EtiGond`,
  `Fiches_EtiProd`, `Fiches_Mvtexpdc`, `Fiches_Tarcli`, `Fiches_TarTypcli`, `Fiches_StkDepots`
  (absente aussi de `Modifart`) et les liens inverses `Fiches_Rpl1.coderpl1` / `Fiches_Rpl2.coderpl2`
  créés par `Maj_Rpl1`/`Maj_Rpl2`.
  ⚠️ **ARTICLES-A06** : `SHOW TABLES` et `DELETE IGNORE` ne sont pas traduits pour SQLite par
  `DB_Connection` (grep) ; le `Catch` final renvoie `False`, converti en chaîne vide (vérifié avec
  `gbs3` : `False` → `""`) : l'appelant conclut à un succès.

### Création, commandes, listes annexes

- **`Button1_Click()`** [réductible : `Button1` est dans le groupe `Btn`, la fonction n'est appelée
  que par `Btn_click` cas 9] [mixte] : vide la fiche, prépare l'option, propose le code suivant
  `Utils.Next_Code(Dera)` et l'affiche (`Maj_Zones`).
- **`ToggleButton6_Click()`** [handler] : liste `Colcom` des commandes **clients** contenant
  l'article (`TabLigbl` × `TabBl`, `type = "C"`). **`ToggleButton66_Click()`** — **code mort** : même
  requête, aucun contrôle `ToggleButton66` dans le `.form` ni appel.
- **`ToggleButton5_Click()`** [handler] : commandes **fournisseurs** (`TabLigcom`, puis une requête
  `TabEntcom` jointe à `Fiches_Four` **en dur** par ligne, requêtes N+1).
- **`Colcom_Activate()`** [handler] : ouvre `ACom` ou `AFacture` selon `Typed`.
  **`Colcom_KeyPress()`** : fermeture (`Key.Esc` et `Key.Escape` testés deux fois).
- **`Qte_DblClick()`** [handler] [mixte] : fenêtre construite par code (`Form` + `ColumnView` +
  `TextBox`) du stock par dépôt (`TabDepots` ⟕ `TabStkDepots`).
- **`Mat_Click()`**, **`Stocke_Click()`** (décocher « stocké » remet `qte`, mini, maxi à 0 **sans
  contrôle**), **`Ect_Click()`**, **`Ect2_Click()`**, **`Cpp_Click()`** (écotaxes exclusives)
  [handlers] [GUI].
- **`Stocke_MouseUp2()`** — jamais appelée : nom d'événement inexistant. C'est pourtant le **seul
  contrôle** interdisant de modifier « stocké » pour un article présent dans un BL ou l'inventaire
  (`TabLigbl`, `TabInv`) : à traiter comme anomalie (ARTICLES-A15) plutôt que comme code mort.
- **`Button10_click()`** [handler] : importe les remises quantitatives de la famille dans `Tbrem`.
- **`tbrem_Click()`**, **`tbxrem_KeyPress()`** [handlers], **`MoveToCol()`**, **`ShowTextBox()`**,
  **`HideTextBox()`** [réductibles] : édition de la grille `Tbrem` par une `TextBox` superposée ;
  même mécanisme dans [`Famille`](../Famille.class/architecture.md).
- **`Phot_Click()`** [handler] → `FileFilter()` (`Private`, paramètre `All` inutilisé) →
  **`aff_Photo(prem)`** : chargement et dessin dans `Photos`. ⚠️ `hImage.Stretch(...)` ne modifie pas
  l'image (résultat ignoré) ; en cas d'échec de `Image.Load`, l'image précédente reste dans `hImage` ;
  la réponse « Non » à l'avertissement de taille masque `Photos` puis dessine quand même (ARTICLES-A13).
- **`Tnom_Photo()`** — **code mort** (boucle de découpage du chemin, aucun appel ; homonyme dans
  `Fcaras`). **`Codart(coda)`** — **code mort**.
- **`Button12_Click()`**, **`DateChooser1_Activate()`** [handlers] : calendrier de la date de mise
  à jour des prix (`Datefbt`).
- **`ToggleButton2_Click()`** [handler] : écran `Materiel` (numéros de série).
- **`Button8_Click()`** [handler] [mixte] : nouveau document GED de l'article (`New LGed(Null, 0,
  LGed.Articles, "", code)`), tags famille et fournisseur, montants HT/TTC (`LPrix`), puis `Maj_Dssr`.
  ⚠️ **ARTICLES-A10** : `WHERE art_code = " & Code.Text` **sans quotes** : erreur SQL pour un code
  non numérique (tags et montants absents), correspondance numérique approximative sinon.
- **`Button13_Click()` / `Button6_Click()`** [handlers] : `TarTypeCli` en mode client / type client.
- **`Button9_Click()`** [handler] : coefficients par type client : écrit `Variables.OrgCoefTypeCli
  = "Art"`, `ArtCode`, `Artintitule`, `ArtTva` (`Txtva`), `ArtHt` (= `Prvt`, prix de revient affiché
  « PA HT » par `CoefTypeC`), puis `CoefTypeC.ShowModal()` (auto-instance). ⚠️ ARTICLES-A16 :
  `OrgCoefTypeCli` n'est jamais remis à zéro ; `CoefTypeC` ouvert ensuite par `Fmenu.class:2248`
  s'affiche en mode article avec l'article précédent (à confirmer).
- **`Button16_Click()`** [handler] : bascule l'affichage remises quantitatives / types clients.
- **`Button7_Click/_Enter/_Leave()`** [handlers] : aide (`Doc.Open("Articles")`).
- **`$opt_recalculpx()`** [handler de l'événement `recalculpx` de `Artopt`] : `PaUALF`.

## SQL émis : synthèse

| Opération | Tables (clé `Cbase`) | Fonctions |
|---|---|---|
| Lecture fiche | `TabArt`, `TabCdBarre`, `TabRpl1`, `TabRpl2`, `TabCequ`, `TabLigcom`, `TabCentrales`, `TabPrdComp`, `TabFam`, `TabTvav`, `TabFour`, `TabPromo`, `TabDocGed` ; en dur `Fiches_Parametres`, `Fiches_Comptes`, `Fiches_Mvtexpdc`, `Fiches_TarTypcli`, `Fiches_Typec`, `Fiches_Art`, `Fiches_Four`, `Fiches_Marques` | `Maj_Zones`, `CleanChamps`, `FamMan`, `Maj_ColType`, `Composants_Click`, `ToggleButton5_Click`, `_New` |
| Création | `INSERT` + `UPdate` `TabArt` ; `UPdate Fiches_Parametres.dnart` | `EnrgArt` |
| Modification | 2 × `UPdate` `TabArt` (+ `art_ddatefbt`) | `EnrgArt` |
| Satellites | `INSERT`/`DELETE` `TabCdBarre`, `TabRpl1`, `TabRpl2`, `TabCequ` ; `UPDATE` `TabArt.art_cequ` ; **`DELETE Fiches_Art`** | `Maj_CodeBarre`, `Del_CodeBarre`, `Maj_Rpl*`, `Del_Rpl*`, `Del_Codequ`, `MajEqu.Maj` |
| Suppression | `TabArt`, `TabMvtexp`, `TabInv`, `TabInvT`, `TabLigrecpt`, `TabCdBarre`, `TabRpl1`, `TabRpl2`, `TabCequ`, `Docs_Ged`/`Docs_Tag` (via `LGed`) | `art_Suppr` |
| Export serveur | fichiers `Art_Serveur.txt`, `CB_Serveur.txt`, `Rpl*` (`Serveur.Pass`) | 10 appels gardés par `Variables.Sprix And Sexport And SMajArt` |

Les valeurs passent toutes par `&N`, sauf `Button8_Click` (A10) et les filtres `left(...)` de
`ToggleButton1_click`/`ToggleButton3_Click` (A11). Syntaxe MySQL non traduite : `SHOW TABLES`,
`DELETE IGNORE` (A06).

## État global utilisé

- `Start.LocalSettings` : `/Soc<XX>/Materiel`, `/Pvcons`, `/Caisse`, `/Taxe`, `/ipr`, `/Coul_fen`
  (et `/bois`, `/pp` via `Utils.Option`) ; `/Coul/Znaff`, `/Coul/Focus`, `/Coul/Znss`, `/Coul/Btns`.
- `Start.Societe`, `Start.Musique`, `Start.son` (72 tests `If start.son Then Music.Play`).
- `Utils.db` et utilitaires (`cpoint`, `CDec`, `Find_nbdec`, `Find_cbarre`, `Calcode`, `Next_Code`,
  `Remplace`, `Commande`, `convBool`, `Cdate_Aff`, `Cdate_Dbase`, `Observers`, `ObsGotf`, `ObsLstf`,
  `SetEditColor`, `FColr`, `Bip`, `Option`).
- `Variables.Sprix`, `Variables.Sexport`, `Variables.SMajArt` (garde d'export) ; écrites :
  `Variables.OrgCoefTypeCli`, `ArtCode`, `Artintitule`, `ArtTva`, `ArtHt` (lues par `CoefTypeC`).
- Auto-instances de formulaires : `Famille`, `FFournisseur`, `CoefTypeC`, `LGed` (statique).
- Date système : promotion du jour (`Form_Open`), `art_cdate`, `art_ddatefbt` ; aléa : `Calc_barre`.

## Propositions d'amélioration

### Réécriture / refactorisation (ciblée, fichier legacy)

- Supprimer le code mort sûr (`ToggleButton66_Click`, `Dsg1_GotFocus`, `Ec0LF`, `TvaMan`,
  `Tnom_Photo`, `Codart`, branche `mo_code` d'`Update_Req`, branche inatteignable de `Maj_Zones`,
  variables inutilisées) ; **ne pas** supprimer `Stocke_MouseUp2` sans décision sur A15.
- Helpers privés pour les idiomes répétés : `FocusSel(hCtrl)` (137 appels `SetFocus`, presque toujours suivis de `Select`),
  `ErreurSon()` (27 blocs `Catch` « son + `Message.Error(Error.Text & " " & Error.where)` »), `SaisieInvalide()` (21 avertissements « Veuillez verifier votre saisie SVP ! »),
  `ChampNumerique(hTxt, sFormat, …)` pour les validations `*LF` à comportement identique.
- `Maj_Zones` : extraire `ChargeListe(hCombo, sTable, sColonne, sCode)` (4 boucles) et
  `AfficheRemisesQte(r As Result)` (18 lignes, partagée avec `Button10_click`).
- `EnrgArt` : extraire `InsereArticle()`, `MajArticle()` et `MajSatellites()` (bloc dupliqué entre
  création et modification) sans changer l'ordre des requêtes.
- `Maj_ColType` : filtrer `cart` en SQL et joindre `Fiches_Art` (SQL modifié, affichage identique).

### Commonalisation avec d'autres fichiers

- Garde d'export `Variables.Sprix And Variables.Sexport And Variables.SMajArt` (10 occurrences ici,
  44 dans 9 fichiers) → `Serveur.Actif("Art")` proposé par
  [`Serveur`](../../../Serveur.module/architecture.md) (SERVEUR-008).
- Arrondi du PV TTC au 0,05 par chaîne : même code dans [`Movr`](../Movr.class/architecture.md),
  [`Materiel`](../Materiel.class/architecture.md), [`FTvav`](../../../Compta/Tables/FTvav.class/architecture.md),
  [`LPrix`](../../../Utils/LPrix.class/architecture.md) et [`Utils`](../../../Utils/Utils.module/architecture.md) :
  une fonction pure commune `ArrondiPrix(sMontant, sArr, sFormat) As String` qui reproduit
  exactement l'algorithme de chaîne d'`Articles.arrondi` (les variantes divergent, à comparer cas par
  cas avant de fusionner).
- Calculs marge / taux de marque / coefficients (`Calc_Marge`, `Calc_Percent`, `Calc_coeff`,
  `Calc_coeff2`) : homonymes dans [`Materiel`](../Materiel.class/architecture.md) et
  [`MajTarifM`](../../Stock/Tarifs/MajTarifM.class/architecture.md).
- Grille de remises quantitatives `Tbrem` (`ShowTextBox`, `HideTextBox`, `MoveToCol`, `tbrem_Click`,
  `tbxrem_KeyPress`) : identique dans [`Famille`](../Famille.class/architecture.md) ; une classe
  utilitaire `GrilleRemises` pilotant une `TableView` et une `TextBox` passées en paramètres (sans
  toucher aux `.form`).
- Détection de la promotion du jour (`Form_Open`) : même requête dans `Caisse.class:218` et
  `Facture.class:508` → `ArtPromo.PromoDuJour()` (voir [`ArtPromo`](../ArtPromo.module/architecture.md)).
- Liste des tables portant un code article : `art_Suppr` et
  [`Changefam.Modifart`](../../../Utils/Changefam.class/architecture.md) tiennent deux listes
  divergentes (A05) ; une constante commune (table, colonne) servirait aux deux.
- Écrans voisins à forte duplication (fonctions homonymes) : `Materiel` (33), `Movr` (23),
  `MajTarifM` (20), `Famille` (17), `ConsultArt` (14), `FTvav` (10).

### Réduction de portée

Toutes les fonctions listées « portée réductible » par `deps.py` passent en `Private` **sauf** :
`art_Suppr` (appelée par `SupprArt`), `Refresh` (surcharge de la méthode héritée, à confirmer), les
handlers d'événements (y compris `$opt_recalculpx`, `ColTri_*`, `ColTriGenDoc_MajSel`) et les
`<Grille>_Click` appelés par le rejeu (`Composants_Click`, `fourList_Click`, `FamList_Click`,
`ColMarque_Click`). `Bsel`/`Bval` restent `Public` (`TriGen`). `Button1_Click` peut passer `Private`
(pseudo-handler d'un contrôle groupé) mais garde son nom.

### Séparation traitement / GUI

- Extraire des fonctions pures sur des valeurs (Float/String) : `PrixAchatNet(pbht, tr, rem1, rem2,
  rem3)`, `PrixTTC(pvht, txtva)`, `ArrondiPvTTC(sPvttc, sArr, sFormat)`, `Marges(pvht, pmp, paht,
  prvt)`, `TauxMarque(pvht, prvt)`, `CoefDepuisTaux(percent)`, appelées par les fonctions actuelles
  qui gardent la lecture/écriture des contrôles.
- `art_Suppr` : séparer `MotifRefusSuppression(code) As String` (requêtes) et
  `SupprimeArticle(code)` (écritures) de la confirmation et des `Utils.Bip`.
- `EnrgArt` : isoler la construction des paramètres SQL de la lecture des contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Art` porte 6 tranches de remises quantitatives en 18 colonnes (`qte1..12`, `rem1..6`),
  comme `Fiches_Fam` : une table `Fiches_ArtRemQte(code, rang, qte_min, qte_max, remise)` simplifierait
  `Maj_Zones`, `Button10_click` et `EnrgArt`.
- Le code-barre principal est dupliqué entre `Fiches_Art.art_cbarre` et `Fiches_CdBarre`, l'équivalence
  entre `art_cequ` et `Fiches_Cequ`, le remplacement entre `art_crpl1` et `Fiches_Rpl1` : une seule
  source de vérité éviterait des incohérences comme A01/A02.
- Les liens de remplacement sont stockés deux fois (`Fiches_Rpl1` et `Fiches_Rpl2` symétriques).
- Clés étrangères (`ON DELETE CASCADE`) vers `Fiches_Art.art_code` pour les tables satellites
  (codes-barres, équivalences, composants, tarifs) : la suppression ne laisserait plus d'orphelins (A05).
- Montants et quantités en `DECIMAL` homogènes (aujourd'hui formatés côté client avec `nbdec`).
