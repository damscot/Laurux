# Impcpostaux — Architecture

> Source : `.src/Utils/Exports-Imports/Impcpostaux.class` · Form : `Impcpostaux.form`

## Vue d'ensemble

Fenêtre d'**import des codes postaux** dans `Fiches_Cpostaux` (`Cbase.Table("TabCpostaux")`) depuis
un fichier `ville;cp;…` (par défaut `~/Cpostaux.csv`). Les codes postaux à 4 chiffres sont complétés
par un `0` initial. Un couple (cp, ville) n'est inséré que s'il n'existe pas.

Ouverte par `Fmenu.Menu284_Click` (« Import des codes postaux ») et `Prgm` (programme
`Impcpostaux`). Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-8 | Public | 1 | 4 | 0 | méthode spéciale |
| `Button1_Click` | 10-49 | Public | 10 | 37 | 0 | handler GUI |
| `Button2_Click` | 51-55 | Public | 1 | 3 | 0 | handler GUI |
| `FilePath_MouseDown` | 58-64 | Public | 1 | 5 | 0 | handler GUI |
| `FileSelect_Activate` | 66-72 | Public | 1 | 5 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [nécessaire (spéciale)] [GUI]. Centre, chemin par défaut `User.Home & "/Cpostaux.csv"`.
- **`Button1_Click()`** [handler] [mixte]. Ouvre le fichier (`Try`), boucle `Line Input` ; découpe
  les deux premiers champs par `InStr`/`Left$`/`Mid$` (boucle `For x = 1 To 2` + `Select Case`), puis
  `SELECT * FROM Fiches_Cpostaux WHERE cp = &1 AND burdist = &2` et `INSERT INTO … (cp, burdist)` si
  absent. Musique (sans `Music.Load` ni test de `Start.Son`), `Message.Warning`. Le fichier n'est
  jamais fermé. Partie extractible : `ImporterCodesPostaux(sChemin) As Integer` et
  `DecouperLigne(sLig) As String[]`.
- **`Button2_Click()`** [handler] [GUI]. Ferme.
- **`FilePath_MouseDown()`** / **`FileSelect_Activate()`** [handlers] [GUI]. Affichent un
  `FileChooser` intégré (`FileSelect`) et recopient le chemin choisi dans `FilePath`.

## État global utilisé

- `Utils.db`, `Cbase.Table("TabCpostaux")`.

## Anomalies relevées

- Ligne sans `;` : `InStr` renvoie 0, `Left$(Lig, -1)` donne la ligne sans son dernier caractère et
  la ville et le cp reçoivent des valeurs incohérentes, insérées en base.
- Fichier jamais fermé ; messages non extraits pour l'i18n (`("…")` absent).

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer la boucle `For x = 1 To 2` + `Select Case` par `Split(Lig, ";")` (comportement identique
  pour les lignes valides ; vérifier le cas « ligne sans `;` » par le test T03).

### Commonalisation avec d'autres fichiers

- Socle commun d'import/export (`LireCsv`, `FinTraitement`) : voir
  [`Impclient`](../Impclient.class/architecture.md). Le motif « SELECT d'existence puis INSERT » est
  le même que dans [`ImptartypeC`](../ImptartypeC.class/architecture.md) (upsert).
- [`Enrgcp.Ecp(cpostal, burdist)`](../../Enrgcp.module/architecture.md) exécute **exactement** le
  même `SELECT` d'existence + `INSERT` sur `TabCpostaux`, à une différence près : `Ecp` ignore un
  code postal vide, alors que `Impcpostaux` l'insère. Appeler `Enrgcp.Ecp` n'est donc neutre que si
  l'on garde l'insertion des cp vides côté appelant (ou après validation de l'anomalie A03).

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- `ImporterCodesPostaux(sChemin As String) As Integer` appelée par `Button1_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une clé unique `(cp, burdist)` permettrait un `INSERT IGNORE` et supprimerait le `SELECT` par ligne
  (~39 000 communes en France).
