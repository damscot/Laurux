# FClient — Architecture

> Source : `.src/Gestion/Tables/FClient.class`

## Vue d'ensemble

`FClient` est la **fiche client** de la gestion commerciale : liste des clients (`Colcli`, GridView
virtuelle alimentée par `Utils.Base` / `Utils.rs1`) avec recherche incrémentale par en-tête de
colonne, et fiche détaillée sur un `Tabstrip1` de 9 onglets (+ un 10e « Statistiques » ajouté par
[`gridvi`](../../../Utils/gridvi.class/architecture.md)) :

| Index | Onglet | Contenu, tables |
|---|---|---|
| 0 | Identité | `Fiches_Cli` (+ compte `Fiches_Comptes` type `C`), mails `Mails_Cli`, statut, commercial, tournée, région TIPP (option) |
| 1 | Divers | RIB / IBAN / BIC / RUM SEPA, échéance (`Fiches_Echeances`), remises, frais de gestion, mode de règlement (`Fiches_Reglements`), type client (`Fiches_Typec`), tarifs (`TarTypeCli`) |
| 2 | Ventilations | `Fiches_Cli_Vtl` (comptes de ventilation), libellé d'écriture et tags par défaut (`libel_def`, `tag_def`) |
| 3 | Observations | `cli_obs` |
| 4 | Matériels | `Fiches_Materiels` (si `/Soc<XX>/Materiel`) |
| 5 | Adresse livraison | `Fiches_AdrlivC` |
| 6 | Contacts | `Fiches_ContactC` |
| 7 | Dossiers liés | GED `Docs_Ged` (`TriGen` dans `PanelGedDoc`), copie PDF automatique (case `Copie`) |
| 8 | Abonnement | dernière facture d'abonnement (`Fiches_Bl` type `A`), si `/Soc<XX>/Faca` |

Points d'entrée (tous sur l'**auto-instance**) : `Fmenu.class:565` (`FClient.ShowModal()`),
`Saisecrit.class:1206` et `Tresor.class:928` (création d'un compte client manquant pendant une
saisie comptable), `Facture.class:884` et `Facture.class:4061`. [`Tricp`](../../../../../.src/Affichages/Tricp.class)
écrit directement `FClient.Bsel`, `FClient.Codepostal` et `FClient.Bureaudistributeur` (l. 132-134).

Nature : **GUI** ; tout le SQL (création, mise à jour, suppression, numérotation) est dans les
handlers ou dans des procédures qui lisent les contrôles. Le fichier est le **jumeau** de
[`FFournisseur`](../FFournisseur.class/architecture.md) (voir « Duplication avec FFournisseur »).

Boutons du groupe `Btn` (dispatch par `Tag` dans `Btn_Click`) : 1 `Button7` aide, 2 `Button1` mail,
3 `Button2` créer, 4 `Button3` supprimer, 5 `Button4` enregistrer, 6 `Button5` fermer, 7 `Button12`
étiquettes, 8 `Button13` imprimer les étiquettes, 9 `Button14` fermer le panneau étiquettes. Les
fonctions `ButtonN_Click` correspondantes ne sont **pas** levées par Gambas (contrôles groupés) : ce
sont des pseudo-handlers appelés par `Btn_Click`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `n` | var | Private |  | Integer | 28 |
| `Tri` | var | Private |  | String | 29 |
| `tab` | var | Private |  | String | 30 |
| `sel` | var | Private |  | String | 31 |
| `Clitable` | var | Private |  | New String[8] | 32 |
| `Enr` | var | Private |  | Integer | 33 |
| `son` | var | Private |  | Integer | 34 |
| `sKey` | var | Private |  | String | 35 |
| `Dbl` | var | Private |  | String | 36 |
| `Type` | var | Private |  | String | 37 |
| `CoulZnaf` | var | Private |  | Integer | 38 |
| `CoulFc` | var | Private |  | Integer | 39 |
| `sStatut` | var | Private |  | String | 40 |
| `i2` | var | Private |  | Integer | 41 |
| `txtPosX` | var | Private |  | Integer | 42 |
| `txtPosY` | var | Private |  | Integer | 43 |
| `Filename` | var | Private |  | String | 44 |
| `Nblargeur` | var | Private |  | String | 45 |
| `Nbhauteur` | var | Private |  | String | 46 |
| `Largeur` | var | Private |  | Integer | 47 |
| `Hauteur` | var | Private |  | Integer | 48 |
| `Mrghaut` | var | Private |  | Integer | 49 |
| `Mrgauche` | var | Private |  | Integer | 50 |
| `Esplargeur` | var | Private |  | Integer | 51 |
| `Esphauteur` | var | Private |  | Integer | 52 |
| `Nbetq` | var | Private |  | Integer | 53 |
| `bl` | var | Private |  | Integer | 54 |
| `Nb` | var | Private |  | Boolean | 55 |
| `sSociete` | var | Private |  | String | 56 |
| `sAdr1` | var | Private |  | String | 57 |
| `sAdr2` | var | Private |  | String | 58 |
| `sCP` | var | Private |  | String | 59 |
| `sFetiq` | var | Private |  | String | 60 |
| `Org` | var | Private |  | Boolean | 61 |
| `Fichier` | var | Private |  | String | 62 |
| `hColCli` | var | Private |  | Boolean | 63 |
| `pdf` | var | Private |  | Cetiquettes | 64 |
| `ComboCom` | var | Private |  | Boolean | 65 |
| `Tableau` | var | Private |  | String[] | 66 |
| `Col` | var | Private |  | Collection | 67 |
| `Bsel` | var | Public |  | Boolean | 68 |
| `Bval` | var | Public |  | String | 69 |
| `Codepostal` | var | Public |  | String | 70 |
| `Bureaudistributeur` | var | Public |  | String | 71 |
| `$soption` | var | Private |  | String | 73 |
| `$grdv` | var | Private |  | Gridvi | 74 |
<!-- /AUTO:declarations -->

État d'instance notable :
- `Tri`, `sel`, `Dbl`, `Org`, `ComboCom`, `hColCli` : état de la recherche (colonne de tri, texte
  saisi, ordre inverse, recherche « commence par » pour le CP, mode ville/contact, grille agrandie).
- `Enr` : drapeau **partagé** par `collman`, `Ventilman`, `echman` (résultat du dernier contrôle).
- `bl` : 0 = code postal de la fiche, 1 = code postal de l'adresse de livraison.
- Étiquettes : `pdf`, `Nbetq`, `i2`, `txtPosX/Y`, `Nblargeur`, `Nbhauteur`, `Largeur`, `Hauteur`,
  `Mrghaut`, `Mrgauche`, `Esplargeur`, `Esphauteur`, `sFetiq`, `nb`, `sSociete`, `sAdr1/2`, `sCP`,
  `Filename`.
- `$soption` (`Utils.Option()`, `T`/`B`/`P`) : options consignes (`B`) et produits pétroliers (`P`).
- `$grdv` : onglet statistiques ([`gridvi`](../../../Utils/gridvi.class/architecture.md), type `C`).
- **Inutilisés** : `n` et `CoulFc` (écrits, jamais lus), `Fichier`, `Tableau` (jamais utilisés),
  `tab` (écrit dans `Ref`, mort, toutes les autres occurrences sont des `Dim Tab` locaux),
  `Col` (membre utilisé seulement par `Maj_Dssr`, peut devenir local).
