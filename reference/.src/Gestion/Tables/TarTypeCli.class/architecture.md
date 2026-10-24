# TarTypeCli — Architecture

> Source : `.src/Gestion/Tables/TarTypeCli.class`

## Vue d'ensemble

`TarTypeCli` est l'écran des **tarifs particuliers par client ou par type de client** : pour un
client (`Fiches_Tarcli`, colonne `ccli`) ou un type de client (`Fiches_TarTypcli`, colonne
`type`), il liste les articles qui ont un coefficient particulier et permet d'en saisir, d'en
modifier et d'en supprimer. Le mode est fixé à la construction par l'énumération publique
`client` / `type` (`$choix`).

Points d'entrée : `Fmenu:2190,2199` (`New TarTypeCli(TarTypeCli.client|type)`),
`FClient:3263,3273` (client ou type du client courant), `Articles:4536,4546` (article courant).

La partie haute affiche la liste (`TriGen` dans le panneau `Lstart`, colonnes calculées en SQL :
prix HT `art_prvt × coef`, TTC, remise par rapport au prix public `art_pvht`, marge). La partie
basse est un formulaire de saisie (prix de revient, coefficient, PV HT, PV TTC, remise, prix
public) dont les zones se recalculent par une cascade
[`LPrix`](../../../Utils/LPrix.class/architecture.md) + [`LTaxe`](../../../Utils/LTaxe.class/architecture.md)
(`$lpx As "LPrix"`, handler `LPrix_change`).

