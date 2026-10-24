# Btqart — Architecture

> Source : `.src/Gestion/Tables/Btqart.class`

## Vue d'ensemble

`Btqart` (formulaire « Maj boutique », menu `Fmenu.Menu184_Click` → `Btqart.ShowModal()` sur
l'auto-instance) prépare la **mise à jour des produits d'une boutique en ligne** : l'utilisateur
saisit ou sélectionne des codes articles, chacun est ajouté comme une ligne CSV (`;`) dans
`~/Prd.csv` et, si la case `Photo` est cochée, le chemin de sa photo dans `~/Photo.csv` ; le bouton
« Envoyer » transfère ces fichiers par FTP avec la commande externe **`wput`**, en utilisant
l'adresse d'import des articles, celle des photos, l'identifiant et le mot de passe enregistrés dans
les préférences (`/Soc<XX>/Adradminart`, `/Adradminphot`, `/Identifiant`, `/Mdpadmin`, saisis dans
`Prefs`).

Les codes déjà saisis sont mémorisés dans la **table de travail `Art_Saisis`**
(`Cbase.Table("TabArtSaisis")`, clé primaire `code`), supprimée et recréée à l'ouverture et après
chaque envoi : la clé primaire sert de détection de doublon (échec de l'`INSERT`).

Nature : **mixte** (SQL, fichiers, commande externe et contrôles mêlés). Fichier court (235 lignes,
12 fonctions, CC max 17).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hfil` | var | Private | oui | File | 27 |
| `hfil2` | var | Private | oui | File | 28 |
| `rarts` | var | Private |  | Result | 29 |
| `rtva` | var | Private |  | Result | 30 |
| `rfam` | var | Private |  | Result | 31 |
| `CoulZns` | var | Private |  | Integer | 32 |
| `CoulZnaf` | var | Private |  | Integer | 33 |
| `CoulFc` | var | Private |  | Integer | 34 |
| `Bsel` | var | Public |  | Boolean | 35 |
| `Bval` | var | Public |  | String | 36 |
| `b` | var | Private |  | Integer | 37 |
<!-- /AUTO:declarations -->

⚠️ Le bloc ci-dessus omet les variables déclarées sans mot-clé (`Private` implicite) : `rarts`,
`rtva`, `rfam` (`Result` partagés entre `Art_man` et `Button4_Click`), `CoulZns`, `CoulZnaf`,
`CoulFc` (écrites dans `_New`, jamais lues). `hfil`/`hfil2` sont `Static` : partagés par toutes les
instances (une seule en pratique, l'auto-instance). `Bsel`/`Bval` sont écrits par `TriArticles` via
`Object.SetProperty` (`TriArticles.class:30-31`, `165-166`) et doivent rester `Public`.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 40-68 | Public | 7 | 26 | 0 | méthode spéciale |
| `ToggleButton1_Click` | 70-74 | Public | 1 | 3 | 0 | handler GUI |
| `SelectionArt` | 77-88 | Public | 2 | 9 | 0 | portée réductible ? |
| `button4_KeyPress` | 90-94 | Public | 1 | 3 | 0 | handler GUI |
| `Cmpt_KeyPress` | 96-119 | Public | 8 | 19 | 0 | handler GUI |
| `Art_man` | 124-148 | Public | 5 | 23 | 0 | portée réductible ? |
| `Button4_Click` | 153-167 | Public | 3 | 13 | 0 | handler GUI |
| `Button2_Click` | 172-202 | Public | 17 | 28 | 0 | handler GUI |
| `ChkInput` | 204-212 | Public | 6 | 7 | 0 | portée réductible ? |
| `Cmpt_GotFocus` | 217-223 | Public | 1 | 5 | 0 | handler GUI |
| `Button1_Click` | 225-229 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 231-235 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : mixte]. `DROP TABLE IF EXISTS` puis `CREATE TABLE`
  `Art_Saisis (code Char(15) NOT NULL, PRIMARY KEY (code))` + `Utils.db.Engine()` ; centrage (deux
  fois), musique, couleurs (inutilisées), observateurs ; lecture des quatre paramètres de connexion
  dans `Start.LocalSettings` ; **ouverture en écriture (troncature)** de `User.Home/Prd.csv` et
  `User.Home/Photo.csv` ; `Art = "00000"`.
- **`ToggleButton1_Click()`** [handler] → **`SelectionArt()`** [réductible] [GUI] : liste
  `TriArticles(…, Me)` ; si un article est choisi (`Bsel`/`Bval` positionnés par `TriArticles`),
  l'enregistre (`Button4_Click`).
- **`Cmpt_KeyPress()`** [handler] : Entrée/Tab sur `Art` → focus sur `Button4` ; F1 aide ; F2 liste.
- **`Cmpt_GotFocus()`** [handler] : couleur d'édition (`Utils.SetEditColor`).
- **`Art_man()`** [réductible] [mixte] : lit l'article (`TabArt`) ; s'il existe, `INSERT` du code dans
  `Art_Saisis` (doublon → « Cet article a déjà été saisi ! », `b = 1`) ; sinon « Cet article n'existe
  pas ! ».
- **`Button4_Click()`** [handler] [mixte] : `Art_man`, puis lit la TVA (`TabTvav`) et la famille
  (`TabFam`) **sans tester `Available`** (BTQART-A04) et écrit une ligne de 31 champs
  dans `Prd.csv` (désignation, libellé famille, PV HT, taux TVA, PA HT, code, référence et code
  fournisseur, code-barre, poids, écotaxe, quantité, caractéristiques `art_crst` répétées quatre fois,
  « Produit en stock »…). Les champs ne sont pas échappés (BTQART-A05). La ligne se termine par
  `";" ""` : deux littéraux adjacents, concaténés par le compilateur (équivaut à `";"`). Ajoute le
  chemin de la photo dans `Photo.csv` si demandé, et le code à la liste affichée `ListBart`.
- **`button4_KeyPress()`** [handler] : **toute touche** sur `Button4` relance `Button4_Click` (après
  un premier enregistrement, `Art` est vide : message « Cet article n'existe pas ! », à confirmer
  avec l'activation native du bouton par Entrée/Espace, BTQART-A06).
- **`Button2_Click()`** (CC 17) [handler] [mixte] : si les quatre paramètres sont renseignés et la
  liste non vide : ferme les fichiers, `Shell "wput Prd.csv ftp://<id>:<mdp>@<adr>/Prod.csv" Wait`,
  puis un `wput` par photo listée, message « Transfert terminé ! », vide la liste, recrée
  `Art_Saisis` et rouvre (tronque) les deux fichiers. ⚠️ `Prd.csv` est désigné par un chemin
  **relatif** : le transfert dépend du répertoire courant du processus, alors que le fichier est
  écrit dans `User.Home` (BTQART-A01) ; identifiant et mot de passe passent **en clair sur la ligne
  de commande** (visibles par `ps`) et ne sont pas échappés, comme les chemins de photos
  (BTQART-A02) ; le code retour de `wput` n'est pas testé (BTQART-A03).
- **`ChkInput()`** — **code mort** (filtre numérique, aucun appel, signalé `unused` par `deps.py`,
  confirmé par grep).
- **`Button1_Click()`** [handler] : aide `Doc.Open("Btq")`. **`Button3_Click()`** [handler] :
  fermeture (les fichiers restent ouverts jusqu'à la fin du processus).

## État global utilisé

- `Start.LocalSettings` : `/Soc<XX>/Identifiant`, `/Adradminart`, `/Adradminphot`, `/Mdpadmin`
  (mot de passe stocké **en clair** par `Prefs.class:652`), `/Coul/Znaff`, `/Coul/Focus`,
  `/Coul/Znss` ; `Start.Societe`, `Start.Musique`, `Start.son`.
- `Utils.db` (`Exec`, `Engine`), `Cbase.Table` (`TabArtSaisis`, `TabArt`, `TabTvav`, `TabFam`).
- Système de fichiers : `User.Home/Prd.csv`, `User.Home/Photo.csv`, répertoire courant (A01).
- Outil externe : `wput` (dépendance à inscrire dans DEPENDANCES.md si absente).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `ChkInput`, les variables `CoulZns`/`CoulZnaf`/`CoulFc` et le second `Me.Center`.
- Helper privé `RazSaisie()` pour la séquence `DROP`/`CREATE` de `Art_Saisis` + ouverture des
  fichiers (dupliquée entre `_New` et `Button2_Click`).
- `Button4_Click` : construire la ligne CSV dans une fonction pure `LigneProduit(rArt, sFamille,
  sTaux) As String` (testable en gb.test), remplacer `";" ""` par `";"` (texte produit identique).
- `rarts`, `rtva`, `rfam` → locales (passer `rarts` de `Art_man` à `Button4_Click` par retour de
  fonction).

### Commonalisation avec d'autres fichiers

- Table de travail recréée à chaque ouverture : même idiome que les tables `Rupture`/`RuptureC`,
  `Ctrln`, `CFamille` (voir notes transverses) ; un helper `Utils.TableTravail(sNom, sDdl)`
  centraliserait `DROP`/`CREATE`.
- Commandes externes (`wput`) : à regrouper avec les autres appels `Shell` d'export (phase 3).

### Réduction de portée

- `SelectionArt`, `Art_man` → `Private` (aucun appelant externe, grep). `Bsel`/`Bval` restent
  `Public` (`TriArticles`).

### Séparation traitement / GUI

- `Button4_Click` : extraire `AjouteArticle(sCode, bPhoto) As String` (SQL + écriture des fichiers,
  renvoie un message d'erreur) ; `Button2_Click` : extraire `EnvoiBoutique() As Integer`
  (commandes `wput`), les messages restant dans les handlers.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Art_Saisis` est une table de travail partagée par tous les postes (pas de colonne poste ou
  utilisateur) : deux utilisateurs simultanés se suppriment mutuellement leur sélection. Une table
  temporaire de session (`CREATE TEMPORARY TABLE`) ou une colonne `poste` éviterait la collision.
