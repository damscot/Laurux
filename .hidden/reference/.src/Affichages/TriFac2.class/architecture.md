# TriFac2 — Architecture

> Source : `.src/Affichages/TriFac2.class`

## Vue d'ensemble

`TriFac2` est une variante de [`TriFac`](../TriFac.class/architecture.md) : **liste modale de
sélection d'un document existant** ouverte par `Facture.Creation(False)` (`Button25_Click`, reprise
d'un document pour en créer un nouveau). Deux sources, choisies par les boutons radio du `.form` :

- **`Encours`** (valeur par défaut dans le `.form`) : documents en cours `Fiches_Bl`
  (`Cbase.Table("TabBl")`), hors documents à `totalht = '0'` ; colonnes numéro de BL, numéro de
  facture, date, code, nom + prénom, total HT, total TTC ;
- **`Archives`** : factures archivées `Fiches_HistoFac` (`TabHisFac`) ; la colonne numéro de BL est
  vidée.

La grille `ColFac` (8 colonnes, la colonne 0 de largeur 1 porte le prénom) est remplie en mode
données. Les en-têtes `TextBox` (`NOMM`, `NMF`, `DA`, `CO`, `NM`, `MT`, `MTC`) suivent le même idiome
que `TriFac` : clic = colonne de tri, frappe = filtre `LIKE "%sel%"`, double-clic = inversion,
saisie de date `jjmm`/`jjmmaaaa` convertie en `sel2`. Pagination par `LIMIT NbEnreg, lg`.

**Protocole de retour** : `ColFac_Click` écrit `Variables.Bsel = True` et `Variables.numeroFac`
(numéro de BL en mode en cours, numéro de facture en mode archives) ; `Facture` lit ces variables
(`Facture.class:12111`) puis `EntFac` choisit la source selon la longueur du numéro (10 caractères
= facture archivée, `Facture.class:9909`).

