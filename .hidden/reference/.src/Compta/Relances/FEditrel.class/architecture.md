# FEditrel — Architecture

> Source : `.src/Compta/Relances/FEditrel.class`

## Vue d'ensemble

`FEditrel` est l'écran de **préparation et d'édition des relances clients** (menu Comptabilité ›
Relances › Préparation des relances, `Fmenu.Menu49_Click`). Il remplace l'ancien écran
[`FPrepRel2`](../FPrepRel2.class/architecture.md), devenu mort.

Fonctionnement :
1. **Génération** (`Button1_Click`) : recrée la table de travail `Fiches_relances` (`DROP` +
   `CREATE`, clé `(compte, lind)`) puis y insère les écritures 411 non lettrées échues à la date
   saisie (`Listextcpt` mode `"relance"`), avec un niveau = dernier niveau de relance + 1, borné à 3.
2. **Affichage** (`affiche`) : une ligne [`Ligcli`](../Ligcli.class/architecture.md) par compte dans
   `ScrollView1` ; la ligne active affiche son extrait (lignes [`Ligext`](../Ligext.class/architecture.md))
   dans `ScrollView2`. Navigation clavier (`Up`/`Down`) et souris (`Gotf`), tri par code ou par nom.
3. **Édition groupée** (`Buttonedit_Click` → `Impressionr`) : un PDF unique `~/tmp/Relances.pdf`
   avec une lettre par client sélectionné, à imprimer et non déjà traité individuellement ; chaque
   écriture imprimée met à jour `Fiches_Mvt.relance`.

Les lignes sont manipulées par `ScrollView1.Children` typé `Variant` : tous les accès aux membres
de `Ligcli` (`selection`, `numero`, `lib`, `couleur`, `visext`…) échappent au typage statique.

Nature globale : **mixte**, avec deux grosses fonctions qui mêlent SQL, PDF et contrôles
(`Button1_Click` CC 11, `Impressionr` CC 25).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$blargeur` | var | Private |  | Boolean | 3 |
| `$icompteur` | var | Private |  | Integer | 4 |
| `Devises` | var | Private |  | String | 5 |
| `son` | var | Private |  | Integer | 6 |
| `Coulfd` | var | Private |  | New String[] | 7 |
| `Coulfond` | var | Private |  | String | 8 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 10-40 | Public | 4 | 27 | 0 | méthode spéciale |
| `lig_GotF` | 42-57 | Public | 5 | 13 | 0 | handler GUI |
| `Lig_up` | 59-75 | Public | 3 | 13 | 0 | handler GUI |
| `lig_Down` | 77-93 | Public | 3 | 13 | 0 | handler GUI |
| `ScrollView1_KeyPress` | 95-100 | Public | 3 | 4 | 0 | handler GUI |
| `Checktout_Click` | 102-119 | Public | 4 | 15 | 0 | handler GUI |
| `CheckBox2_Click` | 121-131 | Public | 2 | 8 | 0 | handler GUI |
| `affiche` | 133-158 | Private | 5 | 23 | 0 |  |
| `efface` | 160-174 | Private | 3 | 12 | 0 |  |
| `Buttontrnom_Click` | 176-221 | Public | 9 | 37 | 0 | handler GUI |
| `Buttontrn_Click` | 223-268 | Public | 9 | 37 | 0 | handler GUI |
| `ligtag` | 270-280 | Private | 2 | 8 | 0 |  |
| `selcouleur` | 282-292 | Private | 2 | 8 | 0 |  |
| `couleur` | 294-302 | Private | 2 | 7 | 0 |  |
| `Button1_Click` | 304-395 | Public | 11 | 82 | 0 | handler GUI |
| `dte_KeyPress` | 397-413 | Public | 5 | 9 | 0 | handler GUI |
| `dteN1_GotFocus` | 415-421 | Public | 1 | 5 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 423-436 | Public | 2 | 12 | 0 | portée réductible ? |
| `Impressionr` | 438-610 | Public | 25 | 152 | 0 | portée réductible ? |
| `Buttonedit_Click` | 612-616 | Public | 1 | 3 | 0 | handler GUI |
| `Button6_Click` | 618-622 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_New()`** [spéciale] [mixte]. Observateurs replay, son, centrage ; couleur de focus
  `Coulfond = Val(Utils.FColr(/Coul/Focus)[0])` (variable déclarée `String` mais utilisée comme
  couleur entière) ; date du jour ; devise lue dans `Fiches_Parametres` (`Cbase.Table("TabParam")`),
  convertie en symbole (`"Euros"` → `€`, sinon première lettre) ; mise en page ; `affiche()` ;
  `Checktout_Click` (la case est cochée dans le `.form`) ; sélection de la première ligne.

