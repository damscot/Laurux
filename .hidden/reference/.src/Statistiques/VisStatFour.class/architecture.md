# VisStatFour — Architecture

> Source : `.src/Statistiques/VisStatFour.class`

## Vue d'ensemble

Visualisation du « Chiffre d'affaire fournisseur » calculé par
[`StatFour`](../StatFour.class/architecture.md) (`New VisStatfour(Me, Start.Societe, Son,
DteN0, DteN1)`). Lit `Total` (`cdfour`, `nmfour`, `montant`, `montant1`), l'affiche dans `Liste`
(ColumnView, 5 colonnes : code, nom, montant, net N-1, % N/N-1) et imprime un PDF
`~/tmp/Statfour.pdf` (`Chistoriques.Level1FO`/`level2FO`/`Level4FO`/`Level5FO`). L'en-tête de
commentaire porte le nom `VisStatCli.class` (copie).

Particularités : **pas d'appel à `Utils.Observers(Me)`** (écran non journalisé, non rejouable),
5 méthodes d'impression `Level0`…`Level5` basées sur `Draw` (ancienne impression) **jamais
appelées**.

Nature globale : **GUI**, lecture seule de `Total`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `total` | var | Public |  | Integer | 27 |
| `value` | var | Public |  | Float[] | 28 |
| `Dtn0` | var | Public |  | String | 29 |
| `Dtn1` | var | Public |  | String | 30 |
| `Tri` | var | Public |  | String | 31 |
| `sens` | var | Public |  | String | 32 |
| `Filename` | var | Private |  | String | 33 |
| `son` | var | Private |  | Integer | 34 |
| `PosY` | var | Private |  | Integer | 35 |
| `Page` | var | Private |  | Integer | 36 |
| `Coulfond` | var | Private |  | New String[] | 37 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 39-67 | Public | 1 | 27 | 0 | méthode spéciale |
| `Affichage` | 69-103 | Public | 8 | 32 | 0 | portée réductible ? |
| `Sens_Aff` | 105-113 | Public | 2 | 7 | 0 | portée réductible ? |
| `Bcode_Click` | 115-120 | Public | 1 | 4 | 0 | handler GUI |
| `Bnom_Click` | 122-127 | Public | 1 | 4 | 0 | handler GUI |
| `Ca_Click` | 129-134 | Public | 1 | 4 | 0 | handler GUI |
| `Ca1_Click` | 136-141 | Public | 1 | 4 | 0 | handler GUI |
| `Button2_Click` | 143-205 | Public | 6 | 60 | 0 | handler GUI |
| `Level0` | 208-215 | Public | 1 | 6 | 0 | portée réductible ? |
| `Level1` | 218-235 | Public | 1 | 16 | 0 | portée réductible ? |
| `level2` | 238-249 | Public | 1 | 10 | 0 | portée réductible ? |
| `Level4` | 252-265 | Public | 1 | 12 | 0 | portée réductible ? |
| `Level5` | 268-281 | Public | 1 | 12 | 0 | portée réductible ? |
| `Button1_Click` | 283-288 | Public | 3 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New(Hitniv, Soc, Sn, Dte1, Dte2)`** [portée : nécessaire (spéciale)] [nature : GUI] :
  mémorise `son`, `Dtn0`, `Dtn1`, configure les colonnes, `Tri = "cdfour"`, `Sens = "desc"`,
  `Affichage`. Pas d'`Utils.Observers`.
- **`Affichage()`** (CC 8, max) [portée : réductible] [nature : mixte]. `filename =
  "~/tmp/Edstatfour.kud"` (jamais créé) ; `Tab2 = "Fiches_art"` inutilisé ; `SELECT * FROM Total
  ORDER BY <Tri> <Sens>` si `Bnom` ou `Bcode` (opérateur `Or If`), sinon `lpad(<Tri>, 12, ' ')` ;
  boucle `Totl` **inutilisée** ; par ligne, % = `(montant − montant1) × 100 / montant`, c'est-à-dire
  rapporté au **montant N** (dans `VisStatTypCli`, rapporté au N-1 : VISSTATFOUR-A01), `Try`
  (division par zéro ignorée).
- **`Sens_Aff()`** [portée : réductible] [nature : calcul] : bascule asc/desc (5 copies).
- **`Bcode_Click`, `Bnom_Click`, `Ca_Click`, `Ca1_Click`** [handlers RadioButton, `Public`
  obligatoire] [nature : GUI] : `Tri` = `cdfour`, `nmfour`, `montant`, `montant1`, puis
  `Affichage`.
- **`Button2_Click()`** (« Imprimer ») [handler] [nature : GUI] : `Shell "cd ~"` sans effet,
  `Coulfond` relu mais inutilisé ; une ligne `level2FO` par ligne de grille ; saut de page à
  283 mm avec le titre « Impression du CA **clients** » (copie, VISSTATFOUR-A02) ; total % global
  `(tot1 − totn1) × 100 / tot1` (erreur de division si `tot1 = 0`, à confirmer) ;
  `If tot1 < totn1 Then totpourcent = totpourcent` (sans effet).
- **`Level0(dtn0, dtn1)`, `Level1()`, `level2(…)`, `Level4()`, `Level5(…)`** [portée :
  réductible] [nature : GUI] — **code mort** (signal `unused`, vérifié par `grep` : aucun appel,
  aucune chaîne dynamique) : dessin `Draw.*` d'un ancien état imprimé, remplacé par
  `Chistoriques`.
- **`Button1_Click()`** (« Quitter ») : supprime `filename` (le PDF si imprimé) puis ferme.

## État global utilisé

- `Start.Son`, `User.Home`, `Utils.Coulfd`, `Utils.db`.
- Table de travail `Total` (structure de `StatFour`, partagée : STATFOUR-A05).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Level0`…`Level5`, la boucle `Totl`, `total`, `value`, `Coulfond`, `Page`, `Tab2`,
  le nom `.kud`, `Shell`, l'instruction sans effet de la ligne 197.
- Corriger l'en-tête de commentaire (`VisStatFour.class`, « CA par fournisseur »).

### Commonalisation avec d'autres fichiers

- Socle `VisStat*` ([VisStatComm](../VisStatComm.class/architecture.md)) : `SensInverse`,
  `RequeteTotal`, `ImprimeListe`, et `Evolution(n, n1)` partagé avec
  [`VisStatTypCli`](../VisStatTypCli.class/architecture.md) (formules à unifier : A01).
  `dup.py` : 84 à 95 lignes communes avec les autres `VisStat*` (ratio 0,40 à 0,45, plus faible à
  cause du code mort `Level*`).

### Réduction de portée

- `Affichage`, `Sens_Aff`, `Dtn0`, `Dtn1`, `Tri`, `sens` → `Private` ; `Level0`…`Level5`,
  `total`, `value` supprimés.

### Séparation traitement / GUI

- `Affichage` : extraire `LignesTotal(sTri, sSens, bBrut)` (requête + %).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Voir `StatFour`.
