# Mvtex — Architecture

> Source : `.src/Gestion/Stock/Mvtex.class` · Formulaire : `.src/Gestion/Stock/Mvtex.form`

## Vue d'ensemble

`Mvtex` est l'écran **« Mouvement de stock exceptionnel »** (menu Gestion › Stock,
`Fmenu.Menu79_Click`, après contrôle du tunnel de réplication) : saisie de régularisations de
stock (entrées ou sorties hors achats/ventes) article par article dans une `ColumnView`
(`Colrcp`), puis enregistrement groupé.

Flux :
1. date (`Datej`, `TextReg` date), sens (`Entree`/`Sortie`, sortie par défaut), article (`Cart`,
   code ou `*code-barre`, F2/bouton → `TriArticles`), quantité, commentaire ;
2. « Enregistrer » (`Button1`, tag 1) ajoute ou cumule/remplace la ligne dans la grille
   (`Maj_colrcp`) ; la date est alors verrouillée ;
3. « Valider la saisie » (`Button2`, tag 2) ou fermeture avec confirmation → `Enrgbl` :
   `INSERT` dans `Fiches_Mvtexp` (`qtep` = entrée, `qtem` = sortie, `com`) et mise à jour directe
   de `Fiches_Art.art_qte`, sous `LOCK TABLES` mais **sans transaction** ; avec l'option boissons
   (`B`/`T`), écriture des lignes de régie `Fiches_ligregie` (droits d'accise, `Calculdroit`) et
   d'un numéro de vignette ; puis édition PDF `~/tmp/mvtex.pdf`.

Place dans le calcul du stock (voir le tableau des sources de
[Stockmvt](../../Stockmvt.class/architecture.md)) : `Fiches_Mvtexp` est relue par
[Cstock](../../../Utils/Cstock.module/architecture.md) (`qtep - qtem` depuis l'inventaire) et par
`Stockmvt` (ligne « Mouvements exceptionnels »). `Mvtex` met à jour `art_qte` **directement**
(`Utils.db.Edit`), sans `DB_Connection.Lockstock` (pas de PAMP, pas de stock par dépôt), ce qui
est cohérent avec `Cstock` (qui ne pondère pas `Fiches_Mvtexp` par `art_txconv`). Les mouvements
saisis sont purgés par [Epurmvtexp](../Epurmvtexp.class/architecture.md).

Nature globale : **mixte** ; écran instrumenté (`Utils.Observers`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `B` | var | Private |  | Integer | 27 |
| `Tab` | var | Private |  | String | 28 |
| `Tab2` | var | Private |  | String | 29 |
| `Decm` | var | Private |  | String | 30 |
| `Stocke` | var | Private |  | Boolean | 31 |
| `p` | var | Private |  | Float | 32 |
| `son` | var | Private |  | Integer | 33 |
| `Tri` | var | Private |  | String | 34 |
| `$soption` | var | Private |  | String | 35 |
| `Bsel` | var | Public |  | Boolean | 37 |
| `Bval` | var | Public |  | String | 38 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 40-71 | Public | 1 | 29 | 0 | méthode spéciale |
| `CleanChamps` | 76-83 | Public | 1 | 6 | 0 | portée réductible ? |
| `RazBl` | 88-94 | Public | 1 | 5 | 0 | portée réductible ? |
| `Rcpt_lostfocus` | 99-119 | Public | 5 | 17 | 0 | handler GUI |
| `Rcpt_gotfocus` | 121-135 | Public | 5 | 13 | 0 | handler GUI |
| `rcppt_keypress` | 136-151 | Public | 4 | 13 | 0 | portée réductible ? |
| `Btn_KeyPress` | 156-176 | Public | 5 | 16 | 0 | handler GUI |
| `Btn_Click` | 178-207 | Public | 6 | 24 | 0 | handler GUI |
| `form_close` | 209-215 | Public | 3 | 5 | 0 | handler GUI |
| `art_man` | 221-258 | Public | 5 | 35 | 0 | portée réductible ? |
| `SelectionArt` | 260-280 | Public | 4 | 18 | 0 | portée réductible ? |
| `Quantite` | 285-307 | Public | 4 | 19 | 0 | portée réductible ? |
| `qterecue_LF` | 312-316 | Public | 2 | 3 | 0 | portée réductible ? |
| `Maj_qte` | 321-329 | Public | 1 | 6 | 0 | portée réductible ? |
| `ToggleButton2_Click` | 331-335 | Public | 1 | 3 | 0 | handler GUI |
| `Maj_colrcp` | 340-401 | Public | 15 | 58 | 0 | portée réductible ? |
| `Colrcp_Activate` | 406-428 | Public | 3 | 21 | 0 | handler GUI |
| `Colrcp_Keypress` | 433-448 | Public | 5 | 13 | 0 | handler GUI |
| `Enrgbl` | 453-548 | Public | 16 | 88 | 0 | portée réductible ? |
| `atvig` | 550-569 | Private | 2 | 18 | 0 |  |
| `imprim` | 573-747 | Private | 7 | 165 | 0 |  |
| `Button4_Click` | 752-756 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et remise à blanc

- **`_New()`** [portée : nécessaire] [nature : GUI]. Observateurs, musique, colonnes de `Colrcp`
  (Code, Désignation, Qté entrée, Qté sortie, Commentaire), `Datej` = maintenant, `Qterecue`
  numérique, chaînage `[datej, Cart, qterecue, Comment, Button1]`, option `Utils.Option()`.
- **`CleanChamps()`** [portée : réductible] [GUI]. Vide `Cart`, `Dart`, `Artstock`, `qterecue`.
- **`RazBl()`** [portée : réductible] [GUI]. `CleanChamps`, vide `Comment` (contrôle du
  formulaire) et `Colrcp`.

### Événements de saisie (groupe `Rcpt` : `Datej` 1, `Cart` 2, `Dart` 3, `Qterecue` 4, `Comment` 5)

- **`Rcpt_lostfocus()`** [handler] [mixte]. Tag 2 : si `Cart` commence par `*`, recherche par
  code-barre (`Utils.Find_cbarre`) puis `art_man` ; sinon `art_man`. Tag 4 : `qterecue_LF`.
- **`Rcpt_gotfocus()`** [handler] [GUI]. Refuse le focus hors date/article tant que `Cart` est
  vide (son + `Message.Warning`).
- **`rcppt_keypress()`** [**jamais levé**] [GUI]. Nom mal orthographié (`rcppt` au lieu de
  `Rcpt`) : F1 (aide) et F2 (sélection d'article) ne fonctionnent pas au clavier. `unused`
  (deps.py) confirmé par grep. Voir MVTEX-A01.
- **`Btn_KeyPress()`** / **`Btn_Click()`** [handlers du groupe `Btn` : `Button1` 1, `Button2` 2,
  `Button3` 3] [mixte]. Tag 1 (code dupliqué entre les deux) : verrouille `Datej`,
  `qterecue_LF`, `Maj_colrcp`, `CleanChamps`. Tag 2 : `Enrgbl` si la grille n'est pas vide, puis
  réactive `Datej`. Tag 3 : `Me.Close`.
- **`form_close()`** [handler] [mixte]. Si la grille contient des lignes, propose de valider
  (`Enrgbl`).
- **`ToggleButton2_Click()`** [handler] : `SelectionArt`.
- **`Colrcp_Activate()`** [handler] [GUI]. Rappelle la ligne courante dans la zone de saisie
  (sens déduit de la colonne remplie), relit l'article (`art_man`), **supprime** la ligne de la
  grille. Le `MoveFirst` initial ne sert qu'au test `Available`.
- **`Colrcp_Keypress()`** [handler] [GUI]. Suppr : retire la ligne courante ; Entrée :
  `Colrcp_Activate`.
- **`Button4_Click()`** [handler] : `Doc.Open("Mvtexp")`.

### Article

- **`art_man()`** [portée : réductible] [mixte]. `SELECT * FROM Fiches_Art WHERE art_code = &1` ;
  article stocké : désignation, stock (`Utils.cpoint`), quantité 1, nombre de décimales
  `art_dec` ; non stocké ou inexistant : message. `Tab2 = "Fiches_Tvaav"` est affecté mais jamais
  utilisé.
- **`SelectionArt()`** [portée : réductible] [mixte]. `New TriArticles(True, False, "art_code",
  "", "", Null, False, False, Me)` (9 arguments : correct, `Me` est l'objet de retour), puis
  `Bsel`/`Bval` (positionnés par `TriArticles` via `Object.SetProperty`), puis `art_man`.
- **`Quantite()`** [code mort : jamais appelée] [mixte]. Relit le stock et colore `Artstock`.
- **`qterecue_LF()`** [portée : réductible] [GUI]. Quantité nulle → 1.

### Grille et enregistrement

- **`Maj_colrcp()`** (CC 15) [portée : réductible] [mixte]. Option `B`/`T` : refus si la période
  de droits est close (`VerifDate.ClotDroi`). Article absent de la grille : ajout (entrée en
  colonne 2, sortie en colonne 3). Déjà présent : « 1 cumuler / 2 remplacer » ; le cumul signe la
  quantité (`Utils.totobs`), la réécrit dans la bonne colonne ou retire la ligne si elle est
  nulle. Aucune écriture en base.
- **`Maj_qte(qte)`** [portée : réductible] [calcul]. `Utils.db.Edit("Fiches_Art", …)`,
  `art_qte += qte` pour l'article de la ligne **courante** de `Colrcp` (curseur positionné par
  `Enrgbl`).
- **`Enrgbl()`** (CC 16, max du fichier) [portée : réductible] [mixte].
  `LOCK TABLES Fiches_Art WRITE, Fiches_Mvtexp WRITE` ; pour chaque ligne :
  `INSERT INTO Fiches_Mvtexp (code, daterecpt, qtep, qtem, Com)` (textes de la grille, `""`
  pour la colonne vide) puis `Maj_qte(±qte)` ; `UNLOCK TABLES`. **Pas de transaction** : une
  erreur au milieu laisse des mouvements partiels. Option `B`/`T` : détecte les articles soumis à
  droits (`Fiches_Art` × `Fiches_regie`, test `Available` dupliqué) et les vignettes
  (`suspendu`) ; calcule un numéro de régie libre (`datej.dte.D & Str(i)` jusqu'à absence dans
  `Fiches_ligregie`) **hors verrou** ; si droits : numéro de vignette (`atvig`, appliqué à toutes
  les lignes), `LOCK TABLES` puis `Begin` (sous MySQL, `START TRANSACTION` libère les verrous de
  table, à confirmer), une ligne `Fiches_ligregie` par article à droits (`Calculdroit` :
  volumes, droits, sécurité sociale, taux), `Commit`, `UNLOCK`. Enfin `imprim`, puis `RazBl`.
- **`atvig()`** [Private] [calcul + `Message.Error`]. `LOCK TABLES Fiches_Parametres`, lit
  `nvign` (colonne ajoutée à l'exécution par `modfichier.module:86`, absente de
  `db_control.csv`), l'incrémente, l'écrit sur 25 chiffres, `UNLOCK`.
- **`imprim(bvign, bdroit, nvign)`** [Private] [GUI/édition]. `Report` construit par code (titre,
  en-têtes, une ligne par mouvement, colonnes volume/degré/alcool pur si droits) imprimé dans
  `~/tmp/mvtex.pdf` puis `Visualiseur.Prog`. ⚠️ Le signe de la quantité passé à `Calculdroit`
  est l'inverse de celui d'`Enrgbl` (entrée négative ici) : volumes affichés négatifs pour les
  entrées (à confirmer). `nvign` (paramètre) n'est pas imprimé.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.R/G/B` (couleur du titre de l'édition).
- `Utils.db` (`Exec`, `Edit`, `Create9`, `Begin`, `Commit`), `Utils.Option`, `Utils.cpoint`,
  `Utils.totobs`, `Utils.Find_cbarre`, `Utils.Observers`.
- `Bsel`/`Bval` `Public` : écrits par `TriArticles` (`Object.SetProperty`), doivent rester
  `Public`.
- Membres hérités du style ancien : `B` (écrit, jamais lu), `p` et `Tri` (inutilisés), `Tab2`
  (inutilisé), `Decm`, `Stocke`, `Tab`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Factoriser le cas « tag 1 » de `Btn_KeyPress`/`Btn_Click` dans une fonction privée
  `AjouteLigne()`.
- `Maj_colrcp` : helper privé `EcritQte(qte As Float)` qui place la quantité dans la colonne
  entrée ou sortie (trois copies aujourd'hui).
- `imprim` (175 lignes) : helper `Cellule(hbox, texte, police, largeur, alignement, bordure)`
  (même motif que `Achat.imprime`, voir ACHAT-003).

### Commonalisation avec d'autres fichiers

- **Saisie d'article stocké** (`art_man`, `CleanChamps`, `Quantite`, `SelectionArt`, gestion de
  `*code-barre`) : copies quasi identiques dans [MvtProdcomp](../MvtProdcomp.class/architecture.md)
  (même en-tête « Receipt.class »), [MvtDepots](../../Depots/MvtDepots.class/architecture.md) et
  [Sdepots](../../Depots/Sdepots.class/architecture.md) → contrôle ou module commun (phase 3).
- **Numéro de vignette** (`atvig`) : même séquence `LOCK`/lecture/`UPDATE nvign` dans
  [commande1](../commande1.class/architecture.md) (`rececp_Click`, l. 778-803) → helper unique.
- **Lignes de régie** (`Fiches_ligregie` + `Calculdroit`) : aussi écrites par
  [Achat](../../Entrées/Achat.class/architecture.md) (`EnrRec`, l. 959) → fonction commune
  `Regie.AjouteLigne(...)` (en conservant les écarts de format de `numlig`, voir ACHAT-A09).
- Mise à jour de stock : rapprocher `Maj_qte` des autres écrivains de `art_qte` (notes
  transverses « Stock : Cstock ↔ Lockstock ↔ Validinv ↔ Stockmvt »).

### Réduction de portée

- `CleanChamps`, `RazBl`, `art_man`, `SelectionArt`, `qterecue_LF`, `Maj_qte`, `Maj_colrcp`,
  `Enrgbl` : aucun appelant externe (grep) → `Private`. `Bsel`/`Bval` et les handlers restent
  `Public`. `Quantite` et `rcppt_keypress` relèvent du code mort / de l'anomalie A01.

### Séparation traitement / GUI

- `Enrgbl` : extraire `EnregistreMouvements(dte, lignes As Variant[])` (SQL identique), la
  grille étant convertie en tableau par le handler ; `atvig` renvoie déjà une valeur (garder le
  `Message.Error` dans l'appelant).
- `art_man` : lecture de l'article dans une fonction qui renvoie le `Result`, affichage séparé.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `qtep`/`qtem` en `varchar` (texte de la grille, virgule possible) : un `DECIMAL` signé unique
  `qte` simplifierait `Cstock`, `Stockmvt` et les éditions.
- Un identifiant de lot de saisie (comme `mind` de `Fiches_Mvtexpdc`) permettrait de rattacher
  les lignes de régie à leurs mouvements.
- `nvign` : à déclarer dans le schéma de référence (`db_control.csv`) plutôt qu'à l'exécution.
