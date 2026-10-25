# TriCpt — Architecture

> Source : `.src/Affichages/TriCpt.class`

## Vue d'ensemble

`TriCpt` est la **fenêtre modale de sélection d'un compte** (plan comptable, clients,
fournisseurs, adresses de livraison, contacts), appelée **62 fois dans 41 fichiers** de la
comptabilité, de la gestion et de la caisse. Elle héberge une liste
[`TriGen`](../TriGen.class/architecture.md) dans `Panel1`, reconstruite à chaque changement de
mode, et un bandeau de choix (`Pchoix`) :

- type de comptes : `clifou` (clients et fournisseurs), `cli`, `fou`, `all`, `gest`, `bil`,
  `treso` (ce dernier n'est **jamais rendu visible** et porte le libellé « Bilan ») ;
- pour les clients (`pcli`) : adresse de facturation (`Afac`), de livraison (`Livr`) ou contacts
  (`contact`) ; conditions (`cptcli`) : `inact`, `divers`, `autoe` (groupe `cond1`) ;
- colonne variable (`Cselc`) : adresse 2, statut, téléphones, portable, e-mail…

### Signature et énumérations

```gambas
Public Enum Tous, Client, Fournisseur, Client_Fournisseur, Bilan, Gestion, General, Tresorerie
Public Enum Avec_Solde, Sans_Solde
Public Sub _new(type As Variant, solde As Integer, obj As Object)
```

`type` est une valeur de l'énumération, ou une lettre `"B"`, `"G"`, `"C"`, `"F"`, `"T"` (comme
dans `Fiches_Comptes.type_cc`) ; toute autre chaîne donne `Tous` (0). `Avec_Solde` ajoute la
colonne `ROUND(solde,2)`. `obj` est l'écran appelant (toujours `Me`) ; trois arguments
obligatoires, pas d'argument `Parent`.

### Protocole de retour

1. `_new` mémorise `$obj` mais **ne remet pas** `Bsel`/`Bval` de l'appelant à zéro (contrairement
   à [`TriArticles`](../TriArticles.class/architecture.md) et `TriGen`) : une annulation (Échap,
   fermeture) laisse chez l'appelant le `Bsel = True` et le `Bval` d'une sélection précédente, qui
   sont alors réappliqués (TRICPT-A01 ; relevé par MATERIEL-A09 et FFOURNISSEUR-A07).
2. `TriGen` est créé avec `ob = Me` : il écrit `Bsel`/`Bval` sur **`TriCpt`** (membres `Public`),
   puis lève `ColTri_MajSel(val)`.
3. `ColTri_MajSel` recopie `Bsel = True`/`Bval = val` chez `$obj` si `val` n'est pas vide, sinon
   `Stop Event` ; puis `Me.Close()` dans tous les cas (code identique à `TriArticles`).

