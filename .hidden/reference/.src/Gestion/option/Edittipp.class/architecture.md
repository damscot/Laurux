# Edittipp — Architecture

> Source : `.src/Gestion/option/Edittipp.class` · État associé : `Edittipp.report` (gb.report)

## Vue d'ensemble

`Edittipp` est l'**état mensuel TICPE/TIPP** de l'option carburants : l'« ANNEXE IX — liste des
destinataires finals en suite de livraison par un distributeur de carburant en acquitté »
(déclaration douanière DGDDI). Classe d'un **`Report`** (fichier `Edittipp.report`, pas de `.form`)
dont la bande répétée `ligne` affiche, par ligne de livraison ou de facture portant un code TIPP :
n° de facture (ou de BL), produit, volume, raison sociale + ville, SIRET, code région, destinataire
(`cli_dfin`). Lancé par `menuopt.btn_Click` : `New Edittipp($mois, $anne)`, `Print` vers
`~/tmp/tipce.pdf`, puis `Visualiseur.Prog`.

Règle métier telle que le code l'applique (`_new`) : pour le mois choisi, union de
- lignes de BL (`Fiches_Ligbl`, BL de type `B` ou `F`) avec `tipp_ligbl` renseigné, n° = facture si
  `numfac` non `NULL`, sinon n° de BL ;
- lignes de factures historisées (`Fiches_HistoLigfac`) avec `tipp_ligfac` renseigné ;

l'article doit figurer dans `Fiches_region` (`cart = art_code`). Les colonnes `tipp_ligbl`,
`tipp_ligfac`, `cli_dfin` sont ajoutées à l'exécution par `modfichier.fichiercarbu` et **absentes
de `db_control.csv`**.

⚠️ Le `.report` contient en dur la raison sociale et l'adresse d'un utilisateur
(« S.E ETS MAGUER SAS », « 24800 THIVIERS ») : l'état n'est correct que pour cette société (le
`.report` est intouchable dans ce plan ; à signaler).

Nature globale : **édition (GUI) + SQL**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$dte` | var | Private |  | LDate | 3 |
| `$res` | var | Private |  | Result | 4 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 6-15 | Public | 2 | 8 | 0 | méthode spéciale |
| `num_Data` | 17-22 | Public | 1 | 4 | 0 | handler GUI |
| `prod_Data` | 24-29 | Public | 1 | 4 | 0 | handler GUI |
| `vol_Data` | 31-36 | Public | 1 | 4 | 0 | handler GUI |
| `rais_Data` | 38-43 | Public | 1 | 4 | 0 | handler GUI |
| `siret_Data` | 45-50 | Public | 1 | 4 | 0 | handler GUI |
| `code_Data` | 52-57 | Public | 1 | 4 | 0 | handler GUI |
| `dest_Data` | 59-64 | Public | 1 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(mois, anne)`** [portée : nécessaire] [nature : mixte]. `$dte = LDate(1er du mois)` ;
  requête `UNION ALL` décrite ci-dessus, bornes `$dte.D` et `$dte.FinMois.D` ;
  `ligne.DataCount = $res.Count` si résultat (sinon la bande n'est pas répétée).
  ⚠️ Jointure `Fiches_region` sur l'article seul (`cart = art_code AND code_ligbl = cart`) alors que
  la clé est `(code, cart)` : un article décliné dans plusieurs régions duplique chaque ligne
  (une par région), à confirmer (EDITTIPP-A01). ⚠️ Une ligne de BL facturé peut figurer aussi
  dans l'historique des factures (double comptage possible, à confirmer). ⚠️ `numfac IS NULL` :
  un BL non facturé avec `numfac = ''` affiche `''`.
- **`num_Data`, `prod_Data`, `vol_Data`, `rais_Data`, `siret_Data`, `code_Data`, `dest_Data`
  (Index)** [portée : nécessaire (événements `Data` des `ReportLabel` du `.report`)] [nature :
  GUI]. `$res.MoveTo(Index)` puis valeur du champ (raison sociale : 25 + 20 caractères).
  Signalés `unused`/réductibles par `deps.py` : **faux positifs** (handlers d'un `.report`, non
  analysé).

## État global utilisé

- `Utils.db.Exec`, `LDate`.
- Tables : `Fiches_region`, `Fiches_Ligbl`, `Fiches_Bl`, `Fiches_HistoLigfac`, `Fiches_HistoFac`,
  `Fiches_Cli`, `Fiches_Art` (noms en dur).

## Propositions d'amélioration

### Réécriture / refactorisation

- Les 7 handlers `*_Data` répètent `$res.MoveTo(Index)` : helper privé `Ligne(Index) As Result`
  (comportement identique ; noms des handlers inchangés).
- Texte SQL dans une fonction privée `RequeteMois()` testable ; `Cbase.Table` pour les tables qui
  ont une clé (`TabLigbl`, `TabBl`, `TabHisLigFac`, `TabHisFac`, `TabCli`, `TabArt`).

### Commonalisation avec d'autres fichiers

- Liste des lignes TIPP du mois : même jeu de données que les contrôles TIPP de `Facture`/`FClient`
  (colonnes `tipp_*`) ; pas de doublon de code trouvé.

### Réduction de portée

Aucune : les `*_Data` sont des handlers de l'état.

### Séparation traitement / GUI

`RequeteMois()` renvoie le `Result` ; le report ne fait que lire.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Identité du déclarant (raison sociale, adresse, n° DGDDI) à lire depuis `Fiches_Societes`
  (colonne `tipp` déjà ajoutée par `modfichier`) au lieu du texte en dur du `.report`.
- Intégrer `Fiches_region` et les colonnes `tipp_*`, `cli_dfin` dans `db_control.csv`.
