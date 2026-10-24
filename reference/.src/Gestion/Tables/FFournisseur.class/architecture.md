# FFournisseur — Architecture

> Source : `.src/Gestion/Tables/FFournisseur.class`

## Vue d'ensemble

`FFournisseur` est la **fiche fournisseur** : liste des fournisseurs (`Cfour`, GridView virtuelle
alimentée par `Utils.Base` / `Utils.rs1`) avec recherche par en-tête de colonne, et fiche sur un
`TabFour` de 6 onglets :

| Index | Onglet | Contenu, tables |
|---|---|---|
| 0 | Identité | `Fiches_Four` (+ compte `Fiches_Comptes` type `F`), mails `Mails_Four`, collectif `40…` |
| 1 | Divers | RIB / IBAN / BIC, TVA intracommunautaire, site web, n° client chez le fournisseur, échéance, franco, minimum de commande, frais de port, centrale d'achat (`Fiches_Centrales`), code-barres |
| 2 | Ventilations | `Fiches_Four_Vtl`, libellé d'écriture et tags par défaut (`libel_def`, `tag_def`) |
| 3 | Observations | `fo_obs` |
| 4 | Contacts | `Fiches_ContactF` |
| 5 | Dossiers liés | GED `Docs_Ged` (`TriGen` dans `PanelGedDoc`), copie PDF automatique (case `Copie`) |

Points d'entrée : `Fmenu.class:571` (`Ffournisseur.ShowModal()`), `Articles.class:1294`,
`Saisecrit.class:1207`, `Tresor.class:929`, `Facture.class:6345` (F4) — tous sur l'**auto-instance** —
et `Facture.class:5658` (F11) qui crée une **nouvelle instance** (`New FFournisseur`), ce qui casse
le retour de [`Tricp`](../../../../../.src/Affichages/Tricp.class) (A07).

Nature : **GUI** ; SQL et règles dans les handlers. Jumeau de
[`FClient`](../FClient.class/architecture.md) : la mesure de duplication et la proposition de socle
commun `FicheTiers` y sont détaillées (1725 lignes communes, 80 % de ce fichier).

Boutons du groupe `Btn` (dispatch par `Tag` dans `Btn_Click`) : 1 `Button7` aide, 2 `Button1` mail,
3 `Button2` créer, 4 `Button3` supprimer, 5 `Button4` enregistrer, 6 `Button5` fermer, 7 `Button15`
→ fonction `Button14_Click` (panneau étiquettes), 8 `Button13` → fonction `Button15_Click`
(impression), 9 `Button14` → masque le panneau. Les noms de fonction ne correspondent donc pas aux
noms des contrôles ; ce sont des pseudo-handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `N` | var | Private |  | Integer | 28 |
| `Tri` | var | Private |  | String | 29 |
| `Tab` | var | Private |  | String | 30 |
| `Sel` | var | Private |  | String | 31 |
| `fourtable` | var | Private |  | New String[8] | 32 |
| `type` | var | Private |  | String | 33 |
| `Enr` | var | Private |  | Integer | 34 |
| `son` | var | Private |  | Integer | 35 |
| `sKey` | var | Private |  | String | 36 |
| `Dbl` | var | Private |  | String | 37 |
| `CoulZnaf` | var | Private |  | Integer | 38 |
| `CoulFc` | var | Private |  | Integer | 39 |
| `b` | var | Private |  | Integer | 40 |
| `sCentrale` | var | Private |  | String | 41 |
| `i2` | var | Private |  | Integer | 42 |
| `txtPosX` | var | Private |  | Integer | 43 |
| `txtPosY` | var | Private |  | Integer | 44 |
| `Filename` | var | Private |  | String | 45 |
| `Nblargeur` | var | Private |  | String | 46 |
| `Nbhauteur` | var | Private |  | String | 47 |
| `Largeur` | var | Private |  | Integer | 48 |
| `Hauteur` | var | Private |  | Integer | 49 |
| `Mrghaut` | var | Private |  | Integer | 50 |
| `Mrgauche` | var | Private |  | Integer | 51 |
| `Esplargeur` | var | Private |  | Integer | 52 |
| `Esphauteur` | var | Private |  | Integer | 53 |
| `sSociete` | var | Private |  | String | 54 |
| `sAdr1` | var | Private |  | String | 55 |
| `sAdr2` | var | Private |  | String | 56 |
| `sCP` | var | Private |  | String | 57 |
| `Nbetq` | var | Private |  | Integer | 58 |
| `Nb` | var | Private |  | Boolean | 59 |
| `sFetiq` | var | Private |  | String | 60 |
| `Fichier` | var | Private |  | String | 61 |
| `hCfour` | var | Private |  | Boolean | 62 |
| `pdf` | var | Private |  | Cetiquettes | 63 |
| `Tableau` | var | Private |  | String[] | 64 |
| `Bsel` | var | Public |  | Boolean | 65 |
| `Bval` | var | Public |  | String | 66 |
| `Codepostal` | var | Public |  | String | 67 |
| `Bureaudistributeur` | var | Public |  | String | 68 |
| `Col` | var | Private |  | Collection | 70 |
<!-- /AUTO:declarations -->

