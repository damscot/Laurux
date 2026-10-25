# Listecom — Architecture

> Source : `.src/Gestion/Stock/Listecom.class` · Formulaire : `.src/Gestion/Stock/Listecom.form`

## Vue d'ensemble

`Listecom` est une **fenêtre de consultation en lecture seule** : l'historique des achats d'un
client (lignes d'articles `A` et de main-d'œuvre `M` de ses factures et BL, en cours et
« entretien » `…M`). Tout le travail est fait dans le constructeur `_new(snumcli, snumart)` ; il
n'y a aucun handler en dehors de `Form_Close`.

Deux modes d'affichage dans la même `GridView1` :

- **Avec article** (`snumart` non vide, `Facture` Ctrl+A) : une ligne par (date, code, désignation),
  colonnes Code / Désignation / Date / Quantité / Px HT moyen (`net / qte`).
- **Sans article** (`snumart = ""`, `Facture` Ctrl+H, `FClient` bouton 24) : les **10 dernières
  dates** d'achat (facture ou BL de total HT non nul) en colonnes (Date / Quantité / Px HT par
  date), une ligne par article ; la désignation vient de `Fiches_Art`, sinon de `Fiches_Mo`, sinon
  du libellé de la ligne.

Les appelants ouvrent la fenêtre en bas de l'écran (`Y = Screen.AvailableHeight - 100`) et la
ferment avant d'en ouvrir une autre (`Try $lcom.Close`).

Nature globale : **mixte** (SQL de lecture et remplissage de la grille entremêlés dans `_new`).
Aucune écriture en base.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$snumart` | var | Private |  | String | 3 |
| `$snumcli` | var | Private |  | String | 4 |
| `design` | var | Private |  | String | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 7-141 | Public | 14 | 131 | 0 | méthode spéciale |
| `ajouart` | 143-163 | Private | 4 | 18 | 0 |  |
| `rechart` | 165-174 | Private | 3 | 7 | 0 |  |
| `Form_Close` | 176-180 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(snumcli, snumart)`** (CC 14, LOC 131) [portée : nécessaire (constructeur)] [nature :
  mixte]. Appelle `Utils.Observers(Me)`, puis :
  1. lit les dates d'achat : `UNION` de `Fiches_HistoFac`(+`Fiches_HistoLigfac` si article) et
     `Fiches_Bl`(+`Fiches_Ligbl`), triée par date décroissante ; sans article, `LIMIT 10` et
     filtre `totalht <> 0` sur les BL. Les tables `…M` (entretien) ne sont **pas** interrogées
     pour les dates, mais le sont pour les lignes ;
  2. pour chaque date, une requête `UNION` de 4 sous-requêtes (`Fiches_HistoFac[M]` ×
     `Fiches_HistoLigfac[M]`, `Fiches_Bl[M]` × `Fiches_Ligbl[M]`) qui somme `qte_*` et `netht_*`
     (virgule remplacée par un point) par code et libellé, types de ligne `A` et `M` ;
  3. remplit la grille (mode article : une ligne par résultat ; mode client : recherche de la
     ligne de l'article par `rechart`, création par `ajouart`, colonne `1 + index_date × 3`).
  Effets de bord : aucun en base. Tables en dur, sans `Cbase.Table`.
  ⚠️ Points relevés :
  - mode article : `Columns.Count = 1 + res.Count * 4` alors que seules 5 colonnes sont
    utilisées (colonnes vides en trop) ; `Else "0,00"` alors que le format est `"0.000"` ;
  - mode client : la boucle externe s'arrête sur `j >= Columns.Max` ; si une date n'a **aucune**
    ligne `A`/`M` (`res1` vide), `j` n'avance que d'une unité et `res.MoveNext` est appelé
    au-delà de la dernière date (lecture de `res!dte` sur un résultat épuisé, erreur probable, à
    confirmer) ;
  - ligne 106 : pas de `&` entre deux littéraux (`"… GROUP BY code_ligbl,libel_ligbl "` puis
    `"UNION SELECT …"` à la ligne 107) ; la concaténation implicite par le compilateur est à
    vérifier (`gbc3`, voir notes transverses) ;
  - SQLite : `… UNION(SELECT …)` (sous-requête composée entre parenthèses) n'est pas accepté
    par SQLite ; la requête de dates échoue probablement sur une base SQLite (à confirmer).
- **`ajouart(code)`** [portée : Private] [nature : mixte]. Ajoute une ligne à la grille, cherche la
  désignation dans `Fiches_Art` puis `Fiches_Mo`, sinon reprend la variable membre `design`
  (libellé de la ligne courante, effet de bord de `_new`). Le code est stocké dans
  `Rows[i].Text` (en-tête de ligne), sous `Try`.
- **`rechart(code)`** [portée : Private] [nature : GUI]. Recherche linéaire de la ligne dont
  l'en-tête vaut `code` ; renvoie `-2` si absente.
- **`Form_Close()`** [handler, `Public` obligatoire] [nature : GUI]. `Me.Delete` : la fenêtre est
  détruite à la fermeture (les appelants gardent une référence invalide, d'où leurs `Try …Close`).

## État global utilisé

- `Utils.db` (lecture), `Utils.Observers(Me)` (instrumentation log/replay et couleurs).
- `Screen.AvailableWidth` (largeur de la fenêtre en mode client).
- Aucune variable globale écrite ; variable membre `design` utilisée comme canal implicite entre
  `_new` et `ajouart`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire les deux grosses requêtes `UNION` (identiques au filtre `code_ligxx = &3` près) dans
  une fonction privée `ReqLignes(avecArticle As Boolean) As String` qui produit **exactement** le
  même texte SQL.
- Séparer `_new` en `LitDates()`, `RemplitParArticle()`, `RemplitParClient()` (CC 14 → ≤ 6).
- Passer `design` en paramètre de `ajouart` au lieu d'une variable membre.

### Commonalisation avec d'autres fichiers

- La somme « qte/netht avec virgule remplacée » sur les 4 couples de tables factures/BL
  (en cours et entretien) est aussi écrite dans
  [Cstock.module](../../../Utils/Cstock.module/architecture.md) (recalcul du stock) et
  [Stockmvt](../../Stockmvt.class/architecture.md) (mouvements) : une vue ou un générateur de
  sous-requêtes commun « lignes vendues » est envisageable en phase 3 (définitions à aligner, voir
  le tableau des sources de mouvements de `Stockmvt`).
- Recherche de désignation article puis main-d'œuvre (`ajouart`) : même motif dans
  [Facture](../../Facturation/Facture.class/architecture.md) (`Art_man`) et les écrans de stock.

### Réduction de portée

- Rien à réduire : `_new` et `Form_Close` doivent rester `Public`, les deux autres fonctions sont
  déjà `Private`.

### Séparation traitement / GUI

- Les requêtes (dates, lignes, désignation) peuvent être isolées dans des fonctions qui renvoient
  des `Result` sans toucher `GridView1` ; `_new` ne ferait plus que le remplissage.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `qte_*` et `netht_*` sont stockés en texte avec virgule : `REPLACE(…, ',', '.')` dans chaque
  agrégat. Un type `DECIMAL` supprimerait ces conversions et permettrait des index utiles.
- Un index `(cdclifac, datefac)` / `(cdclibl, datebl)` accélérerait la lecture des dates.
