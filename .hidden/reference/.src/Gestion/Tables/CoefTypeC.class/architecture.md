# CoefTypeC — Architecture

> Source : `.src/Gestion/Tables/CoefTypeC.class`

## Vue d'ensemble

`CoefTypeC` gère la table des **coefficients de vente par type de client et par famille**
(`Fiches_CoeffTypec`, clé `Cbase` `TabCtcli` : `lind`, `coder` = type client, `codef` = famille,
`coeff`). Ces coefficients sont lus par [`TarArt`](../../../Utils/TarArt.class/architecture.md)
(« coeff de marge par famille et type client »), `Facture` et `EdArt3`.

Ouvert depuis le menu (`Fmenu:2248`, `CoefTypeC.Show()`) ou depuis la fiche article
(`Articles:4560`, `CoefTypeC.ShowModal()`) ; dans ce second cas `Articles` positionne
`Variables.OrgCoefTypeCli = "Art"` et les données de l'article (`ArtCode`, `Artintitule`,
`ArtTva`, `ArtHt`) : le panneau `Panel1` affiche alors le prix de vente que donnerait le
coefficient sélectionné.

Structure : liste `TabTypec` (`ColumnView`), zones `Cdt` (type), `Cdf` (famille, contrôle
`textfamille`), `Coeff`, listes de choix `Coltype`/`Colfam`, boutons Enregistrer / Supprimer.
Les zones sont dans le groupe d'événements `rem` (`Rem_KeyPress`). Même gabarit que
[`Remisec`](../Remisec.class/architecture.md) (remises par type de client et famille).

Nature : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `CoulZns` | var | Private |  | Integer | 27 |
| `CoulfOC` | var | Private |  | Integer | 28 |
| `$lind` | var | Private |  | String | 29 |
| `son` | var | Private |  | Integer | 30 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 32-45 | Public | 1 | 10 | 0 | méthode spéciale |
| `Form_Open` | 47-72 | Public | 2 | 23 | 0 | handler GUI |
| `Maj_TabTypec` | 74-96 | Public | 5 | 20 | 0 | portée réductible ? |
| `Cleanchamps` | 98-112 | Public | 1 | 13 | 0 | portée réductible ? |
| `Tabtypec_Select` | 114-120 | Public | 1 | 2 | 0 | handler GUI |
| `ToggleButton1_Click` | 122-149 | Public | 4 | 25 | 0 | handler GUI |
| `Coltype_Click` | 151-160 | Public | 1 | 8 | 0 | handler GUI |
| `ToggleButton2_Click` | 162-189 | Public | 4 | 25 | 0 | handler GUI |
| `Colfam_Click` | 191-200 | Public | 1 | 8 | 0 | handler GUI |
| `Quitte_Cdt` | 202-227 | Public | 3 | 20 | 0 | portée réductible ? |
| `Quitte_Cdf` | 229-255 | Public | 3 | 21 | 0 | portée réductible ? |
| `Quitte_Coeff` | 257-273 | Public | 2 | 15 | 0 | portée réductible ? |
| `Button2_Click` | 275-294 | Public | 4 | 17 | 0 | handler GUI |
| `Button3_KeyPress` | 296-300 | Public | 4 | 3 | 0 | handler GUI |
| `Button3_Click` | 302-332 | Public | 9 | 26 | 0 | handler GUI |
| `Rem_KeyPress` | 334-351 | Public | 10 | 13 | 0 | handler GUI |
| `Button4_Click` | 353-357 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 362-366 | Public | 1 | 3 | 0 | handler GUI |
| `Tabtypec_Click` | 368-378 | Public | 3 | 9 | 0 | handler GUI |
| `AffProduit` | 380-395 | Public | 2 | 13 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [GUI]. Couleurs `CoulFoc`/`CoulZns` (calculées,
  **jamais utilisées**), `Utils.Observers(Me)`, musique, centrage.
- **`Form_Open()`** [handler] [GUI]. Colonnes de `TabTypec` ; `Panel1` visible si
  `Variables.OrgCoefTypeCli = "Art"` ; `Maj_TabTypec`. Variable `Frmt` inutilisée.
- **`Maj_TabTypec()`** [portée : réductible] [mixte]. `select * from <TabCtcli> As e inner join
  <TabTypec> As a on a.code = e.coder` ; ajout des lignes (`Try`, doublons ignorés) ; focus sur
  `Cdt` (deux fois).
- **`Cleanchamps()`** [portée : réductible] [GUI]. Vide les zones et réinitialise les libellés du
  panneau article. ⚠️ Les libellés ne correspondent pas à ceux d'`AffProduit` (`Label4` reçoit
  « PA HT : » au lieu de « Coeff : », `Label6` « Coeff : » au lieu de « PV HT : », `Label2` n'est
  pas réinitialisé).
- **`Tabtypec_Select()`** [handler] — corps vide (trois appels commentés) : sans effet.
- **`Tabtypec_Click()`** [handler, `replay_dynamic`] [mixte]. Recopie la ligne dans les zones,
  mémorise `$lind`, `Quitte_Cdf`, puis `AffProduit` en mode article.
- **`AffProduit()`** [portée : réductible] [nature : calcul + GUI]. PV HT = `ArtHt × coeff`, PV
  TTC = PV HT × (1 + `ArtTva` / 100), arrondis à 2 décimales par `Format$` ; calcul en chaînes
  (`Val`/`Utils.cpoint`/`Format$`) et variable `Pvht` déclarée `String` mais affectée d'un
  `Float`.
