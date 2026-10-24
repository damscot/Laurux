# Famille — Architecture

> Source : `.src/Gestion/Tables/Famille.class`

## Vue d'ensemble

`Famille` est l'**écran de gestion de la table des familles d'articles** (`Fiches_Fam`, clé
`Cbase` `TabFam`). Pour une famille : libellé, coefficient de vente, remise, code et taux de
TVA (`Fiches_Tvaav`), comptes de vente (`compt_fam`, `compt2_fam`, `compt4_fam`,
`compt5_fam`), compte d'achat (`compt3_fam`, comptes de classe 6), compte de remise (709),
éco-taxe, et une grille de **remises par quantité** (`Tbrem`, 6 tranches `qteN`/`qteN+1`/`remN`).
Avec l'option dépôts (`/Soc<XX>/Depots`), le compte de vente peut être spécifique à un dépôt
(`Fiches_FamDep`). L'onglet « Statistiques » est fourni par
[`gridvi`](../../../Utils/gridvi.class/architecture.md) (type `F`).

Ouvert depuis le menu (`Fmenu:875`, `Famille.Show`) et depuis la fiche article
(`Articles:1290`, `Famille.ShowModal`) : auto-instance du formulaire.

Les zones de saisie appartiennent au **groupe d'événements `fam`** (`Coef`, `Remise`, `Cdtva`,
`Codecompt` à `Codecompt5`, `Cmptrem`, `Ecotx`, `Libelfam`, et la liste `Colcompt2`) : les
handlers nominaux `Coef_LostFocus`, `Remise_LostFocus`, `Ecotx_LostFocus`, `Colcompt2_KeyPress`
ne sont **pas levés** par Gambas ; les trois premiers sont appelés explicitement par
`fam_lostfocus` et `Button1_Click` selon le `Tag` du contrôle.

Nature : **mixte**, logique et SQL dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$iRow` | var | Private |  | Integer | 27 |
| `$iColumn` | var | Private |  | Integer | 28 |
| `CoulZns` | var | Private |  | Integer | 29 |
| `CoulFoc` | var | Private |  | Integer | 30 |
| `CoulCol` | var | Private |  | Integer | 31 |
| `son` | var | Private |  | Integer | 32 |
| `b` | var | Private |  | Integer | 33 |
| `AncT` | var | Private |  | String | 34 |
| `Org` | var | Private |  | String | 35 |
| `$grdv` | var | Private |  | Gridvi | 36 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 38-108 | Public | 6 | 66 | 0 | méthode spéciale |
| `TBfam_click` | 110-114 | Public | 1 | 3 | 0 | handler GUI |
| `Form_Open` | 116-137 | Public | 6 | 18 | 0 | handler GUI |
| `Refresh` | 139-145 | Public | 1 | 5 | 0 | portée réductible ? |
| `Maj_Zones` | 147-196 | Public | 23 | 47 | 0 | portée réductible ? |
| `Dep_Click` | 199-208 | Public | 3 | 7 | 0 | handler GUI |
| `tbrem_Click` | 216-226 | Public | 1 | 9 | 0 | handler GUI |
| `tbxrem_KeyPress` | 229-259 | Public | 5 | 24 | 0 | handler GUI |
| `MoveTo` | 262-275 | Public | 5 | 12 | 0 | portée réductible ? |
| `ShowTextBox` | 278-301 | Public | 9 | 21 | 0 | portée réductible ? |
| `HideTextBox` | 304-335 | Public | 13 | 28 | 0 | portée réductible ? |
| `Cleanchamps` | 337-348 | Public | 1 | 10 | 0 | portée réductible ? |
| `Button2_Click` | 350-354 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 356-439 | Public | 28 | 78 | 0 | handler GUI |
| `Colfam_Click` | 441-445 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 447-483 | Public | 8 | 34 | 0 | handler GUI |
| `ToggleButton2_Click` | 485-490 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton4_Click` | 492-497 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton3_Click` | 499-504 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton5_Click` | 506-511 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton6_Click` | 513-518 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton7_Click` | 520-525 | Public | 1 | 4 | 0 | handler GUI |
| `AffCpt` | 527-562 | Public | 6 | 33 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 564-602 | Public | 6 | 36 | 0 | handler GUI |
| `Colcompt_Click` | 604-629 | Public | 7 | 24 | 0 | handler GUI |
| `Colcompt_KeyPress` | 634-649 | Public | 5 | 14 | 0 | handler GUI |
| `Colcompt2_Click` | 651-659 | Public | 1 | 7 | 0 |  |
| `Colcompt2_KeyPress` | 661-682 | Public | 6 | 18 | 0 | portée réductible ? |
| `Tvalist2_Click` | 684-693 | Public | 1 | 8 | 0 | handler GUI |
| `Tvalist2_KeyPress` | 698-719 | Public | 6 | 18 | 0 | handler GUI |
| `Coef_LostFocus` | 721-740 | Public | 3 | 17 | 0 | portée réductible ? |
| `Remise_LostFocus` | 742-759 | Public | 4 | 16 | 0 | portée réductible ? |
| `Ecotx_LostFocus` | 762-781 | Public | 4 | 18 | 0 | portée réductible ? |
| `Fam_GotFocus` | 786-803 | Public | 7 | 13 | 0 | handler GUI |
| `Test_Tva` | 805-834 | Public | 5 | 26 | 0 | portée réductible ? |
| `fam_lostfocus` | 836-868 | Public | 13 | 31 | 0 | handler GUI |
| `fam_KeyPress` | 870-945 | Public | 20 | 58 | 0 | handler GUI |
| `Btn_KeyPress` | 947-956 | Public | 2 | 6 | 0 | portée réductible ? |
| `compteGman` | 961-976 | Public | 3 | 13 | 0 | portée réductible ? |
| `Button5_Click` | 981-985 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture et affichage

