# TriEcritures — Architecture

> Source : `.src/Affichages/TriEcritures.class`

## Vue d'ensemble

`TriEcritures` est la **liste modale de sélection d'une écriture comptable** de `Fiches_Mvt`
(`Cbase.Table("TabMvt")`), ouverte par les écrans de saisie [`Saisecrit`](../../Compta/Saisecrit.class/architecture.md)
(journaux) et [`Tresor`](../../Compta/Tresor.class/architecture.md) (trésorerie) pour reprendre une
écriture non validée (`ecritnv`, `Type = "0"`) ou validée (`ecritv`, `Type = "1"`).

Paramètres de `_new($Type, $sel, $tr)` : `validee` recherché (`"0"`/`"1"`), filtre initial (toujours
`""` chez les appelants), `tresorerie` (`"0"` pour `Saisecrit`, `"1"` pour `Tresor`). La liste montre
les écritures non clôturées (`cloturee = 0`), hors collectif (`collectif is null`), et, en
trésorerie, non pointées (`pointee = 0 or pointee is null`).

Grille `Ecrit` (GridView en mode données, 9 colonnes : journal, compte, intitulé, date, numéro,
document, débit, crédit, libellé). En-têtes `TextBox` (`JO`, `COM`, `Nom`, `DA2`, `NUM2`, `DOC2`,
`DEB`, `CRED`, `INTITULE`) : la prise de focus (`*_GotFocus` → `*_Click`) choisit la colonne de tri et
vide le filtre, la frappe construit le filtre `LIKE "%sel%"`, le double-clic inverse l'ordre
(`Dbclk2`). Pagination par `LIMIT NbEnreg, lg`.

**Protocole de retour par le module [`Comptabilite`](../../Compta/Utils/Comptabilite.module/architecture.md)** :
l'appelant met `Comptabilite.Bsel = False` et ouvre la liste ; `Ecrit_Click` écrit
`Comptabilite.snum` (colonne 4, numéro), `Comptabilite.libelle` (colonne 8), `Comptabilite.journal`
(colonne 0) et `Comptabilite.Bsel = True`, puis ferme. `Saisecrit` lit `snum` (`ecrit2`/`ecrit3`) ;
`Tresor` lit `snum`, `libelle` et `journal`. `_new` remet aussi `Comptabilite.sCmpt = ""` (lue
seulement par `TresorFac`, classe morte).

`Utils.Observers(Me)` est appelé : écran journalisé et rejouable.

Nature globale : **GUI**, SQL concaténé.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `CoTable` | var | Private |  | New String[9] | 3 |
| `dbl` | var | Private |  | Boolean | 4 |
| `NbEnreg` | var | Private |  | Integer | 5 |
| `Tri` | var | Private |  | String | 6 |
| `Type` | var | Private |  | String | 7 |
| `sel` | var | Private |  | String | 8 |
| `lg` | var | Private |  | Integer | 9 |
| `tsr` | var | Private |  | String | 10 |
| `numero` | var | Private |  | String | 11 |
| `modif` | var | Private |  | Boolean | 12 |
<!-- /AUTO:declarations -->

