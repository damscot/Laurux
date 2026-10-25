# VisStatComm — Architecture

> Source : `.src/Statistiques/VisStatComm.class`

## Vue d'ensemble

`VisStatComm` est l'écran de **visualisation** du « Chiffre d'affaires des commerciaux ». Il est
ouvert uniquement par [`StatComm.Traitement`](../StatComm.class/architecture.md)
(`New VisStatComm(Me, Start.Societe, son, dteN0, dteN1, Detail.Value)`), lit la table de travail
`Total` remplie par `StatComm`, l'affiche dans la grille `Liste` (ColumnView, 9 colonnes : code,
nom, prénom, brut HT, remise, net HT, % commission, montant de commission, commercial), calcule
les totaux (`Brutht`, `Remises`, `NetHT`, `Netnn` = total des commissions) et imprime un PDF
`~/tmp/Statcli.pdf` via [`Chistoriques`](../../Reports/Chistoriques.class/architecture.md)
(`Level1AC`, `level2AC`) et `Visualiseur.Prog`.

Le paramètre `det` (case `Detail` de `StatComm`) fixe le mode : détail (une ligne par client,
jointure `Fiches_Cli` pour retrouver `cli_comm`) ou synthèse (une ligne par commercial).

Nature globale : **GUI**, avec SQL de lecture seule (`Total`, `Fiches_Cli`,
`Fiches_Commerciaux`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `total` | var | Public |  | Integer | 27 |
| `value` | var | Public |  | Float[] | 28 |
| `Dtn0` | var | Public |  | String | 29 |
| `Dtn1` | var | Public |  | String | 30 |
| `Tri` | var | Public |  | String | 31 |
| `sens` | var | Public |  | String | 32 |
| `CoulZns` | var | Private |  | Integer | 33 |
| `CoulZnaf` | var | Private |  | Integer | 34 |
| `CoulFc` | var | Private |  | Integer | 35 |
| `PosY` | var | Private |  | Integer | 36 |
| `Page` | var | Private |  | Integer | 37 |
| `Filename` | var | Private |  | String | 38 |
| `detail` | var | Private |  | Boolean | 39 |
| `son` | var | Private |  | Integer | 40 |
| `Coulfond` | var | Private |  | New String[] | 41 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 43-97 | Public | 1 | 52 | 0 | méthode spéciale |
| `Affichage` | 99-168 | Public | 14 | 64 | 0 | portée réductible ? |
| `Sens_Aff` | 170-178 | Public | 2 | 7 | 0 | portée réductible ? |
| `Bcode_MouseDown` | 180-189 | Public | 2 | 8 | 0 | handler GUI |
| `Bnom_MouseDown` | 191-196 | Public | 1 | 4 | 0 | handler GUI |
| `Bbrut_MouseDown` | 198-203 | Public | 1 | 4 | 0 | handler GUI |
| `Brem_MouseDown` | 205-210 | Public | 1 | 4 | 0 | handler GUI |
| `Bnet_MouseDown` | 212-217 | Public | 1 | 4 | 0 | handler GUI |
| `Bnet2_MouseDown` | 219-224 | Public | 1 | 4 | 0 | portée réductible ? |
| `Button2_Click` | 226-281 | Public | 5 | 49 | 0 | handler GUI |
| `Button1_Click` | 284-289 | Public | 3 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New(Hitniv, Soc, Sn, dte1, dte2, det)`** [portée : nécessaire (spéciale)] [nature : GUI].
  `Utils.Observers(Me)` (une fois), lecture de 4 couleurs (`CoulZns`, `CoulZnaf`, `CoulFc`,
  `Coulfond` : **jamais relues**), mémorise `son`, `Dtn0`, `Dtn1`, `detail` ; `Hitniv` et `Soc`
  sont ignorés. Configure 9 colonnes, `Tri = "cdclifac"`, `Sens = "desc"` puis `Affichage`
  (qui inverse le sens : premier affichage croissant).
- **`Affichage()`** (CC 14, max) [portée : réductible] [nature : mixte].
  - Requête : détail → `SELECT * FROM Total LEFT JOIN <TabCli> ON cli_code = cdclifac` ;
    synthèse → `SELECT * FROM Total`. Si `Bnom.value` : `ORDER BY <Tri> <Sens>` ; sinon
    **`Tri` est forcé à `"commercial"`** et l'ordre devient `lpad(commercial, 12, ' ')`
    (l. 117 et 124). `Tri`/`Sens` sont concaténés (valeurs internes, pas de saisie).
  - Première boucle : cumul `Totl` **jamais utilisé** puis `MoveFirst`.
  - Pour chaque ligne : `SELECT * FROM <TabCommerciaux> WHERE code = cli_comm` (détail) ou
    `= cdclifac` (synthèse) ; **ligne ignorée si le commercial est introuvable** (clients sans
    commercial en détail) et exclue des totaux. Commission : `totfac - (totfac - totfac * comm /
    100)` (= `totfac * comm / 100`), affichée si `comm > 0`, format `"00.00"`.
  - Totaux : `Brutht`, `Remises`, `NetHT`, `Netnn` (somme des commissions relues depuis la
    colonne 7 par `Val(cpoint(…))`). `Netnn2` (évolution N/N-1) est commenté.
  Partie extractible : construction de la requête et calcul des lignes (sans contrôles).
- **`Sens_Aff()`** [portée : réductible] [nature : calcul]. Bascule `sens` asc ↔ desc ; identique
  dans les 5 `VisStat*`.
- **`Bcode_MouseDown`, `Bnom_MouseDown`, `Bbrut_MouseDown`, `Brem_MouseDown`,
  `Bnet_MouseDown`** [handlers des RadioButton, `Public` obligatoire] [nature : GUI]. Fixent `Tri`
  (`commercial` ou `cdclifac` pour `Bcode` selon le mode, `nmclifac`, `brutfac`, `rmfac`,
  `totfac`) puis `Affichage`. Ils réagissent à `MouseDown`, donc **avant** que le RadioButton
  soit coché : `Bnom.value` lu dans `Affichage` est celui du clic précédent ; combiné au forçage
  de `Tri`, les tris Brut/Remise/Net ne s'appliquent jamais et le tri par nom n'agit qu'au second
  clic (VISSTATCOMM-A01, à confirmer par replay).
- **`Bnet2_MouseDown()`** [portée : réductible] — **code mort** : le `.form` n'a pas de contrôle
  `Bnet2` (signal `unused` de `deps.py`, vérifié par `grep`) ; il triait sur `totfacn1`.
- **`Button2_Click()`** [handler, « Imprimer »] [nature : GUI]. `Shell "cd ~"` (sans effet),
  PDF portrait A4 : `Entete`, `Level0F(dtn0, dtn1)`, `Level1AC`, une ligne `level2AC` par ligne
  de grille (nom + prénom concaténés), saut de page à `PosY >= 283` (titre de la 2e page
  « CA **clients** par commercial », légère variante). Totaux `htn`, `rmT`, `netT` calculés mais
  **jamais imprimés** (`Level4C`/`Level5c` commentés). Sortie `~/tmp/Statcli.pdf` puis
  `Visualiseur.Prog`.
- **`Button1_Click()`** [handler, « Quitter »]. Supprime `Filename` s'il existe puis ferme.
  Le même nom `~/tmp/Statcli.pdf` est utilisé par [`VisStatComArt`](../VisStatComArt.class/architecture.md).

## État global utilisé

- `Start.LocalSettings["/Coul/…"]` (lus, inutilisés), `Start.Son`, `User.Home`.
- `Utils.Observers`, `Utils.FColr`, `Utils.Coulfd`, `Utils.cpoint`, `Utils.db`.
- Table de travail `Total` (structure de `StatComm`) : si un autre écran statistique la recrée
  pendant que `VisStatComm` est ouvert, un clic de tri échoue (colonne inconnue) ou affiche des
  données étrangères (STATCOMM-A05).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer la boucle `Totl`, `total`, `value`, les 4 couleurs, `Frmt`, `Tab`, `page`, `Shell`,
  les totaux non imprimés et `Bnet2_MouseDown` (code mort).
- Remplacer la requête `Fiches_Commerciaux` par ligne par une jointure (`INNER JOIN` pour
  conserver l'exclusion des lignes sans commercial) : SQL modifié, lecture seule, grille
  identique.
- Simplifier la formule de commission en `totfac * comm / 100` seulement si T03 montre des
  chaînes formatées identiques (arrondi flottant).

### Commonalisation avec d'autres fichiers

Mesure `dup.py` : 121 lignes communes avec [`VisStatComArt`](../VisStatComArt.class/architecture.md)
(ratio 0,60), 120 avec [`VisStatTypCli`](../VisStatTypCli.class/architecture.md) (0,56), 86 à 96
avec [`VisStatFour`](../VisStatFour.class/architecture.md) et
[`VisStatClimo`](../VisStatClimo.class/architecture.md). Parties communes aux 5 `VisStat*` :
`Sens_Aff` (identique), en-tête du `_New` (couleurs mortes, `Observers`, colonnes), requête
« `SELECT * FROM Total ORDER BY <Tri>|lpad(<Tri>)` », boucle d'impression (`Entete` +
`Level0F` + `Level1x`, ligne `level2x`, saut à 283 mm, `Lines`, `Footer`, `Output`,
`Visualiseur.Prog`) et `Button1_Click` (identique). Proposition, dans le socle
`StatCommun.module` décrit dans [StatComm](../StatComm.class/architecture.md) :
`SensInverse(sSens)`, `RequeteTotal(sFrom, sTri, sSens, bBrut, Optional sWhere)`, et une
procédure d'impression `ImprimeListe(hListe, sTitre, sFichier, …)` paramétrée par les colonnes
(les méthodes `Level1x`/`level2x` de `Chistoriques` restent distinctes). Le `.form` et les
handlers restent dans chaque écran.

### Réduction de portée

- `Affichage`, `Sens_Aff` et les variables `Dtn0`, `Dtn1`, `Tri`, `sens` → `Private` (aucun
  accès externe : `StatComm` n'utilise que `hForm.Show()`). `total` et `value` sont supprimés
  (code mort).

### Séparation traitement / GUI

- `Affichage` : extraire `LignesTotal(bDetail, sTri, sSens, bBrut) As Variant[]` (requête et
  calcul de la commission) ; le remplissage de `Liste` et des totaux reste dans l'écran.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Voir `StatComm` : table `Total` temporaire ou par poste ; la commission pourrait être calculée
  directement en SQL si `Total` portait le taux du commercial.
