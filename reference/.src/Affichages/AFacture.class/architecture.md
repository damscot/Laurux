# AFacture — Architecture

> Source : `.src/Affichages/AFacture.class`

## Vue d'ensemble

D'après le code, `AFacture` est une **fenêtre modale de consultation des lignes d'un document de
vente** (BL, facture en cours) : l'en-tête (numéro, code et nom du client, date) est passé par
l'appelant ; les lignes sont lues dans `Fiches_Ligbl` (`Cbase.Table("TabLigbl")`) et, à défaut,
dans l'archive `Fiches_LigblM` (nom en dur). Elles sont affichées dans la `ColumnView` `Colrcp3`
(ligne, code, désignation, quantité, prix brut HT, remise, prix net HT), avec le total HT et le
nombre de lignes. Les lignes de commentaire (`typel_ligbl = "C"`) sont éclatées sur plusieurs
lignes de la vue.

Appelants : `Facture.AffDoc`, `Facturefm.Coldetail_Activate`, `Facturergbl.Coldetail_Activate` et
`Articles.Colcom_Activate` (liste des ventes de l'article). Lecture seule, aucun retour. Pas de
`Utils.Observers(Me)`.

Nature : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `numbl` | var | Private |  | String | 3 |
<!-- /AUTO:declarations -->

| Variable | Usage |
|---|---|
| `numbl` | numéro du document affiché |

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 5-15 | Public | 1 | 9 | 0 | méthode spéciale |
| `DocVentes` | 17-88 | Public | 12 | 65 | 0 | portée réductible ? |
| `Codecli_KeyPress` | 90-94 | Public | 6 | 3 | 0 | handler GUI |
| `Button3_Click` | 96-101 | Public | 1 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new($num, $code, $nom, $date)`** [portée : nécessaire (constructeur)] [nature : GUI] :
  centre, remplit l'en-tête, appelle `Docventes` (casse indifférente).
- **`DocVentes()`** [portée : réductible] [nature : mixte] : 7 colonnes et titres ; `SELECT * FROM
  TabLigbl WHERE num_ligbl = &1`, sinon `SELECT * FROM Fiches_LigblM WHERE num_ligbl = &1`. Si aucune
  ligne n'est trouvée, `Button3_Click` ferme la fenêtre **mais l'exécution continue** : le
  `If Not Error` ne teste rien (aucun `Try` avant) et le `Repeat` lit `Rcli!typel_ligbl` sur un
  résultat vide → erreur ; l'appelant fait ensuite `ShowModal` sur une fenêtre déjà fermée
  (AFACTURE-A01). Pour chaque ligne article : clé `numlig_ligbl` (colonne 0), code si l'article
  existe, quantité formatée `Utils.CDec` **écrite en colonne 2 puis écrasée** par la désignation
  (colonne 3 = quantité brute, AFACTURE-A02), prix, remise, net ; total HT par `Val()` des montants
  stockés en texte localisé (saisis depuis les `TextBox` de `Facture`, virgule décimale). Lignes
  commentaire : une ligne par ligne de texte. `Nlgf` recalculé à chaque tour.
- **`Codecli_KeyPress()`** [handler] : Échap (deux tests équivalents) ou F2 → `Button3_Click`.
- **`Button3_Click()`** [handler] : vide la vue et ferme.

## État global utilisé

- `Utils.db.Exec`, `Utils.CDec` ; `Cbase.Table("TabLigbl")`, `("TabArt")` ; table `Fiches_LigblM`
  en dur (la clé `TabLigblM` existe dans `Cbase`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Cbase.Table("TabLigblM")` au lieu de `Fiches_LigblM` (même texte SQL).
- Supprimer l'écriture morte de la colonne 2, le `Nlgf` dans la boucle, le `If Not Error` sans
  `Try`, le double test d'Échap, les lignes commentées et le `With Utils`.

### Commonalisation avec d'autres fichiers

- [`TriHistos.DocVentes`](../TriHistos.class/architecture.md) (branche BL) et
  [`ACom.DocCom`](../ACom.class/architecture.md) : même mise en page et même boucle → module commun
  `DetailDocument` (TRIHISTOS-006). `AFacture` est l'implémentation la plus simple et servirait de
  référence.

### Réduction de portée

- `DocVentes` → `Private` (vérifié : aucun appel externe).

### Séparation traitement / GUI

- `LignesDocument(sNum) As Result` (choix `Fiches_Ligbl` / `Fiches_LigblM`) et
  `TotalLignes(rLignes) As Float` ; `DocVentes` n'affiche plus que le résultat.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `netht_ligbl`, `qte_ligbl`… en `varchar` au format localisé : des `DECIMAL` éviteraient la
  dépendance à la locale de `Val()` (vérifié par `gbs3` : en `fr_FR`, `Val("12.50")` vaut `Null`,
  `Val("12,50")` vaut 12,5).
