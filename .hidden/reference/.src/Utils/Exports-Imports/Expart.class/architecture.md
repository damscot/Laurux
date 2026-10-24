# Expart — Architecture

> Source : `.src/Utils/Exports-Imports/Expart.class` · Form : `Expart.form`

## Vue d'ensemble

Fenêtre d'**export des articles** (`Fiches_Art`) en CSV `;` (fichier `Liste_articles.csv` dans le
répertoire choisi, `~` par défaut). Une ligne d'en-tête de 23 colonnes est écrite, puis une ligne par
article triée par code (`ORDER BY lpad(art_code,15,' ')`, traduit pour SQLite par `DB_Connection`).
Les prix sont formatés selon le nombre de décimales de l'article (`Utils.Find_nbdec(art_nbd)`).

Ouverte par `Fmenu.Menu281_Click` (« Export des articles »). En-tête de fichier source erroné
(« Exparticle.class »). Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 26 |
| `Num` | var | Private |  | String | 27 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 29-37 | Public | 1 | 6 | 0 | méthode spéciale |
| `Svs_Click` | 39-49 | Public | 2 | 9 | 0 | handler GUI |
| `Button3_Click` | 51-55 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 57-119 | Public | 8 | 59 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Utils.Observers`, `Music.Load`,
  centrage, `Sauves.Text = User.Home`.
- **`Svs_Click()`** [portée : nécessaire (handler)] [nature : GUI]. `Dialog.SelectDirectory` ;
  une annulation remet `Sauves.Text` à `User.Home` (perte d'un choix précédent). Code identique dans
  [`Expclient`](../Expclient.class/architecture.md).
- **`Button3_Click()`** [handler] [GUI]. Ferme.
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : mixte].
  Ouvre `Sauves.Text & "/Liste_articles.csv"` (créé même si aucun article), `SELECT * FROM
  Fiches_Art ORDER BY lpad(art_code,15,' ')` (table en dur). Pour chaque article : formatage
  `Format$(…, nbdec)` des prix `art_pbht`, `art_pauaht`, `art_paht`, `art_frais`, `art_prvt`,
  `art_pvht`, `art_pvttc`, `art_pvcons` (seul ce dernier est protégé par `Try`) ; `art_stocke`
  converti `"T"` → `"O"`, sinon `"N"` (repose sur la conversion Booléen → `"T"` d'un `tinyint(1)`
  lu par gb.db, à confirmer sous SQLite). La colonne « Nb dcm » reçoit la **chaîne de format**
  (`"0"`, `"0.00"`, `"0.000"`) et non un nombre. Musique si `son`, `Message.Info`, `Close`, fermeture.
  Partie extractible : `LigneArticle(r As Result) As String` et `EnteteArticles() As String`.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Utils.db`, `Utils.Observers`, `Utils.Find_nbdec`.
- Variables d'instance `son`, `Num` (`Num` n'a pas besoin d'être un membre : variable locale).

## Anomalies relevées

- Un prix `Null` (autre que `art_pvcons`) fait échouer `Format$` : export interrompu, fichier partiel
  non fermé.
- Aucune protection des `;` présents dans les désignations.
- Colonne « Nb dcm » contenant un format au lieu du nombre de décimales.
- Le curseur n'est jamais mis en attente mais est remis à `Default`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer les 21 variables intermédiaires par la construction d'un `String[]` puis `.Join(";")`.
- `Num` en variable locale.

### Commonalisation avec d'autres fichiers

- [`Expclient`](../Expclient.class/architecture.md) : même squelette (`_New`, `Svs_Click`,
  `Button3_Click`, ouverture du fichier, boucle `Repeat`, fin de traitement) — 22 lignes normalisées
  communes (46 % d'`Expclient`). Socle commun proposé dans
  [`Impclient`](../Impclient.class/architecture.md) : `ChoisirRepertoire`, `EcrireCsv(sChemin,
  aEntete, aLignes)`, `FinTraitement`.
- Le formatage par `Find_nbdec` est répété dans les éditions d'articles (`Gestion/Impressions/EdArt*`) ;
  à comparer avant d'en faire un helper `FormatPrixArticle(v, nbd)`.

### Réduction de portée

- Aucune fonction `Public` hors handlers et constructeur.

### Séparation traitement / GUI

- Extraire `ExporterArticles(sChemin As String) As Integer` (nombre de lignes) ; le handler garde
  messages et curseur.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Le tri `lpad(art_code,15,' ')` empêche l'usage d'un index : une colonne de tri normalisée (ou un
  code numérique séparé) accélérerait l'export sur gros catalogue.
