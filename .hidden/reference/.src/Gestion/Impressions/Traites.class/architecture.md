# Traites — Architecture

> Source : `.src/Gestion/Impressions/Traites.class` (+ `Traites.form`)

## Vue d'ensemble

Écran « Listing des traites » (menu `Menu265`, `Fmenu.class:2134`). Il imprime en PDF
(`~/tmp/Traites.pdf`, classe `Ccompta` de `Reports`) toutes les lignes de la table de travail
`Fiches_Traites` (alimentée par `EcrAuto.class:558` lors de la comptabilisation des factures
réglées par traite), avec les coordonnées bancaires et l'adresse du client (`Fiches_Cli`).

Si l'option LCR de la société est inactive (`/Soc<XX>/Lcr` faux), l'écran propose ensuite
d'**effacer** le fichier des traites : la table est supprimée (`DROP TABLE`) puis recréée avec une
structure codée en dur. Si l'option LCR est active, les traites sont transférées vers les LCR par
`Lcr.Button10_Click`, qui réimprime le même listing avec
[`Lcr.Imp_Traites`](../../Lcr/Lcr.class/architecture.md) (≈ 107 lignes communes) puis vide la table.

Nature : **mixte** (SQL + DDL + PDF dans un seul handler).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Coulfond` | var | Private |  | New String[] | 3 |
| `PosY` | var | Private |  | Integer | 4 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Form_Open` | 6-17 | Public | 2 | 10 | 0 | handler GUI |
| `Button2_Click` | 19-23 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 25-103 | Public | 8 | 74 | 0 | handler GUI |
| `Level1` | 106-131 | Public | 1 | 24 | 0 | portée réductible ? |
| `Level2` | 134-154 | Public | 1 | 19 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Form_Open()`** [handler] [GUI] : `Utils.Observers(Me)`, centrage, `Coulfond = Utils.Coulfd()`
  (jamais utilisé ensuite), texte d'explication selon `/Soc<XX>/Lcr`. Le texte « pour le mois en
  cours » est inexact : aucune sélection de date n'est faite (TRAITES-A02).
- **`Button2_Click()`** [handler] [GUI] : fermeture.
- **`Button1_Click()`** (CC 8) [handler] [mixte] :
  - SQL : `SELECT * FROM Fiches_Traites` (nom en dur, pas de clé Cbase), puis pour chaque traite
    `SELECT * FROM <TabCli> WHERE cli_code = &1` (N+1 requêtes).
  - PDF `Ccompta` portrait : `Entete("Listing des Traites au <date>")`, `Level1T` (titres),
    `Level2T` (14 arguments, signature vérifiée) par traite ; `PosY += 25` même si le client est
    introuvable (bloc vide) ; saut de page à `PosY >= 280` sans `BasPage` intermédiaire ;
    `BasPage`, `Output`, `Visualiseur.Prog`.
  - Purge (option LCR inactive) : `Message.Warning(…, "Non", "Oui") = 2` → `DROP TABLE
    Fiches_Traites` puis `Try CREATE TABLE Fiches_Traites (code, nom, montant, date, datech, numfac,
    acceptee TINYINT, ecartee TINYINT, lind auto)`. ⚠️ La structure recréée **diffère** de la
    référence `db_control.csv` (colonne `imp` absente, `acceptee`/`ecartee` en `tinyint` au lieu
    de `int(1)`) et un échec du `CREATE` (silencieux) laisse la base **sans table** : `EcrAuto`
    échouerait ensuite (TRAITES-A01).
  - Résidus : `Shell "cd …"` sans effet, `With Utils` pour le seul `.Cdate_Aff`, `LOCK TABLES`
    commentés, réaffectation inutile de `Traite`.
- **`Level1()`, `Level2(…)`** [portée : réductible — **code mort**] [GUI] : ancienne mise en page
  par `Draw` (coordonnées en 1/10 mm), jamais appelées (`unused` selon `deps.py`, confirmé par
  grep : aucun appel nu ni qualifié).

## État global utilisé

- `Start.LocalSettings["/Soc" & Start.Societe & "/Lcr"]`, `User.Home`.
- `Utils.Observers`, `Utils.Coulfd`, `Utils.Cdate_Aff`, `Utils.db`, `Cbase.Table("TabCli")`.
- Fichier `~/tmp/Traites.pdf`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Level1`/`Level2`, `Coulfond`, `Shell "cd"`, la réaffectation de `Traite` (TRAITES-002).
- Extraire `ImprimeTraites(sFichier) As Boolean` (lecture + PDF) et `PurgeTraites()` (DDL) du
  handler (TRAITES-004).
- Jointure `Fiches_Traites LEFT JOIN Fiches_Cli` à la place des N+1 requêtes, en conservant le
  bloc vide des traites sans client (SQL modifié, texte PDF identique ; TRAITES-005).

### Commonalisation avec d'autres fichiers

- [`Lcr.Imp_Traites`](../../Lcr/Lcr.class/architecture.md) imprime le même listing (dates par
  `LDate(…).L` au lieu de `Utils.Cdate_Aff`, fichier `~/Traites.pdf`, purge par `TRUNCATE`). Une
  procédure commune paramétrée (chemin du PDF, formateur de date) placée dans un module des LCR
  (ou `CLcr`) supprimerait la copie (TRAITES-003). Les différences de format de date doivent être
  conservées en paramètre tant que les tests ne prouvent pas l'égalité des sorties.
- Purge : `Lcr` utilise `TRUNCATE` (non traduit pour SQLite), ici `DROP`/`CREATE` : une fonction
  unique `ViderTraites()` à base de `DELETE FROM` corrigerait les deux (anomalie, TRAITES-A01).

### Réduction de portée

- `Level1`, `Level2` : suppression (code mort) plutôt que réduction.

### Séparation traitement / GUI

- `Button1_Click` : lecture des traites et des clients dans une fonction sans contrôle ; le
  handler garde les messages et l'appel à `Visualiseur`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Ajouter une clé `TabTraites` dans `Cbase` et un index sur `Fiches_Traites.code`.
- La table de travail `Fiches_Traites` pourrait porter un état « imprimée » (colonne `imp` déjà
  prévue par `Maj217`) au lieu d'être vidée.