- `Public` : `Bsel`, `Bval` (écrits par `TriCpt`/`TriGen` via `Object.SetProperty(Me, …)` et par
  `Tricp`), `Codepostal`, `Bureaudistributeur` (écrits par `Tricp`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 76-182 | Public | 23 | 100 | 0 | méthode spéciale |
| `Form_Open` | 184-192 | Public | 1 | 7 | 0 | handler GUI |
| `Tabstrip1_Click` | 194-224 | Public | 8 | 28 | 0 | handler GUI |
| `nom_pays` | 226-238 | Public | 3 | 10 | 0 | portée réductible ? |
| `Colcli_Data` | 240-272 | Public | 8 | 30 | 0 | handler GUI |
| `Tris` | 274-288 | Public | 1 | 13 | 0 | portée réductible ? |
| `Deb2` | 290-320 | Public | 18 | 29 | 0 | portée réductible ? |
| `Colcli_contact` | 322-350 | Public | 3 | 26 | 0 | portée réductible ? |
| `Deb3` | 352-367 | Public | 9 | 14 | 0 | portée réductible ? |
| `Maj_Zones` | 369-477 | Public | 42 | 105 | 0 | portée réductible ? |
| `Aff_Mat` | 479-494 | Public | 3 | 13 | 0 | portée réductible ? |
| `ChiffreA` | 496-517 | Public | 4 | 19 | 0 | portée réductible ? |
| `Button10_Click` | 519-536 | Public | 4 | 15 | 0 | handler GUI |
| `button11_Click` | 538-551 | Public | 3 | 11 | 0 | handler GUI |
| `Button17_Click` | 553-563 | Public | 2 | 8 | 0 | handler GUI |
| `Maj_vtl` | 565-570 | Public | 1 | 4 | 0 | portée réductible ? |
| `CleanVtl` | 572-577 | Public | 1 | 4 | 0 | portée réductible ? |
| `Refresh` | 579-584 | Public | 1 | 4 | 0 | portée réductible ? |
| `CleanChamps` | 586-659 | Public | 1 | 70 | 0 | portée réductible ? |
| `Email_KeyPress` | 661-686 | Public | 7 | 22 | 0 | handler GUI |
| `Email_LostFocus` | 688-692 | Public | 1 | 3 | 0 | handler GUI |
| `Maj_Email` | 694-711 | Public | 5 | 15 | 0 | portée réductible ? |
| `Colcli_KeyPress` | 713-717 | Public | 3 | 3 | 0 | handler GUI |
| `RdimColcli` | 719-731 | Public | 2 | 11 | 0 | portée réductible ? |
| `colcli_Click` | 733-761 | Public | 3 | 25 | 0 | handler GUI |
| `Aff_Statut` | 763-777 | Public | 5 | 12 | 0 | portée réductible ? |
| `Cmpt_GotFocus` | 779-783 | Public | 2 | 3 | 0 | handler GUI |
| `Cmpt_LostFocus` | 785-826 | Public | 14 | 38 | 0 | handler GUI |
| `Cmpt_KeyPress` | 828-982 | Public | 36 | 131 | 0 | handler GUI |
| `Cnt_GotFocus` | 984-990 | Public | 1 | 5 | 0 | handler GUI |
| `Cnt_KeyPress` | 992-1038 | Public | 11 | 38 | 0 | handler GUI |
| `Cbl_GotFocus` | 1043-1049 | Public | 1 | 5 | 0 | handler GUI |
| `Cbl_KeyPress` | 1051-1099 | Public | 11 | 39 | 0 | handler GUI |
| `Cmpt2_KeyPress` | 1101-1205 | Public | 23 | 84 | 0 | handler GUI |
| `Cmpt2_GotFocus` | 1210-1216 | Public | 1 | 5 | 0 | handler GUI |
| `Cmpt3_KeyPress` | 1218-1248 | Public | 9 | 24 | 0 | handler GUI |
| `Vnt_Click` | 1250-1259 | Public | 2 | 8 | 0 | handler GUI |
| `Vnt_KeyPress` | 1261-1278 | Public | 6 | 15 | 0 | handler GUI |
| `Cmpt3_GotFocus` | 1283-1289 | Public | 1 | 5 | 0 | handler GUI |
| `C1_GotFocus` | 1291-1296 | Public | 2 | 4 | 0 | handler GUI |
| `C1_LostFocus` | 1298-1302 | Public | 2 | 3 | 0 | handler GUI |
| `N1_GotFocus` | 1304-1309 | Public | 2 | 4 | 0 | handler GUI |
| `N1_LostFocus` | 1311-1315 | Public | 2 | 3 | 0 | handler GUI |
| `A1_GotFocus` | 1317-1322 | Public | 2 | 4 | 0 | handler GUI |
| `A1_LostFocus` | 1324-1328 | Public | 2 | 3 | 0 | handler GUI |
| `cp1_GotFocus` | 1330-1335 | Public | 2 | 4 | 0 | handler GUI |
| `cp1_LostFocus` | 1337-1341 | Public | 2 | 3 | 0 | handler GUI |
| `V1_GotFocus` | 1343-1348 | Public | 2 | 4 | 0 | handler GUI |
| `V1_LostFocus` | 1350-1354 | Public | 2 | 3 | 0 | handler GUI |
| `Btn_Click` | 1356-1392 | Public | 11 | 24 | 0 | handler GUI |
| `Remmo_LF` | 1394-1406 | Public | 2 | 11 | 0 | portée réductible ? |
| `Remart_LF` | 1408-1420 | Public | 2 | 11 | 0 | portée réductible ? |
| `Button4_Click` | 1422-1502 | Public | 18 | 77 | 0 | portée réductible ? |
| `majchamp` | 1504-1603 | Private | 10 | 94 | 0 |  |
| `Button3_Click` | 1605-1673 | Public | 12 | 65 | 0 | portée réductible ? |
| `Button2_Click` | 1675-1737 | Public | 15 | 57 | 0 | portée réductible ? |
| `GenRum` | 1739-1744 | Public | 2 | 4 | 0 | portée réductible ? |
| `Ventilations` | 1746-1784 | Public | 5 | 35 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 1786-1799 | Public | 2 | 10 | 0 | handler GUI |
| `ToggleButton2_Click` | 1801-1838 | Public | 4 | 28 | 0 | handler GUI |
| `Colcompt2_Click` | 1840-1846 | Public | 1 | 5 | 0 | handler GUI |
| `Colcompt2_KeyPress` | 1851-1872 | Public | 6 | 18 | 0 | handler GUI |
| `Button6_Click` | 1874-1911 | Public | 8 | 33 | 0 | portée réductible ? |
| `ToggleButton4_Click` | 1915-1946 | Public | 4 | 29 | 0 | handler GUI |
| `Typec_KeyPress` | 1948-1957 | Public | 2 | 8 | 0 | handler GUI |
| `Coltype_Click` | 1959-1965 | Public | 1 | 5 | 0 | handler GUI |
| `Recup_Typec` | 1967-1976 | Public | 2 | 7 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 1979-2009 | Public | 4 | 28 | 0 | handler GUI |
| `Colech_Click` | 2011-2019 | Public | 1 | 7 | 0 | handler GUI |
| `Colech_KeyPress` | 2024-2045 | Public | 6 | 18 | 0 | handler GUI |
| `echman` | 2050-2068 | Public | 3 | 16 | 0 | portée réductible ? |
| `Cmpt3_Click` | 2070-2074 | Public | 1 | 3 | 0 | handler GUI |
| `Vents_Keypress` | 2076-2083 | Public | 2 | 6 | 0 | handler GUI |
| `Vents_Activate` | 2085-2101 | Public | 3 | 14 | 0 | handler GUI |
| `Dbclk` | 2103-2113 | Public | 2 | 9 | 0 | portée réductible ? |
| `Titre` | 2115-2123 | Public | 2 | 7 | 0 | portée réductible ? |
| `C1_Click` | 2125-2135 | Public | 1 | 9 | 0 | handler GUI |
| `C1_Dblclick` | 2137-2141 | Public | 1 | 3 | 0 | handler GUI |
| `N1_Click` | 2143-2153 | Public | 1 | 9 | 0 | handler GUI |
| `N1_Dblclick` | 2155-2159 | Public | 1 | 3 | 0 | handler GUI |
| `A1_Click` | 2161-2171 | Public | 1 | 9 | 0 | handler GUI |
| `A1_Dblclick` | 2173-2177 | Public | 1 | 3 | 0 | handler GUI |
| `Cp1_Click` | 2179-2189 | Public | 1 | 9 | 0 | handler GUI |
| `Cp1_Dblclick` | 2191-2195 | Public | 1 | 3 | 0 | handler GUI |
| `V1_Clk` | 2197-2211 | Public | 2 | 13 | 0 | portée réductible ? |
| `V1_Dblclick` | 2213-2217 | Public | 1 | 3 | 0 | handler GUI |
| `Ref` | 2219-2227 | Public | 1 | 6 | 0 | portée réductible ? |
| `C1_KeyPress` | 2229-2242 | Public | 6 | 12 | 0 | handler GUI |
| `N1_KeyPress` | 2244-2257 | Public | 6 | 12 | 0 | handler GUI |
| `A1_KeyPress` | 2259-2272 | Public | 6 | 12 | 0 | handler GUI |
| `Cp1_KeyPress` | 2274-2289 | Public | 6 | 14 | 0 | handler GUI |
| `V1_KeyPress` | 2291-2304 | Public | 6 | 12 | 0 | handler GUI |
| `collman` | 2306-2336 | Public | 10 | 28 | 0 | portée réductible ? |
| `Ventilman` | 2338-2366 | Public | 6 | 26 | 0 | portée réductible ? |
| `Button1_Click` | 2368-2381 | Public | 2 | 11 | 0 | portée réductible ? |
| `Envoi` | 2383-2396 | Public | 6 | 11 | 0 | portée réductible ? |
| `Button19_Click` | 2398-2419 | Public | 3 | 19 | 0 | handler GUI |
| `Button12_Click` | 2422-2427 | Public | 2 | 4 | 0 | portée réductible ? |
| `init_ComboBox` | 2429-2445 | Public | 5 | 14 | 0 | portée réductible ? |
| `Button13_Click` | 2447-2515 | Public | 11 | 66 | 0 | portée réductible ? |
| `Imprime` | 2517-2534 | Public | 3 | 15 | 0 | portée réductible ? |
| `ImprimeC` | 2536-2562 | Public | 3 | 24 | 0 | portée réductible ? |
| `fin_impression` | 2564-2570 | Public | 1 | 5 | 0 | portée réductible ? |
| `pos_Etiq` | 2572-2601 | Public | 6 | 28 | 0 | portée réductible ? |
| `pos_EtiqC` | 2603-2634 | Public | 8 | 30 | 0 | portée réductible ? |
| `Cpman` | 2637-2651 | Public | 2 | 12 | 0 | portée réductible ? |
| `aff_cp` | 2653-2692 | Public | 8 | 37 | 0 | portée réductible ? |
| `Colcp_Click` | 2694-2713 | Public | 2 | 18 | 0 | handler GUI |
| `Colcp_KeyPress` | 2719-2745 | Public | 7 | 23 | 0 | handler GUI |
| `ChkCp` | 2747-2755 | Public | 7 | 7 | 0 | portée réductible ? |
| `Cpman2` | 2758-2777 | Public | 3 | 17 | 0 | portée réductible ? |
| `Cpman3` | 2779-2798 | Public | 3 | 17 | 0 | portée réductible ? |
| `ToggleButton5_Click` | 2800-2814 | Public | 2 | 12 | 0 | handler GUI |
| `ToggleButton6_Click` | 2816-2830 | Public | 2 | 12 | 0 | handler GUI |
| `Button15_Click` | 2835-2856 | Public | 7 | 19 | 0 | handler GUI |
| `Aff_AdrC` | 2858-2884 | Public | 5 | 24 | 0 | portée réductible ? |
| `Colal_Click` | 2886-2907 | Public | 4 | 19 | 0 | handler GUI |
| `Colal_KeyPress` | 2909-2920 | Public | 4 | 10 | 0 | handler GUI |
| `CleanChampsAdr` | 2922-2936 | Public | 3 | 14 | 0 | portée réductible ? |
| `Button16_Click` | 2939-2959 | Public | 11 | 18 | 0 | handler GUI |
| `Aff_Ct` | 2961-2983 | Public | 4 | 20 | 0 | portée réductible ? |
| `Colal2_Click` | 2985-3001 | Public | 2 | 14 | 0 | handler GUI |
| `Colal2_KeyPress` | 3003-3015 | Public | 7 | 11 | 0 | handler GUI |
| `CleanChampsCt` | 3017-3027 | Public | 1 | 9 | 0 | portée réductible ? |
| `Maj_Dssr` | 3032-3082 | Public | 5 | 44 | 0 | portée réductible ? |
| `PanelGedDoc_MajSel` | 3084-3094 | Public | 2 | 8 | 0 | handler GUI |
| `FileFilter` | 3098-3105 | Private | 1 | 5 | 0 |  |
| `Button7_Click` | 3107-3111 | Public | 1 | 3 | 0 | portée réductible ? |
| `Inactif2_Click` | 3113-3120 | Public | 1 | 6 | 0 | handler GUI |
| `Statut2_Click` | 3122-3129 | Public | 1 | 6 | 0 | handler GUI |
| `Button9_Click` | 3131-3161 | Public | 4 | 28 | 0 | handler GUI |
| `Docs_Click` | 3163-3167 | Public | 1 | 3 | 0 | handler GUI |
| `Tous_Click` | 3169-3173 | Public | 1 | 3 | 0 | handler GUI |
| `Facs_Click` | 3175-3179 | Public | 1 | 3 | 0 | handler GUI |
| `FacsCompta_Click` | 3181-3185 | Public | 1 | 3 | 0 | handler GUI |
| `BonLivraison_Click` | 3187-3191 | Public | 1 | 3 | 0 | handler GUI |
| `Comman_Click` | 3193-3197 | Public | 1 | 3 | 0 | handler GUI |
| `Devis_Click` | 3199-3203 | Public | 1 | 3 | 0 | handler GUI |
| `Button20_Click` | 3205-3247 | Public | 3 | 40 | 0 | handler GUI |
| `Button21_Click` | 3249-3257 | Public | 1 | 6 | 0 | handler GUI |
| `Button22_Click` | 3259-3266 | Public | 1 | 5 | 0 | handler GUI |
| `Button23_Click` | 3268-3276 | Public | 1 | 6 | 0 | handler GUI |
| `Buttr1_Click` | 3280-3286 | Public | 1 | 5 | 0 | handler GUI |
| `Buttr1_trouve` | 3288-3292 | Public | 1 | 3 | 0 | handler GUI |
| `Butto1_Click` | 3295-3302 | Public | 1 | 5 | 0 | handler GUI |
| `butto1_trouve` | 3304-3308 | Public | 1 | 3 | 0 | handler GUI |
| `Cmpt2_LostFocus` | 3311-3324 | Public | 4 | 13 | 0 | handler GUI |
| `Buttr2_Click` | 3328-3334 | Public | 1 | 5 | 0 | handler GUI |
| `Buttr2_trouve` | 3336-3340 | Public | 1 | 3 | 0 | handler GUI |
| `Butto2_Click` | 3343-3350 | Public | 1 | 5 | 0 | handler GUI |
| `butto2_trouve` | 3352-3356 | Public | 1 | 3 | 0 | handler GUI |
| `Button24_Click` | 3359-3368 | Public | 2 | 7 | 0 | handler GUI |
| `RechTag_Click` | 3370-3398 | Public | 3 | 22 | 0 | handler GUI |
| `LibelDef_LostFocus` | 3400-3407 | Public | 2 | 5 | 0 | handler GUI |
| `Update_ListTags` | 3409-3424 | Public | 2 | 11 | 0 | portée réductible ? |
| `ListTags_Add` | 3427-3437 | Public | 2 | 8 | 0 | handler GUI |
| `ListTags_LostFocus` | 3439-3443 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

Étiquettes : [portée : nécessaire | réductible] [nature : calcul | GUI | mixte]. « pseudo-handler »
désigne une fonction nommée `Contrôle_Événement` qui n'est pas levée par Gambas (contrôle groupé ou
événement inexistant) mais appelée dans le fichier ; son nom est conservé.