- **`_New()`** [portée : nécessaire (spéciale)] [GUI]. Couleurs du thème (`/Coul/Focus`,
  `/Coul/Znss`, `/Coul/Znaff`), `Utils.Observers(Me)`, colonnes de `colFam` (5 colonnes, titre
  TVA tiré de `/Soc<XX>/Taxe`), grilles `Tbrem` (6 × 3) et `Tbrem2` (titres « Remise n » : six
  affectations identiques par ligne), `Gridvi` type `F`, liste des dépôts
  (`Cbase.Table("TabDepots")`, sauf codes `01…`) si l'option dépôts est active.
- **`TBfam_click()`** [handler] [GUI]. Rappelle `Utils.Observers(Me)` à **chaque** clic sur un
  onglet : les `ReplayObserver` sont recréés (doublons dans le journal de rejeu, voir
  UTILS-A08) et les couleurs réappliquées.
- **`Form_Open()`** [handler] [mixte]. `SELECT * FROM <TabFam> order by code_fam` ; remplit
  `colFam`, y compris des colonnes 5 à 8 (`cdtva_fam`, `cptrem_fam`, `ect_fam`, `rem_fam`) alors
  que la vue n'a que 5 colonnes (textes non affichés, à confirmer).
- **`Refresh()`** [portée : réductible] [GUI]. Vide `colFam`, `Form_Open`, `Maj_Zones`.
- **`Maj_Zones()`** (CC 23 par les `Try`) [portée : réductible] [mixte]. Relit la famille
  sélectionnée (`where code_fam = &1`, sans test `Available`), remplit les zones et `Tbrem`,
  rafraîchit les statistiques (`$grdv.bouton_Click`), lit le compte du dépôt
  (`Fiches_FamDep`). `Catch` vide : toute erreur est ignorée.
- **`Dep_Click()`** [handler] [mixte]. Compte de vente du dépôt choisi (`Fiches_FamDep`).
- **`Colfam_Click()`** [handler, `replay_dynamic`] [GUI]. `Maj_Zones`.

### Grille des remises par quantité

- **`tbrem_Click`**, **`tbxrem_KeyPress`** [handlers] et **`MoveTo`**, **`ShowTextBox`**,
  **`HideTextBox`** [portée : réductible] [GUI]. Édition cellule par cellule d'une `TableView`
  par une `TextBox` superposée (flèches, Entrée, Tab). La valeur mini d'une tranche est
  proposée à « maxi de la tranche précédente + 0,01 » ; formats `0.00` (quantités) et `0.000`
  (remises) ; plafond 9 999 999,99 ; valeur nulle effacée (sauf cellule [0,0], toujours `0,00`).
  Même mécanisme dans `Articles` et `Txmo`.

### Saisie des zones (groupe `fam`)

- **`Fam_GotFocus()`** [handler du groupe] [GUI]. `Utils.SetEditColor`, valeurs par défaut
  (coefficient `1,000`, remise `0,000`, éco-taxe `0,00`) selon le `Tag`.
- **`fam_lostfocus()`** (CC 13) [handler du groupe] [mixte]. Selon le `Tag` : libellé
  (`Utils.Remplace`), `Coef_LostFocus`, `Remise_LostFocus`, `Test_Tva`, contrôle d'existence
  des comptes (`compteGman`) et du préfixe 709 du compte de remise, `Ecotx_LostFocus`.