L'écran **n'appelle pas `Utils.Observers(Me)`** (non journalisé, non rejouable en l'état).

Nature globale : **GUI**, SQL concaténé dans 8 fonctions `Deb*`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Fac` | var | Private |  | New String[8] | 3 |
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
| `Client` | var | Private |  | String | 17 |
<!-- /AUTO:declarations -->

| Variable | Usage |
|---|---|
| `Fac` | noms des colonnes SQL selon la source ; `Fac[1] = ""` en mode archives (lecture `Utils.rs2[""]` : renvoie l'objet `Result` lui-même, vérifié par `gbs3`, puis texte vidé ligne 101) |
| `Tri`, `sel`, `sel2`, `Dbl`, `sDa`, `NbEnreg`, `lg` | comme `TriFac` |
| `Dat` | affecté partout mais **sans effet** : les deux branches de chaque `Deb*` sont identiques |
| `Client` | affecté dans `_New`, jamais lu : code mort |
| `Prxdec` | jamais `True` : code mort |
| `CoulB`, `CoulF`, `Fnt`, `Prenom` | état de dessin de `ColFac_Data` |

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 19-50 | Public | 7 | 30 | 0 | méthode spéciale |
| `ColFac_Data` | 52-119 | Public | 20 | 62 | 0 | handler GUI |
| `Deb2` | 121-132 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb2b` | 134-145 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb3b` | 147-158 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb3` | 160-169 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb2bis` | 171-182 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb2bbis` | 184-195 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb3bbis` | 197-208 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb3bis` | 210-219 | Public | 2 | 8 | 0 | portée réductible ? |
| `Tris` | 221-237 | Public | 1 | 15 | 0 | portée réductible ? |
| `Titre` | 239-249 | Public | 1 | 9 | 0 | portée réductible ? |
| `NOMM_MouseDown` | 251-268 | Public | 2 | 16 | 0 | handler GUI |
| `NOMM_Dblclick` | 270-275 | Public | 1 | 4 | 0 | handler GUI |
| `NOMM_KeyPress` | 277-296 | Public | 8 | 18 | 0 | handler GUI |
| `DA_MouseDown` | 298-318 | Public | 3 | 19 | 0 | handler GUI |
| `DA_Dblclick` | 320-326 | Public | 1 | 5 | 0 | handler GUI |
| `DA_KeyPress` | 328-362 | Public | 13 | 33 | 0 | handler GUI |
| `CO_MouseDown` | 364-384 | Public | 3 | 19 | 0 | handler GUI |
| `CO_Dblclick` | 386-391 | Public | 1 | 4 | 0 | handler GUI |
| `CO_KeyPress` | 393-412 | Public | 8 | 18 | 0 | handler GUI |
| `NM_MouseDown` | 414-434 | Public | 3 | 19 | 0 | handler GUI |
| `NM_Dblclick` | 436-441 | Public | 1 | 4 | 0 | handler GUI |
| `NM_KeyPress` | 443-462 | Public | 8 | 18 | 0 | handler GUI |
| `NMF_MouseDown` | 464-480 | Public | 2 | 15 | 0 | handler GUI |
| `NMF_Dblclick` | 482-487 | Public | 1 | 4 | 0 | handler GUI |
| `NMF_KeyPress` | 489-508 | Public | 8 | 18 | 0 | handler GUI |
| `MT_MouseDown` | 510-530 | Public | 3 | 19 | 0 | handler GUI |
| `MT_Dblclick` | 532-537 | Public | 1 | 4 | 0 | handler GUI |
| `MT_KeyPress` | 539-558 | Public | 8 | 18 | 0 | handler GUI |
| `MTC_MouseDown` | 560-580 | Public | 3 | 19 | 0 | handler GUI |
| `MTC_Dblclick` | 582-587 | Public | 1 | 4 | 0 | handler GUI |
| `MTC_KeyPress` | 589-608 | Public | 8 | 18 | 0 | handler GUI |
| `Dbclk` | 610-629 | Public | 4 | 18 | 0 | portée réductible ? |
| `ColFac_Click` | 631-641 | Public | 2 | 9 | 0 | handler GUI |
| `ColFac_KeyPress` | 643-668 | Public | 11 | 23 | 0 | handler GUI |
| `ColFac_MouseWheel` | 670-679 | Public | 4 | 8 | 0 | handler GUI |
| `Descendre_Click` | 681-691 | Public | 5 | 9 | 0 | handler GUI |
| `Remonter_Click` | 693-701 | Public | 4 | 7 | 0 | handler GUI |
| `Descendre_KeyPress` | 703-711 | Public | 5 | 7 | 0 | handler GUI |
| `Remonter_KeyPress` | 713-721 | Public | 5 | 7 | 0 | handler GUI |
| `Deplacement` | 723-756 | Public | 9 | 32 | 0 | portée réductible ? |
| `Archives_Click` | 758-768 | Public | 3 | 9 | 0 | handler GUI |
| `Encours_Click` | 770-780 | Public | 3 | 9 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et affichage

- **`_New(cclient)`** [portée : nécessaire (constructeur)] [nature : GUI] : titres, `lg`, filtre
  initial sur le code client (`cdclibl` ou `cdclifac` selon `Encours`), sinon tri `numbl`/`numfac` ;
  `Tris` puis `Deb2` (source « en cours » car `Encours` vaut `True` à l'ouverture).
- **`Tris()`**, **`Titre()`** [portée : réductible] [nature : GUI] : 8 colonnes ; libellés des 7
  en-têtes.
- **`ColFac_Data(Row, Column)`** [portée : nécessaire (handler)] [nature : mixte] : identique à
  `TriFac.ColFac_Data` (couleurs `/Coul/Facts` relues à chaque cellule, `Avoir` inutilisée, prénom
  mémorisé en colonne 0) avec le choix des noms de colonnes selon `Encours`, la colonne 1 vidée en
  mode archives, la date en colonne 3, le nom en colonne 5 et les montants en colonnes 6-7.

### Requêtes [portée : réductible] [nature : mixte]

| Fonction | Table | Filtre | Ordre |
|---|---|---|---|
| `Deb2` | `TabBl` | `Tri LIKE "%sel%" AND totalht <> '0'` | `DESC` |
| `Deb2b` | `TabBl` | `… "%sel2%" …` | `DESC` |
| `Deb3b` | `TabBl` | `… "%sel2%" …` | `ASC` |
| `Deb3` | `TabBl` | `… "%sel%" …` | `ASC` |
| `Deb2bis` | `TabHisFac` | `Tri LIKE "%sel%"` | `DESC` |
| `Deb2bbis` | `TabHisFac` | `… "%sel2%"` | `DESC` |
| `Deb3bbis` | `TabHisFac` | `… "%sel2%"` | `ASC` |
| `Deb3bis` | `TabHisFac` | `… "%sel%"` | `ASC` |

Chaque fonction a deux branches `If dat = 0` **identiques** (au nombre d'espaces près) ; lignes de
SQL commentées laissées en place. Toutes concatènent `Tri`, le filtre, `NbEnreg` et `lg`.

### En-têtes (7 groupes de 3 handlers) [portée : nécessaire (handlers)] [nature : GUI]

- **`*_MouseDown`** : vident `sel`/`Dbl`/`NbEnreg`, fixent `Tri` selon la source et appellent `Deb2`
  (en cours) ou `Deb2bis` (archives). `NMF` trie sur `numfac` dans les deux sources.
- **`*_Dblclick`** : `Dbclk`. **`*_KeyPress`** : construisent `sel`, relancent `Deb2`/`Deb2bis`,
  Échap/F2 ferment, flèche bas donne le focus à la grille. `DA_KeyPress` : conversion de date (4 ou 8
  chiffres) puis `Deb2b`/`Deb2bbis` ; **le retour arrière jusqu'au filtre vide appelle `Deb2` même
  en mode archives** (ligne 335 : `Tri = "datefac"` sur `Fiches_Bl` → erreur SQL, TRIFAC2-A01).
- **`Dbclk()`** [portée : réductible] : premier double-clic `Deb3`/`Deb3bis` (ordre `ASC`), second
  `Deb2` (en cours) ou **`Deb2bbis`** (archives, filtre de date `sel2` au lieu de `sel`, TRIFAC2-A02).

### Sélection, pagination, changement de source

- **`ColFac_Click()`** [portée : nécessaire (handler, rejoué par `Object.Call`)] [nature : mixte] :
  `Variables.Bsel = True`, `Variables.numeroFac` (colonne 1 ou 2), fermeture.
- **`ColFac_KeyPress()`** : Entrée sélectionne ; Échap/F2 → `Variables.Bsel = False` ; pagination
  par flèches et PageUp/PageDown.
- **`ColFac_MouseWheel`, `Descendre_Click`, `Remonter_Click`, `Descendre_KeyPress`,
  `Remonter_KeyPress`** [handlers] : pagination, comme `TriFac`.
- **`Deplacement()`** [portée : réductible] : choisit parmi les 8 requêtes selon `Dbl`, `sDa` et
  `Encours` (cohérent, contrairement à `TriFac.Deplacement`).
- **`Archives_Click()` / `Encours_Click()`** [handlers] [nature : GUI] : changent `Tri`
  (`numfac`/`numbl`), `Dat`, redimensionnent et rechargent ; **ne vident ni `sel`, `sel2`, `Dbl`,
  `sDa` ni `NbEnreg`**, ni les en-têtes (TRIFAC2-A03).

## État global utilisé

- `Variables.Bsel`, `Variables.numeroFac` (écrits).
- `Utils.rs2`, `Utils.Base2`, `Utils.Fcolr`, `Utils.cpoint` ; `Start.LocalSettings` (couleurs),
  `Start.Societe`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Dat` (sans effet), `Client`, `Prxdec`, `Avoir` et les lignes de SQL commentées.
- Remplacer les 8 `Deb*` par `Charge(bArchives, bDate, bDesc)` produisant le même texte SQL
  (aux espaces près : à traiter comme « SQL modifié, dump identique »).
- Aides `ActiverColonne(sTriEnCours, sTriArchives, hEntete)` et `SaisieFiltre()` pour les 21
  handlers d'en-tête.

### Commonalisation avec d'autres fichiers

- [`TriFac`](../TriFac.class/architecture.md) : 374 lignes communes (ratio 0,72) ; le mode archives
  est la même liste. Socle `RequeteFactures(…)` commun (voir TRIFAC-008) étendu à la source
  `Fiches_Bl` (`RequeteDocuments`).
- Pagination → `PaginationListe` (avec `TriFac`, `TriEcritures`, `Tricartes`, `TriclientsD`, `Tricp`,
  `TriMat`).
- Calcul des couleurs `/Coul/Facts` : copie exacte de `TriFac.ColFac_Data`.

### Réduction de portée

- `Deb2`, `Deb2b`, `Deb3b`, `Deb3`, `Deb2bis`, `Deb2bbis`, `Deb3bbis`, `Deb3bis`, `Tris`, `Titre`,
  `Dbclk`, `Deplacement` → `Private` (vérifié : aucun usage hors du fichier). Handlers inchangés.

### Séparation traitement / GUI

- Texte SQL dans une fonction pure (`RequeteDocuments(bArchives, sTri, sFiltre, bDesc, iDebut, iNb)`)
  testable en gb.test ; `Charge` ne fait que `Utils.Base2` et `ColFac.Refresh`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `totalht` est un `double` comparé à la chaîne `'0'` : une colonne d'état « document vide »
  (ou un `DECIMAL`) rendrait le filtre exact et indexable.
- Mêmes remarques que `TriFac` sur le tri de `numfac` (`varchar`) et le `LIKE` sur les dates.
