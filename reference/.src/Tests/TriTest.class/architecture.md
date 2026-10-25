# TriTest — Architecture

> Source : `.src/Tests/TriTest.class`

## Vue d'ensemble

Formulaire de test de [`TriGen`](../../Affichages/TriGen.class/architecture.md) : un `Panel1` où
`TriGen` dessine sa grille, un `TextBox1` qui reçoit la valeur choisie et une case `CheckBox1`
(« en stock ») qui ajoute un filtre imposé.

**Étude allégée (décision utilisateur)** : TriTest est considéré comme l'implémentation d'un test de
`TriGen` ; seules son API de test et ses dépendances sont décrites. Le comportement testé est
documenté dans [TriGen/architecture.md](../../Affichages/TriGen.class/architecture.md).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Bsel` | var | Public |  | Boolean | 3 |
| `Bval` | var | Public |  | String | 4 |
| `tr` | var | Private |  | TriGen | 6 |
| `Col` | var | Private |  | Collection | 7 |
<!-- /AUTO:declarations -->

`Bsel`/`Bval` sont écrits par `TriGen.Close` via `Object.SetProperty` (protocole de retour commun à
toutes les fenêtres de sélection) : portée `Public` nécessaire.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 10-43 | Public | 2 | 20 | 0 | méthode spéciale |
| `form_Close` | 45-50 | Public | 1 | 4 | 0 | handler GUI |
| `ColTri_MajSel` | 52-61 | Public | 2 | 8 | 0 | handler GUI |
| `CheckBox1_Click` | 64-72 | Public | 2 | 7 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (constructeur)] [nature : mixte] : requête sur
  `Cbase.Table("TabArt")` (code, désignation, fournisseur, famille, quantité, et colonne calculée
  `bgcolor` selon `art_suspendu`/`art_stocke`/`art_qte`) ; construit la `Collection` des colonnes
  (`ResultField` → libellé d'en-tête) ; crée `New TriGen(Panel1, Col, Res, Req, 20, Me) As "ColTri"`.
  Deux variantes commentées (fenêtre propre `Null`, parent `Me`) : traces d'essais.
- **`form_Close()`** [handler] : imprime `Bsel` et `Bval` (sortie standard).
- **`ColTri_MajSel(val)`** [handler de l'événement `MajSel` de TriGen] : recopie `Bval` dans
  `TextBox1`, ou vide le champ et fait `Stop Event` si la sélection est annulée.
- **`CheckBox1_Click()`** [handler] : `tr.ExtraSel("art_qte > 0 and art_stocke = 1", "and")` ou
  retrait du filtre imposé.

## État global utilisé

`Utils.db`, `Cbase`. Aucun état partagé écrit.

## Propositions d'amélioration

### Réécriture / refactorisation

- Enrichir le formulaire en **banc de test de `TriGen`** (TRITEST-002) : boutons ou options pour
  chaque scénario de TRIGEN-T01 à T09 (filtre/tri, pagination, sélection simple, colonnes `cle`,
  sélection multiple, filtre sans résultat, caractères spéciaux, impression, fenêtre propre), et une
  sortie texte déterministe (valeurs de `Bsel`/`Bval`, nombre de lignes, requête générée) pour la
  comparaison entre les deux clones.

### Commonalisation avec d'autres fichiers

Aucune : le code de création d'une `TriGen` est l'idiome des appelants réels (TriArticles, TriCpt…).

### Réduction de portée

Aucune : handlers et `Bsel`/`Bval` restent `Public`.

### Séparation traitement / GUI

Sans objet (banc d'essai GUI).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

Aucune.
