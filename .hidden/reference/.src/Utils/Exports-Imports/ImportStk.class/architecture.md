# ImportStk — Architecture

> Source : `.src/Utils/Exports-Imports/ImportStk.class` · Form : `ImportStk.form`

## Vue d'ensemble

Fenêtre d'**import de quantités en stock** depuis un fichier `;` (`code;quantité`). Pour chaque
ligne dont le code article existe, `art_qte` **et** `art_stkdep` de `Fiches_Art` reçoivent la
quantité lue ; les codes inconnus sont listés dans `~/tmp/Diff.txt`, affiché par
`Visualiseur.Prog` s'il n'est pas vide. Aucun mouvement de stock n'est enregistré.

Le commentaire d'en-tête (« Comparaison entre un fichier texte et la table des produits… ») est
recopié de [`CompArt`](../../CompArt.class/architecture.md) et ne décrit pas ce fichier.

Ouverte uniquement par `Prgm` (programme `ImportStk`, `ShowModal`). Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 7-11 | Public | 1 | 3 | 0 | méthode spéciale |
| `Svs_Click` | 13-21 | Public | 2 | 7 | 0 | handler GUI |
| `Button1_Click` | 23-27 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 29-72 | Public | 10 | 41 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [nécessaire (spéciale)] [GUI]. `Music.Load(Start.Musique)`.
- **`Svs_Click()`** [handler] [GUI]. `Dialog.OpenFile` → `ChemFic.Text`. Identique à `CompArt.Svs_Click`.
- **`Button1_Click()`** [handler] [GUI]. Ferme.
- **`Button2_Click()`** [handler] [mixte].
  Musique jouée **avant** le traitement si `son`. Si `ChemFic` est vide : avertissement. Si le
  fichier existe : suppression puis création de `~/tmp/Diff.txt` (le répertoire `~/tmp` doit
  exister), boucle `Line Input` + `Split(";")` :
  - `SELECT * FROM Fiches_Art WHERE art_code = &1` avec le code **sans espaces** (`Replace$`) ;
  - trouvé : `UPdate Fiches_Art SET art_qte = &2, art_stkdep = &2 WHERE art_code = &1` avec le code
    **brut** (espaces conservés) ;
  - sinon : compteur `Nbc` et ligne d'erreur dans `Diff.txt`.
  Puis `Message.Info`, `Visualiseur.Prog(Diff.txt)` si `Nbc > 0`. `Close #hfile`/`#hfile2` sont
  exécutés aussi quand le fichier n'existe pas.
  Partie extractible : `ImporterStock(sSource, sRapport) As Integer` (nombre de codes inconnus).

## État global utilisé

- `Start.Son`, `Start.Musique`, `Utils.db`, `Visualiseur.Prog`.

## Anomalies relevées

- l.52/54 : code nettoyé pour le `SELECT`, code brut pour l'`UPDATE` : un code avec espaces est
  « trouvé » mais rien n'est mis à jour, sans signalement.
- l.66-67 : fichier inexistant → `Close` sur des fichiers `Null` (erreur d'exécution).
- Ligne sans `;` ou vide : `Lig2[1]` (ou `Lig2[0]`) hors bornes → erreur et import interrompu.
- Quantité écrite sans conversion (`"1,5"` envoyé tel quel) ; pas de transaction.

## Propositions d'amélioration

### Réécriture / refactorisation

- Corriger le commentaire d'en-tête (documentation).
- Remonter les `Close` dans la branche où les fichiers sont ouverts (change le comportement en cas
  d'erreur : voir anomalie A02).

### Commonalisation avec d'autres fichiers

- [`CompArt`](../../CompArt.class/architecture.md) : **90 %** des lignes normalisées communes
  (39 lignes). Les deux fenêtres ne diffèrent que par l'action sur un article trouvé/manquant.
  Proposition : une procédure commune `ParcourirFichierArticles(sSource, sRapport, hAction)` ou,
  plus simplement, un module partagé `ImpExp` exposant `LireCsv` et `RapportDiff(lignes)` ; les deux
  `Button2_Click` deviennent quelques lignes.
- Socle commun d'import/export : voir [`Impclient`](../Impclient.class/architecture.md).

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- `ImporterStock(sSource As String, sRapport As String) As Integer` sans contrôle ; le handler garde
  curseur, messages, `Visualiseur`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Un import de stock devrait créer un mouvement d'inventaire (traçabilité) ; hors schéma actuel de
  ce traitement.
