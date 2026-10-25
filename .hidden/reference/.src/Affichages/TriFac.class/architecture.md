# TriFac — Architecture

> Source : `.src/Affichages/TriFac.class`

## Vue d'ensemble

`TriFac` est une **liste de sélection modale de factures archivées** (`Fiches_HistoFac`), ouverte
par `Facture.Creation(True)` (bouton « avoir à partir d'une facture existante », `Button26_Click`).
La grille `ColFac` (GridView en mode données, `ColFac_Data`) affiche 7 colonnes : prénom (colonne 0,
largeur 1, masquée), numéro, date, code client, nom + prénom, total HT, total TTC.

Les en-têtes sont des `TextBox` (`NO`, `DA`, `CO`, `NM`, `MT`, `MTC`) : un clic (`MouseDown`) choisit
la colonne de tri et vide le filtre, la frappe (`KeyPress`) construit le filtre `sel` (filtre
`LIKE "%sel%"` sur la colonne de tri), un double-clic (`Dblclick`) bascule l'ordre (`Dbclk`). La
colonne date accepte une saisie `jjmm` ou `jjmmaaaa` convertie en motif SQL (`sel2`). La
pagination est manuelle (`LIMIT NbEnreg, lg`, `lg` = nombre de lignes visibles) : boutons
`Descendre`/`Remonter`, molette, flèches et PageUp/PageDown.

**Protocole de retour** : `ColFac_Click` écrit `Variables.Bsel = True` et `Variables.numeroFac`
(numéro de la ligne), puis ferme. L'appelant lit `Variables.Bsel` (`Facture.class:12111`) puis
`EntFac()` charge la facture `Variables.numeroFac`. `Échap`/`F2` dans la grille remettent
`Variables.Bsel` à `False` ; les autres fermetures non (voir TRIFAC-A04).

L'écran **n'appelle pas `Utils.Observers(Me)`** : il n'est ni journalisé ni rejouable en l'état.

Nature globale : **GUI**, avec SQL construit par concaténation dans quatre fonctions `Deb*`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Fac` | var | Private |  | New String[7] | 3 |
| `Tri` | var | Private |  | String | 4 |
| `sel` | var | Private |  | String | 5 |
| `sel2` | var | Private |  | String | 6 |
| `Dbl` | var | Private |  | Boolean | 7 |
| `Dat` | var | Private |  | Integer | 8 |
| `CoulB` | var | Private |  | Integer | 9 |
| `CoulF` | var | Private |  | Integer | 10 |
| `Fnt` | var | Private |  | String | 11 |
| `Prenom` | var | Private |  | String | 12 |
| `Prxdec` | var | Private |  | Boolean | 13 |
| `NbEnreg` | var | Private |  | Integer | 14 |
| `sDa` | var | Private |  | String | 15 |
| `lg` | var | Private |  | Integer | 16 |
<!-- /AUTO:declarations -->

| Variable | Usage |
|---|---|
| `Fac` | noms des colonnes SQL par numéro de colonne de la grille ; **rempli à chaque cellule** dans `ColFac_Data` |
| `Tri` | colonne SQL de tri et de filtre (`numfac`, `datefac`, `cdclifac`, `nmclifac`, `totfac`, `totfacttc`) |
| `sel` / `sel2` | filtre saisi / motif de date converti (`%-mm-jj` ou `aa-mm-jj`) |
| `Dbl` | ordre inversé après double-clic (affecté avec `"1"`/`""`, converti en Booléen) |
| `Dat` | `0` : tri numérique `abs(lpad(col,10,' '))` dans `Deb2`/`Deb3` ; `1` : tri alphabétique |
| `sDa` | `"1"` quand la colonne active est la date (choix `Deb2b`/`Deb3b` en pagination) |
| `NbEnreg`, `lg` | décalage et taille de page |
| `CoulB`, `CoulF`, `Fnt`, `Prenom` | état de dessin de `ColFac_Data` (prénom mémorisé entre la colonne 0 et la colonne 4) |
| `Prxdec` | jamais mis à `True` : code mort |

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 18-38 | Public | 5 | 19 | 0 | méthode spéciale |
| `ColFac_Data` | 40-92 | Public | 19 | 50 | 0 | handler GUI |
| `Deb2` | 94-103 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb2b` | 105-114 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb3b` | 116-125 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb3` | 127-136 | Public | 2 | 8 | 0 | portée réductible ? |
| `Tris` | 138-153 | Public | 1 | 14 | 0 | portée réductible ? |
| `Titre` | 155-164 | Public | 1 | 8 | 0 | portée réductible ? |
| `NO_MouseDown` | 166-178 | Public | 1 | 11 | 0 | handler GUI |
| `NO_Dblclick` | 180-185 | Public | 1 | 4 | 0 | handler GUI |
| `NO_KeyPress` | 187-202 | Public | 7 | 14 | 0 | handler GUI |
| `DA_MouseDown` | 204-216 | Public | 1 | 11 | 0 | handler GUI |
| `DA_Dblclick` | 218-224 | Public | 1 | 5 | 0 | handler GUI |
| `DA_KeyPress` | 226-251 | Public | 10 | 24 | 0 | handler GUI |
| `CO_MouseDown` | 253-265 | Public | 1 | 11 | 0 | handler GUI |
| `CO_Dblclick` | 267-272 | Public | 1 | 4 | 0 | handler GUI |
| `CO_KeyPress` | 274-288 | Public | 6 | 13 | 0 | handler GUI |
| `NM_MouseDown` | 290-302 | Public | 1 | 11 | 0 | handler GUI |
| `NM_Dblclick` | 304-309 | Public | 1 | 4 | 0 | handler GUI |
| `NM_KeyPress` | 311-325 | Public | 6 | 13 | 0 | handler GUI |
| `MT_MouseDown` | 327-339 | Public | 1 | 11 | 0 | handler GUI |
| `MT_Dblclick` | 341-346 | Public | 1 | 4 | 0 | handler GUI |
| `MT_KeyPress` | 348-362 | Public | 6 | 13 | 0 | handler GUI |
| `MTC_MouseDown` | 364-376 | Public | 1 | 11 | 0 | handler GUI |
| `MTC_Dblclick` | 378-383 | Public | 1 | 4 | 0 | handler GUI |
| `MTC_KeyPress` | 385-399 | Public | 6 | 13 | 0 | handler GUI |
| `Dbclk` | 401-412 | Public | 2 | 10 | 0 | portée réductible ? |
| `ColFac_Click` | 414-420 | Public | 1 | 5 | 0 | handler GUI |
| `ColFac_KeyPress` | 422-446 | Public | 9 | 22 | 0 | handler GUI |
| `ColFac_MouseWheel` | 448-457 | Public | 4 | 8 | 0 | handler GUI |
| `Descendre_Click` | 459-469 | Public | 5 | 9 | 0 | handler GUI |
| `Remonter_Click` | 471-479 | Public | 4 | 7 | 0 | handler GUI |
| `Descendre_KeyPress` | 481-489 | Public | 5 | 7 | 0 | handler GUI |
| `Remonter_KeyPress` | 491-499 | Public | 5 | 7 | 0 | handler GUI |
| `Deplacement` | 501-518 | Public | 5 | 16 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction

- **`_New(cclient)`** [portée : nécessaire (constructeur)] [nature : GUI]. Calcule `lg`, pose les
  titres, place `cclient` dans l'en-tête `CO` et dans le filtre `sel` (tri `cdclifac`), sinon tri
  `numfac` ; dimensionne la grille (`Tris`) et charge la première page (`Deb2`, `Dat = 0` donc tri
  numérique). Le test `If Not IsNull(cclient)` est écrit deux fois. `Facture` passe `""` quand le
  code client est vide : `IsNull("")` est vrai, donc pas de filtre.
- **`Tris()`** [portée : réductible] [nature : GUI] : 7 colonnes, largeurs copiées des en-têtes.
- **`Titre()`** [portée : réductible] [nature : GUI] : restaure les libellés des 6 en-têtes.

### Affichage

- **`ColFac_Data(Row, Column)`** (CC 19, max du fichier) [portée : nécessaire (handler)]
  [nature : mixte]. À **chaque cellule** : lit `Start.LocalSettings["/Coul/Facts"]` et `["/Coul/Avs"]`
  (la seconde n'est jamais utilisée), remplit `Fac[]`, se place sur `Utils.rs2[Row]`, calcule les
  couleurs par `Utils.Fcolr` (repli sur `/Soc<XX>/Coul_fen`), formate la date (`jj.mm.aaaa`),
  concatène le prénom mémorisé au nom (colonne 4) et formate les montants (`Utils.cpoint`, `0.00`).
  Le test `column = 7` est sans effet (la grille a 7 colonnes, 0 à 6). La partie extractible est le
  calcul des couleurs (une seule fois par ouverture) et le formatage d'une valeur.

### Requêtes (toutes sur `Cbase.Table("TabHisFac")`, via `Utils.Base2` → `Utils.rs2`)

| Fonction | Filtre | Ordre | Particularité |
|---|---|---|---|
| `Deb2` | `Tri LIKE "%sel%"` | `DESC` ; si `Dat = 0` : `abs(lpad(Tri,10,' ')) DESC` | requête par défaut |
| `Deb2b` | `Tri LIKE "%sel2%"` | `Tri DESC` | branches `Dat` identiques |
| `Deb3b` | `Tri LIKE "%sel2%"` | `Tri ASC` | branches `Dat` identiques |
| `Deb3` | `Tri LIKE "%sel%"` | **`DESC`** comme `Deb2` | ajoute la colonne `numserie` (jamais affichée) |

Toutes : `LIMIT NbEnreg, lg`, valeurs **concaténées** (`sel`, `sel2`, `Tri`, `NbEnreg`, `lg`), guillemets
doubles autour du motif. `lpad` est traduit pour SQLite par `DB_Connection`. [portée : réductible]
[nature : mixte : SQL + rafraîchissement de la grille].

### En-têtes (6 groupes de 3 handlers) [portée : nécessaire (handlers)] [nature : GUI]

- **`NO_*`, `DA_*`, `CO_*`, `NM_*`, `MT_*`, `MTC_*` `_MouseDown`** : vident `sel`, `Dbl`, `NbEnreg`,
  fixent `Tri`, `Dat` (0 pour `CO`, 1 sinon) et `sDa` (`"1"` pour `DA`), vident l'en-tête et
  appellent `Deb2`.
- **`*_Dblclick`** : fixent `Dat` (et `sDa` pour `DA`), puis `Dbclk`.
- **`*_KeyPress`** : `Dat = 1` (y compris `CO_KeyPress`, alors que `CO_MouseDown` met `Dat = 0`),
  ajout de `Key.Text` ou retour arrière sur `sel`, puis `Deb2`. Échap/F2 ferment ; flèche bas
  (`NO` seulement) donne le focus à la grille. `DA_KeyPress` ignore `.` (code 46) et ne relance la
  requête qu'à 4 caractères (`jjmm` → `%-mm-jj`) ou 8 (`jjmmaaaa` → `aa-mm-jj`), avec `Deb2b`.
- **`Dbclk()`** [portée : réductible] : alterne `Deb3` / `Deb2` ; comme `Deb3` est aussi en `DESC`,
  l'ordre **n'est pas inversé** (TRIFAC-A01).

### Sélection et pagination

- **`ColFac_Click()`** [portée : nécessaire (handler ; rejoué par `Object.Call`, doit rester
  `Public`)] [nature : mixte] : `Variables.Bsel = True`, `Variables.numeroFac` = colonne 1, fermeture.
- **`ColFac_KeyPress()`** [handler] : Échap/F2 → `Variables.Bsel = False` et fermeture ; flèche haut
  en ligne 0 → page précédente ; flèche bas en dernière ligne, PageDown/PageUp → pagination.
  **Entrée ne sélectionne pas** (contrairement à `TriFac2`).
- **`ColFac_MouseWheel`, `Descendre_Click`, `Remonter_Click`, `Descendre_KeyPress`,
  `Remonter_KeyPress`** [handlers] [nature : GUI] : ajustent `NbEnreg` de ± `lg` puis `Deplacement`.
- **`Deplacement()`** [portée : réductible] : borne `NbEnreg` à 0 puis choisit la requête :
  `Dbl` et `sDa = "1"` → `Deb3` (filtre `sel`) ; `Dbl` seul → `Deb3b` (filtre `sel2`, ordre ASC) ;
  sinon `Deb2b` (date) ou `Deb2`. La combinaison est incohérente avec `Dbclk` (TRIFAC-A01).

## État global utilisé

- `Variables.Bsel`, `Variables.numeroFac` (écrits ; lus par `Facture`).
- `Utils.rs2` (résultat partagé rempli par `Utils.Base2`), `Utils.Base2`, `Utils.Fcolr`, `Utils.cpoint`.
- `Start.LocalSettings["/Coul/Facts"]`, `["/Coul/Avs"]`, `["/Soc<XX>/Coul_fen"]`, `Start.Societe`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplir `Fac[]` et calculer les couleurs une seule fois (dans `_New`) ; supprimer `Prxdec`,
  `Avoir`, le test `column = 7` et le double test de `_New`.
- Remplacer `Deb2`/`Deb2b`/`Deb3`/`Deb3b` par `Charge(sFiltre, bNumerique, sOrdre, bNumserie)`
  produisant **le même texte SQL** (les branches `Dat` identiques disparaissent).
- Remplacer les 18 handlers d'en-tête par trois aides privées `ActiverColonne(sTri, hEntete, iDat,
  sDa)`, `SaisieFiltre(iDat)` et `InverserOrdre(iDat, sDa)` ; les handlers restent (même nom,
  `Public`) et deviennent des appels d'une ligne.

### Commonalisation avec d'autres fichiers

- [`TriFac2`](../TriFac2.class/architecture.md) partage 374 lignes sur 409 (ratio 0,72, mesuré par
  `dup.py`) : son mode « factures archivées » (`Deb2bis`…`Deb3bis`) est la même liste sur
  `Fiches_HistoFac`, sans la colonne numéro de BL ni le tri numérique. Socle proposé : une fonction
  pure commune `RequeteFactures(sSource, sTri, sFiltre, bNumerique, bDesc, iDebut, iNb) As String`
  (module à créer en phase 3, par ex. `ListeFactures`) utilisée par les deux classes, chacune
  gardant ses contrôles et ses handlers.
- **Pagination** (`Descendre_*`, `Remonter_*`, `ColFac_MouseWheel`, flèches de `ColFac_KeyPress`,
  `Deplacement`) : identique dans [`TriFac2`](../TriFac2.class/architecture.md),
  [`TriEcritures`](../TriEcritures.class/architecture.md), [`TriBl`](../TriBl.class/architecture.md),
  [`Tricartes`](../../Caisse/Affichages/Tricartes.class/architecture.md), `TriclientsD`, `Tricp`,
  `TriMat` → classe d'aide `PaginationListe` (état `NbEnreg`/`lg`, méthodes `Suivante`,
  `Precedente`, `Molette`, `Touche`), proposée au lot Caisse (TRICARTES-005).
- **En-têtes `TextBox` triables** (clic = colonne, frappe = filtre, double-clic = ordre) : même idiome
  dans `TriFac2`, `TriEcritures`, `TriBl` ; un socle `ListeEntetes` (aides `ActiverColonne` /
  `SaisieFiltre`) éviterait 6 à 9 copies par écran. `TriGen` implémente déjà tri, filtre et pagination
  mais crée ses propres contrôles : y migrer imposerait de modifier le `.form` (exclu du rework).
- `ColFac_Data` : même calcul de couleurs `/Coul/Facts` dans `TriFac2` (copie exacte).

### Réduction de portée

- `Deb2`, `Deb2b`, `Deb3b`, `Deb3`, `Tris`, `Titre`, `Dbclk`, `Deplacement` → `Private` (aucun
  appelant externe, vérifié par `grep` ; seul `Facture` instancie la classe). Les handlers restent
  `Public` ; `ColFac_Click` est appelé dynamiquement par `ReplayObserver`.

### Séparation traitement / GUI

- Isoler le texte SQL dans `RequeteFactures(…)` (pure, testable en gb.test) ; `Charge` ne garde que
  `Utils.Base2` et `ColFac.Refresh`.
- Isoler le formatage d'une cellule (`FormatCellule(iColonne, sValeur, sPrenom) As String`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `numfac` est un `varchar(10)` trié par `abs(lpad(numfac,10,' '))` : un numéro entier (ou une colonne
  calculée indexée) permettrait un tri numérique indexé.
- Le filtre `LIKE "%…%"` sur `datefac` (datetime) impose un parcours complet ; une recherche par
  intervalle de dates (`BETWEEN`) utiliserait `idx_datefac`.
