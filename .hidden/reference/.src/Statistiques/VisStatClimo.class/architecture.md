# VisStatClimo — Architecture

> Source : `.src/Statistiques/VisStatClimo.class`

## Vue d'ensemble

Visualisation du « Chiffre d'affaires produits et main d'oeuvre par client » calculé par
[`StatClimo`](../StatClimo.class/architecture.md) (`New VisStatClimo(Me, Start.Societe, son,
dteN0, dteN1)`). Lit `Total` (une ligne par client), l'affiche dans `Liste` (ColumnView,
8 colonnes : code, nom, prénom, pièces, remise pièces, M.O., remise M.O., total net) et imprime
un PDF `~/tmp/Statpmc.pdf` (`Chistoriques.Level1P`/`level2P`/`Level4P`/`Level5P`).

Nature globale : **GUI**, lecture seule.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `total` | var | Public |  | Integer | 29 |
| `value` | var | Public |  | Float[] | 30 |
| `Dtn0` | var | Public |  | String | 31 |
| `Dtn1` | var | Public |  | String | 32 |
| `Tri` | var | Public |  | String | 33 |
| `sens` | var | Public |  | String | 34 |
| `Filename` | var | Private |  | String | 35 |
| `son` | var | Private |  | Integer | 36 |
| `PosY` | var | Private |  | Integer | 37 |
| `Coulfond` | var | Private |  | New String[] | 38 |
| `Nbpage` | var | Private |  | Integer | 39 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 41-85 | Public | 1 | 42 | 0 | méthode spéciale |
| `Affichage` | 87-112 | Public | 3 | 23 | 0 | portée réductible ? |
| `Sens_Aff` | 114-122 | Public | 2 | 7 | 0 | portée réductible ? |
| `Bcode_Click` | 124-129 | Public | 1 | 4 | 0 | handler GUI |
| `Bnom_Click` | 131-136 | Public | 1 | 4 | 0 | handler GUI |
| `Bpieces_Click` | 138-143 | Public | 1 | 4 | 0 | handler GUI |
| `Bremp_Click` | 145-150 | Public | 1 | 4 | 0 | handler GUI |
| `Bmo_Click` | 152-157 | Public | 1 | 4 | 0 | handler GUI |
| `Bremmo_Click` | 159-164 | Public | 1 | 4 | 0 | handler GUI |
| `Button2_Click` | 166-242 | Public | 4 | 74 | 0 | handler GUI |
| `Button1_Click` | 245-250 | Public | 3 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New(Hitniv, Soc, Sn, dte1, dte2)`** [portée : nécessaire (spéciale)] [nature : GUI] :
  `Utils.Observers(Me)` une fois, `Coulfond`/`Frmt` lus inutilement, colonnes, `Tri =
  "cdclifac"`, `Sens = "desc"`, `Affichage`.
- **`Affichage()`** [portée : réductible] [nature : mixte] : `SELECT * FROM Total ORDER BY <Tri>
  <Sens>` (pas de variante `lpad` ici) ; colonnes formatées `"0.00"` ; total = `TotA + TotM −
  RemP − RemMo`. Pas de ligne de totaux à l'écran.
- **`Sens_Aff()`** [portée : réductible] [nature : calcul] : bascule asc/desc (5 copies).
- **`Bcode_Click`, `Bnom_Click`, `Bpieces_Click`, `Bremp_Click`, `Bmo_Click`, `Bremmo_Click`**
  [handlers RadioButton, `Public` obligatoire] [nature : GUI] : `Tri` = `cdclifac`, `nmclifac`,
  `TotA`, `RemP`, `TotM`, `RemMo`, puis `Affichage`.
- **`Button2_Click()`** (« Imprimer ») [handler] [nature : mixte] : `Shell "cd ~"` ; le PDF est
  ouvert (`Entete`, `Level0F`, `Level1P`) **avant** le test `Liste.Count` ; `SELECT * FROM
  Fiches_Societes WHERE cd_sc = Start.Societe` → `Ste` **jamais utilisé** (requête inutile, nom
  de table en dur) ; les montants de chaque ligne sont relus par `Val()` (Float) puis passés à
  `level2P` dont les paramètres sont des `String` : la conversion implicite Float → String n'est
  **ni localisée ni formatée** (`12.5` au lieu de `12,50`, vérifié avec gbs3 en locale fr_FR),
  alors que la ligne de total `level5P` reçoit des `Format$(…, "0.00")` (VISSTATCLIMO-A01) ; saut
  de page à 283 mm ; `Visualiseur.Prog`.
- **`Button1_Click()`** (« Quitter ») : supprime le PDF puis ferme.

## État global utilisé

- `Start.Societe`, `Start.Son`, `User.Home`, `Utils.Observers`, `Utils.Coulfd`, `Utils.FColr`,
  `Utils.db`.
- Table de travail `Total` (structure de `StatClimo`, partagée : STATCLIMO-A05).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `total`, `value`, `Coulfond`, `Frmt`, `Tab`, `Nbpage`, `Shell`, la requête
  `Fiches_Societes` et `Ste` (SQL modifié, lecture seule).
- Ouvrir le PDF après le test `Liste.Count` (sans effet visible : `Total` n'est jamais vide à
  l'ouverture de l'écran).

### Commonalisation avec d'autres fichiers

- Socle `VisStat*` ([VisStatComm](../VisStatComm.class/architecture.md)) : `SensInverse`,
  `RequeteTotal`, `ImprimeListe`. `dup.py` : 83 à 97 lignes communes avec les autres `VisStat*`.

### Réduction de portée

- `Affichage`, `Sens_Aff`, `Dtn0`, `Dtn1`, `Tri`, `sens` → `Private` ; `total`, `value`
  supprimés.

### Séparation traitement / GUI

- `Affichage` : extraire `LignesTotal(sTri, sSens)` ; `Button2_Click` : extraire le calcul des
  totaux (`TotauxListe`) de la boucle d'impression.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Voir `StatClimo`.