- **`fam_KeyPress()`** (CC 20) [handler du groupe] [GUI]. Entrée/Tab : zone suivante selon le
  `Tag` ; F1 : aide ; F2 : listes (tag 5 TVA, tag 6 comptes de vente → `Codecompt`).
  ⚠️ Tag 7 (`Codecompt2`) ouvre la liste pour le **compte de remise** (`ToggleButton3_click`,
  `Org = "Cmptrem"`) ; F2 est sans effet sur les autres comptes.
- **`Coef_LostFocus`, `Remise_LostFocus`, `Ecotx_LostFocus`** [portée : nécessaire (nom de
  handler conservé), jamais levés, appelés par `fam_lostfocus`/`Button1_Click`] [mixte].
  Normalisation (`Utils.cpoint`, `Format$`), message et remise à blanc si invalide.
- **`Test_Tva()`** [portée : réductible] [mixte]. Interdit le changement de code TVA si des
  articles de la famille ont l'ancien code (`<TabArt> WHERE art_tva = &1 and art_fam = &2`) ;
  vérifie le code dans `<TabTvav>` et recopie le taux. Communique par la variable `b`.
- **`compteGman(compt)`** [portée : réductible] [mixte]. Existence du compte
  (`<TabComptes> WHERE compte_cc = &1`) ; `b = 1` sinon.

### Listes de choix

- **`ToggleButton2..7_Click`** [handlers] → `Org` + **`AffCpt()`** [portée : réductible]
  [mixte] : liste des comptes de classe 7 (classe 6 pour `Codecompte3`), `left(compte_cc,1)`.
- **`Colcompt_Click` / `Colcompt_KeyPress`** [handlers, `Colcompt_Click` en `replay_dynamic`]
  [GUI]. Recopie le compte dans la zone d'origine (`Org`) et passe à la zone suivante.
- **`ToggleButton1_Click`**, **`Tvalist2_Click`** (`replay_dynamic`), **`Tvalist2_KeyPress`**
  [handlers] [mixte]. Liste des codes TVA (`<TabTvav>`).
- **`Colcompt2_Click`** (`replay_dynamic`) et **`Colcompt2_KeyPress`** [handler inactif] :
  `Colcompt2` est dans le groupe `fam` (son `KeyPress` est traité par `fam_KeyPress`) et n'est
  **jamais rendu visible** (`Visible = False` dans le `.form`, aucun `Visible = True`) :
  `Colcompt2_KeyPress` n'est jamais levé et `Colcompt2_Click` n'est appelé que par lui. Code mort.

### Boutons

- **`Button1_Click()`** (CC 28, max du fichier) [handler] [mixte]. Enregistrement : `Test_Tva`,
  `Coef_LostFocus`, `Ecotx_LostFocus`, nettoyage du libellé ; champs obligatoires (code,
  coefficient, TVA, compte, compte de remise) ; compte de remise en 709 ; puis
  `UPdate <TabFam>` en deux requêtes (19 puis 13 paramètres `&{n}`) ou `INSERT` (31 colonnes) ;
  `Serveur.Pass("Fam", "M"|"C", code)` si `Variables.Sprix And Sexport And SMajArt` ; mise à jour
  ou insertion de `Fiches_FamDep` (**même sans option dépôts** : ligne avec `depot = ''`) ;
  `Refresh`, `Cleanchamps`, repositionnement. Variables `b`/`bb` (`bb` déclarée `String`,
  comparée à 1) et `With Utils` rendent le flux difficile à lire ; les branches `compteGman`
  sont commentées.
- **`Button3_Click()`** [handler] [mixte]. Suppression après confirmation, refusée si des
  articles (`<TabArt>`) ou des mains d'œuvre (`<TabMo>`) utilisent le code **saisi** ; supprime
  la famille **sélectionnée** dans `colFam` (`colFam.Current[0]`). ⚠️ Refus : le pointeur reste
  en attente (`Mouse.Wait` jamais rétabli) ; les lignes `Fiches_FamDep` ne sont pas supprimées ;
  pas de `Serveur.Pass` (à confirmer).
- **`Btn_KeyPress()`** : aucun contrôle ni groupe `Btn` dans le `.form` : jamais levé, code mort.
- **`Button2_Click`** (fermer), **`Button5_Click`** (`Doc.Open("Familles")`), **`Cleanchamps`**
  [portée : réductible].

## État global utilisé

