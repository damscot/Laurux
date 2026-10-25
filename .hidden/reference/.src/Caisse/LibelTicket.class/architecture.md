# LibelTicket — Architecture

> Source : `.src/Caisse/LibelTicket.class`

## Vue d'ensemble

Écran de saisie d'un **texte unique** : le texte de fin de ticket de caisse (4 lignes de 72 caractères annoncées). Le texte est stocké dans la table mono-ligne
`Fiches_LibelTicket` (colonne `libeltk`, via `Cbase.Table("TabLibelTicket")`) et lu par la caisse (`Caisse.class:4008`, avant l'impression du ticket).
L'écran est ouvert en modal par le menu de gestion ([`Fmenu`](../../Communs/Fmenu.class/architecture.md),
`Menu207_Click`).

Le couple LibelTicket / LibelAvoirs est une copie quasi identique (seuls la table, la
colonne, le contrôle et la page d'aide changent) de [`LibelFac`](../../Gestion/Tables/LibelFac.class/architecture.md)
(bas de facture), lui-même voisin de `Tleg` et `Tmail` (« texte unique », TLEG-003).

Contrôles du `.form` : `Txtbfac` (TextArea), `Button1` (aide, hors groupe), `Button2`
(Enregistrer, tag 2) et `Button3` (Quitter, tag 3) dans le groupe **`Btn`**.

Nature : **mixte** (SQL dans les handlers). L'écran n'appelle pas `Utils.Observers(Me)` : il
n'est **pas journalisé** et donc pas rejouable en l'état (LIBELTICKET-A02).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 28-33 | Public | 1 | 4 | 0 | méthode spéciale |
| `Form_Open` | 35-42 | Public | 2 | 5 | 0 | handler GUI |
| `Btn_Click` | 44-60 | Public | 4 | 9 | 0 | handler GUI |
| `Button2_Click` | 62-76 | Public | 3 | 12 | 0 | portée réductible ? |
| `Button1_Click` | 81-85 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI] : `Music.Load(Start.Musique)`
  (le son n'est jamais joué dans cet écran), `Me.Center`.
- **`Form_Open()`** [nécessaire, handler] [mixte] : `SELECT * FROM Fiches_LibelTicket` (sans `WHERE`,
  table mono-ligne) ; si une ligne existe, `Txtbfac.Text = libeltk`.
- **`Btn_Click()`** [nécessaire, handler du groupe `Btn`] [GUI] : `Select Case Last.Tag` :
  1 → rien (appel commenté, et `Button1` n'est pas dans le groupe : branche morte), 2 →
  `Button2_Click()`, 3 → `Me.Close`.
- **`Button2_Click()`** [réductible] [mixte] : `Button2` appartient au groupe `Btn`, donc ce
  n'est **pas** un handler levé par Gambas mais une méthode appelée par `Btn_Click` (signal
  `scope_reducible` confirmé ; le rejeu d'un bouton passe par `Value = True`, qui lève
  `Btn_Click`). Applique `Utils.ReplaceLb` (`"` → `''`, `&` → `et`) au texte, puis s'il
  n'est pas vide : `INSERT INTO Fiches_LibelTicket(libeltk) VALUES (&1)` si la table est vide, sinon
  `UPdate Fiches_LibelTicket SET libeltk = &1` (**sans `WHERE`**, volontaire : table mono-ligne). Texte vide :
  rien n'est enregistré (LIBELTICKET-A01). Aucun retour visuel.
- **`Button1_Click()`** [nécessaire, handler] [GUI] : `Doc.Open("BasTicket")` (aide HTML).

Aucun signal `unused`, `handlers_inactifs`, `replay_*` ni `arity_errors` pour ce fichier.

## État global utilisé

- `Utils.db`, `Cbase.Table("TabLibelTicket")`, `Utils.ReplaceLb`, `Start.Musique`, `Music`, `Doc`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Music.Load` et la branche vide `Case 1` (code mort).
- Isoler la lecture et l'écriture dans deux fonctions privées sans contrôle :
  `LitTexte() As String` et `EcritTexte(sTexte)` ; les handlers ne gèrent que `Txtbfac`.

### Commonalisation avec d'autres fichiers

- Fonctions « texte unique » `LitTexteUnique(sTabKey, sColonne)` / `EcritTexteUnique(…)`
  proposées par [`Tleg`](../../Gestion/Tables/Tleg.class/architecture.md) (TLEG-003) et
  [`LibelFac`](../../Gestion/Tables/LibelFac.class/architecture.md) (LIBELFAC-004) : LibelTicket et
  [`LibelAvoirs`](../LibelAvoirs.class/architecture.md) en sont les deux derniers clients. Les lecteurs côté
  caisse (`Caisse.class:289` avec la table en dur, `Caisse.class:4008`) pourraient utiliser la
  même lecture.

### Réduction de portée

- `Button2_Click` → `Private` (pseudo-handler, appelé seulement par `Btn_Click`).

### Séparation traitement / GUI

- Voir « Réécriture » : extraction de `LitTexte`/`EcritTexte` (SQL identique).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les cinq textes uniques (`Fiches_LibelTicket`, `Fiches_LibelAvoirs`, `Fiches_LibelFac`,
  `Fiches_Tleg`, texte de `Tmail`) pourraient devenir des lignes d'une table de paramètres
  texte (`clé`, `valeur`).
- `libeltk` est un `varchar(250)` alors que l'écran annonce 4 lignes de 72 caractères
  (288 caractères + sauts de ligne) : passer en `varchar(320)` ou `TEXT` (voir LIBELTICKET-A03).
