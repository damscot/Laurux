# Crupt — Architecture

> Source : `.src/Utils/Crupt.module`

## Vue d'ensemble

`Crupt` contient une seule procédure, `Rupture` (319 lignes, **CC 106**, la plus complexe de la
couche Utils), qui calcule les **produits en rupture de stock et les quantités à commander**. Elle
remplit deux tables de travail **non temporaires** (créées avec `CREATE TABLE`, supprimées au début
de chaque appel) :

- `Rupture` (`Tab2`) : une ligne par article et fournisseur (et par client si regroupement par
  client) : quantité en commande fournisseur `qtefour`, quantité commandée par les clients `qtecli`,
  quantité à commander `qtecom` ;
- `RuptureC` (`Tab3`, seulement pour `EdRup`) : détail par client et par commande client.

Ces tables sont ensuite lues par l'appelant pour imprimer le PDF.

Le commentaire d'en-tête annonce trois usages (commandes automatiques, liste des ruptures, recherche
des fournisseurs en commande), mais **un seul appelant existe** : `EdRup.class:335`, avec
`Org = "EdRup"`. Toutes les branches `Org <> "EdRup"` sont donc du **code mort** dans l'état actuel
(vérifié par grep : aucun autre appel de `Crupt.Rupture`).

Paramètres :
- `chk1` : « Inclure les produits non stockés » (`EdRup.CheckBox1`) ;
- `chk2` : « Regroupement par client » (`EdRup.CheckBox2`) ;
- `four1`/`four2` : bornes de fournisseurs ; `art1`/`art2` : bornes d'articles ;
- `Org` : origine de l'appel (`"EdRup"`).