- **`ToggleButton1_Click` / `Coltype_Click`** [handlers, `Coltype_Click` en `replay_dynamic`]
  [mixte]. Liste des types (`<TabTypec>`).
- **`ToggleButton2_Click` / `Colfam_Click`** [handlers, `Colfam_Click` en `replay_dynamic`]
  [mixte]. Liste des familles (`<TabFam>`).
- **`Quitte_Cdt()`**, **`Quitte_Cdf()`**, **`Quitte_Coeff()`** [portée : réductible] [mixte].
  Existence du type (`Fiches_Typec` en dur), de la famille (`Fiches_Fam` en dur), validité du
  coefficient ; `Balloon.Warning` + `Stop Event` + focus en cas d'erreur ; libellé et zone
  suivante sinon. **Aucune valeur de retour.**
- **`Rem_KeyPress()`** [handler du groupe `rem`] [GUI]. Entrée/Tab : `Quitte_*` selon le `Tag`
  (1 type, 2 famille, 3 coefficient).
- **`Button3_Click()`** / **`Button3_KeyPress()`** [handlers] [mixte]. Enregistrement : appelle
  les trois `Quitte_*` puis, **quel que soit leur résultat**, `UPdate` ou `INSERT` dans
  `Fiches_CoeffTypec` (nom en dur dans `Tab`) avec `Val(Utils.cpoint(Coeff))` ; un type ou une
  famille inexistants sont donc enregistrés (coefficient invalide → `NULL`). Message si
  l'insertion échoue. Variable `skey` sans effet (repositionnement commenté).
- **`Button2_Click()`** [handler] [mixte]. Suppression de la ligne `$lind` (`<TabCtcli>`), après
  confirmation ; variable `Tab` inutilisée.
- **`Button4_Click`** (fermer), **`Button1_Click`** (`Doc.Open("CoefTypeclient")`).

## État global utilisé

- `Variables.OrgCoefTypeCli`, `Variables.ArtCode`, `Variables.Artintitule`, `Variables.ArtHt`,
  `Variables.ArtTva` (écrits par `Articles.Button9_Click`). ⚠️ `OrgCoefTypeCli` n'est **jamais
  remis à vide** : après une ouverture depuis un article, l'ouverture depuis le menu affiche
  encore le panneau article avec les données périmées.
- `Start.LocalSettings["/Coul/…"]`, `Start.Son`, `Start.Musique`, `Utils.Observers`,
  `Utils.FColr`, `Utils.cpoint`, `Doc.Open`.
- Tables : `Fiches_CoeffTypec` (via `Cbase` et en dur), `Fiches_Typec` (via `Cbase` et en dur),
  `Fiches_Fam` (via `Cbase` et en dur).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Quitte_Cdt`/`Quitte_Cdf`/`Quitte_Coeff` → fonctions booléennes (même affichage), testées par
  `Button3_Click` **seulement après validation de l'anomalie A01** ; en rework, seul le
  regroupement du code est possible.
- Supprimer `CoulZns`/`CoulFoc`, `Frmt`, `Tab`/`skey` inutilisés, `Tabtypec_Select` vide.

### Commonalisation avec d'autres fichiers

- [`Remisec`](../Remisec.class/architecture.md) est une copie au nom de table et de colonne près
  (`Fiches_RemTypec.remise` au lieu de `Fiches_CoeffTypec.coeff`) : `ToggleButton1/2_Click`,
  `Coltype_Click`, `Colfam_Click`, `Quitte_Cdt`, `Quitte_Cdf`, `Quitte_Coeff`/`Quitte_Remise`,
  `Button2/3_Click`, `Button3_KeyPress`, `Rem_KeyPress`, `Cleanchamps` → module ou classe de base
  commune paramétrée (table, colonne de valeur, libellés), avec
  [`Remisecli`](../Remisecli.class/architecture.md) (client au lieu du type).
- Listes des familles et des types : aussi dans [`Famille`](../Famille.class/architecture.md),
  [`TarTypeCli`](../TarTypeCli.class/architecture.md).
- Calcul `AffProduit` (prix de revient × coefficient + TVA) : même règle que
  [`TarArt`](../../../Utils/TarArt.class/architecture.md) et que la cascade `LPrix` de
  [`GesTar`](../../Entrées/GesTar.class/architecture.md), mais en chaînes et avec arrondi à 2
  décimales (écart d'arrondi possible).

### Réduction de portée

- `Maj_TabTypec`, `Cleanchamps`, `Quitte_Cdt`, `Quitte_Cdf`, `Quitte_Coeff`, `AffProduit` : aucun
  appel externe (vérifié par `grep -rn`) → `Private`.
- `Coltype_Click`, `Colfam_Click`, `Tabtypec_Click` : `replay_dynamic`, restent `Public`.

### Séparation traitement / GUI

- `EnregistreCoef(type, famille, coeff)`, `SupprimeCoef(lind)`, `PrixProduit(pa, coeff, tva)`
  (calcul pur de `AffProduit`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Pas de contrainte d'unicité sur `(coder, codef)` (clé `lind` auto-incrémentée) : l'unicité est
  assurée par l'application ; un index unique la garantirait.
- Clés étrangères `coder` → `Fiches_Typec.code`, `codef` → `Fiches_Fam.code_fam`.
