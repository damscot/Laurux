# Portable — Architecture

> Source : `.src/Gestion/Lcr/Portables/Portable.module`

## Vue d'ensemble

Malgré son rangement sous `Lcr/`, ce module n'a **aucun lien avec les LCR**. Les « portables » sont,
d'après le code seulement, des **terminaux portables de saisie (lecteurs de codes-barres) d'inventaire** :
le terminal produit un fichier texte `inventaire.txt` que l'utilisateur doit copier dans
`~/Portable` (message des écrans appelants ; texte de `Majcasier.form` : « fichier inventaire.txt
généré par le portable inventaire »). Chaque ligne est une suite de champs séparés par `;`.

`Import(Org)` lit ce fichier pour l'impression d'**étiquettes** (`Org = "Etiq"`) : chaque ligne
`code-barres;nombre` devient une ligne de la table de travail `Etiquettes` (`code`, `nombre`), après
résolution du code-barres en code article (`Utils.Find_cbarre`). Les rejets sont écrits dans
`~/tmp/ImpT.txt` et comptés dans la globale `cpt2`, que les écrans d'étiquettes lisent pour ouvrir
ce rapport dans l'éditeur.

Le même fichier `~/Portable/inventaire.txt` est relu, par du code dupliqué, dans
[`Majcasier`](../Majcasier.class/architecture.md), `Achat`, `Facture`, `SaisieInv`, `SaisieInvT`.

Nature : **traitement** (fichiers + SQL) avec un `Message.Error` dans le `Catch`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `cpt2` | var | Public | oui | Integer | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Import` | 8-79 | Public | 18 | 68 | 4 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Import(Org As String)`** [portée : nécessaire, appelée par `Etigond`, `Etiqart`, `Etiqcasier`,
  `Majcasier`] [nature : mixte, GUI limitée au `Catch`] (CC 18) :
  - `Shell "cd ~"` sans effet ; ouvre `~/tmp/ImpT.txt` en écriture (le crée ou le **vide**) ; si
    `~/tmp` n'existe pas, erreur → `Catch` (`Music.Play` + `Message.Error`) ;
  - ouvre `~/Portable/inventaire.txt` en lecture **et écriture** (lecture seule suffirait) sous
    `Try` ; absent → la fonction se termine sans message ;
  - **seulement si `Org = "Etiq"`** : en-tête du rapport, puis pour chaque ligne non nulle : champ 1 =
    code-barres → `Code = Utils.Find_cbarre(Codeb)` (code article via `TabCdBarre` ou `TabArt`, `""`
    si inconnu) ; champ 2 = nombre (`Format$(Val(Utils.cpoint(cle)), "#")`). Si `Code` est non vide :
    `SELECT * FROM Cbase.Table("TabArt") where art_code = &1`, puis
    `Try INSERT INTO Etiquettes (code, nombre) Values (&1, &2)` (table de travail nommée en dur,
    erreurs ignorées) ; article introuvable → rapport + `cpt2`. `Code` n'est **pas** réinitialisé
    entre deux lignes : une ligne sans code-barres réutilise l'article de la ligne précédente (et
    est tout de même insérée, après le message « rejetée ») ;
  - pour `Org = "Casier"` (appel de `Majcasier`), rien n'est lu : la fonction vide seulement
    `~/tmp/ImpT.txt` ;
  - `Hnew` n'est jamais fermé explicitement, `HFil` seulement dans la branche `Etiq` (fermeture à la
    libération de l'objet `File`, à confirmer) ; `With utils` inutile ;
  - **`cpt2` n'est jamais remis à 0** : il cumule les rejets de tous les imports de la session.

## État global utilisé

- `Public cpt2 As Integer` (globale de module) : lue par `Etigond:1062`, `Etiqart:1023`,
  `Etiqcasier:1000` (`If Portable.cpt2 <> 0 Then Editeur.Prog_Editeur(Filename)`).
- `User.Home`, `Utils.Find_cbarre`, `Utils.cpoint`, `Utils.db`, `Cbase.Table("TabArt")`, `Music`.
- Fichiers : `~/Portable/inventaire.txt` (entrée), `~/tmp/ImpT.txt` (rapport).
- Table de travail `Etiquettes` (hors `Cbase`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Découper la ligne par `Split(Lig, ";")` au lieu de la boucle `InStr`/`Mid$` (même résultat pour
  les lignes à 2 champs ; à vérifier pour les champs vides).
- Fermer explicitement `Hnew` et `HFil` (`Try Close`) ; ouvrir le fichier en lecture seule.
- Supprimer `Shell "cd …"`, `With utils`, le double `Val(Utils.cpoint(…))`.

### Commonalisation avec d'autres fichiers

- **Lecture de `~/Portable/inventaire.txt`** dupliquée dans `Majcasier.Import_Portable`,
  `Achat.class:711`, `Facture.class:10525`, `SaisieInv.class:472`, `SaisieInvT.class:483` :
  proposer `Portable.LireInventaire() As String[][]` (champs par ligne) et
  `Portable.ResoudreCode(codebarre) As String`, appelés par ces écrans (phase 3 ; `Facture`
  seulement de façon minimale).
- Le message « Le fichier 'inventaire.txt' du portable doit être vidé dans ~/Portable » est
  dupliqué dans 4 écrans.

### Réduction de portée

- `Import` et `cpt2` sont utilisés à l'extérieur : portée nécessaire.

### Séparation traitement / GUI

- Le `Catch` affiche `Message.Error` : renvoyer un code d'erreur et laisser l'appelant afficher le
  message (même texte).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Table de travail `Etiquettes` non déclarée dans `Cbase` ni dans `db_control.csv` (créée à
  l'exécution par les écrans d'étiquettes) : à normaliser avec les autres tables de travail.
