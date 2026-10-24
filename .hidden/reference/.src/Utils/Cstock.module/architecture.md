# Cstock — Architecture

> Source : `.src/Utils/Cstock.module`

## Vue d'ensemble

`Cstock` est le **moteur de recalcul du stock théorique** des articles stockés (`Fiches_Art.art_qte`)
à partir des historiques de mouvements. Il est appelé par l'écran
[`Calcstock`](../Calcstock.class/architecture.md) (recalcul à la demande : un article, une plage de
casiers, tous les articles) et par la validation de l'inventaire de fin d'année
(`.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class:190`, `Cstock.Calc_stock("", "")`).

Formule appliquée pour chaque article (toutes les sommes portent sur les mouvements datés
`>= date de départ`) :

```
art_qte = stock de départ
        − Σ qte_ligbl   (Fiches_Ligbl  ⋈ Fiches_Bl,  type B ou F, ligne article 'A', date dte_ligbl)
        − Σ qte_ligbl   (Fiches_LigblM ⋈ Fiches_BlM, idem)
        − Σ qte_ligfac  (Fiches_HistoFac  ⋈ Fiches_HistoLigfac,  ligne 'A', date dtligbl_ligfac)
        − Σ qte_ligfac  (Fiches_HistoFacM ⋈ Fiches_HistoLigfacM, idem)
        + Σ qte × art_txconv            (Fiches_Ligrecpt, réceptions, date daterecpt)
        + Σ (qtep − qtem)               (Fiches_Mvtexp et Fiches_Mvtexpdc, mouvements exceptionnels)
        ± Σ qte                         (Fiches_Sdepots, dépôt '01' en dur, type 'S' en négatif)
```

- **Stock de départ** : `art_stkdep` (stock validé au dernier inventaire), remplacé par
  `inv_qtestock` du dernier inventaire tournant (`Fiches_HisInvT`) s'il en existe un après la date
  de départ ; la date de départ devient alors la date de cet inventaire.
