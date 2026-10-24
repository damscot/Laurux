# Remisec — Architecture

> Source : `.src/Gestion/Tables/Remisec.class`

## Vue d'ensemble

`Remisec` gère la table des **remises par type de client et par famille** (`Fiches_RemTypec` :
`lind`, `coder` = type client, `codef` = famille, `remise`), lue par
[`TarArt`](../../../Utils/TarArt.class/architecture.md), `Facture`, `Moulinage` et `TriEqu`
(clé `Cbase` `TabRemTypec`, **non utilisée ici** : le nom est en dur). L'en-tête du fichier
(« Gestion de la table des types clients ») est inexact.

Ouvert depuis le menu (`Fmenu:1411`, `Remisec.show`). C'est l'**unique utilisateur** de
[`RichDataGrid`](../../../Utils/RichDataGrid.class/architecture.md) : la liste est une grille
`Tabtypec` (`GridView`) pilotée par `$hGrid = New RichDataGrid(Tabtypec) As "Tabtypec"`, avec
formats de colonnes [`CFormat`](../../../Utils/CFormat.class/architecture.md) ; le tri par
colonne et la recherche (clic droit) sont fournis par `RichDataGrid`.

Même gabarit que [`CoefTypeC`](../CoefTypeC.class/architecture.md) (zones `Cdt`, `Cdf`,
`Remise` dans le groupe `rem`, listes `Coltype`/`Colfam`, contrôles `Quitte_*`).