Nature globale : **traitement** (SQL et calcul), sans GUI.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Rupture` | 6-332 | Public | 106 | 319 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### `Rupture(chk1, chk2, four1, four2, art1, art2, Org)` — [portée : nécessaire] [nature : calcul]

Algorithme en cinq phases (branche `EdRup`) :

1. **Tables de travail** (l. 25-75) : `DROP TABLE IF EXISTS Rupture, RuptureC` puis `CREATE TABLE`
   (`Try`, erreurs ignorées). La clé primaire de `Rupture` inclut `codec` si `chk2`. Les
   définitions sont écrites par concaténation sur plusieurs lignes ; aux lignes 32-33 et 67-68 il
   manque le `&` de fin de ligne entre `"four Char(8),"` et `"qtecli FLOAT,"` : le code compile, ce
   qui suppose que le compilateur concatène deux littéraux adjacents (à confirmer avec `gbc3`).
2. **Commandes fournisseurs en cours** (l. 76-121) : `Fiches_Ligcom` ⟕ `Fiches_Art` dans les bornes
   (avec `art_stocke = 1` si non `chk1`). Pour chaque ligne : fournisseur = `art_four` si égal à
   `four1`, sinon le fournisseur de l'entête de commande (`Fiches_Entcom`). Insère ou cumule `qtefour`
   dans `Rupture` (clé `codea` + `four`, ou `codea` + `intitulea` + `four` pour les articles divers
   `.DEP`).
   ⚠️ L. 101 : `If Not Error` teste l'erreur du **dernier `Try` exécuté** ; si la branche l. 96-97 est
   prise, il s'agit du `Try` de la l. 88 ou 90 (état périmé, à confirmer).
   ⚠️ L. 117 : la mise à jour du cumul filtre sur `codea` et `intitulea` sans `four` : elle touche
   aussi les lignes des autres fournisseurs du même article.
3. **Commandes clients en cours** (l. 122-231) : `Fiches_Ligbl` ⟕ `Fiches_Bl` (type `C`, lignes
   article `A`) dans les bornes, triées par client. Pour chaque ligne, calcule `qtec`, retrouve
   l'article et met à jour `qtecli` dans `Rupture` ou insère, et alimente `RuptureC` par client et par
   commande si `chk2`. C'est la partie la plus imbriquée (jusqu'à 8 niveaux).
   ⚠️ L. 181 : `UPdate RuptureC SET qte = …, qtecli = …` alors que `RuptureC` n'a **pas** de colonne
   `qtecli` : erreur SQL non interceptée (`Exec` propage l'erreur) dans le cas `chk2` avec une ligne
   `Rupture` de `codec <> "0"` (atteignable seulement par les branches l. 158/160, à confirmer).
   ⚠️ L. 224 (branche non `EdRup`, code mort) : `WHERE codea = &1` reçoit `codec`.
   `Bcarts` n'est jamais remis à `False` (sans effet : toujours vrai quand l'article existe).
4. **Stock théorique et quantité à commander** (l. 232-295) : pour chaque article des bornes,
   `Stkth = art_qte + Σ(qtefour − qtecli)` ; si stocké et `stkmini > Stkth`, `Qtecom = |stkmaxi −
   Stkth|` ; division par `art_txconv` (⚠️ division par zéro si `art_txconv` vaut 0 ; `NULL` à
   confirmer) ; 0 si `stkmini = 0`. Les lignes multiples d'un article sont fusionnées (suppression des
   doublons, sauf articles `.DEP`). Insère ou met à jour `qtecom`.
   L. 275 : priorité des opérateurs `A And B And C Or If Not D` (le `Or If Not art_stocke` est
   toujours faux dans cette branche).
5. **Ajustement final** (l. 296-330) : pour chaque ligne de `Rupture` ayant `qtecli` et `qtefour`,
   recalcule `qtecom` (non stocké : `qtecli − |qtefour|` ; autre fournisseur : cumul ; même
   fournisseur : `qtefour` ou `qtecli − |qtefour|` si `qtecom` est `NULL`), puis `UPdate`. Hors
   `EdRup`, supprime les lignes des autres fournisseurs.

Autres remarques :
- Variables inutilisées ou figées : `Tabl` (affectée, jamais lue), `rupt`, `rupt2`, `Nbpage`,
  `nmclient`, `stkrl` initialisé par `Try` ; `UCase$(".DEP")` est une constante `".DEP"`.
- L. 83 : paramètre `four1` passé sans `&1` dans la requête (branche morte).
- Tables : `Cbase.Table("TabLigcom"|"TabArt"|"TabEntcom"|"TabLigbl"|"TabBl")` ; `Rupture`/`RuptureC`
  en dur (pas d'entrée `Cbase`), absentes de `db_control.csv`.
- SQL émis : 2 `DROP`, 2-3 `CREATE`, puis par ligne lue 2 à 5 requêtes : la procédure est en
  O(lignes de commandes + lignes clients + articles) requêtes unitaires.

## État global utilisé

- `Utils.db`, `Utils.cpoint`, `Cbase.Table`.
- Tables de travail partagées `Rupture`, `RuptureC` : **communes à tous les postes** connectés à la
  même base (deux éditions simultanées s'écrasent). `Changefam.class:541-542,732` met aussi à jour
  ces tables lors d'un changement de code article.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les branches `Org <> "EdRup"` (code mort, un seul appelant) : CC 106 → environ 70, sans
  changement de comportement pour `EdRup`. La signature est conservée (paramètre `Org` ignoré ou
  retiré avec mise à jour d'`EdRup`).
- Découper par phase en procédures privées : `CreerTables(chk2)`, `CumulCommandesFournisseurs(…)`,
  `CumulCommandesClients(…)`, `CalculQuantites(…)`, `AjusterQuantites(…)` ; chacune ≤ CC 25.
- Extraire les calculs purs : `StockTheorique(stk, lignes)`, `QuantiteACommander(stocke, stkmini,
  stkmaxi, stkth, txconv)`, `IntituleSansPrefixe(intitule)` (le motif `"~ "` est répété 3 fois).
- Helper `EstDivers(codea)` pour le test `Left$(codea, 4) = ".DEP"` (9 occurrences) et
  `ChercheRupture(codea, intitulea, four)` pour les 8 `SELECT` presque identiques sur `Rupture`.

### Commonalisation avec d'autres fichiers

- [`EdRup`](../../Gestion/Impressions/EdRup.class/architecture.md) déclare les mêmes noms de tables
  (`Tab2 = "Rupture"`, `Tab3 = "RuptureC"`) : constantes publiques `Crupt.TabRupture` /
  `Crupt.TabRuptureC` partagées (et avec [`Changefam`](../Changefam.class/architecture.md)).
- Le retrait du préfixe `"~ "` des désignations existe probablement dans d'autres éditions de stock
  (à rechercher en phase 3) : candidat `Utils.SansPrefixe`.

### Réduction de portée

- `Rupture` reste `Public` (appelée par `EdRup`).

### Séparation traitement / GUI

- Sans objet (aucun accès GUI) ; la séparation porte sur les calculs purs ci-dessus, testables en
  gb.test.

### Requêtes signalées par `sql_params` (après le lot Gestion-2)

- l. 83 : argument `four1` sans marqueur `&N` (signal `sql_params`) : voir CRUPT-A06.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Remplacer les tables partagées `Rupture`/`RuptureC` par des tables `TEMPORARY` (propres à la
  connexion) ou ajouter une colonne de session : supprime les collisions entre postes.
- Le calcul pourrait être fait par quelques requêtes ensemblistes (`GROUP BY` sur `Fiches_Ligcom`
  et `Fiches_Ligbl`, jointure sur `Fiches_Art`) au lieu de milliers de requêtes unitaires.
- Index sur `Fiches_Ligcom(code, four)` et `Fiches_Ligbl(code_ligbl, four_ligbl)` à vérifier dans
  `db_control.csv`.
