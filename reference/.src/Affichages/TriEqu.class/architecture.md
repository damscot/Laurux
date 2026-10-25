# TriEqu — Architecture

> Source : `.src/Affichages/TriEqu.class`

## Vue d'ensemble

`TriEqu` est la **fenêtre modale de choix parmi les articles équivalents** : quand le code saisi
dans une ligne de facture correspond à plusieurs articles par la table des codes équivalents
(`Fiches_Cequ`, `codequ` → `codep`), `Facture.Art_Equ` l'ouvre pour faire choisir l'article. La
grille `Colart` (11 colonnes dont 3 masquées) liste les articles `Fiches_Art` joints, triés par
code, quantité ou prix d'achat, avec pagination manuelle sur `Utils.rs2`.

### Signature et protocole de retour

```gambas
Public Sub _new(sOrg As String, cdcp As String, retro As Boolean, client As String, type As String, tclient As Boolean)
```

Seul appelant : `Facture:4523` — `New TriEqu("Facture", Cart.Text, retro.value, code.text, Typec,
Tcli)`. `cdcp` est le code équivalent recherché (égalité stricte `codequ like "<code>"`) ;
`retro` et `type` servent au calcul (inopérant) du prix client ; `client` et `tclient` sont
mémorisés et **jamais lus**.

Retour par l'état global :

- sélection (clic ou Entrée), si `sOrg = "Facture"` : `Variables.Bsel = True`,
  `Variables.$Codearticle = <art_code>` (colonne 3), `clic = True`, fermeture ;
- annulation (Échap/F2 dans la grille, les en-têtes ou les boutons) et toute fermeture sans clic
  (`Form_Close`) : `Variables.Bsel = False`, `Variables.$Codearticle = ""`.