### Navigation et sélection (handlers des événements `Ligcli` groupe `"lig"`)

- **`lig_GotF(nlig)`** [handler `Gotf`] [GUI]. Si la ligne change : fond par défaut pour toutes les
  lignes, couleur de focus et `visext` (extrait) pour la ligne `nlig`, décoche `CheckBox2`.
- **`Lig_up(nlig)` / `lig_Down(nlig)`** [handlers `Up`/`Down`] [GUI]. Même traitement sur la ligne
  précédente/suivante (`$icompteur ± 1`, bornes 0 et `count - 1`).
- **`ScrollView1_KeyPress()`** [handler] [GUI]. Flèches → `Lig_up`/`lig_Down`.
- **`Checktout_Click()`** [handler] [GUI]. Applique `Checktout.Value` à la propriété `selection` de
  toutes les lignes `Ligcli` (voir [`Ligcli.Checkselec_Click`](../Ligcli.class/architecture.md) pour
  l'effet SQL possible), puis focus sur la ligne courante.
- **`CheckBox2_Click()`** [handler] [GUI]. Applique `CheckBox2.Value` à la `selection` de toutes les
  lignes `Ligext` de l'extrait.
- **`Buttontrnom_Click()` / `Buttontrn_Click()`** [handlers] [GUI]. Tri des lignes par `numero`
  (`Buttontrnom`, malgré son nom) ou par `lib` (nom) ; le sens alterne selon `Tag` (1/2) avec
  changement d'icône. Tri par échange de position (`tab[j].next = tab[i]`) en O(n²), en relisant
  `Children` après chaque déplacement ; puis `ligtag` renumérote les tags. Les deux fonctions sont
  identiques à la propriété comparée près.
- **`ligtag()`** [Private] [GUI]. `Tag = rang` pour chaque ligne.
- **`selcouleur()` / `couleur(coul)`** [Private] [GUI] — **code mort** (appels commentés).

### Génération des relances

- **`affiche()`** [Private] [mixte]. Si la table existe (`Utils.db.Tables.Exist`),
  `SELECT compte FROM Fiches_relances GROUP BY compte ORDER BY compte ASC` ; crée les `Ligcli`,
  cumule `sold` et affiche « N clients vous doivent un total de … ». Ajuste la largeur une fois
  (`$blargeur`).
- **`efface()`** [Private] [GUI]. Détruit toutes les lignes `Ligcli`.
- **`Button1_Click()`** [handler] [mixte] (CC 11). « Générer » :
  `DROP TABLE if exists Fiches_relances` puis `CREATE TABLE … PRIMARY KEY (compte, lind)` +
  `Utils.db.Engine()` ; si une date est saisie : `New Listextcpt("411%", -8 ans, +8 ans, "n",
  "dte asc", "relance", dteN)` ; barre de progression ; pour chaque écriture : écartée si l'échéance
  est postérieure à la date (`LDate.Apres`) ; niveau = 1 si `relance` vide, sinon `relance + 1` borné
  à 3 ; `SELECT * from Fiches_Cli where cli_code = &1` ; `INSERT` sous `Try`, et en cas d'échec
  second `INSERT` avec `numdoc = compte & lind`. Puis `efface`, `affiche`, tout sélectionner.
  ⚠️ `prgb.Close` final est exécuté même si la barre n'a pas été créée (date vide ou aucune
  écriture) : erreur « objet nul » (FEDITREL-A01). `Me.mouse = Mouse.Default` sans `Mouse.Wait`
  préalable.
- **`dte_KeyPress()`** [handler du groupe `Dte`] [GUI]. Entrée/Retour/Tab sur `DteN1` (tag 1) →
  `dteN1_LostFocus`.
- **`dteN1_GotFocus()` / `dteN1_LostFocus()`** [handlers] [GUI]. Couleur d'édition
  (`Utils.SetEditColor`), normalisation de la date (`Utils.Cdate_calc`/`Cdate_aff`), date du jour si
  invalide (`"00.00.0:00"`).

### Édition