Nature : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$hGrid` | var | Private |  | RichDataGrid | 29 |
| `CoulZns` | var | Private |  | Integer | 30 |
| `CoulfOC` | var | Private |  | Integer | 31 |
| `Tabtype` | var | Private |  | String | 32 |
| `son` | var | Private |  | Integer | 33 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-49 | Public | 1 | 11 | 0 | méthode spéciale |
| `Form_Open` | 51-78 | Public | 1 | 14 | 0 | handler GUI |
| `Maj_Zones` | 80-94 | Public | 1 | 12 | 0 | portée réductible ? |
| `Cleanchamps` | 96-106 | Public | 1 | 9 | 0 | portée réductible ? |
| `Tabtypec_Select` | 108-114 | Public | 1 | 5 | 0 | handler GUI |
| `ToggleButton1_Click` | 116-143 | Public | 4 | 25 | 0 | handler GUI |
| `Coltype_Click` | 145-154 | Public | 1 | 8 | 0 | handler GUI |
| `ToggleButton2_Click` | 156-183 | Public | 4 | 25 | 0 | handler GUI |
| `Colfam_Click` | 185-194 | Public | 1 | 8 | 0 | handler GUI |
| `Quitte_Cdt` | 196-221 | Public | 3 | 20 | 0 | portée réductible ? |
| `Quitte_Cdf` | 223-249 | Public | 3 | 21 | 0 | portée réductible ? |
| `Quitte_Remise` | 251-267 | Public | 2 | 15 | 0 | portée réductible ? |
| `Button2_Click` | 269-287 | Public | 4 | 16 | 0 | handler GUI |
| `Button3_KeyPress` | 289-293 | Public | 4 | 3 | 0 | handler GUI |
| `Button3_Click` | 295-324 | Public | 10 | 27 | 0 | handler GUI |
| `Rem_KeyPress` | 326-345 | Public | 10 | 13 | 0 | handler GUI |
| `Button4_Click` | 347-351 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 356-360 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [GUI]. Couleurs (`CoulFoc`/`CoulZns`, jamais
  utilisées), `Utils.Observers(Me)`, musique, centrage, création du `RichDataGrid`.
- **`Form_Open()`** [handler] [mixte]. Paramètres de la grille : table `Fiches_RemTypec` (en dur,
  membre `Tabtype`), champs `lind, coder, codef, remise`, titres, `DataField = "lind"`, formats
  `CFormat["Width: 80; Format: 0.000; Alignment: left"]` pour la remise, puis `Refresh`.
  ⚠️ `CFormat._Get` convertit le format par `Val` (`"0.000"` → `0`, CFORMAT-A01) : la remise est
  affichée avec un format dégradé (arrondi à l'entier, à confirmer par le test REMISEC-T05).
  Variable `Frmt` inutilisée.
- **`Tabtypec_Select()`** [handler de l'événement `Select` du `RichDataGrid`] [mixte].
  `Maj_Zones`, `Quitte_Cdt`, `Quitte_Cdf` (libellés, focus sur la remise).
- **`Maj_Zones()`** [portée : réductible] [mixte]. `SELECT * FROM Fiches_RemTypec where lind =
  &1` (`$hGrid.Value`), sans test `Available` ; `Cleanchamps` puis recopie.
- **`Cleanchamps()`** [portée : réductible] [GUI]. Vide les zones.
- **`ToggleButton1_Click` / `Coltype_Click`**, **`ToggleButton2_Click` / `Colfam_Click`**
  [handlers, `Coltype_Click` et `Colfam_Click` en `replay_dynamic`] [mixte]. Listes des types
  (`<TabTypec>`) et des familles (`<TabFam>`).
- **`Quitte_Cdt()`**, **`Quitte_Cdf()`**, **`Quitte_Remise()`** [portée : réductible] [mixte].
  Existence du type (`Fiches_Typec` en dur), de la famille (`Fiches_Fam` en dur), validité de la
  remise (format `00.000`) ; `Balloon.Warning` + `Stop Event` en cas d'erreur ; aucune valeur
  de retour.
- **`Rem_KeyPress()`** [handler du groupe `rem`] [GUI]. Entrée/Tab : `Quitte_*` selon le `Tag`.
- **`Button3_Click()`** / **`Button3_KeyPress()`** [handlers] [mixte]. Enregistrement :
  `Quitte_*` puis, **quel que soit leur résultat**, `UPdate` ou `INSERT` de `Fiches_RemTypec`
  (`Val(Utils.cpoint(Remise))`) ; `$hGrid.Refresh` ; `Try Tabtypec.MoveTo(skey, 0)` où `skey`
  est le numéro de ligne courant (modification) ou **le code du type** (création) : la ligne
  sélectionnée ensuite est arbitraire ; `CleanChamps`.
- **`Button2_Click()`** [handler] [mixte]. Suppression de la ligne `$hGrid.Value` après
  confirmation, `Refresh`, `Cleanchamps`.
- **`Button4_Click`** (fermer), **`Button1_Click`** (`Doc.Open("RemTypeclient")`).

## État global utilisé

- `Start.LocalSettings["/Coul/…"]`, `Start.Son`, `Start.Musique`, `Utils.Observers`,
  `Utils.FColr`, `Utils.cpoint`, `Cbase.Table("TabTypec"|"TabFam")`, `Doc.Open`.
- Tables : `Fiches_RemTypec` (en dur ; `RichDataGrid` l'interroge avec `db.Exec`, connexion
  courante gb.db, voir RICHDATAGRID-A02), `Fiches_Typec`, `Fiches_Fam`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `CoulZns`/`CoulfOC`, `Frmt`, les `Tab` locaux redondants ; corriger l'en-tête.
- `Cbase.Table("TabRemTypec")` pour le membre `Tabtype` et les requêtes (même nom produit).

### Commonalisation avec d'autres fichiers

- Gabarit commun avec [`CoefTypeC`](../CoefTypeC.class/architecture.md) (copie au nom de table
  et de colonne près) et [`Remisecli`](../Remisecli.class/architecture.md) : listes type /
  famille / client, contrôles `Quitte_*`, enregistrement / suppression.
- Listes des familles : aussi dans [`Famille`](../Famille.class/architecture.md).

### Réduction de portée

- `Maj_Zones`, `Cleanchamps`, `Quitte_Cdt`, `Quitte_Cdf`, `Quitte_Remise` : aucun appel externe
  (vérifié par `grep -rn`) → `Private`.
- `Coltype_Click`, `Colfam_Click` (`replay_dynamic`) et les handlers restent `Public`.

### Séparation traitement / GUI

- `EnregistreRemise(type, famille, remise)`, `SupprimeRemise(lind)` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Pas de contrainte d'unicité sur `(coder, codef)` (clé `lind`) ; index unique et clés
  étrangères vers `Fiches_Typec`/`Fiches_Fam` souhaitables.
- `Fiches_RemTypec`, `Fiches_CoeffTypec` et `Fiches_RemCliFam` ont la même forme (code, famille,
  valeur) : une table unique typée simplifierait les trois écrans.