- `Start.LocalSettings` : `/Coul/Focus`, `/Coul/Znss`, `/Coul/Znaff`, `/Soc<XX>/Taxe`,
  `/Soc<XX>/Depots`, `/Soc<XX>/Coul_fen` ; `Start.Son`, `Start.Musique`, `Start.Societe`.
- `Variables.Sprix`, `Variables.Sexport`, `Variables.SMajArt` ; `Serveur.Pass`.
- `Utils.db`, `Utils.Observers`, `Utils.FColr`, `Utils.SetEditColor`, `Utils.cpoint`,
  `Utils.PointBase`, `Utils.Remplace` ; `Doc.Open`.
- Tables : `Fiches_Fam`, `Fiches_Art`, `Fiches_Mo`, `Fiches_Comptes`, `Fiches_Tvaav`,
  `Fiches_Depots` (via `Cbase`), `Fiches_FamDep` (en dur, pas de clé `Cbase`).
- Membres : `b` (drapeau d'erreur partagé entre fonctions), `AncT` (ancien code TVA), `Org`
  (zone cible de la liste des comptes), `$iRow`/`$iColumn`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Button1_Click` : extraire `EnregistreFamille()` (deux `UPdate` ou un `INSERT`, puis
  `Fiches_FamDep`) et remplacer le drapeau global `b` par des fonctions qui renvoient un
  booléen (`Test_Tva`, `compteGman`).
- Les 6 lignes `Tbrem[n, 0/1/2]` de `Maj_Zones` et les 36 paramètres de `Button1_Click` :
  boucle sur l'indice de tranche (noms de colonnes `qte(2n+1)`, `qte(2n+2)`, `rem(n+1)`) ;
  le texte SQL produit doit rester identique.
- `_New` : supprimer les 5 affectations répétées de `Tbrem2.Rows[n].text`.

### Commonalisation avec d'autres fichiers

- Édition d'une `TableView` par `TextBox` superposée (`MoveTo`, `ShowTextBox`, `HideTextBox`,
  `tbxrem_KeyPress`) : copie dans [`Articles`](../Articles.class/architecture.md) et
  [`Txmo`](../Txmo.class/architecture.md) → composant commun.
- Liste des comptes (`ToggleButton*` + `AffCpt` + `Colcompt_*`) et contrôle `compteGman` :
  même patron dans [`FTvac`](../../../Compta/Tables/FTvac.class/architecture.md),
  [`FTvav`](../../../Compta/Tables/FTvav.class/architecture.md),
  [`FJournaux`](../../../Compta/Tables/FJournaux.class/architecture.md),
  [`Saisecrit`](../../../Compta/Saisecrit.class/architecture.md) (`compteGman`).
- Liste des familles (`Colfam`) : mêmes requêtes dans
  [`CoefTypeC`](../CoefTypeC.class/architecture.md), [`Remisec`](../Remisec.class/architecture.md),
  [`Remisecli`](../Remisecli.class/architecture.md).
- `Fiches_FamDep` est aussi lu par `Moulinage` (compte de vente par dépôt) : une fonction
  `CompteFamilleDepot(fam, depot)` éviterait la duplication.

### Réduction de portée

- `Refresh`, `Maj_Zones`, `MoveTo`, `ShowTextBox`, `HideTextBox`, `Cleanchamps`, `AffCpt`,
  `Test_Tva`, `compteGman` : aucun appel externe (vérifié par `grep -rn`) → `Private`.
- `Coef_LostFocus`, `Remise_LostFocus`, `Ecotx_LostFocus` : noms de handlers (contrôles du
  groupe) conservés et `Public` (règle des handlers, même inactifs).
- `Colfam_Click`, `Colcompt_Click`, `Colcompt2_Click`, `Tvalist2_Click` : `replay_dynamic`,
  restent `Public`.

### Séparation traitement / GUI

- `EnregistreFamille(valeurs)`, `SupprimeFamille(code) As String` (motif de refus ou `""`),
  `FamilleUtilisee(code)`, `TvaModifiable(famille, ancienCode)` sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les remises par quantité occupent 18 colonnes (`qte1`…`qte12`, `rem1`…`rem6`) : une table
  `Fiches_FamRemQte(fam, tranche, mini, maxi, remise)` serait plus simple.
- `txtva_fam` recopie le taux de `Fiches_Tvaav` : une jointure sur `cdtva_fam` suffirait.
- Clé `Cbase` absente pour `Fiches_FamDep` ; clé étrangère `fam` → `Fiches_Fam` (suppression en
  cascade).