État d'instance notable :
- `Tab` (`"Fiches_Four"`, utilisé par `Deb2`/`Deb3`), `Tri`, `Sel`, `Dbl`, `hCfour` : recherche.
- `Enr` : drapeau partagé par `collman`/`Ventilman` ; `b` : drapeau d'erreur partagé par
  `FrancoLF`, `FportLF`, `MinCoMLF`, `CtrlBarre`, `CtrlCbarre`.
- `type` : `"F"` (enregistrement) ou `"G"` (`TriCpt`).
- Étiquettes : mêmes 17 membres que FClient (`pdf`, `Nbetq`, `i2`, `txtPosX/Y`…).
- **Inutilisés** : `N` et `CoulFc` (écrits, jamais lus), `Fichier`, `Tableau` ; `Col` (membre utilisé
  seulement par `Maj_Dssr`).
- `Public` : `Bsel`, `Bval` (écrits par `TriCpt`/`TriGen` via `Object.SetProperty` et par `Tricp`),
  `Codepostal`, `Bureaudistributeur` (écrits par `Tricp`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 72-119 | Public | 7 | 45 | 0 | méthode spéciale |
| `Cfour_Data` | 121-153 | Public | 8 | 30 | 0 | handler GUI |
| `Form_Open` | 155-164 | Public | 1 | 8 | 0 | handler GUI |
| `nom_pays` | 166-178 | Public | 3 | 10 | 0 | portée réductible ? |
| `Tabfour3_click` | 180-184 | Public | 1 | 3 | 0 | portée réductible ? |
| `Tris` | 186-201 | Public | 1 | 13 | 0 | portée réductible ? |
| `Deb2` | 203-208 | Public | 1 | 4 | 0 | portée réductible ? |
| `Deb3` | 210-215 | Public | 1 | 4 | 0 | portée réductible ? |
| `Maj_Zones` | 217-276 | Public | 15 | 57 | 0 | portée réductible ? |
| `CleanVtl` | 278-283 | Public | 1 | 4 | 0 | portée réductible ? |
| `Refresh` | 285-290 | Public | 1 | 4 | 0 | portée réductible ? |
| `CleanChamps` | 292-337 | Public | 1 | 43 | 0 | portée réductible ? |
| `Email_KeyPress` | 339-366 | Public | 7 | 24 | 0 | handler GUI |
| `Email_LostFocus` | 368-372 | Public | 1 | 3 | 0 | handler GUI |
| `Maj_Email` | 374-392 | Public | 5 | 16 | 0 | portée réductible ? |
| `Button19_Click` | 396-417 | Public | 3 | 19 | 0 | handler GUI |
| `Aff_Centrale` | 419-433 | Public | 5 | 12 | 0 | portée réductible ? |
| `Cmpt_LostFocus` | 435-452 | Public | 6 | 14 | 0 | handler GUI |
| `Cmpt_KeyPress` | 454-589 | Public | 35 | 116 | 0 | handler GUI |
| `Cmpt_GotFocus` | 594-600 | Public | 1 | 5 | 0 | handler GUI |
| `Cnt_GotFocus` | 602-608 | Public | 1 | 5 | 0 | handler GUI |
| `Cmpt2_KeyPress` | 610-755 | Public | 31 | 121 | 0 | handler GUI |
| `CtrlBarre` | 760-781 | Public | 8 | 18 | 0 | portée réductible ? |
| `Codebarre` | 786-800 | Public | 5 | 13 | 0 | portée réductible ? |
| `CtrlCbarre` | 805-822 | Public | 5 | 15 | 0 | portée réductible ? |
| `Calc_barre` | 827-837 | Public | 1 | 8 | 0 | portée réductible ? |
| `Cnt_KeyPress` | 839-884 | Public | 11 | 38 | 0 | handler GUI |
| `FrancoLF` | 889-912 | Public | 8 | 22 | 0 | portée réductible ? |
| `FportLF` | 917-940 | Public | 8 | 22 | 0 | portée réductible ? |
| `MinCoMLF` | 945-968 | Public | 8 | 22 | 0 | portée réductible ? |
| `Cmpt2_LostFocus` | 970-988 | Public | 5 | 16 | 0 | handler GUI |
| `Cmpt2_GotFocus` | 993-999 | Public | 1 | 5 | 0 | handler GUI |
| `Btn_Click` | 1001-1033 | Public | 10 | 22 | 0 | handler GUI |
| `Cmpt3_KeyPress` | 1035-1058 | Public | 8 | 20 | 0 | handler GUI |
| `Vnt_Click` | 1060-1070 | Public | 2 | 9 | 0 | handler GUI |
| `Vnt_KeyPress` | 1072-1090 | Public | 6 | 16 | 0 | handler GUI |
| `C1_GotFocus` | 1092-1097 | Public | 2 | 4 | 0 | handler GUI |
| `C1_LostFocus` | 1099-1103 | Public | 2 | 3 | 0 | handler GUI |
| `N1_GotFocus` | 1105-1110 | Public | 2 | 4 | 0 | handler GUI |
| `N1_LostFocus` | 1112-1116 | Public | 2 | 3 | 0 | handler GUI |
| `A1_GotFocus` | 1118-1123 | Public | 2 | 4 | 0 | handler GUI |
| `A1_LostFocus` | 1125-1129 | Public | 2 | 3 | 0 | handler GUI |
| `cp1_GotFocus` | 1131-1136 | Public | 2 | 4 | 0 | handler GUI |
| `cp1_LostFocus` | 1138-1142 | Public | 2 | 3 | 0 | handler GUI |
| `V1_GotFocus` | 1144-1149 | Public | 2 | 4 | 0 | handler GUI |
| `V1_LostFocus` | 1151-1155 | Public | 2 | 3 | 0 | handler GUI |
| `Compt_GotFocus` | 1157-1161 | Public | 2 | 3 | 0 | portée réductible ? |
| `Compt_LostFocus` | 1163-1168 | Public | 2 | 4 | 0 | portée réductible ? |
| `collman` | 1170-1198 | Public | 9 | 26 | 0 | portée réductible ? |
| `Ventilman` | 1200-1233 | Public | 8 | 31 | 0 | portée réductible ? |
| `Cfour_Click` | 1235-1259 | Public | 2 | 21 | 0 | handler GUI |
| `Cfour_KeyPress` | 1261-1268 | Public | 3 | 6 | 0 | handler GUI |
| `RdimCfour` | 1270-1281 | Public | 2 | 10 | 0 | portée réductible ? |
| `Ventilations` | 1283-1327 | Public | 7 | 41 | 0 | portée réductible ? |
| `Maj_vtl` | 1329-1334 | Public | 1 | 4 | 0 | portée réductible ? |
| `colfo_Click` | 1336-1345 | Public | 1 | 8 | 0 | portée réductible ? |
| `colfo_Activate` | 1347-1351 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button4_Click` | 1353-1427 | Public | 19 | 72 | 0 | portée réductible ? |
| `Colcompt2_KeyPress` | 1432-1453 | Public | 6 | 18 | 0 | handler GUI |
| `ToggleButton2_Click` | 1455-1493 | Public | 6 | 35 | 0 | handler GUI |
| `Colcompt2_Click` | 1495-1503 | Public | 1 | 7 | 0 | handler GUI |
| `Button3_Click` | 1505-1584 | Public | 15 | 74 | 0 | portée réductible ? |
| `Button2_Click` | 1586-1642 | Public | 13 | 52 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 1644-1657 | Public | 2 | 10 | 0 | handler GUI |
| `ToggleButton5_Click` | 1659-1688 | Public | 4 | 27 | 0 | handler GUI |
| `Colech_Click` | 1690-1696 | Public | 1 | 5 | 0 | handler GUI |
| `Colech_KeyPress` | 1701-1722 | Public | 6 | 18 | 0 | handler GUI |
| `Button6_Keypress` | 1724-1728 | Public | 3 | 3 | 0 | portée réductible ? |
| `Button6_Click` | 1730-1734 | Public | 1 | 3 | 0 | portée réductible ? |
| `Enrgvent` | 1736-1769 | Public | 7 | 31 | 0 | portée réductible ? |
| `Vents_Keypress` | 1771-1783 | Public | 3 | 10 | 0 | handler GUI |
| `Vents_Activate` | 1785-1802 | Public | 3 | 15 | 0 | handler GUI |
| `Button1_Click` | 1804-1813 | Public | 3 | 6 | 0 | portée réductible ? |
| `Dbclk` | 1815-1825 | Public | 2 | 9 | 0 | portée réductible ? |
| `C1_Click` | 1827-1840 | Public | 1 | 12 | 0 | handler GUI |
| `C1_Dblclick` | 1842-1855 | Public | 1 | 12 | 0 | handler GUI |
| `N1_Click` | 1857-1870 | Public | 1 | 12 | 0 | handler GUI |
| `N1_Dblclick` | 1872-1885 | Public | 1 | 12 | 0 | handler GUI |
| `A1_Click` | 1887-1899 | Public | 1 | 11 | 0 | handler GUI |
| `A1_Dblclick` | 1901-1913 | Public | 1 | 11 | 0 | handler GUI |
| `Cp1_Click` | 1915-1927 | Public | 1 | 11 | 0 | handler GUI |
| `Cp1_Dblclick` | 1929-1941 | Public | 1 | 11 | 0 | handler GUI |
| `V1_Click` | 1943-1955 | Public | 1 | 11 | 0 | handler GUI |
| `V1_Dblclick` | 1957-1969 | Public | 1 | 11 | 0 | handler GUI |
| `Ref` | 1971-1979 | Public | 1 | 6 | 0 | portée réductible ? |
| `C1_KeyPress` | 1981-1993 | Public | 4 | 11 | 0 | handler GUI |
| `N1_KeyPress` | 1995-2007 | Public | 4 | 11 | 0 | handler GUI |
| `A1_KeyPress` | 2009-2021 | Public | 4 | 11 | 0 | handler GUI |
| `Cp1_KeyPress` | 2023-2035 | Public | 4 | 11 | 0 | handler GUI |
| `V1_KeyPress` | 2037-2049 | Public | 4 | 11 | 0 | handler GUI |
| `Button14_Click` | 2052-2057 | Public | 2 | 4 | 0 | portée réductible ? |
| `init_ComboBox` | 2059-2075 | Public | 5 | 14 | 0 | portée réductible ? |
| `Button15_Click` | 2077-2145 | Public | 12 | 65 | 0 | portée réductible ? |
| `Imprime` | 2147-2167 | Public | 7 | 18 | 0 | portée réductible ? |
| `ImprimeC` | 2169-2195 | Public | 3 | 24 | 0 | portée réductible ? |
| `fin_impression` | 2197-2203 | Public | 1 | 5 | 0 | portée réductible ? |
| `pos_Etiq` | 2205-2234 | Public | 6 | 28 | 0 | portée réductible ? |
| `pos_EtiqC` | 2236-2267 | Public | 8 | 30 | 0 | portée réductible ? |
| `Cpman` | 2270-2289 | Public | 3 | 17 | 0 | portée réductible ? |
| `aff_cp` | 2291-2318 | Public | 4 | 25 | 0 | portée réductible ? |
| `Colcp_Click` | 2320-2329 | Public | 1 | 8 | 0 | handler GUI |
| `Colcp_KeyPress` | 2334-2355 | Public | 6 | 18 | 0 | handler GUI |
| `ChkCp` | 2357-2365 | Public | 7 | 7 | 0 | portée réductible ? |
| `ChkFranco` | 2368-2376 | Public | 7 | 7 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 2378-2391 | Public | 2 | 11 | 0 | handler GUI |
| `Button8_Click` | 2395-2399 | Public | 1 | 3 | 0 | handler GUI |
| `Button11_Click` | 2401-2416 | Public | 2 | 13 | 0 | handler GUI |
| `button12_Click` | 2418-2430 | Public | 3 | 8 | 0 | handler GUI |
| `Button17_Click` | 2432-2442 | Public | 2 | 8 | 0 | handler GUI |
| `Button16_Click` | 2445-2465 | Public | 11 | 18 | 0 | handler GUI |
| `Aff_Ct` | 2467-2487 | Public | 4 | 18 | 0 | portée réductible ? |
| `Colal2_Click` | 2489-2505 | Public | 2 | 14 | 0 | handler GUI |
| `Colal2_KeyPress` | 2507-2519 | Public | 7 | 11 | 0 | handler GUI |
| `CleanChampsCt` | 2521-2531 | Public | 1 | 9 | 0 | portée réductible ? |
| `Maj_Dssr` | 2536-2586 | Public | 5 | 44 | 0 | portée réductible ? |
| `PanelGedDoc_MajSel` | 2588-2598 | Public | 2 | 8 | 0 | handler GUI |
| `FileFilter` | 2602-2609 | Private | 1 | 5 | 0 |  |
| `Button7_Click` | 2611-2615 | Public | 1 | 3 | 0 | portée réductible ? |
| `BtnAccesWebTVA_Click` | 2617-2626 | Public | 2 | 6 | 0 | handler GUI |
| `HBox1_MouseDown` | 2628-2630 | Public | 1 | 2 | 0 | handler GUI |
| `Button9_Click` | 2632-2662 | Public | 4 | 28 | 0 | handler GUI |
| `Docs_Click` | 2664-2668 | Public | 1 | 3 | 0 | handler GUI |
| `Tous_Click` | 2670-2674 | Public | 1 | 3 | 0 | handler GUI |
| `Facs_Click` | 2676-2680 | Public | 1 | 3 | 0 | handler GUI |
| `BonRecep_Click` | 2682-2686 | Public | 1 | 3 | 0 | handler GUI |
| `Comman_Click` | 2688-2692 | Public | 1 | 3 | 0 | handler GUI |
| `FacCompta_Click` | 2694-2698 | Public | 1 | 3 | 0 | handler GUI |
| `RechTag_Click` | 2700-2728 | Public | 3 | 22 | 0 | handler GUI |
| `LibelDef_LostFocus` | 2730-2737 | Public | 2 | 5 | 0 | handler GUI |
| `Update_ListTags` | 2739-2754 | Public | 2 | 11 | 0 | portée réductible ? |
| `ListTags_Add` | 2757-2767 | Public | 2 | 8 | 0 | handler GUI |
| `ListTags_LostFocus` | 2769-2773 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

Étiquettes : [portée : nécessaire | réductible] [nature : calcul | GUI | mixte]. Les fonctions
« identiques à FClient » ont le même corps à la normalisation près (`fo_`/`cli_`, noms de tables et
de contrôles) ; leur description complète est dans [FClient](../FClient.class/architecture.md).

### Initialisation, liste et recherche

- **`_New()`** [nécessaire] [mixte] : son, centrage, couleurs, `Utils.Observers(Me)`, bouton SMS
  (`/Sms`), libellés d'en-tête, `nom_pays`, civilités, liste `Centrale` (`<TabCentrales>`, sous
  `Try`), colonnes de `Colal2`.
- **`Form_Open()`** [handler] : `Tab = "Fiches_Four"`, tri par code, `Tris`, `Deb2`, focus.
- **`nom_pays()`**, **`Tris()`**, **`Dbclk()`**, **`Refresh()`**, **`CleanVtl()`** [réductibles] :
  identiques à FClient.
- **`Cfour_Data(Row, Column)`** [handler] : comme `Colcli_Data` (tableau `fourtable`).
- **`Deb2()` / `Deb3()`** [réductibles] [mixte] : `Utils.Base(Cfour, "select * from Fiches_Four where
  <Tri> like "%sel%" order by <Tri> [desc]")` (table via le membre `Tab`, SQL **concaténé**, A10) ;
  pas de filtre actif/statut contrairement à FClient.
- **`C1_Click`, `N1_Click`, `A1_Click`, `Cp1_Click`, `V1_Click`** [pseudo-handlers : `TextBox` sans
  événement `Click`, appelés par les `*_GotFocus`] et **`C1_Dblclick` … `V1_Dblclick`** [handlers] :
  dix corps presque identiques : `sel = ""`, `Ref` (qui vide la fiche et force `Tri = "fo_code"`),
  libellés d'en-tête, colonne de tri, puis `Deb2` (clic) ou `Dbclk` (double-clic). `C1`/`N1`
  appellent en plus `CleanChamps` une seconde fois.
- **`C1_KeyPress` … `V1_KeyPress`** [handlers] : saisie incrémentale (`sel`) puis `Deb2` ; pas de
  F2/Échap ni de recherche « commence par » (différences avec FClient).
- **`C1_GotFocus` … `V1_GotFocus`, `C1_LostFocus` … `V1_LostFocus`** [handlers] : `ObsGotf`/`ObsLstf`
  puis le clic correspondant.
- **`Ref()`** [réductible] : `Tab`, `Tri`, `CleanChamps`, `Tris` (utilisée ici, contrairement à FClient).
- **`Cfour_Click()`** [handler, **appelé par le rejeu**] : `CleanChamps`, `CleanChampsCt`,
  `Maj_Zones`, `Ventilations`, libellés, `Aff_Ct`, `Maj_Dssr("")`, réduction de la grille.
- **`Cfour_KeyPress()`** [handler] : Échap/F2 → `RdimCfour`. **`RdimCfour()`** [réductible] :
  agrandit (avec `Deb2`) ou réduit (sans `Deb2`) la grille.
- **`Tabfour3_click()`**, **`colfo_Click()`**, **`colfo_Activate()`** [**code mort**] : aucun
  contrôle `Tabfour3` ni `colfo` dans le formulaire, aucun appel. `colfo_Activate` appellerait la
  suppression.

### Fiche : lecture, vidage

- **`Maj_Zones()`** (CC 15) [réductible] [mixte] : `select * from <TabFour> Left join Fiches_Comptes
  on compte_cc = fo_code where fo_code = &1` sur `Cfour.row`, **sans test `Available`** (A11) ;
  ~40 zones, montants `franco`/`mincom`/`fport` en `0.00`, `Aff_Centrale`, mails (`<TabMailFour>`).
- **`CleanChamps()`** [réductible] [GUI] : remet à blanc la fiche (`Copie` = case « copie
  automatique des documents »).
- **`Aff_Centrale(sCentrale)`** [réductible] [mixte] : libellé de la centrale (`<TabCentrales>`).
- **`Maj_vtl()`** [**code mort**].

### Saisie (navigation clavier) et contrôles de format

- **`Cmpt_KeyPress()`** (CC 35, max du fichier) [handler, groupe `Cmpt`] : Entrée/Tab enchaîne les
  zones par `Tag` avec `Utils.Remplace` ; tag 2 refuse la saisie sans code ; tag 6 (CP) → `Cpman` ;
  tag 9 (collectif) → `collman` ; tag 10 (**`Fax1`**) insère le mail courant dans `<TabMailFour>` et
  met à jour `fo_email` (doublon de `Maj_Email`, intention à confirmer, A12) ; hors Entrée, tag 9 →
  `ChkCp` (chiffres seuls) ; F1 aide ; F2 : tags 1/2 `RdimCfour` (test `Esc Or F2` redondant),
  tag 6 `Tricp` (**sans `Stop Event`**), tag 9 collectifs. `Case 8` inaccessible (aucun contrôle
  `Cmpt` de tag 8 ; `Email` est une ComboBox hors groupe).
- **`Cmpt_LostFocus()`** [handler] : tag 9 `collman` ; `Case 8` inaccessible.
- **`Cmpt_GotFocus`, `Cnt_GotFocus`, `Cmpt2_GotFocus`** [handlers] : `Utils.SetEditColor`.
- **`Cmpt2_KeyPress()`** (CC 31) [handler] : F9 sur `Cb` (tag 15) → `Codebarre` ; navigation de
  l'onglet Divers ; tag 6 (`Idtva`) : si le numéro commence par `FR`,
  `CTestTVA.isIntraComValide(Idtva.Text)` (sans SIREN), avertissement et `Stop Event` si invalide ;
  tags 10-12 → `FrancoLF`/`MinCoMLF`/`FportLF` puis focus selon `b` ; hors Entrée, tag 10 →
  `ChkFranco` (seule `Franco` est filtrée, pas `MinCom` ni `Fport`) ; F2 tag 9 → échéances.
- **`Cmpt2_LostFocus()`** [handler] : `Cb` : retire un `*` initial, `Utils.Find_cbarre`, puis
  `CtrlBarre` et `CtrlCbarre`.
- **`FrancoLF()`, `FportLF()`, `MinCoMLF()`** [réductibles] [mixte] : trois copies : `cpoint`, test
  `Val(x) = Null`, format `0.00`, `b` ; `Catch` avec message.
- **`ChkFranco()`** [réductible] : filtre de touches (chiffres, `,`, `.`). **`ChkCp()`** [réductible] :
  chiffres seuls (utilisé pour le collectif, tag 9).
- **`CtrlBarre()`** [réductible] [mixte] : longueur 8 ou 13 ; pour 13, clé EAN `Utils.Calcode`
  comparée (entier contre chaîne) au dernier caractère ; la clé d'un EAN-8 n'est pas vérifiée.
- **`Codebarre()`** [réductible] : remplace le code existant après confirmation (`Start.Son` au lieu
  de `son`) ou génère si vide. **`Calc_barre()`** [réductible] [calcul] : `"299999" & code` + clé.
- **`CtrlCbarre()`** [réductible] [mixte] : cherche le code-barres dans **`Fiches_Carte`** (cartes de
  fidélité clients) et compare `code` au **code-barres** au lieu du code fournisseur ; le message
  parle d'un fournisseur (A06). C'est une copie de `FClientcarte.CtrlCbarre` (`FClientcarte.class:526`,
  qui compare bien à `cd`) dont la table n'a pas été adaptée.
- **`Cnt_KeyPress()`** [handler, contacts] : identique à FClient.
- **`Cmpt3_KeyPress()`** [handler] : tag 1 (`Compt`) Entrée → `Compt_LostFocus` ; F1 ; F2 →
  `ToggleButton1_Click`.
- **`Compt_GotFocus()` / `Compt_LostFocus()`** [pseudo-handlers : `Compt` est dans le groupe `Cmpt3`,
  donc jamais levés par Gambas] : `ObsGotf` ; `Ventilman` + `ObsLstf`.
- **`Vnt_Click()` / `Vnt_KeyPress()`** [handlers, groupe `Vnt`] : `Enrgvent`, focus sur `Compt`.
- **`Button6_Keypress()`** [**code mort**, `handlers_inactifs`] : `Button6` est dans le groupe `Vnt`,
  l'événement est levé sous le nom `Vnt_KeyPress`. **`Button6_Click()`** [**code mort**] : seul
  appelant `Button6_Keypress`.
- **`Btn_Click()`** [handler] : dispatch décrit plus haut.

### Création, enregistrement, suppression

- **`Button2_Click()`** [pseudo-handler, Btn 3] [mixte] — **créer** : comme FClient avec
  `dnf` / 401 : `LOCK TABLES` (non relâché si `dnf` < 401000, A02), incrément 401999 → 4011000,
  4019999 → 40110000, `UPDATE dnf`, `UNLOCK` ; copie PDF `/Pdf2` ; collectif par défaut = **dernier**
  compte collectif dont les deux premiers chiffres valent ceux du code (`40`). Pas de frais, pas de
  RUM.
- **`Button4_Click()`** (CC 19) [pseudo-handler, Btn 5] [mixte] — **enregistrer** : nettoie ;
  refuse sans nom/collectif/code ; `collman` ; création (bouton « Valider ») : `INSERT` paramétré de
  38 colonnes dans `Fiches_Four` puis `INSERT` dans `Fiches_Comptes` **sans test d'existence ni
  transaction** (A03) ; modification : `UPDATE` ou `INSERT` de `Fiches_Comptes` (`coll = Col`,
  booléen local toujours faux) puis `UPDATE` de `Fiches_Four` ; montants par `Val(cpoint(...))`,
  centrale par `convBool`, autres cases en valeur brute ; export `Serveur.Pass("Four", "C"|"M")` ;
  `Enrgcp.Ecp` ; enregistre le contact en cours (`Button16_Click`).
- **`Button3_Click()`** (CC 15) [pseudo-handler, Btn 4] [mixte] — **supprimer** : confirmation ;
  refus si écriture `Fiches_Mvt`, main d'œuvre `Fiches_Mo`, article `<TabArt>`, commande
  `Fiches_Entcom`, réception `Fiches_Entrecpt` ; sinon `DELETE` `Fiches_Four`, `Fiches_Comptes`, puis
  `DELETE FROM <TabFdocs>` : clé absente (CBASE-A01), erreur propagée par `DB_Connection.Exec` → le
  `Catch` affiche le message : `Fiches_Four_Vtl` n'est pas nettoyé, **l'export serveur de la
  suppression (`Serveur.Pass("Four", "S")`) n'est jamais émis**, la liste n'est pas rafraîchie (A01).
- **`collman()`** [réductible] [mixte] : collectif existant, `coll` vrai et préfixe `40` ; sinon
  message, focus, `Enr = 0`. Correct (contrairement à `FClient.collman`). `Catch` vide.
- **`Ventilman()`** [réductible] [mixte] : identique à FClient, avec `Catch`.

### Listes de choix

- **`ToggleButton2_Click()`** [handler] : collectifs `40…` (`Colcompt2`) ; `MoveFirst`/`SetFocus` hors
  du test `Available`. **`Colcompt2_Click`** [handler, rejeu] (focus `Fax1`), **`Colcompt2_KeyPress`**.
- **`ToggleButton5_Click()`** [handler] : échéances (`Colech`) ; **`Colech_Click`** [handler, rejeu],
  **`Colech_KeyPress`**.
- **`ToggleButton3_Click()`** [handler] : `New Tricp("Fournisseur", "")` ; `Bsel` jamais remis à faux
  (A07). **`ToggleButton1_Click()`** [handler] : `TriCpt` pour la ventilation (même défaut).
- **`Cpman()`** [réductible] [mixte] : identique à `FClient.Cpman3`. **`aff_cp()`** [réductible]
  (`like '<cp>%'` concaténé), **`Colcp_Click`** [handler, rejeu], **`Colcp_KeyPress`** [handler].

### Ventilations, libellé et tags, GED

- **`Ventilations()`** [réductible] : comme FClient, requête de ventilation paramétrée (`&1`),
  lecture `libel_def`/`tag_def` concaténée ; `Catch` avec message.
- **`Enrgvent()`** [réductible] [mixte] : équivalent de `FClient.Button6_Click` (via
  `Compt_Lostfocus`).
- **`Vents_Keypress()`** [handler] (Suppr ; F1 après un `Stop Event` sans effet sur la suite) et
  **`Vents_Activate()`** [handler] : identiques à FClient.
- **`LibelDef_LostFocus`, `RechTag_Click`, `ListTags_LostFocus`** [handlers], **`Update_ListTags`**
  [réductible], **`ListTags_Add`** [**handler** de l'événement `Add` du `ListEditor`, signalé à tort
  `unused`] : identiques à FClient.
- **`Maj_Dssr(Origin)`** [réductible] [mixte] : comme FClient mais la requête de métadonnées lit
  **toute** la table `Docs_Ged` (pas de `Limit 1`) ; message « Veuillez sélectionner un compte
  client » (A09). **`PanelGedDoc_MajSel`** [handler] ; **`Button9_Click()`** [handler] : nouveau
  document (`LGed.Fournisseurs`), message « saisir un client » (A09) ; **`Docs_Click`, `Tous_Click`,
  `Facs_Click`, `BonRecep_Click`, `Comman_Click`, `FacCompta_Click`** [handlers].
- **`FileFilter()`** [Private, **code mort**].

### Mails, contacts

- **`Maj_Email()`** [réductible] [mixte] : `INSERT` (sous `Try`), `UPDATE fo_email`, recharge.
- **`Email_KeyPress()`** [handler] : Entrée → `Maj_Email` ; Suppr → `DELETE`, recharge et `UPDATE
  fo_email` **seulement s'il reste un mail** : après suppression du dernier, `fo_email` garde
  l'adresse supprimée (A05). **`Email_LostFocus`** [handler].
- **`Button1_Click()`** [pseudo-handler, Btn 2] : `EnvMail.Envoi2` vers `Email` (onglet 0) ou `Mail2`
  (onglet 4), sans texte prédéfini (différence avec FClient).
- **`Button19_Click()`** [handler] : SMS (`Gsm`) ; onglet 4 = Contacts, correct ici.
- **`Button16_Click()`, `Aff_Ct()`, `Colal2_Click()`, `Colal2_KeyPress()`, `CleanChampsCt()`** : comme
  FClient sur `<TabContactF>` (`VALUE`, A04), domaine d'export `ContactF` ; `Aff_Ct` n'écrit pas de
  numéro (pas d'adresse de livraison) et vide la saisie.

### Étiquettes

- **`Button14_Click()`** [pseudo-handler, Btn 7] : panneau + **`init_ComboBox()`** [réductible].
- **`Button15_Click()`** [pseudo-handler, Btn 8] [mixte] : comme `FClient.Button13_Click` avec
  `~/tmp/EtiqFour.pdf`, contrôle du format vide, message « Ce format d'étiquettes n'existe pas » ;
  ne remet pas `i2` ni les positions à zéro en fin d'impression (A08).
- **`Imprime()`** [réductible] : comme FClient, mais imprime le **code-barres** (EAN-13) à la place
  de l'adresse quand `Cb` est renseigné. **`ImprimeC()`, `pos_Etiq()`, `pos_EtiqC()`,
  `fin_impression()`** [réductibles] : identiques à FClient (`pos_EtiqC` : `+= 146` au lieu de
  `+= 140` dans une branche).

### Outils externes

- **`Button8_Click()`** (site web), **`Button11_Click()`** (carte), **`button12_Click()`** (vCard
  avec standard et URL), **`Button17_Click()`** (Infogreffe), **`BtnAccesWebTVA_Click()`**
  (vérification du n° de TVA sur un site tiers) [handlers] : `xdg-open` ou fichier `~/Contacts.vcf`.
- **`HBox1_MouseDown()`** [handler **vide**].
- **`Button7_Click()`** [pseudo-handler, Btn 1, et F1] : aide HTML.

## État global utilisé

- `Utils.db`, `Utils.Base`/`rs1`, `Observers`, `ObsGotf`/`ObsLstf`, `SetEditColor`, `Remplace`,
  `chkEmail`, `cpoint`, `convBool`, `Calcode`, `Find_cbarre`, `Fill_Civilite`, `FColr`.
- `Start.LocalSettings["/Soc<XX>/…"]` : `Sms`, `Coul_fen`, `Pdf2` ; `/Coul/*` ; `Start.Son`,
  `Start.Musique`, `Start.Societe`.
- `Variables.Sprix`, `Sexport`, `SMajFour` (garde d'export, 6 occurrences).
- `CTestTVA.isIntraComValide`.
- Tables en dur : `Fiches_Four`, `Fiches_Comptes`, `Fiches_Four_Vtl`, `Fiches_Mvt`, `Fiches_Mo`,
  `Fiches_Entcom`, `Fiches_Entrecpt`, `Fiches_Parametres`, `Fiches_Echeances`, `Fiches_Etiquettes`,
  `Fiches_Tag`.
- Fichiers : `Pays.txt`, `~/Contacts.vcf`, `~/tmp/EtiqFour.pdf`.

## Propositions d'amélioration

### Socle commun « fiche tiers »

Voir [FClient — Socle commun](../FClient.class/architecture.md) : classe `FicheTiers` paramétrée
(`FicheTiers.Fournisseur`) pour les mails, contacts, ventilations, tags, GED, listes de choix,
outils externes et numérotation, plus `PlancheEtiquettes`. Spécificités qui restent ici : franco /
minimum / port, centrale, code-barres, TVA intracommunautaire, contrôles de suppression (MO,
articles, commandes, réceptions).

### Réécriture / refactorisation

- Les dix `C1…V1_Click/_Dblclick` → `ChoixTri(sTri, hEntete, bInverse)` ; les cinq `*_KeyPress` →
  `SaisieRecherche()`.
- `FrancoLF`/`FportLF`/`MinCoMLF` → `FormateMontant(hZone) As Boolean` (même message, même `b`).
- `Button4_Click` : la liste des 38 colonnes est écrite deux fois (INSERT et UPDATE) ; un tableau
  ordonné de couples (colonne, valeur) servirait aux deux requêtes, texte SQL identique.
- `Calc_barre`/`CtrlBarre` : fonctions pures sur le code (gbtest).

### Commonalisation avec d'autres fichiers

- [`FClient`](../FClient.class/architecture.md) : socle commun.
- Règles de collectif : `40` ici, `41`/`453` dans FClient,
  [`FComptes.collman`](../../../Compta/Tables/FComptes.class/architecture.md),
  [`FCollectif`](../../../Compta/Tables/FCollectif.class/architecture.md) : helper
  `Ccomptes.CollectifValide(sCompte, sType)`.
- TVA intracommunautaire : le contrôle `FR` + `CTestTVA.isIntraComValide` est aussi dans
  [`Fsoc`](../../../Communs/Fsoc.class/architecture.md) (l. 316-321, avec SIREN). Contrairement à ce
  qu'indique la documentation de Fsoc (FSOC-009), **FFournisseur ne nettoie pas de SIREN** : il n'a
  pas de zone SIRET ; le point commun est l'appel de contrôle, à factoriser dans
  [`CTestTVA`](../../../Utils/CTestTVA.class/architecture.md) (ex. `CTestTVA.ControleSaisie(sNum)`).
- Code-barres EAN : `Utils.Calcode` et la génération `299999 & code` existent aussi pour les
  articles et cartes (`Articles`, `FClientcarte`).
- Garde d'export → `Serveur.Actif("Four")` (SERVEUR-008, [Serveur](../../../Serveur.module/architecture.md)).
- GED : `Maj_Dssr` aussi dans [`Articles`](../Articles.class/architecture.md).

### Réduction de portée

→ `Private` : `nom_pays`, `Tris`, `Deb2`, `Deb3`, `Maj_Zones`, `CleanVtl`, `Refresh`, `CleanChamps`,
`Maj_Email`, `Aff_Centrale`, `CtrlBarre`, `Codebarre`, `CtrlCbarre`, `Calc_barre`, `FrancoLF`,
`FportLF`, `MinCoMLF`, `collman`, `Ventilman`, `RdimCfour`, `Ventilations`, `Enrgvent`, `Dbclk`,
`Ref`, `init_ComboBox`, `Imprime`, `ImprimeC`, `fin_impression`, `pos_Etiq`, `pos_EtiqC`, `Cpman`,
`aff_cp`, `ChkCp`, `ChkFranco`, `Aff_Ct`, `CleanChampsCt`, `Maj_Dssr`, `Update_ListTags`.
Restent `Public` : `Bsel`, `Bval`, `Codepostal`, `Bureaudistributeur`, les pseudo-handlers
(`ButtonN_Click`, `C1_Click`…, `Compt_GotFocus`/`Compt_LostFocus`), `ListTags_Add` et les
`<Grille>_Click` du rejeu (`Cfour_Click`, `Colcompt2_Click`, `Colech_Click`, `Colcp_Click`,
`Colal2_Click`).

### Séparation traitement / GUI

- `ProchainCode`/`ReserveCode` (numérotation, partagés avec FClient).
- `SupprimeFournisseur(sCode) As String` (contrôles et `DELETE` dans le même ordre).
- `EcritCompteTiers(...)` pour la partie `Fiches_Comptes` de `Button4_Click`.
- `ControleCollectif`, `CompteVentilable` sans message.

### Requêtes signalées par `sql_params` (après le lot Gestion-2)

- l. 1616 : `Exec` passe `Cd.Text` sans marqueur `&N` (signal `sql_params`) : argument inutile, la requête lit le dernier code fournisseur, ce qui est l'intention.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clés étrangères `Fiches_Four_Vtl.code`, `Fiches_ContactF.code`, `Mails_Four.code`,
  `Docs_Ged.compte` → `Fiches_Four.fo_code` avec suppression en cascade.
- `fo_franco`, `fo_mincom`, `fo_fport` en `DECIMAL` ; booléens (`fo_centrale`, `fo_copie`,
  `fo_exo`) homogènes.
- Index unique sur `Fiches_Four.fo_cb` (unicité du code-barres fournisseur, que `CtrlCbarre`
  cherche aujourd'hui dans `Fiches_Carte`).
- `fo_email` dupliqué avec `Mails_Four`.
- Numérotation `Fiches_Parametres.dnf` par séquence.