Valeur transmise : le **numéro de compte** (`CAST(compte_cc AS char)`, colonne 0). Les 41
appelants doivent garder `Public Bsel`/`Public Bval` — sauf `TresorFac`, qui n'en a pas et lit
`Comptabilite.Bsel` (erreur à la sélection, TRESORFAC-A02).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tous` | enum | Public | oui |  | 3 |
| `Client` | enum | Public | oui |  | 3 |
| `Fournisseur` | enum | Public | oui |  | 3 |
| `Client_Fournisseur` | enum | Public | oui |  | 3 |
| `Bilan` | enum | Public | oui |  | 3 |
| `Gestion` | enum | Public | oui |  | 3 |
| `General` | enum | Public | oui |  | 3 |
| `Tresorerie` | enum | Public | oui |  | 3 |
| `Avec_Solde` | enum | Public | oui |  | 4 |
| `Sans_Solde` | enum | Public | oui |  | 4 |
| `Bsel` | var | Public |  | Boolean | 6 |
| `Bval` | var | Public |  | String | 7 |
| `$obj` | var | Private |  | Object | 9 |
| `$tr` | var | Private |  | TriGen | 10 |
| `$col` | var | Private |  | Collection | 11 |
| `$req` | var | Private |  | String | 12 |
| `$cond` | var | Private |  | String | 13 |
| `$res` | var | Private |  | Result | 14 |
| `$type` | var | Private |  | Integer | 15 |
| `$solde` | var | Private |  | Integer | 16 |
| `$prop` | var | Private |  | ObjProp | 17 |
| `$cb` | var | Private |  | Collection | 19 |
| `$cb1` | var | Private |  | Collection | 20 |
| `$cb2` | var | Private |  | Collection | 21 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 23-99 | Public | 16 | 67 | 0 | méthode spéciale |
| `form_Open` | 101-105 | Public | 1 | 3 | 0 | handler GUI |
| `ColTri_MajSel` | 107-124 | Public | 4 | 15 | 0 | handler GUI |
| `ColTri_ReDim` | 126-130 | Public | 1 | 3 | 0 | handler GUI |
| `debut` | 132-144 | Private | 1 | 10 | 0 |  |
| `Tritous` | 146-154 | Private | 1 | 7 | 0 |  |
| `Tricli` | 157-185 | Private | 2 | 26 | 0 |  |
| `Trilivr` | 187-221 | Private | 2 | 32 | 0 |  |
| `Tricont` | 223-261 | Private | 2 | 36 | 0 |  |
| `Tricontfour` | 263-297 | Private | 1 | 31 | 0 |  |
| `Trifou` | 299-319 | Private | 1 | 18 | 0 |  |
| `Triclifou` | 321-346 | Private | 1 | 23 | 0 |  |
| `slde` | 348-357 | Private | 1 | 7 | 0 |  |
| `tricond` | 359-398 | Private | 17 | 34 | 0 |  |
| `clifou_Click` | 400-411 | Public | 2 | 10 | 0 | handler GUI |
| `cli_Click` | 414-444 | Public | 9 | 27 | 0 | handler GUI |
| `Livr_Click` | 446-459 | Public | 3 | 11 | 0 | handler GUI |
| `contact_Click` | 461-478 | Public | 5 | 15 | 0 | handler GUI |
| `Cselc_Click` | 480-489 | Public | 5 | 8 | 0 | handler GUI |
| `fou_Click` | 491-505 | Public | 5 | 13 | 0 | handler GUI |
| `gest_Click` | 507-518 | Public | 2 | 10 | 0 | handler GUI |
| `bil_Click` | 520-531 | Public | 2 | 10 | 0 | handler GUI |
| `all_Click` | 533-544 | Public | 2 | 10 | 0 | handler GUI |
| `treso_Click` | 546-557 | Public | 2 | 10 | 0 | handler GUI |
| `cond1_Click` | 559-563 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et ouverture

- **`_new(type, solde, obj)`** [portée : nécessaire (spéciale)] [nature : GUI] : conversion de
  `type`, réduction de largeur et de police si l'écran est trop étroit, mémorisation, puis selon
  le type : `Tritous` (Tous/Bilan/Gestion/General/Tresorerie ; en mode Tous, affichage des choix
  `all`/`gest`/`bil`), `Tricli` (Client : `pcli`, `cptcli`, `Pselc`, remplissage de `Cselc`),
  `Trifou` (Fournisseur), `Triclifou` (Client_Fournisseur) ; enfin colonne solde (`slde`). Pas
  d'appel à `Utils.Observers(Me)` : l'écran **n'est pas instrumenté** pour le rejeu. Les
  affectations `cli.Value = True`, `fou.Value = True`, `all.Value = True` ne relancent pas les
  handlers (sinon les colonnes seraient ajoutées deux fois à `$Col` ; à confirmer en phase 2).
- **`form_Open()`** [handler] [GUI] : `tricond()`.
- **`tricond()`** [privée] [nature : mixte] : crée `New TriGen(Panel1, $Col, $res, $req, 20, Me)
  As "ColTri"`, construit la condition imposée et la passe à `ExtraSel` :
  - `lettrable = True` si l'appelant s'appelle `Lettrage` (`$obj.Name`) ;
  - `inact`/`autoe`/`divers` cochés : `(cli_actif = '-1' OR cli_actif = True)`, idem
    `cli_autoent`, `cli_div` ;
  - par type : Bilan `type_cc='B'`, Gestion `type_cc='G'`, General `type_cc='B' OR type_cc='G'`
    (**sans parenthèses**, TRICPT-A02), Client : conditions seules, Tresorerie `type_cc='B' and
    comptr_cc != 0`. **Aucune condition** pour `Tous`, `Fournisseur` et `Client_Fournisseur`
    (`lettrable` ignoré pour un lettrage fournisseur, TRICPT-A04).
  Les colonnes `cli_*` n'existent que dans les requêtes clients : cocher une condition puis passer
  en mode Gestion/Bilan produit une erreur SQL (TRICPT-A03, chemin accessible depuis le mode Tous).
  Termine par `$tr.Show(True)`, **sans effet** (liste dans un `Panel`). Chaque passage émet 3
  requêtes : la requête complète du `Tri*`, celle de `TriGen._ready`, celle de `ExtraSel` (sauf
  quand aucune condition n'est passée).

### Construction des colonnes (privées, [nature : mixte])

Chaque fonction exécute **une requête complète** (tous les comptes du type, sans `LIMIT`) pour
obtenir `Res.Fields`, puis ajoute des `ObjProp` à `$Col`. Tables **en dur** (pas de
`Cbase.Table`).

- **`debut()`** : colonnes code (`compte_cc`) et nom (`intitule_cc`, tri initial).
- **`Tritous()`** : `SELECT CAST(compte_cc AS char) AS compte_cc, intitule_cc, type_cc [, solde]
  FROM Fiches_Comptes` ; divise `Me.Width` et `Panel1.Width` par 2,5 à **chaque** appel — sans
  effet visible, car `TriGen` réimpose ensuite ces largeurs (`ReDim`, `Parent.Width`).
- **`Tricli()`** : jointure `Fiches_Comptes JOIN Fiches_Cli` ; colonnes prénom, adresse 1,
  colonne `Cselc` (via `$cb`), CP, ville. La requête lit tous les champs de `$cb`.
- **`Trilivr()`** : `(Fiches_Comptes JOIN Fiches_AdrlivC) JOIN Fiches_Cli` ; colonnes code, nom,
  prénom, adresse 1, colonne `Cselc` (`$cb1`), CP, ville.
- **`Tricont()`** : `(Fiches_Comptes JOIN Fiches_ContactC) JOIN Fiches_Cli` ; colonnes code, nom,
  prénom, fonction, société, colonne `Cselc` (`$cb2`), CP, ville. Deux colonnes marquées `tri`
  (la dernière l'emporte : société).
- **`Tricontfour()`** : `(Fiches_Comptes JOIN Fiches_ContactF) JOIN Fiches_Four` ; colonnes
  fixes (pas de `Cselc`).
- **`Trifou()`** : `Fiches_Comptes JOIN Fiches_Four` ; adresses 1 et 2, CP, ville (en-tête
  `fo_ville` laissé brut).
- **`Triclifou()`** : `UNION` clients + fournisseurs dans une sous-requête `a` ; colonne `Type`.
- **`slde()`** : colonne solde, alignée à droite, 2 décimales.

### Handlers de changement de mode [GUI]

Tous recréent `$col`, reconstruisent les colonnes, ajoutent le solde et appellent `tricond()` :
**`clifou_Click`** (`Triclifou`), **`cli_Click`** (groupe `cli` = `cli` + `Afac` : clients en
facturation/livraison/contacts, sinon fournisseurs), **`Livr_Click`**, **`contact_Click`**,
**`Cselc_Click`** (changement de colonne variable), **`fou_Click`**, **`gest_Click`**,
**`bil_Click`**, **`all_Click`**, **`treso_Click`** (contrôle jamais visible : handler inatteignable
en pratique), **`cond1_Click`** (`tricond` seul). Le remplissage de `Cselc` depuis `$cb`/`$cb1`/
`$cb2` est écrit trois fois (`_new`, `cli_Click`, `Livr_Click`, `contact_Click`).

### Événements de la liste `TriGen`

- **`ColTri_MajSel(val)`** [handler d'événement `TriGen`] : protocole ci-dessus.
- **`ColTri_ReDim(w)`** [handler] : largeur de la fenêtre.

## État global utilisé

- `Utils.db` (requêtes) ; aucun `Start.*` ni `Variables.*`.
- `$obj` : écran appelant (lu : `.Name` ; écrit : `Bsel`/`Bval`). `$obj.Name` lève une erreur si
  `obj` est `Null` (aucun appelant ne le fait).
- Collections constantes `$cb`, `$cb1`, `$cb2` : libellé de colonne → champ SQL.

## Propositions d'amélioration

### Réécriture / refactorisation

- Les sept constructeurs `Tri*` répètent `k = …` / `New ObjProp(...)` / `$Col.Add` : une méthode
  `AjouteColonne(sChamp, sEntete, Optional bTri, Optional bDroite)` et une table de description
  par mode réduiraient le fichier de moitié (requêtes identiques).
- `RemplitCselc(cCol As Collection)` pour les quatre remplissages de `Cselc`.
- Supprimer `$tr.Show(True)` (sans effet) et les divisions de largeur de `Tritous` (écrasées par
  `TriGen`) — à vérifier en replay (captures d'écran identiques).
- Les huit handlers de mode partagent la séquence `$col = New Collection` / `Tri*` / `slde` /
  `tricond` : `Reconstruit(iType)` privée.

### Commonalisation avec d'autres fichiers

- `ColTri_MajSel` / `ColTri_ReDim` : identiques à [`TriArticles`](../TriArticles.class/architecture.md)
  (voir TRIARTICLES-008).
- Lecture de la structure par requête complète : même défaut que `TriArticles.Update_Req`
  (`LIMIT 0` suffit).

### Réduction de portée

- `deps.py` ne signale aucun membre réductible : toutes les fonctions non-handlers sont déjà
  `Private`. `Bsel`/`Bval` restent `Public` (écrits par `TriGen`), ainsi que les énumérations
  (utilisées par les 41 appelants).

### Séparation traitement / GUI

- `tricond` : condition SQL calculée par une fonction pure `ConditionComptes(iType, sAppelant,
  bInact, bAutoe, bDivers) As String` (texte identique), testable en gbtest.
- Requêtes des `Tri*` dans des fonctions pures `RequeteComptes(iMode, sCond, sChampsSup)`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `cli_actif`, `cli_autoent`, `cli_div` sont comparés à `'-1'` **ou** `True` : un booléen unique
  (`tinyint` 0/1) simplifierait les conditions.
- La jointure `compte_cc = cli_code` / `fo_code` sur des types différents (d'où `CAST(compte_cc
  AS char)`) empêche l'usage d'index ; aligner les types des colonnes de compte permettrait des
  jointures indexées.
