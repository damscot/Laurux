# Tricp — Architecture

> Source : `.src/Affichages/Tricp.class`

## Vue d'ensemble

`Tricp` est la **fenêtre modale de sélection d'un code postal** (table `Fiches_Cpostaux`,
colonnes `cp` et `burdist`). La grille `Colco` est paginée « à la main » (`NbEnreg`, `lg`,
`LIMIT`) sur le résultat **global** `Utils.rs2` (`Utils.Base2`). Deux en-têtes `TextBox` servent
à la fois de libellés, de zones de filtre (début de chaîne, `LIKE "<saisie>%"`) et de sélecteurs de
tri (`CO` → `cp`, `INTIT` → `burdist`).

### Signature et protocole de retour

```gambas
Public Sub _new(sOrg As String, cdcp As String)
```

`sOrg` désigne l'écran appelant ; `cdcp` est le début de code postal déjà saisi (filtre initial).
Contrairement aux autres fenêtres de sélection, l'appelant n'est **pas passé en paramètre** : au
clic, `colco_Click` écrit **en dur** dans une classe choisie par `sOrg` :

| `sOrg` | Écriture | Appelants | Effet réel |
|---|---|---|---|
| `"Client"` | `FClient.Bsel`, `.codepostal`, `.Bureaudistributeur` | `FClient:2642, 2805, 2821` ; `FClientcarte:924` | auto-instance de `FClient` : correct quand `FClient` est lui-même ouvert par son auto-instance (`FClient.ShowModal`, seul mode d'ouverture) ; depuis `FClientcarte`, écrit dans une fenêtre `FClient` cachée et `FClientcarte` (qui lit `Variables.Bsel`) ne voit rien (FCLIENTCARTE-A02) |
| `"Fournisseur"` | `FFournisseur.Bsel`, `.codepostal`, `.Bureaudistributeur` | `FFournisseur:2382` | auto-instance ; **perdu** quand la fiche est ouverte par `New FFournisseur` (`Facture:5658`, FFOURNISSEUR-A07) |
| `"Clientcarte"` | `FClientcarte.Bsel` … | `FClientcarte:1015` | `FClientcarte` n'a **aucun** de ces membres : erreur « Unknown symbol 'Bsel' » à l'exécution (ligne 140, hors `Try`) |
| `"Facture"` | `Variables.Bsel`, `Variables.codepostal`, `Variables.Bureaudistributeur` | `Facture:2577, 2679` | correct |
| autre | rien | — | fermeture seule |

Aucune remise à zéro de `Bsel` à l'ouverture ni à l'annulation : `Variables.Bsel` (Facture,
FClientcarte) et `FClient.Bsel`/`FFournisseur.Bsel` restent à `True` après une première sélection,
et une annulation (Échap) réapplique les anciennes valeurs chez l'appelant (TRICP-A02).

Les membres `Bsel`, `Codepostal`, `Bureaudistributeur` de `FClient` et `FFournisseur`, et
`Variables.Bsel`/`codepostal`/`Bureaudistributeur`, doivent rester `Public`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `CoTable` | var | Private |  | New String[5] | 3 |
| `Dbl` | var | Private |  | Boolean | 4 |
| `sel` | var | Private |  | String | 5 |
| `NbEnreg` | var | Private |  | Integer | 6 |
| `Tri` | var | Private |  | String | 7 |
| `lg` | var | Private |  | Integer | 8 |
| `Origine` | var | Private |  | String | 9 |
| `Codecp` | var | Private |  | String | 10 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 14-34 | Public | 3 | 19 | 0 | méthode spéciale |
| `colco_KeyPress` | 36-62 | Public | 11 | 24 | 0 | handler GUI |
| `Colco_MouseWheel` | 64-73 | Public | 4 | 8 | 0 | handler GUI |
| `Descendre_Click` | 75-85 | Public | 5 | 9 | 0 | handler GUI |
| `Remonter_Click` | 87-95 | Public | 4 | 7 | 0 | handler GUI |
| `Descendre_KeyPress` | 97-105 | Public | 5 | 7 | 0 | handler GUI |
| `Remonter_KeyPress` | 107-115 | Public | 5 | 7 | 0 | handler GUI |
| `Deplacement` | 117-126 | Public | 3 | 8 | 0 | portée réductible ? |
| `colco_Click` | 128-150 | Public | 13 | 21 | 0 | handler GUI |
| `Colco_Data` | 152-161 | Public | 2 | 8 | 0 | handler GUI |
| `Tris` | 163-171 | Public | 1 | 7 | 0 | portée réductible ? |
| `Co_GotFocus` | 173-178 | Public | 2 | 4 | 0 | handler GUI |
| `Co_LostFocus` | 180-184 | Public | 2 | 3 | 0 | handler GUI |
| `Intit_GotFocus` | 186-191 | Public | 2 | 4 | 0 | handler GUI |
| `Intit_LostFocus` | 193-197 | Public | 2 | 3 | 0 | handler GUI |
| `Co_Click` | 199-215 | Public | 2 | 15 | 0 | handler GUI |
| `Co_Dblclick` | 217-221 | Public | 1 | 3 | 0 | handler GUI |
| `Co_KeyPress` | 223-235 | Public | 6 | 11 | 0 | handler GUI |
| `Intit_Click` | 237-248 | Public | 1 | 10 | 0 | handler GUI |
| `Intit_Dblclick` | 250-254 | Public | 1 | 3 | 0 | handler GUI |
| `Intit_KeyPress` | 256-271 | Public | 9 | 14 | 0 | handler GUI |
| `Dbclk` | 273-283 | Public | 2 | 9 | 0 | portée réductible ? |
| `Deb2` | 285-290 | Public | 1 | 4 | 0 | portée réductible ? |
| `Deb3` | 292-297 | Public | 1 | 4 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et chargement

- **`_new(sOrg, cdcp)`** [portée : nécessaire (spéciale)] [nature : GUI] : `Utils.Observers(Me)`,
  mémorisation, `lg` (lignes par page), tri `cp`, `Tris()`, focus sur `CO`, filtre initial
  `Sel = Codecp` (le test `IsNull` donne le même résultat dans les deux branches), `Deb2()`.
- **`Tris()`** [portée : réductible] [GUI] : 2 colonnes, largeurs calées sur les en-têtes.
- **`Deb2()` / `Deb3()`** [portée : réductible] [mixte] : `Utils.Base2(Colco, "select * from
  <TabCpostaux> where <Tri> like "<sel>%" order by <Tri> [Desc] limit <NbEnreg>, <lg>")` ; filtre
  et pagination **concaténés** (TRICP-A04). Ne diffèrent que par `Desc`.
- **`Colco_Data(Row, Column)`** [handler] [GUI] : `Utils.rs2.MoveTo(Row)` et lecture de `cp` ou
  `burdist` (`CoTable` dimensionné à 5 pour 2 colonnes, rempli à chaque cellule).
- **`Deplacement()`** [portée : réductible] [GUI] : borne `NbEnreg` à 0 et recharge dans le sens
  courant (`Dbl`).
- **`Dbclk()`** [portée : réductible] [GUI] : logique inversée : le premier double-clic recharge
  en ordre **croissant** puis passe `Dbl` à `True` (les pages suivantes sortent alors en ordre
  décroissant) ; le second recharge en décroissant puis remet `Dbl` à `False` (TRICP-A03).

### Sélection et pagination

- **`colco_Click()`** [handler, rejoué par `Object.Call` : doit rester `Public`] [GUI] :
  protocole ci-dessus, puis `Me.close`.
- **`colco_KeyPress()`** [handler] [GUI] : Entrée = sélection ; Échap/F2 ferme ; flèche haut en
  première ligne / bas en dernière ligne = page précédente/suivante ; PageUp/PageDown.
- **`Colco_MouseWheel()`** [handler] [GUI] : page suivante si `Mouse.Delta = -1` et page pleine,
  sinon page précédente ; `Deplacement()`.
- **`Descendre_Click` / `Remonter_Click`** [handlers] [GUI] : page suivante (si pleine) /
  précédente, curseur en première ligne. **`Descendre_KeyPress` / `Remonter_KeyPress`** : Échap/F2
  ferme, PageUp/PageDown.

### En-têtes : filtre et tri

- **`Co_GotFocus` / `Intit_GotFocus`** [handlers] [GUI] : journalisation `Utils.ObsGotf` puis
  `Co_Click` / `Intit_Click`. **`Co_LostFocus` / `Intit_LostFocus`** : `Utils.ObsLstf`.
- **`Co_Click()`** [GUI] : `CO` est un `TextBox` (événement `Click` non levé par Gambas) : appelée
  seulement par `Co_GotFocus`. Vide l'en-tête, tri `cp`, page 0, filtre **remis au code initial**
  `Codecp`, `Deb2()`. `Dbl = ""` écrit deux fois.
- **`Intit_Click()`** [GUI] : idem pour `burdist`, filtre vidé.
- **`Co_KeyPress` / `Intit_KeyPress`** [handlers] [GUI] : pour **toute** touche hors `"`, `&`, `'`,
  `sel = Utils.Obstch(sel)` et `Deb2()` (une requête aussi pour les flèches, Échap, F2) ; les trois
  caractères refusés ne sont pas bloqués (`Stop Event` absent) : ils s'affichent dans l'en-tête
  sans entrer dans le filtre. Échap/F2 ferme ; flèche bas → grille ; flèches gauche/droite →
  autre en-tête. `Intit_KeyPress` : F1 ouvre l'aide **« Lettrage »** (copier-coller, TRICP-A05) et
  un `Catch` vide masque toute erreur.
- **`Co_Dblclick` / `Intit_Dblclick`** [handlers] : `Dbclk()`.

## État global utilisé

- `Utils.rs2` (via `Utils.Base2`) : résultat **partagé** avec d'autres listes (`Tricartes`,
  `TriEqu`, `TriMat`…) ; `Tricp` est ouvert en modal depuis `FClientcarte`, lui-même ouvert depuis
  `Tricartes` : au retour, `Tricartes` recharge `rs2` (voir sa documentation).
