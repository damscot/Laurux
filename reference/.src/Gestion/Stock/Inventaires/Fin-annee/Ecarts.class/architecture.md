# Ecarts — Architecture

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class`

## Vue d'ensemble

Édition PDF des **écarts d'inventaire** (menu 83, [`Fmenu.class:1070`](../../../../../Communs/Fmenu.class/architecture.md), `Ecarts.Show`) : pour chaque ligne **comptée** de `Fiches_Inv`,
n° de ligne, code, désignation (42 caractères), stock théorique `inv_qtestock`, quantité comptée,
écart (`inv_qtecomptee - inv_qtestock`) et sa valorisation au prix d'achat (`art_paht`) et au
PMP (`art_pmp`) **actuels** de l'article, avec totaux. Fichier `~/tmp/Ecarts.pdf`, gabarit `Cstocks`
(`Level1E`/`Level2E`/`Level3E`), pagination à 283 mm.

Chaîne : [Geninv](../Geninv.class/architecture.md) → [SaisieInv](../SaisieInv.class/architecture.md) → **Ecarts** → [Validinv](../Validinv.class/architecture.md). Les lignes non comptées sont dans [Ednsaisis](../Ednsaisis.class/architecture.md).

Jumeau : [EcartsT](../../Tournant/EcartsT.class/architecture.md) (91 % de lignes communes, 7 fonctions homonymes sur 7) ; 62 % des lignes sont
aussi communes avec `Ednsaisis` (même squelette d'édition). Les fonctions `Level1`, `Level2`,
`Level3` (dessin `Draw` de l'ancienne impression) ne sont plus appelées.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 27 |
| `son` | var | Private |  | Integer | 28 |
| `Decm` | var | Private |  | String | 29 |
| `PosY` | var | Private |  | Integer | 30 |
| `pdf` | var | Private |  | Cstocks | 31 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 33-61 | Public | 5 | 25 | 0 | méthode spéciale |
| `Button1_Click` | 63-138 | Public | 5 | 73 | 0 | handler GUI |
| `Level1` | 141-164 | Public | 1 | 22 | 0 | portée réductible ? |
| `Level2` | 167-181 | Public | 1 | 13 | 0 | portée réductible ? |
| `Level3` | 184-202 | Public | 1 | 17 | 0 | portée réductible ? |
| `button2_Click` | 204-209 | Public | 3 | 4 | 0 | handler GUI |
| `Button4_Click` | 211-215 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : mixte]. `Utils.Observers(Me)`, puis
  `Try SELECT * FROM Fiches_Inv` (littéral) : la date de la 1re ligne est convertie en texte
  (`mm/dd/yyyy` → `dd/mm/yyyy` par `Mid`/`Left`/`Right`) dans le label `Dte` ; table vide ou
  absente → message « aucun inventaire » et `Me.Close` dans le constructeur (comportement de
  `Ecarts.Show` ensuite à confirmer).
- **`Button1_Click()`** [portée : nécessaire (handler, « Imprimer »)] [nature : mixte].
  `SELECT * FROM Fiches_Inv WHERE inv_comptee = 1` **sans `ORDER BY`**, puis `SELECT * FROM Fiches_Art
  WHERE art_code = &1` par ligne **sans `Available`** (article supprimé → erreur non gérée).
  Calcule écart et valeurs (`Format$(… , "0.00")`), cumule les totaux en chaînes, pagine, puis
  `Visualiseur.Prog`. Aucune ligne comptée → « Aucun article ». `Nbpage` inutilisés ;
  `Shell "cd ~"` sans effet. Partie extractible : lecture et calcul des lignes.
- **`Level1()`, `Level2(…)`, `Level3(…)`** [portée : réductible — **code mort**] [nature : GUI].
  Dessin `Draw` de l'ancienne édition ; aucun appel (`grep` : seuls des `pdf.Level*E` de
  `Cstocks` sont utilisés). Signalées `unused` par `deps.py` : confirmé.
- **`button2_Click()`** [handler] [GUI]. Supprime le PDF, ferme.
- **`Button4_Click()`** [handler] [GUI]. Aide `Doc.Open("Ecarts")`.

## État global utilisé

- `Start.Son`, `Start.Musique` ; `Utils.db`, `Utils.PointBase`,
  `Utils.Observers` ; `Cstocks`, `Visualiseur`, `Doc`.
- Tables (littéraux) : `Fiches_Inv`, `Fiches_Art` (lecture seule).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Level1/2/3` et les variables mortes ; calculer les totaux en `Float` et ne formater
  qu'à l'affichage (même texte produit, à vérifier par le replay).

### Commonalisation avec d'autres fichiers

- Module `Inventaire` (voir [Geninv](../Geninv.class/architecture.md)) : `DateInv(sType)`, `Lignes(sType, 1)`,
  `Libelle(sType)` ; une procédure d'édition paramétrée `EditionEcarts(sType)` servirait les deux
  jumeaux (`Ecarts`, `EcartsT`), les `.form` restant distincts.
- Squelette « édition paginée `Cstocks` » (en-tête, lignes, saut de page à 283 mm, total)
  commun avec `Ednsaisis*`, `Edinv` et `Gestion/Depots/ImpDepots`, `Edsdepots`.

### Réduction de portée

- `Level1`, `Level2`, `Level3` : code mort (suppression plutôt que réduction).

### Séparation traitement / GUI

- `Button1_Click` : fonction `LignesEcarts() As Variant[]` (code, désignation, quantités, écart,
  valeurs) sans contrôle ; le handler ne fait que la mise en page.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Stocker dans la table d'inventaire le PA et le PMP à la date de génération pour valoriser les
  écarts à cette date (aujourd'hui : prix actuels).