### Initialisation et onglets

- **`_New()`** [nécessaire] [mixte] : son, centrage, masque les onglets Matériels (`/Materiel` = 0)
  et Abonnement (`/Faca` = 0), le bouton SMS (`/Sms` = 0) ; couleurs `/Coul/Znaff` et `/Coul/Focus` ;
  `Utils.Observers(Me)` ; libellés d'en-tête ; `nom_pays` ; civilités (`Utils.Fill_Civilite`) ;
  listes `Statut`/`Statut2` (`<TabStatut>`), `Comm` (`<TabCommerciaux>`), `Mreg`
  (`Fiches_Reglements` **en dur**) ; colonnes de `Colmat`, `Colal`, `Colal2` ; pays par défaut ;
  zone Sage (`/Sage`) ; onglet statistiques `New Gridvi(Tabstrip1, "C")` ; options `B`/`P`/`T`.
  Les boucles `Do … Loop Until MoveNext()` sont sous `Try` (aucun message si la table manque).
- **`Form_Open()`** [handler] : tri par code, `Tris`, `Deb2`, focus sur le nom. ⚠️ Aussi levé par la
  fenêtre créée dans `Button20_Click` (`New Form As "Form"`), voir anomalie A11.
- **`Tabstrip1_Click()`** [handler] : `Utils.Observers(Me)` à chaque changement d'onglet, focus ;
  onglet 8 : `SELECT * FROM <TabBl> where cdclibl = &1 and type = 'A' and not isnull(numfac)` **sans
  `ORDER BY`** : la « dernière facture » affichée est une ligne quelconque (A12).