| Variable | Usage |
|---|---|
| `CoTable` | noms des 9 colonnes SQL, **rempli à chaque cellule** |
| `dbl` | ordre inversé (affecté avec `"1"`/`""`) |
| `NbEnreg`, `lg` | décalage et taille de page |
| `Tri`, `sel` | colonne de tri/filtre, filtre saisi |
| `Type` | valeur de `validee` (`"0"`/`"1"`), comparée à l'entier `0` (`If Type = 0`) |
| `tsr` | valeur de `tresorerie` (`"0"`/`"1"`) |
| `numero`, `modif` | calculés dans `Ecrit_Data`, **jamais lus** : code mort |

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 15-37 | Public | 3 | 20 | 0 | méthode spéciale |
| `Entete` | 39-51 | Public | 1 | 11 | 0 | portée réductible ? |
| `Dbclk2` | 53-73 | Public | 4 | 19 | 0 | portée réductible ? |
| `JO_LostFocus` | 75-79 | Public | 2 | 3 | 0 | handler GUI |
| `COM_GotFocus` | 81-86 | Public | 2 | 4 | 0 | handler GUI |
| `COM_LostFocus` | 88-92 | Public | 2 | 3 | 0 | handler GUI |
| `DA2_GotFocus` | 94-99 | Public | 2 | 4 | 0 | handler GUI |
| `DA2_LostFocus` | 101-105 | Public | 2 | 3 | 0 | handler GUI |
| `NUM2_GotFocus` | 107-112 | Public | 2 | 4 | 0 | handler GUI |
| `NUM2_LostFocus` | 114-118 | Public | 2 | 3 | 0 | handler GUI |
| `DOC2_GotFocus` | 120-125 | Public | 2 | 4 | 0 | handler GUI |
| `DOC2_LostFocus` | 127-131 | Public | 2 | 3 | 0 | handler GUI |
| `DEB_GotFocus` | 133-138 | Public | 2 | 4 | 0 | handler GUI |
| `DEB_LostFocus` | 140-144 | Public | 2 | 3 | 0 | handler GUI |
| `CRED_GotFocus` | 146-151 | Public | 2 | 4 | 0 | handler GUI |
| `CRED_LostFocus` | 153-157 | Public | 2 | 3 | 0 | handler GUI |
| `INTITULE_GotFocus` | 159-164 | Public | 2 | 4 | 0 | handler GUI |
| `INTITULE_LostFocus` | 166-170 | Public | 2 | 3 | 0 | handler GUI |
| `JO_GotFocus` | 172-177 | Public | 2 | 4 | 0 | handler GUI |
| `JO_Dblclick` | 179-184 | Public | 1 | 4 | 0 | handler GUI |
| `JO_Click` | 186-199 | Public | 2 | 12 | 0 | handler GUI |
| `JO_KeyPress` | 201-220 | Public | 7 | 18 | 0 | handler GUI |
| `Nom_GotFocus` | 222-227 | Public | 2 | 4 | 0 | handler GUI |
| `Nom_Dblclick` | 229-234 | Public | 1 | 4 | 0 | handler GUI |
| `Nom_Click` | 236-249 | Public | 2 | 12 | 0 | handler GUI |
| `Nom_KeyPress` | 251-270 | Public | 7 | 18 | 0 | handler GUI |
| `COM_Click` | 272-285 | Public | 2 | 12 | 0 | handler GUI |
| `COM_Dblclick` | 287-292 | Public | 1 | 4 | 0 | handler GUI |
| `COM_KeyPress` | 294-313 | Public | 7 | 18 | 0 | handler GUI |
| `DA2_Click` | 315-327 | Public | 2 | 11 | 0 | handler GUI |
| `DA2_Dblclick` | 329-334 | Public | 1 | 4 | 0 | handler GUI |
| `DA2_KeyPress` | 336-359 | Public | 8 | 22 | 0 | handler GUI |
| `NUM2_Click` | 361-374 | Public | 2 | 12 | 0 | handler GUI |
| `NUM2_Dblclick` | 376-381 | Public | 1 | 4 | 0 | handler GUI |
| `NUM2_KeyPress` | 383-402 | Public | 7 | 18 | 0 | handler GUI |
| `DOC2_Click` | 404-417 | Public | 2 | 12 | 0 | handler GUI |
| `DOC2_Dblclick` | 419-424 | Public | 1 | 4 | 0 | handler GUI |
| `DOC2_KeyPress` | 426-445 | Public | 7 | 18 | 0 | handler GUI |
| `DEB_Click` | 447-460 | Public | 2 | 12 | 0 | handler GUI |
| `DEB_Dblclick` | 462-467 | Public | 1 | 4 | 0 | handler GUI |
| `DEB_KeyPress` | 469-488 | Public | 7 | 18 | 0 | handler GUI |
| `CRED_Click` | 490-503 | Public | 2 | 12 | 0 | handler GUI |
| `CRED_Dblclick` | 505-510 | Public | 1 | 4 | 0 | handler GUI |
| `CRED_KeyPress` | 512-531 | Public | 7 | 18 | 0 | handler GUI |
| `INTITULE_Click` | 533-546 | Public | 2 | 12 | 0 | handler GUI |
| `INTITULE_Dblclick` | 548-553 | Public | 1 | 4 | 0 | handler GUI |
| `INTITULE_KeyPress` | 555-576 | Public | 8 | 19 | 0 | handler GUI |
| `Ecrit_Data` | 578-612 | Public | 10 | 33 | 0 | handler GUI |
| `Tris2` | 614-629 | Public | 1 | 14 | 0 | portée réductible ? |
| `Ecrit_Click` | 631-639 | Public | 4 | 7 | 0 | handler GUI |
| `Ecrit_KeyPress` | 641-667 | Public | 11 | 24 | 0 | handler GUI |
| `Ecrit_MouseWheel` | 669-678 | Public | 4 | 8 | 0 | handler GUI |
| `Descendre_Click` | 680-690 | Public | 5 | 9 | 0 | handler GUI |
| `Remonter_Click` | 692-700 | Public | 4 | 7 | 0 | handler GUI |
| `Descendre_KeyPress` | 702-710 | Public | 5 | 7 | 0 | handler GUI |
| `Remonter_KeyPress` | 712-720 | Public | 5 | 7 | 0 | handler GUI |
| `Deplacement` | 722-731 | Public | 3 | 8 | 0 | portée réductible ? |
| `Debe1` | 733-738 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debe2` | 740-745 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debe3` | 747-752 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debe4` | 754-759 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debn1` | 761-770 | Public | 2 | 8 | 0 | portée réductible ? |
| `Debn2` | 772-781 | Public | 2 | 8 | 0 | portée réductible ? |
| `Debn3` | 783-792 | Public | 2 | 8 | 0 | portée réductible ? |
| `Debn4` | 794-803 | Public | 2 | 8 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction

