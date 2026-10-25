# Edart4 — Architecture

> Source : `.src/Gestion/Impressions/Edart4.class` · Formulaire : `.src/Gestion/Impressions/Edart4.form`

## Vue d'ensemble

`Edart4` est l'écran actuel d'**impression du tarif client** (menu Gestion > Impression des tables >
Tarif > Client, `Fmenu.Menu74_Click` → `EdArt4.Show` : Gambas résout le nom de classe sans tenir
compte de la casse). Il remplace [`EdArt2`](../EdArt2.class/architecture.md) depuis le commit
`29df3a6d`.

Contrairement aux autres éditions du lot, il n'utilise pas `PdfWriter` mais **gb.report** : un
`Report` construit par code (`ReportVBox`/`ReportHBox`/`ReportLabel`/`ReportImage`) imprimé dans
`~/tmp/tarif.pdf` par un `Printer` (`OutputFile`), puis ouvert par `Visualiseur.Prog`.

L'utilisateur choisit un **client** (`Butclig`, `TriCpt`) ou un **type client** (`Textyp`, liste
`ColumnView1`), des plages fournisseur et article, les familles à imprimer dans un arbre
(`TreeView1`, construit depuis [`Trifam`](../../../Utils/Trifam.class/architecture.md), tout
sélectionné par défaut), et les options photo (`Phot`), articles négociés seulement (`Checkneg`),
saut de page par famille (`Checksdp`), logo (`Checlogo`). Le prix de chaque article est calculé
par [`TarArt`](../../../Utils/TarArt.class/architecture.md) (tarif client, promotions, droits en
option boisson `B`/`T` via `Calculdroit`).

Nature globale : **mixte** : calcul délégué à `TarArt`, SQL et mise en page dans le formulaire.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 3 |
| `$width` | var | Private |  | String | 4 |
| `$coul` | var | Private |  | Integer | 5 |
| `$familles` | var | Private |  | Trifam | 6 |
| `$rpt` | var | Private |  | Report | 7 |
| `$rescli` | var | Private |  | Result | 8 |
| `$soption` | var | Private |  | String | 9 |
| `$tarif` | var | Private |  | TarArt | 10 |
| `Bsel` | var | Public |  | Boolean | 12 |
| `Bval` | var | Public |  | String | 13 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 15-43 | Public | 1 | 24 | 0 | méthode spéciale |
| `TriArticles` | 45-61 | Private | 4 | 14 | 0 |  |
| `ToggleButton5_Click` | 63-73 | Public | 2 | 8 | 0 | handler GUI |
| `ToggleButton6_Click` | 75-85 | Public | 2 | 8 | 0 | handler GUI |
| `Butclig_Click` | 87-102 | Public | 2 | 12 | 0 | handler GUI |
| `Butimp_Click` | 106-168 | Public | 19 | 58 | 0 | handler GUI |
| `tetedecolone` | 171-240 | Private | 4 | 59 | 0 |  |
| `ligne` | 242-318 | Private | 5 | 67 | 0 |  |
| `entetefamille` | 320-329 | Private | 1 | 8 | 0 |  |
| `sautdepage` | 331-340 | Private | 2 | 7 | 0 |  |
| `entete` | 342-401 | Private | 3 | 55 | 0 |  |
| `Buttypc_Click` | 403-424 | Public | 4 | 17 | 0 | handler GUI |
| `ColumnView1_Click` | 426-431 | Public | 1 | 4 | 0 | handler GUI |
| `ColumnView1_KeyPress` | 433-439 | Public | 2 | 5 | 0 | handler GUI |
| `Butfin_Click` | 440-444 | Public | 1 | 3 | 0 | handler GUI |
| `ToggleButton1_Click` | 446-455 | Public | 2 | 8 | 0 | handler GUI |
| `ToggleButton2_Click` | 457-467 | Public | 2 | 8 | 0 | handler GUI |
| `saisie_gotfocus` | 469-473 | Public | 2 | 3 | 0 | handler GUI |
| `saisie_lostfocus` | 475-479 | Public | 2 | 3 | 0 | handler GUI |
| `saisie_keypress` | 481-492 | Public | 5 | 11 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et saisie

- **`_new()`** [portée : nécessaire (constructeur)] [nature : GUI]. `Utils.Observers(Me)`, son,
  centrage, couleur `$coul` depuis `Start.R/G/B` ; 5 observateurs `"saisie"` (`Textyp`, `four`,
  `four2`, `art`, `art2`) dans une variable locale `obs` réaffectée ; `Tag` de chaque champ remplacé
  par un tableau `[précédent, suivant]` (les `Tag` `"1"`…`"6"` du `.form` sont écrasés) ;
  `$familles = New Trifam("1")` puis `TriArticles($familles.enfant)` ; plages par défaut
  (fournisseurs `40100001`–`40199999`, articles `00000`–`ZZZZZ`) ; `$soption = Utils.Option()`.