- **`nom_pays()`** [réductible] [GUI] : remplit `Pays` depuis le fichier `Pays.txt` du **répertoire
  courant** (pas de `Close`, erreur non gérée si absent). Copie identique dans FFournisseur.

### Liste et recherche

- **`Colcli_Data(Row, Column)`** [handler] : `Utils.rs1.MoveTo(Row)`, couleur alternée
  (`/Coul_fen`), texte de la colonne `Clitable[Column]` (tableau rempli à chaque appel). Le test
  `Column = 8` est inaccessible (8 colonnes, index 0-7).
- **`Tris()`** [réductible] [GUI] : 8 colonnes calées sur les largeurs des zones d'en-tête.
- **`Deb2()`** (CC 18) [réductible] [mixte] : `Utils.Base(colcli, "select … from <TabCli> where
  <Tri> like "%sel%" and cli_actif = <Inactif2.value> [and cli_statut like "%<statut>%"] order by
  <Tri>")`. Les branches `hColcli` vrai et faux sont **identiques** octet pour octet (8 appels pour 4
  requêtes distinctes). `Org` (saisie dans l'en-tête CP) remplace `like "%x%"` par `like "x%"`.
  `cli_actif` est comparé à la valeur de la case (`-1`/`0`, entier Gambas). SQL **concaténé** :
  une saisie contenant `"` provoque une erreur SQL (A14). Si `Tri = "nom"` : `Colcli_contact`.
- **`Deb3()`** [réductible] : même chose en ordre décroissant (sans le cas `Org`).
- **`Colcli_contact()`** [réductible] [mixte] : recherche par **nom de contact** : table temporaire
  `Contact` (CREATE TEMPORARY, `Utils.db.AutoIncrement`/`Engine`), une ligne par contact
  (`<TabContact> where nom like "%sel%"`, concaténé) recopiant la fiche client, puis `Utils.Base`
  et `drop TABLE Contact`. ⚠️ Le `drop Table IF exists` initial porte sur le littéral `BlTab` et non
  sur `Contact` ; le client du contact n'est pas testé (`rLib2.Available`), un contact orphelin
  provoque une erreur et laisse la table temporaire (A13).
- **`Dbclk()`** [réductible] : bascule `Deb3`/`Deb2` (`Dbl`).
- **`Titre()`** [réductible] [GUI] : réinitialise les libellés d'en-tête (sauf `V1` si `ComboCom`).
- **`C1_Click`, `N1_Click`, `A1_Click`, `Cp1_Click`** [pseudo-handlers : `TextBox` n'a pas
  d'événement `Click`, appelés par les `*_GotFocus`] : vide `sel`, `Titre`, tri sur `cli_code`,
  `cli_nom`, `cli_adr1`, `cli_cd_ptl`, `Deb2`.
- **`V1_Clk()`** [réductible] : `V1` est une `ComboBox` (« Ville » / « Contact ») ; le nom évite
  l'événement `Click` de la ComboBox. Tri `cli_ville` si le texte vaut « Ville », sinon `nom`
  (recherche par contact), puis vide le texte. Comportement de bascule peu intuitif (à confirmer
  en replay).
- **`C1_Dblclick`, `N1_Dblclick`, `A1_Dblclick`, `Cp1_Dblclick`, `V1_Dblclick`** [handlers] : `Dbclk`.
- **`C1_KeyPress`, `N1_KeyPress`, `A1_KeyPress`, `Cp1_KeyPress`, `V1_KeyPress`** [handlers] : hors
  Entrée, ajoute `Key.Text` à `sel` (ou retire un caractère), `Deb2` (`Cp1` avec `Org = True`) ;
  F2/Échap : `RdimColcli`. Cinq copies du même corps.
- **`C1_GotFocus` … `V1_GotFocus`, `C1_LostFocus` … `V1_LostFocus`** [handlers] :
  `Utils.ObsGotf`/`ObsLstf` (sous `Try`), puis le clic correspondant.
- **`Colcli_KeyPress()`** [handler] : Échap/F2 → `RdimColcli`.
- **`RdimColcli()`** [réductible] [GUI] : agrandit / réduit la grille (`hColcli`) puis `Deb2`.
- **`colcli_Click()`** [handler, **appelé par le rejeu** (`replay_dynamic`)] : `CleanChamps`,
  `CleanChampsCt`, `Maj_Zones`, `Ventilations`, libellés, `Aff_Mat` (si matériel), `Aff_AdrC`,
  `Aff_Ct`, `Maj_Dssr("")`, statistiques (`$grdv.code`, `razcol`).
- **`Inactif2_Click()` / `Statut2_Click()`** [handlers] : filtres inactifs / statut, `Deb2`.
- **`Ref()`** [réductible, **code mort**] : jamais appelée (le `Deb2` est commenté).

### Fiche : lecture, vidage

- **`Maj_Zones()`** (CC 42, max du fichier) [réductible] [mixte] : `select * from <TabCli> Left join
  Fiches_Comptes on compte_cc = cli_code where cli_code = &1` sur la ligne `colcli.row` ; **aucun
  test `Available`** (A15) ; remplit ~55 zones (plusieurs sous `Try`) ; `Lettrable` : le test
  `IsNull(Lettrable.value)` porte sur la case et non sur la donnée (toujours faux) ; mode de
  regroupement `S/D/M/Q` ; mode de règlement recherché dans `Mreg` ; `Recup_Typec`, `Aff_Statut` ;
  `TextBox2` = `hexdblKey.Crypt(...)` du code ; commercial (`<TabCommerciaux>`) ; liste `Email`
  (`<TabMailCli>`). `Randomize` initial sans usage. Partie extractible : `LitClient(sCode) As Result`.
- **`CleanChamps()`** [réductible] [GUI] : remet à blanc ~70 contrôles (`Checkcons.Value = True`
  deux fois ; `Copie` = case « copie automatique des documents », pas le module `Copie`).
- **`Aff_Statut(sStatut)`** [réductible] [mixte] : libellé du statut (`<TabStatut>`).
- **`Recup_Typec(Type)`** [réductible] [mixte] : libellé du type client (`Fiches_Typec` en dur).
- **`Aff_Mat()`** [réductible] [mixte] : matériels du client (`<TabMat>`).
- **`ChiffreA()`** [réductible] [mixte] : F6 sur civilité/nom/prénom : somme de `totfacttc` de
  `Fiches_HistoFac` ∪ `Fiches_HistoFacM` (en dur) entre aujourd'hui moins **4 ans** et aujourd'hui,
  affichée comme « CA sur 12 mois » (A09). Dépend de `Now` (test à horloge fixée).
- **`Maj_vtl()`** [réductible, **code mort**] ; **`CleanVtl()`** [réductible] : zones de ventilation.
- **`Refresh()`** [réductible] : vide `Vents` et rappelle `Form_Open` (recharge la liste).

### Saisie (navigation clavier)

- **`Cmpt_KeyPress()`** (CC 36) [handler, groupe `Cmpt`] : Entrée/Tab enchaîne les zones par `Tag`
  avec `Utils.Remplace` (nettoyage des saisies) ; tag 2 (nom) refuse la saisie sans code
  (« cliquer sur Créer ») ; tag 6 (CP) → `Cpman3` ; tag 16 (collectif) → `collman`. F1 aide ;
  F2 : tag 2 `RdimColcli`, tag 6 `ToggleButton5_Click` (`Tricp`), tag 10 `ToggleButton3_Click`
  (**liste des échéances** sur `Teldom`/`Statut`, tags 10 : A16), tag 16 `ToggleButton2_Click`
  (collectifs) ; F6 : `ChiffreA`. Le `Case 8` (`Email`) est **inaccessible** : `Email` n'est pas
  dans le groupe `Cmpt` et aucun contrôle du groupe n'a le tag 8.
- **`Cmpt_LostFocus()`** [handler] : `ObsLstf` ; tag 16 `collman` (si `Enr = 0` : vide et refocalise) ;
  tag 17 région TIPP (`Fiches_region` en dur, table d'option créée par `modfichier`) ; tag 18 tournée
  (`Fiches_tourne` en dur) : code inconnu → bulle, vidage. `Case 8` inaccessible.
- **`Cmpt_GotFocus()`** [handler] : `Utils.ObsGotf`.
- **`Cmpt2_KeyPress()`** (CC 23) [handler] : navigation onglet Divers ; tag 12 (`Cdech`) → `echman` ;
  F9 sur tag 15 (`Rum`) → `GenRum`. **`Cmpt2_GotFocus`** [handler] : `Utils.SetEditColor`.
- **`Cmpt2_LostFocus()`** [handler] : `Textfrais` normalisé en `0.00` (virgule → point).
- **`Cnt_KeyPress` / `Cnt_GotFocus`** [handlers, contacts], **`Cbl_KeyPress` / `Cbl_GotFocus`**
  [handlers, adresse de livraison ; tag 6 → `Cpman2`].
- **`Cmpt3_KeyPress` / `Cmpt3_GotFocus`** [handlers, ventilation] : tag 1 `Ventilman`, tag 2
  `Button6_Click` (aucun contrôle de tag 2), F2 `ToggleButton1_Click`.
- **`Cmpt3_Click()`** [**code mort**] : le groupe `Cmpt3` ne contient que la `TextBox` `Compt`, qui
  n'a pas d'événement `Click`.
- **`Remmo_LF()` / `Remart_LF()`** [**code mort**, signalés `handlers_inactifs` par `deps.py`] :
  `Remmo`/`Remart` sont dans le groupe `Cmpt2` et `_LF` n'est pas un événement Gambas ; aucun appel.
  Leur corps (`Val(x) = Null`, format `00.00`) diffère de la mise en forme réelle des remises.

### Création, enregistrement, suppression

- **`Button2_Click()`** [pseudo-handler, Btn 3] [mixte] — **créer** : `CleanChamps` ;
  `LOCK TABLES Fiches_Parametres WRITE, Fiches_Cli READ` (ignoré sous SQLite) ; lit `dnc` (dernier
  numéro client) ; refuse si nul ou < 411000 (**sans `UNLOCK`**, A05) ; incrément : 411999 →
  4111000, 4119999 → 41110000, sinon +1 et, si le code existe, `max(cli_code) + 1` ; frais par
  défaut (`frais`) ; `GenRum` ; `UPDATE Fiches_Parametres set dnc = '411…'` ; `UNLOCK TABLES` ;
  collectif par défaut = premier compte `coll = '1'` commençant par `41` ; exemplaires, pays,
  échéance, type, copie PDF depuis `/Soc<XX>/…`. Partie extractible pure :
  `ProchainCode(sDernier, sRacine) As String` (commune avec FFournisseur).
- **`GenRum()`** [réductible] : RUM SEPA = `hexdblKey.Crypt("en", Rnd(10,99) & code & Rnd(10,99),
  "LauruX")` : **non déterministe** (à exclure du dump comparé).
- **`Button4_Click()`** (CC 18) [pseudo-handler, Btn 5] [mixte] — **enregistrer** : nettoie les
  zones ; refuse sans nom, collectif ou code ; `collman` ; si `enr = "1"` : `Utils.db.Begin`, puis
  création (`Create9("Fiches_Cli")`) si le bouton affiche « Va&lider », sinon `Edit("Fiches_Cli",
  "cli_code=&1")` ; `majchamp` (qui fait le `Commit`) ; export serveur
  (`Serveur.Pass("Cli", "C"|"M", …)` si `Sprix And Sexport And SMajCli`) ; `Enrgcp.Ecp` (mémorise
  le CP) ; **enregistre aussi l'adresse de livraison et le contact en cours** (`Button15_Click`,
  `Button16_Click`) ; rafraîchit et resélectionne. ⚠️ Si `Edit` ne renvoie rien, la transaction
  reste ouverte ; le `Catch` ne fait pas de `Rollback` (A06).
- **`majchamp(res)`** [Private] [mixte] : recopie ~50 zones dans le `Result` modifiable (booléens
  sous forme de valeur de case `-1`/`0`), `cli_typec` et `cli_reg` écrits deux fois (la seconde
  écriture de `cli_reg` dépend d'un `SELECT` sur `Fiches_Reglements`) ; options `B`/`P`/`T` ;
  `res.Update` ; puis `Fiches_Comptes` (`Edit` ou `Create9`) : intitulé, `type_cc = 'C'`, `coll =
  0`, `coll_cc`, `lettrable` ; `Utils.db.Commit`.
- **`Button3_Click()`** (CC 12) [pseudo-handler, Btn 4] [mixte] — **supprimer** : confirmation ;
  refus si une écriture existe dans `Fiches_Mvt` (seulement, pas `Mvt1-5`/`MvtM*`) ou un document
  dans `Fiches_Bl` ; sinon `DELETE` de `Fiches_Cli`, `Fiches_Comptes`, `Fiches_Cli_Vtl`, puis
  `DELETE FROM <TabCdocs>` : la clé n'existe pas dans `Cbase` (CBASE-A01), la requête devient
  `DELETE FROM  WHERE code = …`, `DB_Connection.Exec` propage l'erreur et le `Catch` affiche un
  message : `Corsage` n'est pas nettoyé, la liste n'est ni rafraîchie ni vidée (A04). Les mails,
  adresses de livraison, contacts et documents GED du client restent orphelins. Pas d'export
  serveur de la suppression (commentaire : suppression manuelle côté client).
- **`collman()`** [réductible] [mixte] : collectif saisi : existe dans `Fiches_Comptes`, `coll`
  vrai, commence par `41` ou `453`. ⚠️ Si `coll` est faux, `Enr` passe à 0 puis le `Else` du test
  suivant le **remet à 1** : tout compte existant non collectif est accepté (A01). `Catch` vide.
  Résultat dans `Enr`.

### Listes de choix et contrôles

- **`ToggleButton2_Click()`** [handler] : liste `Colcompt2` des collectifs `41…` (`Fiches_Comptes`).
  **`Colcompt2_Click`** [handler, rejeu] / **`Colcompt2_KeyPress`** [handler] : choix / Échap.
- **`ToggleButton3_Click()`** [handler] : liste `Colech` des échéances (`Fiches_Echeances`) ;
  **`Colech_Click`** [handler, rejeu] / **`Colech_KeyPress`** [handler].
- **`echman()`** [réductible] [mixte] : code échéance existant ; `Enr` ; message sinon.
- **`ToggleButton4_Click()`** / **`Typec_KeyPress()`** (F2) [handlers] : liste `Coltype` des types
  clients ; **`Coltype_Click`** [handler, rejeu] → `Recup_Typec`.
- **`Buttr1_Click`/`Buttr2_Click`** [handlers] : `New Rechtipp("N") As "Buttr1"|"Buttr2"` (région
  TIPP) ; **`Buttr1_trouve`/`Buttr2_trouve`** [handlers de l'événement `trouve`] → `Texttr1`/`Texttr2`.
- **`Butto1_Click`/`Butto2_Click`** [handlers] : `New Rechtour As "Butto1"|"Butto2"` ;
  **`butto1_trouve`/`butto2_trouve`** [handlers] → `Textto1`/`Textto2`.

### Code postal

- **`Cpman3()`** [réductible] [mixte] : CP de la fiche : `<TabCpostaux> where cp = &1` ; 1 ligne →
  ville ; plusieurs → `aff_cp` ; aucune → ville vidée. **`Cpman2()`** : idem pour l'adresse de
  livraison (`Cp2`/`Burdist2`). Copies l'une de l'autre.
- **`aff_cp()`** [réductible] [mixte] : liste `Colcp` positionnée selon `bl` ; `cp like '<cp>%'`
  **concaténé**. **`Colcp_Click`** [handler, rejeu] / **`Colcp_KeyPress`** [handler].
- **`ToggleButton5_Click()` / `ToggleButton6_Click()`** [handlers] : `New Tricp("Client", "")` modal
  puis lecture de `Bsel`, `Codepostal`, `Bureaudistributeur`. `Bsel` n'est **jamais remis à faux** :
  après une première sélection, une annulation recopie l'ancienne valeur (A10). `ToggleButton6`
  annulé refocalise `Cp` au lieu de `Cp2`.
- **`Cpman()`** [**code mort**] (variante `Tricp` avec le CP saisi) ; **`ChkCp()`** [**code mort**].

### Ventilations, libellé et tags par défaut

- **`Ventilations()`** [réductible] [mixte] : `libel_def`, `tag_def` (`WHERE cli_code = <code>`
  **concaténé**, sous `Object.Lock`) ; liste `Vents` de `Fiches_Cli_Vtl` (`WHERE code = '<code>'`
  concaténé).
- **`ToggleButton1_Click()`** [handler] : `New TriCpt("G", TriCpt.Sans_Solde, Me)` modal ; `Bsel`/`Bval`
  (même défaut de remise à zéro que A10).
- **`Ventilman()`** [réductible] [mixte] : compte de ventilation existant, ni `C`/`F` ni collectif.
- **`Button6_Click()`** [pseudo-handler : `Button6` est dans le groupe `Vnt`] [mixte] : refus sans
  nom/collectif ou sans compte ; `Ventilman` ; UPDATE (sans effet : mêmes valeurs) ou INSERT
  `Fiches_Cli_Vtl` ; recharge.
- **`Vnt_Click` / `Vnt_KeyPress`** [handlers, groupe `Vnt`] : `Button6_Click`.
- **`Vents_Keypress()`** [handler] : Suppr → `Vents_Activate` ; **`Vents_Activate()`** [handler,
  double-clic] : confirmation puis `DELETE` de la ventilation, `Refresh` (recharge aussi la liste
  des clients).
- **`LibelDef_LostFocus()`** [handler] : `UPDATE <TabCli> SET libel_def` (255 caractères).
- **`RechTag_Click()`** [handler] : `TriGen` modal sur `Fiches_Tag` (en dur), ajoute le tag choisi.
- **`Update_ListTags()`** [réductible] [mixte] : normalise la liste par `LGed.Array2String` /
  `String2Array` puis `UPDATE <TabCli> SET tag_def`.
- **`ListTags_Add()`** [**handler** de l'événement `Add` du `ListEditor` (gb.form) ; signalé à tort
  `unused` par `deps.py`] : ajoute le texte de l'éditeur puis `Update_ListTags`. Ajout possiblement
  en double avec l'ajout natif du contrôle (à confirmer en replay). **`ListTags_LostFocus`** [handler].

### Mails, contacts, adresses de livraison

- **`Maj_Email()`** [réductible] [mixte] : `INSERT` dans `<TabMailCli>` (sous `Try` : doublon
  ignoré), recharge la liste. Contrairement à FFournisseur, ne met pas à jour `cli_email` (fait par
  `majchamp`). Appelée aussi sur une fiche non encore enregistrée (mail orphelin si abandon).
- **`Email_KeyPress()`** [handler] : Entrée → `Maj_Email` ; Suppr → `DELETE` du mail, recharge, puis
  `UPDATE cli_email` avec le texte courant : quand le dernier mail est supprimé, la liste n'est pas
  vidée et `cli_email` reçoit l'adresse supprimée (A08). **`Email_LostFocus`** [handler] : `Maj_Email`.
- **`Button1_Click()`** [pseudo-handler, Btn 2] : `New Commail("F")` (texte prédéfini, l'argument
  ne sert qu'à afficher « Choisir »), puis `Envoi`.
- **`Envoi()`** [réductible] : `EnvMail.Envoi2` vers `Email` (onglet 0) ou `Mail2` (onglet 6),
  entête/corps `/Soc<XX>/Tmail2`, `/Tmail` ou `Variables.stexte`.
- **`Button19_Click()`** [handler] — SMS : `New Gsm(<portable>)` ; onglet 0 → `Portable` ; **onglet 4
  (Matériels)** → `Portable2` (contact, onglet 6) : le SMS à un contact est impossible (A03). La
  branche `Btn` tag 10 qui l'appelle est inaccessible (aucun bouton `Btn` de tag 10).
- **`Button16_Click()`** [handler] — contact : UPDATE si `(code, num)` existe, sinon INSERT avec
  `num = max(num) + 1` **global** (`… VALUE (…)` : syntaxe refusée par SQLite, A07) ; export serveur
  `ContactC` `M`/`C`. **`Aff_Ct()`** [réductible] : liste `Colal2` ; ⚠️ écrit `Numero` (numéro de
  l'**adresse de livraison**) au lieu de `Numero2` (A02). **`Colal2_Click`** [handler, rejeu],
  **`Colal2_KeyPress`** [handler] (Suppr + export `S`), **`CleanChampsCt()`** [réductible].
- **`Button15_Click()`** [handler] — adresse de livraison : même schéma sur `<TabAdrC>` (`VALUE`,
  A07) ; `tipp` (option `P`). L'existence est testée sur `Numero`, que `Aff_Ct` écrase : une
  nouvelle adresse peut **remplacer** une adresse existante si les numéros coïncident (A02).
  **`Aff_AdrC()`** [réductible] (`If Error` sans `Try` : sans effet), **`Colal_Click`** [handler,
  rejeu], **`Colal_KeyPress`** [handler], **`CleanChampsAdr()`** [réductible].

### GED (dossiers liés)

- **`Maj_Dssr(Origin)`** [réductible] [mixte] : `TriGen` dans `PanelGedDoc` sur `<TabDocGed>`
  (`Limit 1` pour les métadonnées de colonnes), filtre `compte = code` et type `LGed.Clients` (ou
  factures de compta) selon le bouton radio. Un nouveau `TriGen` est créé à chaque appel.
- **`PanelGedDoc_MajSel(val)`** [handler de l'événement `MajSel` du `TriGen`] : ouvre le document.
- **`Button9_Click()`** [handler] : nouveau document GED (`LGed` modal, tags = code + `tag_def`,
  requête **concaténée**), puis `Maj_Dssr("")`.
- **`Docs_Click`, `Tous_Click`, `Facs_Click`, `FacsCompta_Click`, `BonLivraison_Click`,
  `Comman_Click`, `Devis_Click`** [handlers] : `Maj_Dssr` avec l'origine correspondante.
- **`FileFilter()`** [Private, **code mort**].

### Étiquettes (panneau `Panel2`)

- **`Button12_Click()`** [pseudo-handler, Btn 7] : affiche le panneau, `init_ComboBox` (formats
  `Fiches_Etiquettes`).
- **`Button13_Click()`** [pseudo-handler, Btn 8] [mixte] : société (`<TabSoc>`), format choisi,
  `Shell "cd ~"` (sans effet), PDF `~/tmp/EtiqCli.pdf` (`Cetiquettes`), positions de départ
  (`Posetiq`), `Imprime` (format 1) ou `ImprimeC` (colis expéditeur/destinataire), `fin_impression`
  (`Visualiseur.Prog`). Le répertoire `~/tmp` doit exister.
- **`Imprime()`, `ImprimeC()`, `pos_Etiq()`, `pos_EtiqC()`, `fin_impression()`** [réductibles]
  [mixte] : calcul de positions sur la page ; copies quasi identiques dans FFournisseur et dans
  les 7 classes de `.src/Gestion/Etiquettes/` (`Eticli`, `Etiqart`…).

### Outils externes et sous-écrans

- **`Button10_Click()`** [handler] : Google Maps (`xdg-open`) ; l. 529 : `Replace$` dont le résultat
  est ignoré (instruction sans effet). **`button11_Click()`** [handler] : vCard `~/Contacts.vcf`.
  **`Button17_Click()`** [handler] : Infogreffe (deux `xdg-open`, `Wait 1`).
- **`Button20_Click()`** [handler] : fenêtre « documents en cours » (`Fiches_Bl` non imprimés,
  `imp = 0`) créée par `New Form As "Form"` : ses événements sont routés vers les handlers
  `Form_*` de `FClient`, donc `Form_Open` recharge la liste des clients (A11, à confirmer).
- **`Button21_Click()`** : `Extrait(code, "", "C", "S")` ; **`Button22_Click()`** / **`Button23_Click()`** :
  `TarTypeCli` (tarifs du client / du type) ; **`Button24_Click()`** : `Listecom` (`Try $lcom.Close`
  sur une variable locale nulle : sans effet). Handlers.
- **`Button7_Click()`** [pseudo-handler, Btn 1, et F1] : `Doc.Open("Tablesclients&fournisseurs")`.
- **`Btn_Click()`** [handler] : dispatch décrit plus haut.

## État global utilisé

- `Utils.db` (Exec, Create9, Edit, Begin/Commit, AutoIncrement, Engine, Subst), `Utils.Base`/`rs1`,
  `Utils.Observers`, `ObsGotf`/`ObsLstf`, `SetEditColor`, `Remplace`, `chkEmail`, `cpoint`,
  `Cdate_Dbase`, `Fill_Civilite`, `FColr`, `Option`.
- `Start.LocalSettings["/Soc<XX>/…"]` : `Materiel`, `Faca`, `Sms`, `Coul_fen`, `Pays`, `Sage`, `Expfact`,
  `Ech`, `Typec`, `Pdf`, `Tmail`, `Tmail2` ; `/Coul/Znaff`, `/Coul/Focus` ; `Start.Son`, `Start.Musique`,
  `Start.Societe`.
- `Variables.Sprix`, `Sexport`, `SMajCli` (garde d'export), `Variables.stexte` (écrit par `Commail`).
- Tables en dur : `Fiches_Cli`, `Fiches_Comptes` (dont la jointure de `Maj_Zones`), `Fiches_Cli_Vtl`,
  `Fiches_Mvt`, `Fiches_Bl`, `Fiches_Parametres`, `Fiches_Reglements`, `Fiches_Typec`,
  `Fiches_Echeances`, `Fiches_Etiquettes`, `Fiches_HistoFac(M)`, `Fiches_Tag`, `Fiches_region`,
  `Fiches_tourne`, `Corsage`.
- Fichiers : `Pays.txt` (répertoire courant), `~/Contacts.vcf`, `~/tmp/EtiqCli.pdf`.

## Duplication avec FFournisseur

Mesure (script de session, lignes hors commentaires normalisées : casse, préfixes `cli_`/`fo_`,
noms `TabCli`/`TabFour`, `Colcli`/`Cfour`, `Tabstrip1`/`TabFour`, `ContactC`/`ContactF`…) :

| Indicateur | Valeur |
|---|---|
| LOC FClient / FFournisseur | 2716 / 2156 |
| Lignes communes (alignement séquentiel) | 920 |
| Lignes communes (multiensemble, sans ordre) | 1725, soit 80 % de FFournisseur |
| Fonctions homonymes | 105 (sur 157 / 132) |
| … identiques après normalisation | 43 |
| … similarité ≥ 0,9 | 54 (576 LOC côté FClient) |
| … similarité ≥ 0,7 | 75 (1016 LOC côté FClient) |
| Paires non homonymes ≥ 0,7 | `Colcli_Data`/`Cfour_Data` 0,70 ; `colcli_Click`/`Cfour_Click` 0,70 ; `RdimColcli`/`RdimCfour` 0,76 ; `Button13_Click`/`Button15_Click` 0,89 ; `Cpman3`/`Cpman` 0,94 ; `ToggleButton3_Click`/`ToggleButton5_Click` 0,91 ; `Button6_Click`/`Enrgvent` 0,72 ; `Button10_Click`/`Button11_Click` 0,79 |

Identiques ou quasi identiques : `nom_pays`, `Tris`, `Dbclk`, `Refresh`, `Maj_vtl`, `CleanVtl`,
`ToggleButton1_Click`, `Colcompt2_KeyPress`, `Colech_KeyPress`, `Cnt_KeyPress`, `Cnt_GotFocus`,
`Cmpt2_GotFocus`, `*_GotFocus`/`*_LostFocus`/`*_KeyPress` des en-têtes, `init_ComboBox`, `Imprime`,
`ImprimeC`, `pos_Etiq`, `pos_EtiqC`, `fin_impression`, `Aff_Ct`, `Button16_Click`, `Colal2_*`,
`CleanChampsCt`, `Maj_Dssr`, `PanelGedDoc_MajSel`, `Button9_Click`, boutons radio GED,
`RechTag_Click`, `LibelDef_LostFocus`, `Update_ListTags`, `ListTags_*`, `Ventilman`, `Ventilations`,
`Vents_Activate`, `Email_*`, `Maj_Email`, `Button17_Click`, `Button19_Click`, `Btn_Click`, `FileFilter`.

Divergences métier : collectif `41`/`453` (client) contre `40` (fournisseur) ; numérotation `dnc`
(411…) contre `dnf` (401…) ; écriture par `Result` modifiable + transaction (client) contre
`INSERT`/`UPDATE` paramétrés sans transaction (fournisseur) ; adresses de livraison, matériels,
abonnement, statistiques, statut, commercial, SEPA (client) ; franco, minimum de commande, port,
centrale, code-barres, TVA intracommunautaire (fournisseur).

## Propositions d'amélioration

### Socle commun « fiche tiers » (sans changer la GUI)

Gambas ne permet pas de partager un `.form` ; on garde donc les deux formulaires, leurs contrôles
et **tous leurs handlers**, dont les corps délèguent à un socle. Proposition :

- **`.src/Gestion/Tables/FicheTiers.class`** (classe d'instance créée dans `_New`,
  `$tiers = New FicheTiers(FicheTiers.Client, Me)`) portant les paramètres qui distinguent les deux
  fiches : clé `Cbase` de la table (`TabCli`/`TabFour`), préfixe de colonne (`cli_`/`fo_`), clés des
  tables de ventilation (`TabCliVtl`/`TabFourVtl`), contacts (`TabContact`/`TabContactF`), mails
  (`TabMailCli`/`TabMailFour`), type GED (`LGed.Clients`/`LGed.Fournisseurs`), domaine d'export
  (`Cli`/`Four`, `ContactC`/`ContactF`), paramètre de numérotation (`dnc`/`dnf`, racine 411/401),
  nom du PDF d'étiquettes.
- Services du socle, chacun recevant les contrôles en paramètre (comme
  [`Ccomptes`](../../../Compta/Ccomptes.module/architecture.md) le fait pour `Colco`) :
  - **calcul pur (gbtest)** : `ProchainCode(sDernier, sRacine)` (incrément 411999 → 4111000…),
    `ClauseRecherche(sTri, sSel, bDebut)` (texte SQL **identique** à aujourd'hui) ;
  - **SQL sans GUI** : `LitTiers`, `Mails(sCode)`, `AjouteMail`/`SupprimeMail`, `Contacts(sCode)`,
    `EnregistreContact(...)`, `SupprimeContact`, `Ventilations(sCode)`, `EnregistreVentilation`,
    `SupprimeVentilation`, `LitLibelTags`/`EcritLibel`/`EcritTags`, `CompteVentilable(sCompte)`,
    `ExisteEcheance(sCode)`, `ChercheCP(sCp)` ;
  - **GUI paramétrée** : `ChargePays(hCombo)`, `RemplitListe(hCol, rResult, …)` (collectifs,
    échéances, types, CP), `PanneauGed(hPanel, sCode, sOrigine)`, `ChoisirTag(hListe)`,
    `OuvreCarte`, `VCard`, `Infogreffe`, `EnvoiSms`.
- **Étiquettes** : extraire `Imprime`/`ImprimeC`/`pos_Etiq`/`pos_EtiqC`/`fin_impression` et leur état
  (13 membres) dans une classe `PlancheEtiquettes` utilisée aussi par les 7 écrans de
  `.src/Gestion/Etiquettes/` (lot ultérieur).
- Gain estimé : 900 à 1 000 LOC sur les deux fichiers, sans modifier un `.form` ni un nom de handler.

### Réécriture / refactorisation (dans le fichier)

- `Deb2`/`Deb3` : une seule construction de la clause `WHERE` (les branches `hColcli` sont
  identiques) ; CC 18 → ≤ 4, texte SQL inchangé.
- `C1/N1/A1/Cp1/V1` : `ChoixTri(sTri, hEntete)` et `SaisieRecherche(bDebut)` ; handlers conservés.
- `Cpman2`/`Cpman3` → `ChoixVille(hCp, hVille)`.
- `Maj_Zones` : `LitClient(sCode)` + affectations ; CC 42 → ≤ 15.
- `Button4_Click` : regrouper les deux branches (création / modification) qui ne diffèrent que par
  `Create9`/`Edit` et la resélection.

### Commonalisation avec d'autres fichiers

- [`FFournisseur`](../FFournisseur.class/architecture.md) : socle ci-dessus.
- Règles de collectif : quatre implémentations divergentes,
  [`FComptes.collman`](../../../Compta/Tables/FComptes.class/architecture.md) (client `41`/`453`,
  fournisseur `40`), [`FCollectif`](../../../Compta/Tables/FCollectif.class/architecture.md)
  (création `401`/`411`/`453`), `FClient.collman` (défaut A01), `FFournisseur.collman` (`40`).
  Proposition : `Ccomptes.CollectifValide(sCompte, sType) As Integer` (0 inexistant, 1 valide,
  2 non collectif ou mauvais préfixe), messages laissés aux écrans ; à appliquer après décision sur
  FCLIENT-A01.
- Garde d'export `Variables.Sprix And Variables.Sexport And Variables.SMajCli` (5 appels) :
  `Serveur.Actif("Cli")` proposé par SERVEUR-008 ([Serveur](../../../Serveur.module/architecture.md)).
- Contrôle du n° de TVA intracommunautaire : présent dans FFournisseur et
  [`Fsoc`](../../../Communs/Fsoc.class/architecture.md) via
  [`CTestTVA`](../../../Utils/CTestTVA.class/architecture.md), **absent** de FClient (évolution, hors
  rework). FClient n'a pas de nettoyage de SIREN (seulement la zone `siret`, sans contrôle).
- Code postal : `Cpman`/`ChkCp` existent aussi dans `FClientcarte`, `Depots`, `Facture`, `Marques`,
  [`Cpostaux`](../Cpostaux.class/architecture.md).
- GED : `Maj_Dssr` existe aussi dans [`Articles`](../Articles.class/architecture.md).
- vCard : [`Expcontact`](../../../Utils/Exports-Imports/Expcontact.class/architecture.md) produit le
  même format.
- Numérotation `dnc` : à rapprocher de `Impclient.Compteur`, `ImpSage` et `Facture` (notes
  transverses du lot Utils).

### Réduction de portée

Fonctions sans appelant externe, nom non lié à un événement : `nom_pays`, `Tris`, `Deb2`,
`Colcli_contact`, `Deb3`, `Maj_Zones`, `Aff_Mat`, `ChiffreA`, `CleanVtl`, `Refresh`, `CleanChamps`,
`Maj_Email`, `RdimColcli`, `Aff_Statut`, `GenRum`, `Ventilations`, `Recup_Typec`, `echman`,
`Dbclk`, `Titre`, `V1_Clk`, `collman`, `Ventilman`, `Envoi`, `init_ComboBox`, `Imprime`,
`ImprimeC`, `fin_impression`, `pos_Etiq`, `pos_EtiqC`, `aff_cp`, `Cpman2`, `Cpman3`, `Aff_AdrC`,
`CleanChampsAdr`, `Aff_Ct`, `CleanChampsCt`, `Maj_Dssr`, `Update_ListTags` → `Private`.
Restent `Public` : `Bsel`, `Bval`, `Codepostal`, `Bureaudistributeur` (écrits par `Tricp`, `TriCpt`,
`TriGen`), tous les `Contrôle_Événement` (y compris pseudo-handlers et `ListTags_Add`), et les
`<Grille>_Click` appelés par le rejeu : `colcli_Click`, `Colcompt2_Click`, `Coltype_Click`,
`Colech_Click`, `Colcp_Click`, `Colal_Click`, `Colal2_Click`.

### Séparation traitement / GUI

- `ProchainCode` (pur) et `ReserveCode(sRacine)` (SQL : LOCK, lecture, UPDATE, UNLOCK) pour
  `Button2_Click`.
- `EcritCompteTiers(sCode, sNom, sColl, bLettrable)` pour la partie `Fiches_Comptes` de `majchamp`.
- `SupprimeClient(sCode) As String` (contrôles + DELETE, renvoie le motif de refus) pour
  `Button3_Click`, même ordre de requêtes.
- `ControleCollectif(sCompte) As Integer` pour `collman`, en conservant le défaut A01 tant qu'il
  n'est pas validé ; messages dans l'appelant.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_AdrlivC.num` et `Fiches_ContactC.num` sont des clés auto-incrémentées : le calcul
  `max(num) + 1` pourrait laisser la base attribuer le numéro.
- Clés étrangères `Fiches_Cli_Vtl.code`, `Fiches_ContactC.code`, `Fiches_AdrlivC.code`,
  `Mails_Cli.code`, `Docs_Ged.compte` → `Fiches_Cli.cli_code` avec suppression en cascade (évite les
  orphelins de A04).
- Colonnes booléennes (`cli_actif`, `cli_exo`, `cli_copie`, `cli_rlvc`…) stockées en `-1`/`0` (valeur
  de case Gambas) : type booléen homogène.
- `cli_email` dupliqué avec `Mails_Cli` : une colonne « principal » dans `Mails_Cli`.
- Table `Fiches_region` créée hors `db_control.csv` (module d'option) ; clés `Cbase` pour
  `Fiches_Reglements`, `Fiches_region`, `Fiches_tourne`, `Corsage`.
- Numérotation `Fiches_Parametres.dnc` : séquence dédiée au lieu de `LOCK TABLES`.
