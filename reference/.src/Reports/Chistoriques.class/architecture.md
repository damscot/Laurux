# Chistoriques — Architecture

> Source : `.src/Reports/Chistoriques.class`

## Vue d'ensemble

`Chistoriques` est le **gabarit PDF des historiques et des statistiques de vente**
(`Inherits PdfWriter`, voir [PdfWriter](../PdfWriter.class/architecture.md)). Il est utilisé par
l'historique des ventes de main d'oeuvre (`Histovmo`) et par les écrans de visualisation des
statistiques (`VisStatClimo`, `VisStatComArt`, `VisStatComm`, `VisStatFour`, `VisStatTypCli`,
`VisHitCartes`), qui écrivent tous `~/tmp/<nom>.pdf` puis l'ouvrent par `Visualiseur.Prog`.

Comme les autres gabarits, il ne fait que du rendu : titre de page (`Entete`), bandeau de période
(`Level0F`), en-têtes de colonnes (`Level1*`), lignes (`level2*`), en-têtes et valeurs de totaux
(`Level4*`/`Level5*`), trait (`Lines`) et pied de page (`Footer`). Une seule méthode formate ses
valeurs (`level2FO`, voir CHISTORIQUES-A01). Aucune base, aucun calcul métier.

Les suffixes désignent l'édition : `F` familles (orphelin, voir code mort), `C` types de client,
`AC` CA par commercial, `A` CA article par commercial, `H` hit-parade, `P` pièces/main d'oeuvre
par client, `FO` CA fournisseurs, sans suffixe et `bis` historiques articles. `Level0F` sert
pourtant de bandeau de période à **toutes** les statistiques (nom hérité de l'édition familles).

| Édition (appelant) | Titre et période | En-tête | Lignes | Totaux |
|---|---|---|---|---|
| Historique MO (`Histovmo`) | `Entete` | `Level1` | `Level2` | — |
| Pièces / MO par client (`VisStatClimo`) | `Entete`, `Level0F` | `Level1P` | `level2P` | `Level4P`, `Level5P` |
| CA article par commercial (`VisStatComArt`) | `Entete`, `Level0F` | `Level1A` | `level2A` | `Level5A` |
| CA par commercial (`VisStatComm`) | `Entete`, `Level0F` | `Level1AC` | `level2AC` | — (`Level5AC` jamais appelé) |
| CA fournisseurs (`VisStatFour`) | `Entete`, `Level0F` | `Level1FO` | `level2FO` | `Level4FO`, `Level5FO` |
| CA par type de client (`VisStatTypCli`) | `Entete`, `Level0F` | `Level1C` | `level2C` | `Level4C`, `Level5C` |
| Hit-parade (`VisHitCartes`) | `Entete`, `Level0F` | `Level1H` | `level2H` | — |
| Historique articles/client, familles | — | `Level1bis`, `Level1F` | `Level2bis`, `level2F` | `Level4F`, `Level5F` (aucun appelant) |

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `R` | var | Private |  | Integer | 5 |
| `G` | var | Private |  | Integer | 6 |
| `B` | var | Private |  | Integer | 7 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 9-16 | Public | 1 | 6 | 0 | méthode spéciale |
| `Entete` | 19-26 | Public | 1 | 6 | 7 |  |
| `Footer` | 29-35 | Public | 1 | 5 | 7 |  |
| `Lines` | 38-44 | Public | 1 | 5 | 6 |  |
| `Level1` | 48-59 | Public | 1 | 10 | 1 |  |
| `Level1bis` | 63-75 | Public | 1 | 11 | 0 | portée réductible ? |
| `Level2` | 78-89 | Public | 1 | 10 | 1 |  |
| `Level2bis` | 92-104 | Public | 1 | 11 | 0 | portée réductible ? |
| `Level0F` | 108-114 | Public | 1 | 5 | 6 |  |
| `Level1F` | 117-129 | Public | 1 | 11 | 0 | portée réductible ? |
| `level2F` | 132-144 | Public | 1 | 11 | 0 | portée réductible ? |
| `Level4F` | 147-155 | Public | 1 | 7 | 0 | portée réductible ? |
| `Level5F` | 158-166 | Public | 1 | 7 | 0 | portée réductible ? |
| `Level1C` | 169-181 | Public | 1 | 11 | 1 |  |
| `Level1AC` | 184-197 | Public | 1 | 12 | 1 |  |
| `level2AC` | 200-213 | Public | 1 | 12 | 1 |  |
| `Level5AC` | 216-223 | Public | 1 | 6 | 0 | portée réductible ? |
| `Level1A` | 226-237 | Public | 1 | 10 | 1 |  |
| `level2A` | 240-251 | Public | 1 | 10 | 1 |  |
| `Level5A` | 254-261 | Public | 1 | 6 | 1 |  |
| `level2C` | 264-276 | Public | 1 | 11 | 1 |  |
| `Level4C` | 279-289 | Public | 1 | 9 | 1 |  |
| `Level5C` | 292-302 | Public | 1 | 9 | 1 |  |
| `Level1H` | 306-314 | Public | 1 | 7 | 1 |  |
| `level2H` | 317-325 | Public | 1 | 7 | 1 |  |
| `Level1P` | 328-340 | Public | 1 | 11 | 1 |  |
| `level2P` | 343-355 | Public | 1 | 11 | 1 |  |
| `Level4P` | 358-368 | Public | 1 | 9 | 1 |  |
| `Level5P` | 371-381 | Public | 1 | 9 | 1 |  |
| `Level1FO` | 384-394 | Public | 1 | 9 | 1 |  |
| `level2FO` | 397-407 | Public | 1 | 9 | 1 |  |
| `Level4FO` | 410-418 | Public | 1 | 7 | 1 |  |
| `Level5FO` | 421-429 | Public | 1 | 7 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et cadre de page (« Communs »)

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI] : copie `Start.R/G/B` dans `R`/`G`/`B`
  (privés, utilisés seulement ici) puis `SetFillColor`. Les arguments de
  `New Chistoriques("Portrait", "mm", "A4")` vont au constructeur de `PdfWriter`.