- `Variables.Bsel`, `Variables.codepostal`, `Variables.Bureaudistributeur` (origine `Facture`).
- Auto-instances `FClient`, `FFournisseur` ; `FClientcarte` (symboles inexistants).
- `Cbase.Table("TabCpostaux")`, `Utils.Observers`, `Utils.ObsGotf`/`ObsLstf`, `Utils.Obstch`,
  `Doc.Open`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Deb2`/`Deb3` → `Charge(bDesc)` (texte SQL identique).
- `Co_KeyPress`/`Intit_KeyPress` → `Saisie()` commune (les touches de navigation restent traitées
  après le rechargement, comme aujourd'hui).
- Supprimer les doublons `Dbl = ""`, la branche `IsNull` redondante de `_new`/`Co_Click`, et
  dimensionner `CoTable` à 2 (initialisé une fois).

### Commonalisation avec d'autres fichiers

- **Pagination tactile** : `Descendre_*`, `Remonter_*`, `Colco_MouseWheel`, `Deplacement` et les
  flèches de `colco_KeyPress` sont identiques à [`Tricartes`](../../Caisse/Affichages/Tricartes.class/architecture.md),
  [`TriclientsD`](../../Caisse/Affichages/TriclientsD.class/architecture.md),
  [`TriMat`](../TriMat.class/architecture.md), [`TriEqu`](../TriEqu.class/architecture.md),
  `TriFac`, `TriBl`, `Archives` → classe d'aide `PaginationListe` (TRICARTES-005), avec
  [`TriGen`](../TriGen.class/architecture.md) comme comportement de référence.
- **Recherche de code postal** : `FClient.aff_cp`/`Cpman`, `FFournisseur.Cpman`,
  `FClientcarte.Cpman`, `Facture.Cpman` interrogent tous `Fiches_Cpostaux` avant d'ouvrir `Tricp`
  (voir [`FClient`](../../Gestion/Tables/FClient.class/architecture.md),
  [`FFournisseur`](../../Gestion/Tables/FFournisseur.class/architecture.md),
  [`FClientcarte`](../../Caisse/FClientcarte.class/architecture.md)) : une fonction commune
  `ChoisirCodePostal(sDebut, ob) As Boolean` renverrait le code et le bureau.
- **Protocole de retour** : passer l'appelant en paramètre et écrire par `Object.SetProperty`
  (comme `TriArticles`/`TriCpt`) supprimerait le `Select Case` sur `sOrg` et les écritures dans
  les auto-instances ; changement de signature à faire avec les 4 appelants (et TRICP-A01).

### Réduction de portée

- `Deplacement`, `Tris`, `Dbclk`, `Deb2`, `Deb3` : aucun appelant externe (vérifié) → `Private`.
  `Co_Click`/`Intit_Click` ne sont pas des handlers effectifs (`TextBox` sans `Click`) mais
  portent un nom de handler : laissés `Public` par prudence.

### Séparation traitement / GUI

- `RequeteCp(sTri, sSel, bDesc, iDebut, iNb) As String` pure (texte identique), utilisée par
  `Charge`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index sur `Fiches_Cpostaux(cp)` et `(burdist)` : la recherche par début de chaîne
  (`LIKE "xx%"`) peut alors utiliser l'index.