- **`Impressionr(Org)`** [portée : réductible, appelée seulement par `Buttonedit_Click`] [mixte]
  (CC 25). Paramètre `Org` inutilisé ; variables `Filetxt`, `Tab4` hors UPDATE et `Shell "cd …"`
  sans effet. En-tête société (`Fiches_Societes`, **sans test `Available`**) ; puis boucle
  `Repeat … Until i = tabl.count` sur les lignes `Ligcli` (**exécutée au moins une fois** : erreur
  d'indice s'il n'y a aucune ligne, FEDITREL-A02) ; pour chaque client sélectionné, à imprimer et
  non traité : lignes `Fiches_relances` du compte, texte du niveau (`Fiches_Txt_Relances`,
  `numlet`) ou « Relevé de compte », une ligne `Level7` par écriture avec
  `UPdate Fiches_Mvt SET relance = &1 WHERE compte = &2 and numdoc = &3` (niveau de la **première**
  écriture du client), saut de page à `PosY >= 273`, solde de la sélection et solde du compte
  (`Fiches_Comptes`, signe inversé si négatif). `pdf.Output` + `Visualiseur.Prog`. Le bloc d'envoi
  par courriel est commenté.
- **`Buttonedit_Click()`** [handler] [GUI]. `Impressionr("")`.
- **`Button6_Click()`** [handler] [GUI]. Ferme.

## État global utilisé

- `Utils.db`, `Utils.FColr`, `Utils.SetEditColor`, `Utils.Cdate_*`, `Utils.cpoint`, `Utils.Observers`.
- `Start.Son`, `Start.Musique`, `Start.Societe`, `Start.LocalSettings["/Coul/Focus"]`,
  `Start.LocalSettings["/Soc<XX>/Siret"]`.
- `Listextcpt`, `LDate`, `ProgBar`, `Creleve`, `Visualiseur`.
- Table de travail globale `Fiches_relances` (partagée par tous les postes).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Buttontrnom_Click`/`Buttontrn_Click` : un helper privé `TriLignes(propriete, croissant)` ;
  le tri peut se faire sur un tableau trié puis replacé dans l'ordre (même ordre final, à valider
  par replay car l'algorithme actuel n'est pas stable).
- `lig_GotF`/`Lig_up`/`lig_Down` : un helper `Active(nlig)` (remise à zéro des couleurs, couleur de
  focus, `visext`, `CheckBox2`).
- Supprimer `selcouleur`/`couleur` (morts), `Filetxt`, `Org`, `Shell "cd …"`.
- Typage : `Coulfond As Integer`, `Coulfd` local à `_New`.

### Commonalisation avec d'autres fichiers

- **Création de `Fiches_relances` et insertion** : copie de
  [`FPrepRel2.Button1_Click`](../FPrepRel2.class/architecture.md) (clé différente) ; l'insertion
  existe aussi dans [`Ligext.CheckBox1_Click`](../Ligext.class/architecture.md).
- **Corps de lettre** et **en-tête société** : dupliqués dans
  [`Ligcli.Buttonedit_Click`](../Ligcli.class/architecture.md),
  [`FRelCompte.Releves`](../FRelCompte.class/architecture.md),
  [`FRelFacture.Releves`](../FRelFacture.class/architecture.md) (voir LIGCLI-004/005).
- Calcul du niveau suivant (`relance + 1` borné à 3) identique à `FPrepRel2:253-261` : fonction
  `NiveauSuivant(relance)`.
- `dte_KeyPress`/`dteN1_*` : même idiome de saisie de date que `FRelCompte`, `FRelFacture` et de
  nombreux écrans Compta (`Compdate` dans `Journaux`, `Balance`, `Editcompte`…).

### Réduction de portée

- `Impressionr` → `Private` (seul appelant : `Buttonedit_Click`, vérifié par grep). Les handlers
  `lig_*` restent `Public` (événements de `Ligcli`).

### Séparation traitement / GUI

- `Button1_Click` : `GenereRelances(dteN) As Integer` (DROP/CREATE + insertions, sans contrôle ni
  barre de progression passée en paramètre optionnel) ; le handler garde la saisie, le message et
  le rafraîchissement.
- `Impressionr` : la liste des clients à éditer (numéro, type de lettre, numéro de lettre) est
  extraite des lignes par le handler, puis passée à une fonction d'édition sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_relances` : table permanente déclarée (avec identifiant d'utilisateur/poste) au lieu
  d'un `DROP`/`CREATE` à chaque génération, qui écrase le travail d'un autre poste.
- Mise à jour de `Fiches_Mvt.relance` par `lind` (stocké dans `Fiches_relances`) plutôt que par
  `compte` + `numdoc` ; index sur `Fiches_Mvt(compte, numdoc)` sinon.
- L'historique (`Fiches_Mvt1-5`) n'est jamais mis à jour : le niveau de relance d'une écriture
  d'un exercice archivé reste figé.