- **Date de départ par défaut** : `Fiches_Parametres.dteinv` (date du dernier inventaire), sinon
  `dteclec1` (début d'exercice), au format `yyyymmdd`.
- Les ventes de caisse ne sont pas lues directement (code commenté) : à confirmer qu'elles sont
  prises en compte via les BL/factures générés par le moulinage (c'est pourquoi `Calcstock` exige
  que le moulinage soit fait).
- Les quantités sont stockées en texte avec virgule : la requête fait `REPLACE(qte, ',', '.')`.

Tout se fait sous `LOCK TABLES` (17 tables, en écriture), sans transaction.

Nature : **calcul** (SQL), mais avec une **dépendance cachée à la GUI** : la sélection des
articles lit les boutons radio du formulaire `Calcstock` (`Calcstock.Cbx.Value`,
`Calcstock.Cbx2.Value`) via son instance automatique.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `dte1` | var | Private | oui | Date | 3 |
| `dte2` | var | Private | oui | String | 4 |
| `dte3` | var | Private | oui | String | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Calc_stock` | 11-134 | Public | 13 | 94 | 2 |  |
| `date_ex` | 139-152 | Public | 3 | 11 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Calc_stock(Art, art2)`** (CC 13, LOC ~95) [portée : nécessaire — `Calcstock`, `Validinv`]
  [nature : calcul, avec lecture de contrôles GUI].
  1. `date_ex()` initialise `dte1`/`dte2`.
  2. Sélection des articles stockés (`art_stocke = 1`) dans `Cbase.Table("TabArt")` :
     - si `Calcstock.Cbx.Value` : l'article `Art` ;
     - sinon si `Calcstock.Cbx2.Value` : casiers `art_casier` entre `Art` et `art2` ;
     - sinon si `Art` est vide : tous, `ORDER BY CAST(art_code AS char)`.
     ⚠️ Sinon (`Art` non vide, aucun des deux boutons) : `ArtResult` reste `Null` → erreur
     « objet nul » sur `.Available`.
     ⚠️ **Couplage GUI** : en appel depuis `Validinv`, `Calcstock` n'est pas ouvert ; l'accès à
     `Calcstock.Cbx` crée l'instance automatique cachée du formulaire (son `_New` charge la musique)
     dont `Cbx.Value = True` par défaut (`Calcstock.form`). La requête cherche alors
     `art_code = ''` : **aucun article n'est recalculé** après la validation d'inventaire.
  3. `LOCK TABLES` (TabArt, TabBl, TabLigbl, TabBlM, TabLigblM, TabHisFac, TabHisLigFac, TabHisFacm,
     TabHisLigFacm, TabMvtexp, TabEntrecpt, TabLigrecpt, TabHEntTck, TabHLigTck, TabSdepots,
     `Fiches_HisInvT`, `Fiches_Mvtexpdc`) — les deux tables d'historique de caisse sont verrouillées
     mais plus lues.
  4. Pour chaque article : stock de départ (`Try qte_art = art_stkdep`, 0 si erreur), recherche du
     dernier inventaire tournant (`inv_date >= dte2 ORDER BY inv_date DESC`), requête `UNION ALL` de
     8 sous-requêtes (tables en dur, sans `Cbase`), cumul des lignes non nulles, `UPDATE art_qte`.
     ⚠️ **`dte2` est une variable de module modifiée dans la boucle** : après un article ayant un
     inventaire tournant, `dte2` vaut la date de cet inventaire pour l'article **suivant**, dont la
     recherche d'inventaire tournant part alors de cette date (au lieu de `dte1`) ; un inventaire
     tournant plus ancien de l'article suivant est ignoré et son stock est faux. (Si aucun
     inventaire n'est trouvé, `dte2` est remis à `dte1`.)
     ⚠️ SQLite : la syntaxe `UNION ALL(SELECT …)` est refusée (« near "(": syntax error », vérifié
     avec `sqlite3`), et la comparaison de dates `'AAAA-MM-JJ' >= 'AAAAMMJJ'` est fausse en
     comparaison de texte : **le recalcul ne fonctionne pas sous SQLite**.
     `SELECT DISTINCT SUM(…)` : `DISTINCT` sans effet. Le multiplicateur `&3 = art_txconv` est
     substitué tel quel (Null → `NULL` : réceptions ignorées).
  5. `UNLOCK TABLES`. Une erreur SQL en cours de boucle laisse les tables verrouillées (pas de
     `Catch`).
  Variables inutilisées : `com_art`, `Tab3` (utilisée dans le `LOCK`), `dte3` locale qui masque la
  variable de module `dte3` (elle-même jamais utilisée). `With Utils` inutile.
- **`date_ex()`** [portée : réductible — aucun appelant externe] [nature : calcul].
  `SELECT * FROM Fiches_Parametres` sans test `Available` ; `dte1 = dteinv`, sinon `dteclec1` ;
  `dte2 = Format$(dte1, "yyyymmdd")`. Erreur → `Message.Error` (couplage GUI).

## État global utilisé

- Variables de module `dte1` (Date), `dte2` (String, **réutilisée et modifiée d'un article à
  l'autre**), `dte3` (inutilisée).
- Contrôles publics du formulaire `Calcstock` (`Cbx`, `Cbx2`, déclarés `#Public = True`).
- `Utils.db`, `Cbase.Table`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer la lecture de `Calcstock.Cbx/Cbx2` par un **paramètre de mode** explicite
  (`Calc_stock(Art, art2, Optional Mode As Integer)`) ; `Calcstock` passe le mode correspondant au
  bouton coché, `Validinv` passe le mode « article » pour **reproduire** le comportement actuel
  (aucun recalcul) tant que l'anomalie A01 n'est pas validée.
- Extraire `StockArticle(code, txconv, stkdep, dteDepart) As Float` (une seule requête `UNION ALL`
  et le cumul) : fonction pure côté Gambas, testable article par article.
- Utiliser une variable **locale** pour la date de départ par article (correction de A02, donc
  dans l'anomalie, pas dans le rework).
- Remplacer les noms de table en dur de la requête par `Cbase.Table(...)` (mêmes noms physiques).

### Commonalisation avec d'autres fichiers

- `DB_Connection.Lockstock` (`DB_Connection.class:521-548`) met à jour `art_qte` (et le PMP) de
  façon incrémentale à chaque mouvement ; `Cstock` recalcule le même champ globalement. Les deux
  définitions du stock devraient partager la même liste de sources de mouvements (phase 3).
- Le calcul des ventes/achats d'un article depuis une date est réécrit (en commentaire) dans
  `Validinv.class:60-160` : la fonction `StockArticle` proposée pourrait servir aux deux.
- L'écran `Stockmvt` (historique des mouvements d'un article) parcourt les mêmes tables : à comparer
  en phase 3 pour une liste de sources commune.

### Réduction de portée

- `date_ex` → `Private` (aucun appelant externe, grep).
- `Calc_stock` reste `Public`.

### Séparation traitement / GUI

- Supprimer la lecture de `Calcstock.Cbx*` (paramètre de mode, ci-dessus).
- `date_ex` : remplacer `Message.Error` par un code retour, l'appelant affichant le message (même
  texte).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Stocker les quantités (`qte_ligbl`, `qte_ligfac`, `qte`, `qtep`, `qtem`, `Fiches_Sdepots.qte`) en
  `DECIMAL` au lieu de texte à virgule : suppression des `REPLACE` et des `CASE … IS NULL`.
- Table unique de mouvements de stock (journal) alimentée par toutes les pièces : le recalcul
  deviendrait `SUM(qte) GROUP BY art_code` en une requête, au lieu de 1 + 2 requêtes par article.
- Index composites `(code_ligbl, dte_ligbl)`, `(code_ligfac, dtligbl_ligfac)`, `(code, daterecpt)`
  sur les tables de lignes (à vérifier dans `db_control.csv`).