Nature : **mixte** ; SQL en dur (aucune clé `Cbase` sauf `TabTypec`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `client` | enum | Public | oui |  | 3 |
| `type` | enum | Public | oui |  | 3 |
| `Bsel` | var | Public |  | Boolean | 4 |
| `Bval` | var | Public |  | String | 5 |
| `son` | var | Private |  | Integer | 7 |
| `Dbl` | var | Private |  | Boolean | 8 |
| `Col` | var | Private |  | Collection | 9 |
| `trb` | var | Private |  | TriGen | 10 |
| `$lpx` | var | Private |  | LPrix | 11 |
| `$resart` | var | Private |  | Result | 12 |
| `$ttc` | var | Private |  | Float | 13 |
| `$choix` | var | Private |  | Integer | 14 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 16-57 | Public | 4 | 38 | 0 | méthode spéciale |
| `Button4_click` | 63-102 | Public | 6 | 37 | 0 | handler GUI |
| `Typec_LostFocus` | 108-112 | Public | 2 | 3 | 0 | handler GUI |
| `Typec_KeyPress` | 114-121 | Public | 4 | 6 | 0 | handler GUI |
| `Coltype_KeyPress` | 123-131 | Public | 4 | 7 | 0 | handler GUI |
| `Coltype_Click` | 133-142 | Public | 1 | 8 | 0 | handler GUI |
| `TypeC_man` | 144-165 | Public | 4 | 19 | 0 | portée réductible ? |
| `Aff_Tarart` | 167-235 | Public | 5 | 64 | 0 | portée réductible ? |
| `ColTri_MajSel` | 237-250 | Public | 3 | 12 | 0 | handler GUI |
| `Button5_click` | 256-260 | Public | 1 | 3 | 0 | handler GUI |
| `Tart_KeyPress` | 262-267 | Public | 3 | 4 | 0 | handler GUI |
| `Tart_LostFocus` | 269-285 | Public | 4 | 14 | 0 | handler GUI |
| `SelectionArt` | 287-302 | Public | 2 | 13 | 0 | portée réductible ? |
| `Art_man` | 307-336 | Public | 8 | 27 | 0 | portée réductible ? |
| `AffLig` | 338-354 | Private | 2 | 14 | 0 |  |
| `Calc_Remise` | 359-366 | Public | 2 | 5 | 0 | portée réductible ? |
| `Button2_Click` | 368-372 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 374-387 | Public | 3 | 11 | 0 | handler GUI |
| `Button6_Click` | 389-422 | Public | 5 | 30 | 0 | handler GUI |
| `Refresh` | 424-432 | Public | 1 | 7 | 0 | portée réductible ? |
| `Button6_KeyPress` | 434-438 | Public | 3 | 3 | 0 | handler GUI |
| `button6_GotFocus` | 440-444 | Public | 1 | 3 | 0 | handler GUI |
| `Tcoeff_Lostfocus` | 446-459 | Public | 4 | 11 | 0 | handler GUI |
| `ColTri_KeyPress` | 461-476 | Public | 6 | 14 | 0 | handler GUI |
| `Tpvht_LostFocus` | 481-490 | Public | 2 | 7 | 0 | handler GUI |
| `Remise_LostFocus` | 492-505 | Public | 2 | 11 | 0 | handler GUI |
| `TpvTTc_LostFocus` | 509-519 | Public | 3 | 8 | 0 | handler GUI |
| `Calc_coeff` | 524-529 | Public | 2 | 4 | 0 | portée réductible ? |
| `LPrix_change` | 531-545 | Public | 4 | 13 | 0 | handler GUI |
| `Button1_Click` | 549-553 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et sélection du client / type

- **`_new(choix, cat, article)`** [portée : nécessaire (spéciale)] [GUI]. Arguments réels
  `(choix, Parent, cat, article)`. Chaînage de saisie, paramètres des `TextReg` (recherche
  d'article intégrée à `Tart`), libellés du mode client ; `cat` → `TypeC_man`, `article` →
  `Art_man`.
- **`Button4_click()`** [handler] [mixte]. Mode client : `TriCpt` (écrit `Bsel`/`Bval` par
  `Object.SetProperty`) puis `TypeC_man` ; mode type : liste `Coltype` (`Cbase.Table("TabTypec")`).
- **`Typec_LostFocus`, `Typec_KeyPress`, `Coltype_KeyPress`, `Coltype_Click`** [handlers,
  `Coltype_Click` en `replay_dynamic`] [GUI]. Validation et choix du client / type.
- **`TypeC_man()`** [portée : réductible] [mixte]. `SELECT cli_nom as libelle FROM Fiches_Cli` ou
  `SELECT * FROM Fiches_Typec` ; libellé puis `Aff_Tarart`. Message si absent (test `Available`
  redondant dans le `Else`).
- **`Aff_Tarart()`** [portée : réductible] [mixte]. Construit la requête de la liste
  (`Fiches_Tarcli|Fiches_TarTypcli LEFT JOIN Fiches_Art … JOIN Fiches_Tvaav`, colonnes calculées
  `pxht`, `pxttc`, `remise`, `marge`), lit une ligne (`LIMIT 1`, **sans filtre**) pour les
  `Fields`, ferme l'ancien `TriGen`, en crée un nouveau `As "ColTri"` puis `ExtraSel("ccli=&1"
  | "type=&1")`. ⚠️ Si la table entière est vide, `Return` avant de fermer l'ancien `TriGen` :
  la liste précédente reste affichée (cas après « supprimer tout »).
- **`ColTri_MajSel(val)`** [handler de `TriGen`] [mixte]. Article choisi dans la liste :
  `SELECT … FROM Fiches_Tarcli|Fiches_TarTypcli JOIN Fiches_Art JOIN Fiches_Tvaav WHERE
  art_code=&1` puis `AffLig`. ⚠️ Pas de filtre sur `ccli`/`type` : le coefficient affiché peut être
  celui d'un **autre** client ou type ayant un tarif sur cet article.
- **`ColTri_KeyPress()`** [handler de `TriGen`] [mixte]. Suppr : supprime le tarif de l'article.
  ⚠️ En mode type, la requête vise `Fiches_Tarcli WHERE type = …` (mauvaise table, colonne
  inexistante → erreur SQL) au lieu de `Fiches_TarTypcli`.

### Article

- **`Button5_click`, `Tart_KeyPress`** (F2 sélection, F4 `Articles.ShowModal`),
  **`SelectionArt()`** [portée : réductible] [mixte] : `TriArticles` (écrit `Bsel`/`Bval`).
- **`Tart_LostFocus()`** [handler] [mixte]. Tarif existant pour ce client/type et cet article →
  `ColTri_MajSel` ; sinon `Art_man`.
- **`Art_man()`** [portée : réductible] [mixte]. Cherche l'article par code (préfixe `*`
  retiré), code équivalent puis référence centrale ; `AffLig` ou message. ⚠️ `Print "artman"`
  (trace de débogage sur la sortie standard).
- **`AffLig()`** (privé) [GUI]. Remplit les zones depuis `$resart` (coefficient particulier s'il
  existe, sinon `art_coef`), puis `Tcoeff_Lostfocus`.

### Calcul des prix (cascade `LPrix`)

- **`Tcoeff_Lostfocus()`** [handler] [mixte]. `LPrix(Tprht, 1, art_cdarr)` + remise en
  **montant** `Tprht × (1 − coef)` (`LTaxe.Remise`, signe inversé par `LTaxe`) sous
  `Object.Lock`, puis TVA : `LPrix_change` est levé une seule fois.
- **`Tpvht_LostFocus()`** : `LPrix(Tpvht)` + TVA. **`Remise_LostFocus()`** : `LPrix(prix public)`
  + remise % + TVA. **`TpvTTc_LostFocus()`** : PV HT déduit du TTC s'il a changé.
  Ces trois handlers ne testent que `IsNull($resart)` (pas `Available`).
- **`LPrix_change(value)`** [handler de `$lpx`] [GUI]. PV HT, PV TTC, remise
  (`Calc_Remise`), coefficient (`Calc_coeff`), alerte si PV < prix de revient.
- **`Calc_Remise()`**, **`Calc_coeff()`** [portée : réductible] [calcul sur contrôles].
  Remise par rapport au prix public ; coefficient PV HT / prix de revient.
- **`button6_GotFocus`** : recalcule la remise.

### Enregistrement

- **`Button6_Click()`** [handler] [mixte]. Transaction ; `Utils.db.Edit` sinon `Create9` de
  `Fiches_Tarcli`/`Fiches_TarTypcli` (`ccli|type`, `cart`, `coef = Tcoeff.Value`) ; liste et
  zones rafraîchies. **`Button6_KeyPress`** : Entrée → `Button6_Click`.
- **`Button3_Click()`** [handler] [mixte]. Supprime **tous** les tarifs du client / type après
  confirmation.
- **`Refresh()`** [portée : réductible] [GUI]. Vide les zones de prix.
- **`Button2_Click`** (fermer), **`Button1_Click`** (`Doc.Open("TarifClient")`).

## État global utilisé

- `Utils.db` (`Exec`, `Edit`, `Create9`, `Begin`, `Commit`, `Subst`), `Cbase.Table("TabTypec")`,
  `Start.son`, `Music`.
- Tables en dur : `Fiches_Tarcli`, `Fiches_TarTypcli`, `Fiches_Art`, `Fiches_Tvaav`,
  `Fiches_Cli`, `Fiches_Typec`.
- `Bsel`/`Bval` `Public` (écrits par `TriCpt` et `TriArticles`).
- Membres privés inutilisés : `son` (le code lit `Start.son`), `Dbl`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Requêtes dupliquées selon `$choix` (`TypeC_man`, `Aff_Tarart`, `ColTri_MajSel`,
  `Tart_LostFocus`, `Button3_Click`, `Button6_Click`, `ColTri_KeyPress`) : deux membres fixés une
  fois dans `_new` (`$table`, `$colonne`) supprimeraient les `If $choix = client` (SQL identique,
  **sauf** `ColTri_KeyPress`, voir A01).
- `TypeC_man` : supprimer le test `Available` redondant.

### Commonalisation avec d'autres fichiers

- Cascade de prix (`Tcoeff_Lostfocus`, `Remise_LostFocus`, `Tpvht_LostFocus`) : fabrique commune
  proposée dans [`GesTar`](../../Entrées/GesTar.class/architecture.md) (GESTAR-008). Ici la remise
  est passée en **montant** : l'équivalence avec `Marge %` doit être prouvée par test.
- Le calcul SQL des prix (`art_prvt × coef`) recoupe
  [`TarArt`](../../../Utils/TarArt.class/architecture.md) (prix client par coefficient) : même
  règle, sans arrondi `LPrix`.
- Recherche du client (`TriCpt`) et liste des types (`Coltype`) : mêmes patrons dans
  [`GesTar`](../../Entrées/GesTar.class/architecture.md) (`Rechc_click`, `Recht_click`),
  [`CoefTypeC`](../CoefTypeC.class/architecture.md) et [`Remisec`](../Remisec.class/architecture.md)
  (`ToggleButton1_Click`).
- Recherche d'article par code / code équivalent / référence centrale (`Art_man`) : à rapprocher
  de `Utils.db.RecArt` ([DB_Connection](../../../Utils/DB_Connection.class/architecture.md)).

### Réduction de portée

- `TypeC_man`, `Aff_Tarart`, `SelectionArt`, `Art_man`, `Calc_Remise`, `Refresh`, `Calc_coeff` :
  aucun appel externe (vérifié par `grep -rn`) → `Private`.
- `Coltype_Click` (`replay_dynamic`) et tous les handlers restent `Public` ; `Bsel`/`Bval` aussi.

### Séparation traitement / GUI

- `EnregistreTarif(code, article, coef)`, `SupprimeTarif(code, article)`,
  `SupprimeTarifs(code)` sans contrôle, appelées par `Button6_Click`, `ColTri_KeyPress`,
  `Button3_Click`.
- `Calc_Remise(pvpublic, pvht)` et `Calc_coeff(pvht, prht)` en fonctions pures.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Tarcli` et `Fiches_TarTypcli` ont la même structure à la colonne de clé près : une
  table unique `(nature, code, cart, coef)` simplifierait cet écran, `GesTar` et `DateTar`.
- Aucune contrainte d'unicité sur `(ccli, cart)` / `(type, cart)` (seule clé : `lind`
  auto-incrémenté, `db_control.csv`) : un index unique garantirait l'absence de doublons que
  l'écran évite par `Utils.db.Edit`.
