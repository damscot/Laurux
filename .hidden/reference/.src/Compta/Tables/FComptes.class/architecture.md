# FComptes — Architecture

> Source : `.src/Compta/Tables/FComptes.class`

## Vue d'ensemble

Écran du **plan comptable** (`Fiches_Comptes`). En haut, une grille `Colco` (GridView virtuelle
remplie par le module [Ccomptes](../../Ccomptes.module/architecture.md) : `Deb2`/`Deb3`, `Tris`,
`Colco_Data`) avec recherche incrémentale sur le code (`CO`) ou l'intitulé (`INTIT`). En bas, la
fiche du compte : code, intitulé, type (`B` bilan, `G` gestion, `A` analytique ; `C`/`F` gérés par
les fiches clients/fournisseurs), collectif de rattachement, cases centralisation, trésorerie,
collectif, compte principal, lettrable, codes et taux de TVA ventes/achats. Un `TabStrip1` à trois
onglets : TVA ; **sous-comptes** de ventilation (`Fiches_SousComptes`, visible si « compte
principal ») ; **analytique** (`Fiches_Analytiques` × `Fiches_Postes`, visible pour les comptes `B`/`G`
si l'option `/Soc<XX>/Analytique` est active).

Points d'entrée : `Fmenu.Menu114_Click` (`Show`) ; `Saisecrit` (l. 1205), `Tresor` (l. 927) et
`Parametre` (l. 342, 558) ouvrent l'**auto-instance** en `ShowModal` pour créer un compte manquant.

Nature : **GUI** ; tout le SQL et les règles métier (type selon le numéro, contrôles de
suppression) sont dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Ncode` | var | Private |  | Integer | 3 |
| `soldec` | var | Private |  | Float | 4 |
| `Enr` | var | Private |  | Integer | 5 |
| `son` | var | Private |  | Integer | 6 |
| `Tri` | var | Private |  | String | 7 |
| `sel` | var | Private |  | String | 8 |
| `Dbl` | var | Private |  | String | 9 |
| `Type` | var | Private |  | String | 10 |
| `Type2` | var | Private |  | String | 11 |
| `Qpostes` | var | Private |  | Boolean | 12 |
| `Bsel` | var | Public |  | Boolean | 14 |
| `Bval` | var | Public |  | String | 15 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Cdate_EXT` | 17-21 | Public | 1 | 3 | 0 | portée réductible ? |
| `lpad` | 23-27 | Public | 1 | 3 | 0 | portée réductible ? |
| `cpoint` | 29-33 | Public | 1 | 3 | 0 | portée réductible ? |
| `_New` | 35-44 | Public | 1 | 6 | 0 | méthode spéciale |
| `Form_Open` | 46-58 | Public | 2 | 11 | 0 | handler GUI |
| `Maj_Zones` | 60-107 | Public | 19 | 45 | 0 | portée réductible ? |
| `cleanChamps` | 109-129 | Public | 1 | 19 | 0 | portée réductible ? |
| `Refresh` | 131-136 | Public | 1 | 4 | 0 | portée réductible ? |
| `Cmpt_KeyPress` | 138-206 | Public | 16 | 60 | 0 | handler GUI |
| `Btn_KeyPress` | 208-217 | Public | 4 | 8 | 0 | handler GUI |
| `Btn_Click` | 219-237 | Public | 5 | 12 | 0 | handler GUI |
| `Form_close` | 239-249 | Public | 3 | 8 | 0 | handler GUI |
| `Cmpt_GotFocus` | 254-258 | Public | 2 | 3 | 0 | handler GUI |
| `Cmpt_LostFocus` | 260-264 | Public | 2 | 3 | 0 | handler GUI |
| `colco_Keypress` | 266-278 | Public | 4 | 10 | 0 | handler GUI |
| `colco_Click` | 280-292 | Public | 3 | 11 | 0 | handler GUI |
| `Button2_Click` | 297-396 | Public | 48 | 93 | 0 | portée réductible ? |
| `Button1_Click` | 402-469 | Public | 15 | 66 | 0 | portée réductible ? |
| `ToggleButton2_Click` | 474-512 | Public | 6 | 36 | 0 | handler GUI |
| `Tvaveman` | 517-540 | Public | 4 | 21 | 0 | portée réductible ? |
| `Tvalist2_KeyPress` | 545-565 | Public | 6 | 17 | 0 | handler GUI |
| `Tvalist2_Click` | 570-579 | Public | 1 | 8 | 0 | handler GUI |
| `ToggleButton3_Click` | 584-622 | Public | 6 | 36 | 0 | handler GUI |
| `Tvaacman` | 627-650 | Public | 4 | 21 | 0 | portée réductible ? |
| `Tvalist_KeyPress` | 655-675 | Public | 6 | 17 | 0 | handler GUI |
| `tvalist_Click` | 680-688 | Public | 1 | 7 | 0 | handler GUI |
| `Comptman` | 693-716 | Public | 2 | 20 | 0 | portée réductible ? |
| `Colco_Data` | 721-725 | Public | 1 | 3 | 0 | handler GUI |
| `Tris` | 727-731 | Public | 1 | 3 | 0 | portée réductible ? |
| `Co_GotFocus` | 733-738 | Public | 2 | 4 | 0 | handler GUI |
| `Co_LostFocus` | 740-744 | Public | 2 | 3 | 0 | handler GUI |
| `Intit_GotFocus` | 746-751 | Public | 2 | 4 | 0 | handler GUI |
| `Intit_LostFocus` | 753-757 | Public | 2 | 3 | 0 | handler GUI |
| `Co_Click` | 759-769 | Public | 1 | 9 | 0 | handler GUI |
| `Co_Dblclick` | 771-780 | Public | 1 | 8 | 0 | handler GUI |
| `Co_KeyPress` | 782-790 | Public | 3 | 7 | 0 | handler GUI |
| `Intit_Click` | 792-802 | Public | 1 | 9 | 0 | handler GUI |
| `Intit_Dblclick` | 804-813 | Public | 1 | 8 | 0 | handler GUI |
| `Intit_KeyPress` | 815-823 | Public | 3 | 7 | 0 | handler GUI |
| `Dbclk` | 825-835 | Public | 2 | 9 | 0 | portée réductible ? |
| `Ref` | 837-843 | Public | 1 | 5 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 848-862 | Public | 2 | 11 | 0 | handler GUI |
| `Button6_Click` | 864-893 | Public | 7 | 26 | 0 | handler GUI |
| `Vents_KeyPress` | 895-913 | Public | 5 | 15 | 0 | handler GUI |
| `Ventilations` | 915-936 | Public | 3 | 19 | 0 | portée réductible ? |
| `CleanVtl` | 938-943 | Public | 1 | 4 | 0 | portée réductible ? |
| `Ventilman` | 945-973 | Public | 6 | 26 | 0 | portée réductible ? |
| `Button4_Click` | 978-982 | Public | 1 | 3 | 0 | portée réductible ? |
| `cprincipal_Click` | 984-992 | Public | 2 | 7 | 0 | handler GUI |
| `Cmpt3_GotFocus` | 998-1002 | Public | 2 | 3 | 0 | handler GUI |
| `Cmpt3_LostFocus` | 1004-1008 | Public | 2 | 3 | 0 | handler GUI |
| `Cmpt3_KeyPress` | 1010-1025 | Public | 6 | 13 | 0 | handler GUI |
| `ToggleButton4_Click` | 1028-1055 | Public | 7 | 25 | 0 | handler GUI |
| `Colposte_Click` | 1058-1069 | Public | 2 | 10 | 0 | handler GUI |
| `TabStrip1_Click` | 1071-1075 | Public | 2 | 3 | 0 | handler GUI |
| `Vnt_Click` | 1078-1101 | Public | 4 | 21 | 0 | handler GUI |
| `Aff_Analytique` | 1103-1128 | Public | 4 | 22 | 0 | portée réductible ? |
| `Postes_KeyPress` | 1130-1145 | Public | 5 | 13 | 0 | handler GUI |
| `Quitter_Postes` | 1147-1155 | Public | 5 | 7 | 0 | portée réductible ? |
| `collman` | 1157-1202 | Public | 17 | 43 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Utilitaires morts

- **`Cdate_EXT(dte)`**, **`lpad(Lpd)`**, **`cpoint(mtt)`** [portée : réductible, **code mort**]
  [nature : calcul] : aucun appel, ni dans le fichier ni ailleurs (vérifié par `grep`).

### Grille et recherche

- **`_New()`** [portée : nécessaire] : observateurs, son, centrage.
- **`Form_Open()`** [handler] : tri par code, `Tris()`, `Ccomptes.Deb2(Colco, <TabComptes>, tri,
  sel)` ; `Ncode` forcé à 999 (jamais lu) ; onglets 2 et 3 masqués.
- **`Refresh()`** [portée : réductible] : vide la grille et relance `Form_Open`.
- **`Colco_Data(Row, Column)`** [handler] : délègue à `Ccomptes.Colco_Data`.
- **`Tris()`** [portée : réductible] : `Ccomptes.Tris(Colco, CO, Intit, Ty, Sol, Co2)` (en-têtes).
- **`Co_GotFocus`/`Co_LostFocus`/`Intit_GotFocus`/`Intit_LostFocus`** [handlers] :
  `Utils.ObsGotf`/`ObsLstf` (sous `Try`) ; le `GotFocus` déclenche aussi le `Click`.
- **`Co_Click`/`Intit_Click`** [handlers] : réinitialise la recherche (`sel`, `Dbl`), `Ref()`, libellés
  des zones d'en-tête, tri par code ou par intitulé, `Deb2`.
- **`Co_Dblclick`/`Intit_Dblclick`** [handlers] : idem puis `Dbclk()`.
- **`Co_KeyPress`/`Intit_KeyPress`** [handlers] : hors `"`, `&`, `'` : `sel = Utils.Obstch(sel)` puis
  `Deb2` (`Catch` vide).
- **`Dbclk()`** [portée : réductible] : alterne `Ccomptes.Deb3` / `Deb2` (drapeau `Dbl`).
- **`Ref()`** [portée : réductible] : tri par code, `CleanChamps`, `Tris`.
- **`colco_Click()`** [handler] : si l'onglet analytique est visible, `Quitter_Postes()` ; si la
  répartition est équilibrée (`Qpostes`), `Maj_Zones`, `Ventilations`, `Aff_Analytique`, sinon message.
- **`colco_Keypress()`** [handler] : Entrée → `colco_Click` ; F1 aide.

### Fiche du compte

- **`Maj_Zones()`** (CC 19) [portée : réductible] [nature : mixte] : `SELECT * FROM <TabComptes>
  where compte_cc = &1` sur la ligne `Colco.row` (**sans test `Available`**), remplit la fiche (la
  plupart des cases sous `Try`), type en lecture seule pour `C`/`F`, `soldec` (jamais lu), visibilité
  des onglets 2 et 3. La condition `Typeco = "B" Or Typeco = "G" And If <option analytique>` dépend
  de la précédence `And`/`Or` de Gambas (à confirmer : l'intention est « (B ou G) et option »).
- **`cleanChamps()`** [portée : réductible] : vide la fiche.
- **`Comptman()`** [portée : réductible] [nature : mixte] : relit le compte saisi et remplit la fiche
  s'il existe (sans les cases principal/lettrable).
- **`Cmpt_KeyPress()`** (CC 16) [handler, groupe `Cmpt`] : Entrée/Tab code → `Comptman` ; intitulé →
  type → TVA ventes (`Tvaveman`, puis enregistrer ou TVA achats) → TVA achats (`Tvaacman`, puis
  enregistrer) ; F1 aide ; F2 listes de TVA.
- **`Cmpt_GotFocus`/`Cmpt_LostFocus`** [handlers] : `Utils.ObsGotf`/`ObsLstf`.
- **`Btn_KeyPress()`** [handler] : Entrée sur Enregistrer → `Button2_Click`.
- **`Btn_Click()`** [handler, groupe `Btn`] : 1 aide, 2 supprimer, 3 enregistrer, 4 fermer.
- **`Form_close()`** [handler] : `Quitter_Postes` si l'onglet analytique est visible ; refuse la
  fermeture si `Qpostes` est faux.
- **`Button2_Click()`** (CC 48, max du fichier) [handler] [nature : mixte] — **enregistrement** :
  1. type en majuscules ; `F` → « créer par la table fournisseurs » et sortie ; `C` sans collectif →
     idem clients ; `C` avec collectif → `collman("C")` (l'appel `collman("F")` qui suit est
     inaccessible) ; `B`/`G` → `enr = "1"`.
  2. `If enr = "1"` : la suite dépend de `Enr`, membre **partagé** avec `Tvaveman`/`Tvaacman`/
     `Ventilman`/`collman` : pour un autre type (`A`, vide…), l'enregistrement a lieu ou non selon
     le dernier contrôle exécuté (anomalie A04).
  3. Forçage du type selon les trois premiers chiffres (comparaison de chaînes) : 100-400,
     402-411, 420-599 → `B` ; 600-799 → `G` ; 800-899 → `B` ; ≥ 900 → `A` (ce dernier `Music.Play`
     sans test de `son`). Avertissement à chaque forçage.
  4. Refus : type ou code vide ; case collectif cochée ; `401…`/`411…` d'un type autre que `B`.
  5. `SELECT … WHERE compte_cc = '<code>'` (concaténation) ; INSERT ou UPDATE paramétrés de 16 / 15
     colonnes. Booléens transmis sous trois formes : valeur brute (`ctrlr.value`, `Col.value`,
     `cprincipal.value`), `CBool(...)`, `Utils.convBool(...)` (`"0"`/`"1"`) ; `solde` =
     `PointBase("0,00")` à la création.
  6. `Refresh`, `CleanChamps`, resélection de la ligne enregistrée dans la grille.
- **`Button1_Click()`** (CC 15) [handler] — **suppression** : refus pour `C`/`F` (zone type) et
  collectif (case) ; puis, sur le compte de la **ligne de grille** `Colco[Colco.row, 0]` (et non le
  code saisi) : refus si une famille l'utilise (`<TabFam>` : `compt_fam`, `cptrem_fam`, `compt2_fam`,
  `compt3_fam`), si des écritures existent (`UNION` de `Fiches_Mvt`, `Mvt1…Mvt5`, puis `Fiches_MvtM…MvtM5`) ;
  sinon confirmation, `DELETE` dans `Fiches_Comptes` et `Fiches_SousComptes` (`code`). Pas de
  contrôle sur `Fiches_Tvaav/Tvaac.cc_tva`, `Fiches_Journaux.cde_banque`, `Fiches_MvtA*` ; les lignes
  `Fiches_Analytiques` du compte restent orphelines.
- **`collman(Typc)`** (CC 17) [portée : réductible] [nature : mixte] : vérifie que le collectif saisi
  existe et est un collectif client (`41…`/`453…`) ; la branche fournisseur teste le membre `type`
  au lieu du paramètre `Typc`. Résultat dans `Enr`. `Catch` vide.
- **`cprincipal_Click()`** [handler] : visibilité de l'onglet sous-comptes.
- **`Button4_Click()`** : `Doc.Open("Comptes")`.

### TVA

- **`ToggleButton2_Click()` / `ToggleButton3_Click()`** [handlers] : listes `Tvalist2` (ventes,
  `Fiches_Tvaav`) / `Tvalist` (achats, `Fiches_Tvaac`), en fermant l'autre.
- **`Tvalist2_KeyPress`/`Tvalist2_Click`, `Tvalist_KeyPress`/`tvalist_Click`** [handlers] : choix
  du code (code, taux, case « générer » cochée), Échap/F2 ferme, F1 aide.
- **`Tvaveman()` / `Tvaacman()`** [portée : réductible] [nature : mixte] : `SELECT * FROM
  Fiches_Tvaav|Tvaac where code_tva = &1` ; renseigne le taux, `Enr` = 0/1.

### Sous-comptes (ventilation)

- **`ToggleButton1_Click()`** [handler] : `TriCpt(TriCpt.General, TriCpt.Sans_Solde, Me)` → `Compt`
  (`Type = "G"`, `Type2 = "B"` affectés pour rien).
- **`Button6_Click()`** [handler] : `Ventilman()` puis, si valide, UPDATE ou INSERT dans
  `Fiches_SousComptes` (`code`, `code_vtl`, `intitule_vtl`) ; l'UPDATE `WHERE code_vtl = &2`
  **rattache** au compte courant un sous-compte déjà rattaché à un autre compte.
- **`Vents_KeyPress()`** [handler] : pose la question « vous allez supprimer » **à chaque touche**,
  puis ne supprime que si la touche était Suppr (anomalie A01).
- **`Ventilations()`** [portée : réductible] : liste des sous-comptes, SQL **concaténé**
  (`WHERE code = '<code>'`).
- **`CleanVtl()`** [portée : réductible] : vide `Compt` et `intitule`.
- **`Ventilman()`** [portée : réductible] : compte de ventilation existant, ni `C`/`F` ni collectif ;
  `Enr` = 0/1.

### Analytique

- **`Cmpt3_GotFocus`/`Cmpt3_LostFocus`** [handlers, groupe `Cmpt3`] : `ObsGotf`/`ObsLstf`.
- **`Cmpt3_KeyPress()`** [handler] : Entrée/Tab sur le pourcentage (tag 3) → `Vnt_Click` ; le test F1
  est imbriqué dans le test Entrée (inaccessible) ; Entrée sur `Compt` et `Poste` ne fait rien.
- **`ToggleButton4_Click()`** [handler] : liste `Colposte` des postes (`<TabPostes>`).
- **`Colposte_Click()`** [handler] : recopie le poste.
- **`TabStrip1_Click()`** [handler] : focus sur le poste si l'onglet analytique est visible.
- **`Vnt_Click()`** [handler, groupe `Vnt`] : INSERT ou UPDATE `<TabAna>` (`code`, `compte`,
  `pourcent`), puis `Aff_Analytique` ; `Catch` → message.
- **`Aff_Analytique()`** [portée : réductible] : jointure `<TabAna>` × `<TabPostes>` du compte, total
  des pourcentages dans `Totposte` (texte).
- **`Postes_KeyPress()`** [handler] : même défaut que `Vents_KeyPress` (question à chaque touche).
- **`Quitter_Postes()`** [portée : réductible] : `Qpostes = False` si le total n'est pas `"100"`
  (comparaison de texte) et n'est pas `"0"` ; `True` seulement si le total vaut `"100"` avec au moins
  un poste. Un total revenu à `"0"` laisse `Qpostes` inchangé : après un état déséquilibré, vider la
  répartition bloque la fermeture et le changement de compte (A02).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.ObsGotf`/`ObsLstf`, `Utils.Obstch`, `Utils.convBool`,
  `Utils.PointBase` ; `Ccomptes` (grille) ; `Cbase.Table` (`TabComptes`, `TabFam`, `TabPostes`,
  `TabAna`) ; `TriCpt` ; `Doc`.
- `Start.LocalSettings["/Soc<XX>/Analytique"]`, `Start.Societe`, `Start.Son`, `Start.Musique`.
- Membres : `Enr` (drapeau partagé), `Qpostes`, `Tri`, `sel`, `Dbl`, `Type` ; `soldec`, `Ncode`,
  `Type2` sans lecture utile ; `Bsel`/`Bval` écrits par `TriCpt`.
- Tables en dur : `Fiches_Comptes`, `Fiches_Mvt…Mvt5`, `Fiches_MvtM…MvtM5`, `Fiches_SousComptes`,
  `Fiches_Tvaav`, `Fiches_Tvaac`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Button2_Click` : extraire `TypeParNumero(sCode, sType) As String` (règle des tranches) et
  `EnregistreCompte(...)` ; CC 48 → ≤ 15.
- `Button1_Click` : `CompteMouvemente(sCode) As Boolean` qui construit les deux `UNION` par boucle sur
  `Cbase.Table("TabMvt")`, `"TabMvt1"`… (même texte SQL).
- Fusionner les paires TVA (`ToggleButton2/3`, `Tvalist2_*`/`Tvalist_*`, `Tvaveman`/`Tvaacman`) en
  procédures paramétrées par la table et les contrôles.
- Fusionner `Co_*`/`Intit_*` en une procédure `ChoixTri(sTri, …)`.

### Commonalisation avec d'autres fichiers

- `cpoint`, `lpad`, `Cdate_EXT` : supprimées (équivalents dans [Utils](../../../Utils/Utils.module/architecture.md)).
- `CompteMouvemente` serait réutilisable par [FCollectif](../FCollectif.class/architecture.md)
  (contrôle incomplet là-bas, anomalie FCOLLECTIF-A03).
- Règles de collectif (`collman`) à partager avec FCollectif, FClient, FFournisseur.
- Listes de TVA : mêmes données que [FTvav](../FTvav.class/architecture.md) /
  [FTvac](../FTvac.class/architecture.md) ; liste des postes comme [FPostes](../FPostes.class/architecture.md).
- Ouverture modale de l'auto-instance par Saisecrit/Tresor/Parametre : un point d'entrée
  `FComptes.Creer(sCode)` permettrait de préremplir le code (évolution, hors rework).

### Réduction de portée

`Maj_Zones`, `cleanChamps`, `Refresh`, `Tvaveman`, `Tvaacman`, `Comptman`, `Tris`, `Dbclk`, `Ref`,
`Ventilations`, `CleanVtl`, `Ventilman`, `Aff_Analytique`, `Quitter_Postes`, `collman` → `Private`
(aucun appelant externe ; les appelants externes n'utilisent que `Show`/`ShowModal`). `Bsel`/`Bval`
restent `Public`.

### Séparation traitement / GUI

- `TypeParNumero`, `EnregistreCompte`, `CompteMouvemente`, `SupprimeCompte` sans contrôle.
- `LitCompte(sCode) As Result` partagé par `Maj_Zones` et `Comptman`.
- `RepartitionEquilibree(fTotal, iNb) As Boolean` pour `Quitter_Postes` (gbtest), sans changer la
  règle actuelle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clés étrangères vers `Fiches_Comptes.compte_cc` (familles, TVA, journaux, sous-comptes,
  analytique, écritures) : la suppression serait contrôlée par la base.
- Colonnes booléennes (`cent_cc`, `comptr_cc`, `coll`, `gen_tv`, `gen_ta`, `cprincipal`,
  `lettrable`) en type booléen homogène.
- `taux_tvente`/`taux_tachat` dupliqués depuis les tables TVA : jointure à la place.
- Clé `Fiches_SousComptes(code_vtl)` explicite (un sous-compte n'a qu'un compte principal).