- **`Entete(sEntete)`** [portée : nécessaire, 7 appelants] [nature : GUI] : `AddPage`, titre centré
  Helvetica gras italique **12** (16 dans les autres gabarits) sur 206 mm à x = 2, y = 5.
- **`Footer()`** [portée : nécessaire, 7 appelants] [nature : GUI] : pied « Page n/{nb} - date -
  Impression demandée par … » à 10 mm du bas, copie exacte de celui de
  [Carticles](../Carticles.class/architecture.md). Surcharge `PdfWriter.Footer` (jamais appelée
  automatiquement). `VisStatTypCli` ne l'appelle qu'à la fin (pas de pied sur les pages
  intermédiaires, VISSTATTYPCLI-A01).
- **`Lines(PosY As String)`** [portée : nécessaire] [nature : GUI] : `SetXY(7, PosY)` (sans effet
  visible : chaque méthode suivante repositionne le curseur), épaisseur 0,1, trait de 2 à 209 mm.
  Le paramètre est déclaré `String` alors que les appelants passent un `Integer` (conversion
  implicite, sans conséquence pour des entiers).

### Historiques articles

- **`Level1()` / `Level2(code, intitule, produit, designation, qte, pvht, PosY)`** [portée :
  nécessaire (`Histovmo`)] [nature : GUI] : 6 colonnes client / intitulé / produit / désignation
  (tronquée à 30 caractères) / quantité / PV HT, police 9.
- **`Level1bis()` / `Level2bis(…)`** [code mort, aucun appelant] : variante avec n° de facture,
  police 7, intitulé tronqué à 28 caractères.

### Statistiques (bandeau, en-têtes, lignes)

- **`Level0F(dtn0, dtn1)`** [portée : nécessaire, 6 appelants `VisStat*`/`VisHitCartes`] [nature :
  GUI] : bandeau « CA pour la période du … au … » de 100 mm à x = 50, y = 16.
- **En-têtes `Level1C`, `Level1AC`, `Level1A`, `Level1H`, `Level1P`, `Level1FO`** [portée :
  nécessaire, un appelant chacun] [nature : GUI] : y = 26, police 9, cellules bordées, centrées
  et remplies. `Level1F` [code mort] est l'en-tête des familles.
- **Lignes `level2C`, `level2AC`, `level2A`, `level2H`, `level2P`** [portée : nécessaire] [nature :
  GUI] : mêmes largeurs que l'en-tête, sans bordure, texte à gauche, montants à droite.
  `level2F` [code mort].
  ⚠️ `level2P` reçoit de `VisStatClimo` des montants `Float` dans des paramètres `String` :
  conversion implicite non localisée et non formatée (« 12.5 » au lieu de « 12,50 »), anomalie
  portée par l'appelant (VISSTATCLIMO-A01).