- **`TriArticles(fam As Trifam)`** [portée : Private] [nature : GUI]. Parcours récursif (via
  `precedant`) de l'arbre des familles et ajout dans `TreeView1`, chaque nœud sélectionné et
  visible. ⚠️ **Homonyme de la classe `TriArticles`** utilisée dans `ToggleButton1_Click`
  (`New TriArticles(…)` reste résolu vers la classe) : source de confusion (limite connue de
  `deps.py`).
- **`saisie_gotfocus()` / `saisie_lostfocus()`** [portée : nécessaire (handlers d'observateur)]
  [nature : GUI]. `Utils.ObsGotf` / `ObsLstf`.
- **`saisie_keypress()`** [portée : nécessaire (handler d'observateur)] [nature : GUI].
  Entrée/Retour/Tab → champ suivant (`Last.Tag[1]`), flèche haut → précédent (`Last.Tag[0]`), puis
  **`Stop Event` inconditionnel** (l. 491) : l'observateur annule toutes les frappes, ce qui
  empêcherait toute saisie au clavier dans ces 5 champs (à confirmer en replay, EDART4-A01).

### Choix du client, du type, des plages

- **`ToggleButton5_Click()` / `ToggleButton6_Click()`** [portée : nécessaire (handler)]
  [nature : GUI]. `New TriCpt(TriCpt.Fournisseur, TriCpt.Sans_Solde, Me)` modal ; si `Bsel`, `Four` /
  `Four2` ← `Bval` (`Bsel` jamais remis à faux).
- **`Butclig_Click()`** [portée : nécessaire (handler)] [nature : mixte]. `TriCpt` client ; si
  `Bsel` : `SELECT * FROM Fiches_Cli WHERE cli_code = &1` (nom en dur, **sans test `Available`**),
  adresse dans `TextArea1`, `Textyp` ← `cli_typec` puis `Textyp.Enabled = False` (jamais réactivé :
  impossible de revenir à un tarif par type sans rouvrir l'écran).
- **`Buttypc_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Bascule `ColumnView1`
  (`Raise` à chaque appel) : `SELECT * FROM Fiches_Typec` (en dur, sans `ORDER BY`), une ligne
  « code libellé » par type.
- **`ColumnView1_Click()`** [portée : nécessaire (handler, rejeu dynamique)] [nature : GUI].
  `Textyp` ← clé courante, liste masquée.
- **`ColumnView1_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. Échap masque la liste.
- **`ToggleButton1_Click()` / `ToggleButton2_Click()`** [portée : nécessaire (handler)]
  [nature : GUI]. `New TriArticles(True, False, "art_code", "", "", Null, False, False, Me)` modal ;
  `Art` / `Art2` ← `Bval`.
- **`Butfin_Click()`** [portée : nécessaire (handler)] [nature : GUI]. `Me.Close` (le PDF n'est pas
  supprimé, contrairement aux autres écrans du lot).

### Impression (gb.report)

- **`Butimp_Click()`** [portée : nécessaire (handler)] [nature : mixte] (CC 19). `Printer` vers
  `~/tmp/tarif.pdf` ; arbre vide → `Return`. `entete`, `tetedecolone`, puis pour chaque nœud
  **sélectionné** de `TreeView1` : un nœud racine (famille) imprime `entetefamille` (précédé de
  `sautdepage` à partir de la 2ᵉ famille) ; pour tout nœud, `SELECT art_code, art_design, art_prvt,
  art_pvht, taux_tva, art_fam, art_photo FROM Fiches_Art, Fiches_Tvaav WHERE code_tva = art_tva AND
  art_fam = &1 AND art_suspendu = &2 (False) AND art_four BETWEEN &3 AND &4 AND art_code BETWEEN &5
  AND &6` (tables en dur, **sans `ORDER BY`** : ordre des articles non garanti). S'il y a des
  articles : ligne « Sous Famille » colorée, puis par article `New TarArt(code, client, Me, type,
  "")` + `Hide` (une fenêtre cachée par article jamais détruite, TARART-A04). Filtre `Checkneg` :
  seulement les articles à prix négocié. TVA = `prixht × taux / 100` (`Utils.totobs`), plus en option
  `B`/`T` la TVA et les droits de `Calculdroit` (`droit + secu`, colonnes « droits » et « S.S ») ;
  TTC = HT + droits + TVA ; `ligne(…)`. Enfin `$rpt.Print(prt)` et `Visualiseur.Prog`. Aucun message
  si aucun article ; pas de curseur d'attente.
- **`tetedecolone()`** [portée : Private] [nature : GUI]. En-tête de colonnes fixe (Code, Libelle,
  H.T, [droits, S.S], TVA, TTC, [Photo]).
- **`ligne(code, lib, ht, tva, ttc, Imag, coul, h, Optional dr, ss)`** [portée : Private]
  [nature : GUI]. Une ligne du rapport ; en mode photo, `Image.Load(imag)` **sans `Try` et sans
  préfixe `/Soc<XX>/Photart`** (les écrans `EdArt1`/`EdArt3` préfixent ce répertoire : l'un des deux
  usages est faux, à confirmer selon le contenu de `art_photo`), ligne de 30 mm.
- **`entetefamille()`** [portée : Private] [nature : GUI]. Bandeau « Famille : code libellé ».
- **`sautdepage()`** [portée : Private] [nature : GUI]. `ReportPageBreak` si `Checksdp`.
- **`entete()`** [portée : Private] [nature : mixte]. Crée `$rpt` ; titre « Impression du tarif
  client au <date> » ; bloc société : `SELECT * FROM Fiches_Societes` **sans filtre `cd_sc`** (1ʳᵉ
  ligne de la table, alors que `Editfac`, `Fmenu`, `Bordereaux` filtrent sur `Start.Societe`) ;
  logo `Image.Load(/Soc<XX>/Logo)` sans `Try` si `Checlogo` ; adresse client (`TextArea1`).

## État global utilisé

- `Start.Musique`, `Start.Son`, `Start.R/G/B`, `Start.Societe`, `Start.LocalSettings`
  (`/Soc<XX>/Logo`, options via `Utils.Option` : `/Soc<XX>/bois`, `/pp`…).
- `Utils.db.Exec`, `Utils.Observers`, `Utils.ObsGotf`, `Utils.ObsLstf`, `Utils.Option`,
  `Utils.totobs`.
- `Visualiseur.Prog` ; `Bsel`/`Bval` écrits par `TriCpt` et `TriArticles` (`Object.SetProperty`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Renommer la procédure privée `TriArticles` (homonyme de la classe) en `AjouteFamilles`.
- Garder les 5 observateurs dans un tableau `Private $obs As Observer[]` (comportement identique
  si les observateurs sont aujourd'hui conservés par l'objet observé, à confirmer).
- Supprimer les variables mortes de `Butimp_Click` (`res`, `cle`, `nego`) et de `Buttypc_Click`.
- `tetedecolone`/`ligne` : 6 blocs `ReportLabel` identiques → helper `Cellule(hb, texte, align,
  largeur, bordure)`.
- Réutiliser **une seule** instance `TarArt` (ou un calcul de tarif sans fenêtre) : dépend du rework
  de `TarArt` (TARART-A04 : changement de comportement si la fenêtre cachée a des effets).

### Commonalisation avec d'autres fichiers

- Faible duplication avec les autres éditions du lot (5 à 8 %, conception différente).
- **En-tête société** : le bloc d'`entete` (raison sociale, adresse, tél., mail, site) est la même
  donnée que les en-têtes PDF des relances (`Creleve.EnteteSociete` proposé par
  [Ligcli](../../../Compta/Relances/Ligcli.class/architecture.md#commonalisation-avec-dautres-fichiers)).
  Comme ici le rendu est gb.report, seule la **lecture** est commune : une fonction
  `Utils.LitSociete() As Result` (avec la décision sur le filtre `cd_sc`) servirait aux deux
  moteurs de rendu.
- Parcours de l'arbre `Trifam` : même procédure récursive dans `Edinv`, `Edinv1`, `Stockmvt`,
  `Histocliart` (proposition `Trifam.Parcours()` de
  [Trifam/architecture.md](../../../Utils/Trifam.class/architecture.md#commonalisation-avec-dautres-fichiers)).
- Liste des types client : même besoin qu'`EdArt3.ToggleButton7_Click` (EDART3-007).

### Réduction de portée

- Aucun membre `Public` réductible (`deps.py` : `scope_reducible` vide) : tous sont des handlers ou
  `Bsel`/`Bval`.

### Séparation traitement / GUI

- `Butimp_Click` : extraire `ArticlesFamille(fam, four1, four2, art1, art2) As Result` et
  `PrixLigne(code, client, typec) As Float[]` (HT, droits, TVA, TTC) sans accès aux contrôles ;
  le handler garde l'arbre, les cases et le rapport.
- `Butclig_Click` : lecture du client séparée de l'affichage de l'adresse.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Un tarif client précalculé (table des prix par client/type) éviterait l'instanciation de
  `TarArt` par article.