- **`_new($Type, $sel, $tr)`** [portée : nécessaire (constructeur)] [nature : mixte] :
  `Utils.Observers(Me)`, `lg`, `Comptabilite.sCmpt = ""`, `Entete`, `Tris2`, tri `dte`, puis `Debn1`
  (`Type = "0"`) ou `Debn3` (`Type = "1"`).
- **`Entete()`** [portée : réductible] [nature : GUI] : libellés des en-têtes (« intitulé » pour
  `Nom`). **`Tris2()`** [réductible] : 9 colonnes de la largeur des en-têtes.

### Affichage

- **`Ecrit_Data(Row, Column)`** [handler] [nature : GUI] : remplit `CoTable`, lit `Utils.rs1[Row]`
  (`Print` sur la console en cas d'erreur de `MoveTo`), formate la date (`jj.mm.aaaa`), aligne et
  formate les montants (`Format$(Val(…), "0.00")`), calcule `numero`/`modif` sans usage.

### Requêtes [portée : réductible] [nature : mixte]

- **`Debn1()` / `Debn3()`** : `SELECT * FROM TabMvt WHERE validee = <Type> AND tresorerie = <tsr>
  AND cloturee = 0 [AND (pointee = 0 | pointee is null) si tsr = "1"] AND collectif is null AND
  <Tri> LIKE "%<sel>%" ORDER BY <Tri> LIMIT <NbEnreg>, <lg>`. En trésorerie, la condition est écrite
  `A … OR B …` sans parenthèses, mais chaque membre répète toutes les conditions : résultat correct.
  `Debn1` et `Debn3` ne diffèrent que par des espaces : **même requête**.
- **`Debn2()` / `Debn4()`** : idem en `DESC` ; identiques entre elles aux espaces près.
- **`Debe1()`…`Debe4()`** : variantes sur `provisoire`/`validee` avec `tresorerie = 1` et sans
  `LIMIT` : **jamais appelées** (`unused`, vérifié par `grep` sur tout `.src`).
- Toutes les valeurs (`Type`, `Tsr`, `Tri`, `sel`, `NbEnreg`, `lg`) sont **concaténées**.

### En-têtes (9 colonnes) [portée : nécessaire (handlers)] [nature : GUI]

- **`*_GotFocus`** (`JO`, `COM`, `Nom`, `DA2`, `NUM2`, `DOC2`, `DEB`, `CRED`, `INTITULE`) : couleur de
  focus (`Utils.ObsGotf`) puis `*_Click`. **`*_LostFocus`** : `Utils.ObsLstf`.
- **`*_Click`** : vident `sel` et `Dbl`, restaurent les en-têtes (`Entete`, sauf `DA2_Click`), vident
  l'en-tête actif, fixent `Tri`, puis `Debn1`/`Debn3`. Un `TextBox` n'a pas d'événement `Click` : ces
  méthodes ne sont appelées que par `*_GotFocus` ; elles portent un nom de handler et restent
  `Public` par prudence.
- **`*_Dblclick`** : fixent `Tri` puis `Dbclk2`. **`Dbclk2()`** [réductible] : alterne
  `Debn2`/`Debn1` (ou `Debn4`/`Debn3`).
- **`*_KeyPress`** : ajout ou retrait d'un caractère de `sel`, requête, Échap/F2 ferment.
  `DA2_KeyPress` convertit une date `jj/mm/aaaa` (10 caractères) en `aaaa-mm-jj` et appelle alors
  **deux fois** la requête (`Debn1` puis `Debn1`/`Debn3`). `INTITULE_KeyPress` a un `Catch` vide.

### Sélection et pagination

- **`Ecrit_Click()`** [handler ; rejoué par `Object.Call`, doit rester `Public`] [nature : mixte] :
  écrit `Comptabilite.snum`/`libelle`/`journal` (dans des `Try`), puis `Comptabilite.Bsel = True` et
  ferme. Sur une grille vide (Entrée), les `Try` échouent mais `Bsel` passe à `True` (TRIECRITURES-A03).
- **`Ecrit_KeyPress()`** : Entrée = sélection, Échap/F2 = fermeture, flèches et PageUp/PageDown =
  pagination.
- **`Ecrit_MouseWheel`, `Descendre_Click`, `Remonter_Click`, `Descendre_KeyPress`,
  `Remonter_KeyPress`** [handlers] et **`Deplacement()`** [réductible] : pagination ; `Deplacement`
  appelle `Debn2`/`Debn1` quel que soit `Type` (sans effet puisque `Debn1` = `Debn3`).

## État global utilisé

- `Comptabilite.Bsel`, `snum`, `libelle`, `journal` (écrits), `sCmpt` (remis à `""`).
- `Utils.rs1` (résultat partagé), `Utils.Base`, `Utils.Observers`, `Utils.ObsGotf`, `Utils.ObsLstf`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Debe1`-`Debe4`, `numero`/`modif` et le test `If Type = 0` des 18 handlers (les deux
  branches exécutent la même requête).
- `Debn1`…`Debn4` → `Charge(bDesc)` (texte SQL identique aux espaces près : « SQL modifié, dump
  identique »).
- Aides privées `ActiverColonne(sTri, hEntete)` et `SaisieFiltre()` pour les 27 handlers
  `Click`/`KeyPress`/`Dblclick`.
- `DA2_KeyPress` : une seule requête après conversion de la date (une requête de moins, dump
  identique).

### Commonalisation avec d'autres fichiers

- [`TriEcritures2`](../TriEcritures2.class/architecture.md) : copie à 88 % (493 lignes communes, sans
  la colonne intitulé ni les filtres `cloturee`/`pointee`), **morte** : suppression proposée
  (TRIECRITURES2-A01) plutôt que commonalisation.
- Pagination → `PaginationListe` (avec `TriFac`, `TriFac2`, `Tricartes`, `TriclientsD`, `Tricp`,
  `TriMat`) ; en-têtes triables → socle `ListeEntetes` (voir [`TriFac`](../TriFac.class/architecture.md)).
- **Protocole de retour** : `Comptabilite` est un module de « boîte aux lettres » ; `TriCpt`/`TriGen`
  utilisent `Object.SetProperty(appelant, "Bsel"/"Bval")`. À terme (réarchitecture hors rework
  autonome, voir l'architecture de `Comptabilite`), `TriEcritures` pourrait exposer `Bsel`, `Numero`,
  `Libelle`, `Journal` lus sur l'instance ; appelants à mettre à jour : `Saisecrit`, `Tresor`.

### Réduction de portée

- `Entete`, `Dbclk2`, `Tris2`, `Deplacement`, `Debn1`, `Debn2`, `Debn3`, `Debn4` → `Private`
  (vérifié : aucun usage externe). `Debe1`-`Debe4` sont supprimées (code mort). Handlers inchangés.

### Séparation traitement / GUI

- `RequeteEcritures(sValidee, sTresorerie, sTri, sFiltre, bDesc, iDebut, iNb) As String` pure,
  texte identique à `Debn1`/`Debn2`, testable en gb.test.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `pointee` nullable impose `pointee = 0 OR pointee IS NULL` : une colonne `NOT NULL DEFAULT 0`
  simplifierait la requête et permettrait un index composite `(validee, tresorerie, cloturee,
  pointee)`.
- Le filtre `LIKE "%…%"` sur `dte` (datetime) ou sur les montants empêche tout index.