C'est la seule fenêtre du lot qui **réinitialise correctement** son retour à l'annulation.
`Facture.Art_Equ` recopie ensuite `Variables.$Codearticle` dans `Cart` dans les deux cas (code
vidé en cas d'annulation). `Variables.Bsel` et `Variables.$Codearticle` doivent rester `Public`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `CodeA` | var | Private |  | String | 3 |
| `ArtTable` | var | Private |  | New String[11] | 4 |
| `sel` | var | Private |  | String | 5 |
| `NbEnreg` | var | Private |  | Integer | 6 |
| `Tri` | var | Private |  | String | 7 |
| `lg` | var | Private |  | Integer | 8 |
| `Origine` | var | Private |  | String | 9 |
| `cli` | var | Private |  | String | 10 |
| `typec` | var | Private |  | String | 11 |
| `tri2` | var | Private |  | String | 12 |
| `codequ` | var | Private |  | String | 13 |
| `PvhtPro` | var | Private |  | String | 14 |
| `Coul` | var | Private |  | Integer | 15 |
| `Dbl` | var | Private |  | Boolean | 16 |
| `retroc` | var | Private |  | Boolean | 17 |
| `Tcli` | var | Private |  | Boolean | 18 |
| `pvpro` | var | Private |  | Float | 19 |
| `clic` | var | Private |  | Boolean | 20 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 22-47 | Public | 2 | 22 | 0 | méthode spéciale |
| `Colart_KeyPress` | 49-77 | Public | 12 | 26 | 0 | handler GUI |
| `Colart_MouseWheel` | 79-88 | Public | 4 | 8 | 0 | handler GUI |
| `Descendre_Click` | 90-100 | Public | 5 | 9 | 0 | handler GUI |
| `Remonter_Click` | 102-110 | Public | 4 | 7 | 0 | handler GUI |
| `Descendre_KeyPress` | 112-122 | Public | 6 | 9 | 0 | handler GUI |
| `Remonter_KeyPress` | 124-134 | Public | 6 | 9 | 0 | handler GUI |
| `Deplacement` | 136-141 | Public | 2 | 4 | 0 | portée réductible ? |
| `Colart_Click` | 143-153 | Public | 3 | 9 | 0 | handler GUI |
| `Form_Close` | 155-162 | Public | 2 | 6 | 0 | handler GUI |
| `Colart_Data` | 164-197 | Public | 6 | 30 | 0 | handler GUI |
| `Tarifclient` | 199-228 | Public | 7 | 27 | 0 | portée réductible ? |
| `Tris` | 230-247 | Public | 1 | 16 | 0 | portée réductible ? |
| `Deb2` | 249-255 | Public | 1 | 4 | 0 | portée réductible ? |
| `Deb3` | 257-263 | Public | 1 | 4 | 0 | portée réductible ? |
| `Co_MouseDown` | 265-277 | Public | 1 | 11 | 0 | handler GUI |
| `Co_Dblclick` | 279-283 | Public | 1 | 3 | 0 | handler GUI |
| `Co_KeyPress` | 285-294 | Public | 5 | 8 | 0 | handler GUI |
| `Co2_MouseDown` | 296-308 | Public | 1 | 11 | 0 | handler GUI |
| `Co2_Dblclick` | 310-314 | Public | 1 | 3 | 0 | handler GUI |
| `Co2_KeyPress` | 316-325 | Public | 5 | 8 | 0 | handler GUI |
| `Co3_MouseDown` | 327-339 | Public | 1 | 11 | 0 | handler GUI |
| `Co3_Dblclick` | 341-345 | Public | 1 | 3 | 0 | handler GUI |
| `Co3_KeyPress` | 347-356 | Public | 5 | 8 | 0 | handler GUI |
| `Dbclk` | 358-368 | Public | 2 | 9 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et chargement

- **`_new(...)`** [portée : nécessaire (spéciale)] [nature : GUI] : `Utils.Observers(Me)`,
  mémorisation, `lg`, `Tri = "codequ"`, `tri2 = "art_paht"` (tri initial par prix d'achat),
  `Tris()`, filtre `Sel = CodeA` (les deux branches `IsNull` sont identiques), `Deb2()`, focus sur
  `Co`.
- **`Tris()`** [portée : réductible] [GUI] : 11 colonnes ; 0 à 2 (`art_stkmin`, `art_stkmax`,
  `art_qte`) de largeur 1 (masquées), puis code, désignation, quantité, PA HT, PV TTC, famille,
  fournisseur, « HT Pro ».
- **`Deb2()` / `Deb3()`** [portée : réductible] [mixte] : `Utils.Base2(Colart, "select codep,
  art_stkmin, art_stkmax, art_qte, art_code, art_design, art_paht, art_pvttc, art_fam, art_four
  from <TabCequ> as e inner join <TabArt> as a on a.art_code = e.codep where <Tri> like "<sel>"
  group by <toutes les colonnes> order by <tri2> asc|Desc limit <NbEnreg>, <lg>")`. Code
  **concaténé** ; le `GROUP BY` sur toutes les colonnes ne sert qu'à dédoublonner. Ne diffèrent
  que par le sens.
- **`Colart_Data(Row, Column)`** [handler] [mixte] : lit `ArtTable[Column]` dans `Utils.rs2`
  (`ArtTable` réécrit à chaque cellule ; `ArtTable[10] = ""`, lecture d'un champ de nom vide :
  sous SQLite `rs2[""]` renvoie le premier champ, vérifié avec gbs3 ; MySQL à confirmer) ; la
  couleur de fond de la ligne est choisie à la colonne 0 (`art_stkmin > 0` → vert, sinon jaune) ;
  colonne 3 → `codequ` ; colonne 10 → `Tarifclient()` puis `Try Text = PvhtPro`.
- **`Tarifclient()`** [portée : réductible] [mixte] : si `retroc` est faux, lit `art_fam`,
  `art_pvht` de l'article (`TabArt`, paramétré `&1`) puis la remise du type de client
  (`TabRemTypec`, `coder = &1 and codef = &2`) et calcule `pvpro`. **Résultat jamais affiché** :
  la colonne 10 affiche `PvhtPro`, qui n'est jamais affecté (toujours `""`), et `pvpro` n'est lu
  nulle part. Coût : **2 requêtes par ligne affichée** à chaque rafraîchissement (TRIEQU-A02).
  Variable `Typeremise` inutile.
- **`Deplacement()`** [portée : réductible] [GUI] : borne `NbEnreg` puis **toujours** `Deb2()`
  (ordre croissant, quel que soit `Dbl`).
- **`Dbclk()`** [portée : réductible] [GUI] : `If Dbl Then Deb2 : Dbl = True Else Deb3 : Dbl =
  False` — `Dbl` ne change jamais (toujours `False`) : chaque double-clic trie en décroissant et
  la page suivante revient en croissant (TRIEQU-A01).

### Sélection, pagination, fermeture

- **`Colart_Click()`** [handler, rejoué par `Object.Call` : doit rester `Public`] [GUI] :
  protocole ci-dessus.
- **`Form_Close()`** [handler] [GUI] : remise à zéro si pas de clic.
- **`Colart_KeyPress()`** [handler] [GUI] : Entrée, Échap/F2 (remise à zéro + fermeture), flèches
  haut/bas en bord de page, PageUp/PageDown.
- **`Colart_MouseWheel`**, **`Descendre_Click`**, **`Remonter_Click`**, **`Descendre_KeyPress`**,
  **`Remonter_KeyPress`** [handlers] [GUI] : pagination identique à `Tricp` (Échap/F2 avec remise
  à zéro).

### En-têtes de tri

- **`Co_MouseDown`, `Co2_MouseDown`, `Co3_MouseDown`** [handlers] [GUI] : `Dbl = False`, libellés
  des autres en-têtes, `tri2` = `art_code`, `art_qte`, `art_paht`, page 0, `Sel = CodeA`, `Deb2()`.
  Corps identiques à la colonne près.
- **`Co_Dblclick`, `Co2_Dblclick`, `Co3_Dblclick`** [handlers] : `Dbclk()`.
- **`Co_KeyPress`, `Co2_KeyPress`, `Co3_KeyPress`** [handlers] : Échap/F2 (remise à zéro +
  fermeture), flèche bas → grille. Aucune saisie de filtre.
- Le bloc d'annulation `Variables.Bsel = False` / `Try Variables.$Codearticle = ""` / `Me.Close`
  est écrit **6 fois** (alors que `Form_Close` le fait déjà).

## État global utilisé

- `Variables.Bsel`, `Variables.$Codearticle` (retour) ; `Utils.rs2` (résultat **partagé** avec
  d'autres listes), `Utils.Base2`, `Utils.cpoint`, `Utils.Observers`.
- `Cbase.Table` : `TabCequ`, `TabArt`, `TabRemTypec`.
- Membres jamais lus : `cli`, `Tcli`, `pvpro`, `PvhtPro` (jamais écrit) ; `clic` sert au retour.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Fermer()` privée pour les 6 blocs d'annulation (ou simple `Me.Close`, `Form_Close` faisant la
  remise à zéro : même effet).
- `Co_MouseDown`/`Co2_MouseDown`/`Co3_MouseDown` → `TriColonne(sTri2, hEntete)` (handlers
  conservés).
- `Deb2`/`Deb3` → `Charge(bDesc)` (texte SQL identique).
- Supprimer `Tarifclient` et son appel (résultat jamais affiché ; la colonne 10 reste vide) :
  SQL modifié (2 requêtes de moins par ligne), dump identique.

### Commonalisation avec d'autres fichiers

- **Pagination** : identique à [`Tricp`](../Tricp.class/architecture.md),
  [`TriMat`](../TriMat.class/architecture.md),
  [`Tricartes`](../../Caisse/Affichages/Tricartes.class/architecture.md) → `PaginationListe`
  (TRICARTES-005), avec [`TriGen`](../TriGen.class/architecture.md) comme référence.
- **Remise par type de client** (`Fiches_RemTypec`, `coder`/`codef`) : le calcul du prix remisé
  existe dans `Facture` et `TarTypeCli` ; si TRIEQU-A02 est validée (afficher le prix client), il
  devra réutiliser la fonction de `Facture` plutôt que ce calcul partiel.

### Réduction de portée

- `Deplacement`, `Tarifclient`, `Tris`, `Deb2`, `Deb3`, `Dbclk` : aucun appelant externe
  (vérifié) → `Private` (`Tarifclient` supprimée par TRIEQU-002).

### Séparation traitement / GUI

- `RequeteEquivalents(sCode, sTri2, bDesc, iDebut, iNb) As String` pure (texte identique).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clé primaire ou index unique sur `Fiches_Cequ(codequ, codep)` : rendrait le `GROUP BY` de
  dédoublonnage inutile ; index sur `codequ` pour la recherche.