- **`level2FO(code, intitule, ca, ca1, pourcent, PosY)`** [portée : nécessaire (`VisStatFour`)]
  [nature : mixte] : seule ligne qui **formate** ses valeurs, par `Format$(Val(x), "0.00")`.
  Partie extractible : le formatage (fonction pure). ⚠️ `Val` renvoie `Null` pour une chaîne vide
  ou non numérique et `Format$(Null, …)` lève « Type mismatch » (vérifié avec `gbx3`, locale
  fr_FR). Or `VisStatFour.Affichage` laisse la colonne % vide quand le CA de la période est nul
  (division par zéro dans un `Try`, `VisStatFour.class:98`) : l'impression s'arrête alors sur
  une erreur non interceptée (CHISTORIQUES-A01, à confirmer par replay). Les montants affichés
  par `VisStatFour` ont été formatés par `Format$` (virgule), donc relus correctement par `Val`.

### Totaux

- **`Level4C`, `Level4P`, `Level4FO`** [portée : nécessaire] : en-têtes de total (3 ou 5 cellules
  pleines). `Level4F` [code mort].
- **`Level5C`, `Level5P`, `Level5A`** [portée : nécessaire] : valeurs de total, cellules pleines,
  alignées à droite avec un **espace final** ajouté (`& " "`) ; **`Level5FO`** aligne au centre
  sans espace. `Level5F` et `Level5AC` [code mort] (`VisStatComm` n'imprime pas de total).

## État global utilisé

- `Start.R`, `Start.G`, `Start.B` (couleur du thème, lue dans `_new`).
- `User.Name`, `Date(Now)` (pied de page, à masquer dans les tests).
- Aucun accès SQL.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les 7 méthodes sans appelant (`Level1bis`, `Level2bis`, `Level1F`, `level2F`,
  `Level4F`, `Level5F`, `Level5AC`) et les membres `R`/`G`/`B`.
- Ramener les 22 méthodes `Level*` vivantes à un appel des helpers `EnteteColonnes` /
  `LigneColonnes` de la base commune (voir [Carticles](../Carticles.class/architecture.md)) ; les
  totaux `Level5*` avec un paramètre « suffixe » (`" "` ou `""`) et un alignement.
- Renommer `Level0F` en `BandeauPeriode` est exclu (API publique utilisée par 6 écrans) ;
  documenter le nom.

### Commonalisation avec d'autres fichiers

- Base commune `PdfLaurux` proposée dans [Carticles](../Carticles.class/architecture.md)
  (CARTICLES-004) : `CouleurTheme`, `PiedDePage` (`Footer` délègue), `TitrePage` (`Entete`,
  taille 12), `Trait` (`Lines` : même code que `Cstocks.Lines`, `Cclients.Lines` à la longueur
  près : 209, 208, 206 mm).
- `Level0F` est un bandeau de période comme les `Level0` de
  [Cbalances](../Cbalances.class/architecture.md), [Ccompta](../Ccompta.class/architecture.md) et
  [Cecheancier](../Cecheancier.class/architecture.md) → `BandeauPeriode(x, y, largeur, texte)`.
- Les écrans appelants partagent le même squelette d'impression (titre, `Level0F`, en-tête,
  boucle sur la grille, saut de page à 283 mm, `Lines`, totaux, `Footer`, `Output`,
  `Visualiseur.Prog`) : socle `ImprimeListe` proposé par
  [VisStatComm](../../Statistiques/VisStatComm.class/architecture.md) ; `Chistoriques` y
  contribuerait par une méthode `SautDePageSi(PosY, seuil, titre, entete)` à condition de garder
  l'ordre exact des appels (titres de reprise différents selon l'écran, VISSTATFOUR-A02).

### Réduction de portée

- Aucune pour les méthodes vivantes (toutes appelées depuis `Statistiques`). Les méthodes sans
  appelant sont supprimées plutôt que rendues privées.

### Séparation traitement / GUI

- `level2FO` : isoler le formatage `Format$(Val(x), "0.00")` dans une fonction pure
  `Montant2Dec(x) As String` (même comportement, erreur comprise), appelée par la ligne. Les
  autres méthodes ne font que du rendu.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
