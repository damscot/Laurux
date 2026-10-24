# Impclient — Architecture

> Source : `.src/Utils/Exports-Imports/Impclient.class` · Form : `Impclient.form`

## Vue d'ensemble

Fenêtre d'**import de clients** depuis un fichier texte délimité par `;` (28 colonnes attendues,
sans ligne d'en-tête). Pour chaque ligne, la classe calcule un nouveau code client à partir du
dernier numéro stocké (`Fiches_Parametres.dnc`), crée la fiche client (`Fiches_Cli`), le compte
auxiliaire associé (`Fiches_Comptes`, type `C`, rattaché au premier collectif `41*`), l'adresse
mail (`Mails_Cli`) puis met à jour `dnc`.

Ouverte par `Fmenu.Menu152_Click` (« Import des clients ») et par `Prgm` (programme `Impclient`).

Nature globale : **mixte** ; le traitement d'import est entièrement dans le handler `Button2_Click`.

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
| `_New` | 29-36 | Public | 1 | 5 | 0 | méthode spéciale |
| `Svs_Click` | 38-46 | Public | 2 | 7 | 0 | handler GUI |
| `Button3_Click` | 48-52 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 54-152 | Public | 40 | 93 | 0 | handler GUI |
| `Compteur` | 154-170 | Public | 6 | 15 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Utils.Observers(Me)` (couleurs de
  focus), `Music.Load(Start.Musique)`, centrage.
- **`Svs_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Boîte `Dialog.OpenFile` (filtres
  csv/txt/tous) et copie du chemin dans `Sauves.Text`. Titre « Choisir un repertoire » alors qu'on
  choisit un fichier. Code identique dans [`ImptartypeC`](../ImptartypeC.class/architecture.md).
- **`Button3_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Ferme la fenêtre.
- **`Button2_Click()`** (CC la plus élevée du fichier) [portée : nécessaire (handler)] [nature : mixte].
  1. `SELECT * FROM Fiches_Parametres` → `Num = dnc`, puis `Compteur()`.
  2. `SELECT * FROM Fiches_Comptes WHERE coll = '1' ORDER BY cast(compte_cc AS char)` → premier
     compte commençant par `41` (sinon le **dernier** collectif lu, ou vide si aucun).
  3. Ouverture du fichier `Sauves.Text` (`Try … If Not Error`) ; boucle `Line Input` + `Split(";")` ;
     les 28 champs sont lus par `Try x = Lig2[n]` (28 lignes).
  4. Si `cli_code = Num` n'existe pas : `INSERT INTO Fiches_Cli` (33 colonnes ; `cli_collectif`,
     `cli_exo = 0`, `cli_cdech = "00"`, `cli_actif = 0`, `cli_div = False`), `INSERT INTO
     Fiches_Comptes` (compte = `Num`, intitulé = nom, `type_cc = "C"`, `coll_cc` = collectif,
     `lettrable = True`), `Try INSERT INTO Mails_Cli` via `Cbase.Table("TabMailCli")`, `Update
     Fiches_Parametres SET dnc`, puis `Compteur()`.
  5. Curseur, musique si `son`, `Message.Info`, fermeture. Fichier absent : `Message.Error`.
  Tables : `Fiches_Parametres` (R/W), `Fiches_Comptes` (R/W), `Fiches_Cli` (R/W), `Mails_Cli` (W).
  Noms de tables **en dur** sauf `TabMailCli`. Pas de transaction.
  Partie extractible : étapes 1, 2 et 4 (fonctions `LireDernierNumero`, `CollectifClient`,
  `CreerClient(champs As String[])`), sans accès aux contrôles.
- **`Compteur()`** [portée : réductible (aucun appelant externe, vérifié par grep)] [nature : calcul].
  Incrémente `Num` : `Null` ou ≤ 411000 → `"411001"` ; 411999 → 4111000 ; 4119999 → 41110000 ;
  sinon `Val(Num) + 1`. `Num` est une `String` qui reçoit des entiers (conversion implicite).

## État global utilisé

- `Start.Son`, `Start.Musique` (initialiseur de membre et `_New`).
- `Utils.db`, `Utils.Observers`, `Cbase.Table("TabMailCli")`.
- Variables d'instance non préfixées `son`, `Num` (privées par défaut).

## Anomalies relevées (détail dans rework.md)

- Ligne 133-140 : si le code calculé existe déjà, la ligne est ignorée **sans** incrémenter `Num` :
  toutes les lignes suivantes sont ignorées aussi, sans message.
- Lignes 105-132 : un champ absent (ligne courte) garde la valeur de la **ligne précédente**
  (`Try` sans remise à zéro).
- Le fichier n'est jamais fermé (`Close #hFil` absent).
- `INSERT INTO Fiches_Comptes` sans contrôle d'existence du compte.
- Une éventuelle ligne d'en-tête est importée comme un client.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer les 28 `Try x = Lig2[n]` par une lecture indexée bornée (`Champ(Lig2, n)` qui renvoie
  `""` si absent) : réduit la CC et supprime la fuite de valeurs (attention : supprimer la fuite
  change le comportement, voir anomalie A02 ; le rework sans changement conserve la sémantique).
- Utiliser `Cbase.Table("TabCli")`, `Cbase.Table("TabComptes")`, `Cbase.Table("TabParametres")`
  (vérifier les clés exactes dans `Cbase.module`).

### Commonalisation avec d'autres fichiers

Socle commun proposé pour les fenêtres d'import/export (`Utils/Exports-Imports/` et apparentées) :
un module `ImpExp.module` (nom à valider) contenant
- `ChoisirFichier(sTitre) As String` / `ChoisirRepertoire() As String` (dupliqués dans
  [`ImptartypeC`](../ImptartypeC.class/architecture.md), [`ImportStk`](../ImportStk.class/architecture.md),
  [`CompArt`](../../CompArt.class/architecture.md), [`Expart`](../Expart.class/architecture.md),
  [`Expclient`](../Expclient.class/architecture.md)) ;
- `LireCsv(sChemin, sSep) As String[][]` qui ouvre, lit et **ferme** le fichier ;
- `Champ(aLig As String[], i As Integer) As String` ;
- `FinTraitement(hForm, bSon, sMessage)` (curseur par défaut + musique + message).
- La numérotation client de `Compteur` est dupliquée à l'identique dans
  [`ImpSage`](../../../Compta/Utils/ImpSage.class/architecture.md) (`ImpSage.class:826-835`) et sous
  une forme voisine dans [`Facture`](../../../Gestion/Facturation/Facture.class/architecture.md)
  (`Facture.class:1840-1847`) : candidat à un helper commun `ProchainCodeClient(sDernier) As String`
  (module `Utils`), pur et testable en gb.test.

### Réduction de portée

- `Compteur` → `Private`.

### Séparation traitement / GUI

- Extraire la boucle d'import dans `Private Function Importer(sChemin As String) As Integer`
  (renvoie le nombre de clients créés), le handler gardant curseur, musique et messages.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Un compteur `dnc` lu puis réécrit sans verrou est sujet aux collisions en multi-poste ; une
  séquence ou une colonne `AUTO_INCREMENT` dédiée éviterait le `SELECT` d'existence.
- Le mail est stocké à la fois dans `Fiches_Cli.cli_email` et `Mails_Cli` : redondance.
