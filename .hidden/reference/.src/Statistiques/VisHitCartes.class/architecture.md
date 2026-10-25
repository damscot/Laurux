# VisHitCartes — Architecture

> Source : `.src/Statistiques/VisHitCartes.class`

## Vue d'ensemble

`VisHitCartes` **affiche et imprime le hit-parade des cartes de fidélité** calculé par
[`HitCarte`](../HitCarte.class/architecture.md). Il est créé par `New VisHitCartes(Me, Tot, son, tri,
dteN0.Text, dteN1.Text)` (`HitCarte.class:223`) puis montré en non modal. Le constructeur lit la table
de travail `Total` (triée par points ou par visites, `LIMIT Tot`), remplit la `ColumnView` `Liste`
(rang, carte, nom, points, visites, % des points) et dessine un histogramme des 20 premières cartes
au plus sur `drwChart`. **Imprimer** produit un PDF (`Chistoriques`) à partir des lignes de la liste ;
**Quitter** supprime le fichier et ferme.

Nature globale : **mixte** (lecture SQL et calcul des pourcentages dans `_New`, rendu GUI, impression).
`Utils.Observers(Me)` est appelé une fois dans `_New`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `total` | var | Private |  | Integer | 27 |
| `value` | var | Private |  | Float[] | 28 |
| `Dtn0` | var | Private |  | String | 29 |
| `Dtn1` | var | Private |  | String | 30 |
| `Filename` | var | Private |  | String | 31 |
| `son` | var | Private |  | Integer | 32 |
| `Totl` | var | Private |  | Float | 33 |
| `PosY` | var | Private |  | Integer | 34 |
| `Coulfond` | var | Private |  | New String[] | 35 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 37-104 | Public | 6 | 65 | 0 | méthode spéciale |
| `Draw_Chart` | 109-176 | Public | 7 | 53 | 0 | portée réductible ? |
| `Button2_Click` | 178-220 | Public | 4 | 40 | 0 | handler GUI |
| `Button1_Click` | 223-228 | Public | 3 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New(Hitniv As HitCarte, Tot, Sn, tri, dte1, dte2)`** [portée : nécessaire (spéciale)] [nature :
  mixte]. `Hitniv` n'est jamais utilisé ; `Frmt` (couleurs) et `Coulfond` sont lus sans usage visible
  (`Coulfond` n'est utilisé nulle part). Configure 6 colonnes de `Liste`, puis
  `SELECT * FROM Total order by points deSC LIMIT <Tot>` (tri `"P"`) ou `order by visite deSC` (sinon) ;
  la limite est concaténée (entier, sans risque d'injection). Premier parcours : `Totl` = somme des
  points des lignes retenues ; second parcours (`MoveFirst`) : une ligne par carte avec
  `Format$(points, "0.00")` et le ratio `points / Totl * 100` (**division par zéro** si toutes les cartes
  ont 0 point), et `value[n] = Val(.Item[3])` (relit le texte formaté). Limite le graphique à 20
  barres puis appelle `Draw_Chart`. Partie extractible : la requête et le calcul des ratios.
- **`Draw_Chart()`** [portée : réductible] [nature : GUI]. Normalise `value[i]` en dixièmes de la somme
  (`sumdata` est un `Integer` : la somme des Float est tronquée, à confirmer sur le rendu), dessine
  l'axe 0..100 et une barre par rang (couleur `color.RGB(i*100, i*10, i*50)`) ; une barre est dessinée
  même pour une valeur nulle (trait fin noir). `colors[]` est calculé sans être lu. Routine
  « Yudi Astira », variante de [`TBord.Draw_Chart`](../TBord.class/architecture.md).
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : mixte]. `Shell "cd ~"` (sans effet),
  `New Chistoriques("Portrait", "mm", "A4")`, `Entete("Impression du hit parades …")`,
  `Level0F(dtn0, dtn1)`, `Level1H()`, puis pour chaque ligne de `Liste` (en la **sélectionnant**,
  effet de bord visible) `level2H(carte, nom, points, posY)` ; saut de page à `PosY >= 283` (`Footer`,
  `Entete` avec un titre légèrement différent « hit parade », `Level0F`, `Level1H`) ; `Lines`,
  `Footer`, `Output(Filename)` vers `~/tmp/Edhit.kud` (extension `.kud` pour un PDF) puis
  `Visualiseur.Prog`. Les visites ne sont pas imprimées. La variable `dte` est inutilisée. Le curseur
  final est `Mouse.Pointing` (et non `Default`).
- **`Button1_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Supprime `~/tmp/Edhit.kud` s'il
  existe, ferme la fenêtre.

## État global utilisé

- `Start.Son` (remplacé par le paramètre `Sn`), `Start.LocalSettings["/Coul/Fnets"]`.
- `Utils.Observers`, `Utils.Coulfd`, `Utils.FColr`, `Utils.db`.
- Table de travail `Total` écrite par `HitCarte` (contrat implicite sur ses colonnes).
- `Chistoriques` (`.src/Reports`), `Visualiseur.Prog`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Tab3`, `Frmt`, `Coulfond`, `colors`, `dte`, `Shell "cd …"` ; le paramètre `Hitniv`
  peut être retiré avec la mise à jour de `HitCarte` dans le même commit (appel à 5 arguments puis
  `Parent` non fourni, voir les acquis sur `New` d'une classe `Form`), ou conservé.
- Calculer `value[n]` à partir du Float lu et non du texte formaté (même valeur arrondie à 2
  décimales).
- Unifier le titre de l'impression (deux libellés différents selon la page) : changement du PDF,
  donc à valider (cosmétique, non retenu comme rework autonome).

### Commonalisation avec d'autres fichiers

- `Draw_Chart` : helper d'histogramme commun avec [`TBord`](../TBord.class/architecture.md)
  (TBORD-007).
- Impression `Chistoriques` (`Entete`/`Level0F`/`Level1H`/`level2H`, saut de page à 283) : même
  séquence dans `VisStatClimo`, `VisStatTypCli`, `VisStatFour`, `VisStatComArt`, `VisStatComm` ; un
  helper `Chistoriques.SautDePage(titre, dtn0, dtn1)` réduirait la duplication (à évaluer en phase 3
  avec le rework de [`Chistoriques`](../../Reports/Chistoriques.class/architecture.md)).

### Réduction de portée

- `Draw_Chart` : aucun appelant externe → `Private`. `Button1_Click`, `Button2_Click` restent
  `Public` (handlers).

### Séparation traitement / GUI

- `_New` → `LitHitParade(tri, total) As Result` et `Ratios(points As Float[]) As Float[]` (calcul pur
  testable en gbtest) ; le constructeur garde la configuration de `Liste` et le remplissage.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune propre à cet écran ; voir la table de travail `Total` dans
  [`HitCarte`](../HitCarte.class/architecture.md).
