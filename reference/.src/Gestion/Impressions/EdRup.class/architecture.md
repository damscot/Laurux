# EdRup — Architecture

> Source : `.src/Gestion/Impressions/EdRup.class` · Formulaire : `.src/Gestion/Impressions/EdRup.form`

## Vue d'ensemble

`EdRup` est l'écran d'**impression des produits à commander** (ruptures de stock) (menu
« Impression des produits a commander », `Fmenu.Menu253_Click` → `EdRup.Show`). Paramètres :
plages fournisseur `Four`–`Four2` et article `Art`–`Art2` (défaut `0000000000000`–`ZZZZZZZZZZZZZ`),
`CheckBox1` (inclure les articles non stockés / sans mini-maxi), `CheckBox2` (détail par commande
client), `CheckBox3` + `Jours` (ventes en caisse des N derniers jours). `CheckBox1`/`CheckBox2` sont
mémorisées par société (`/Soc<XX>/Edrupt/Nstock`, `/Rclient`) à la fermeture.

**Imprimer** appelle [`Crupt.Rupture`](../../../Utils/Crupt.module/architecture.md) (appelant
unique), qui **supprime et recrée** les tables de travail `Rupture` et `RuptureC` (hors
`db_control.csv`, hors `Laurux01.sql`, sans clé `Cbase`) à partir des commandes fournisseurs
(`Fiches_Ligcom`/`Fiches_Entcom`), des commandes clients (`Fiches_Bl`/`Fiches_Ligbl` type `C`, lignes
`A`) et du stock. `EdRup` relit ensuite ces tables jointes à `Fiches_Art` et imprime
`~/tmp/Pcommande.pdf` avec `Carticles` (`Level13`/`Level13R`/`Level13V`, `Level14`/`Level14V`) :

1. produits à commander (`Rupture`), groupés par commande client si `CheckBox2` ;
2. si `CheckBox2`, détail « Dont commande(s) client » (`RuptureC`) ;
3. si `CheckBox3`, ventes en caisse agrégées (`Fiches_HisLigTickets` ⋈ `Fiches_HisEntTickets` ⋈
   `Fiches_Art`).

Autres utilisateurs des tables de travail (grep `Rupture`) : `Crupt.module` (création, écriture),
`Utils/Changefam.class:541-542` (`UPdate Rupture/RuptureC SET codea`) et `:732` (`LOCK TABLES`).
Deux postes qui impriment en même temps s'écrasent (CRUPT-A05).

Nature globale : **mixte**, `Button2_Click` (CC 73, 325 lignes) mêle lecture SQL, règles
« à commander » et mise en page.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `son` | var | Private |  | Integer | 29 |
| `PosY` | var | Private |  | Integer | 30 |
| `PosX` | var | Private |  | Integer | 31 |
| `Coulfond` | var | Private |  | New String[] | 32 |
| `Bsel` | var | Public |  | Boolean | 34 |
| `Bval` | var | Public |  | String | 35 |
| `artbl` | var | Private |  | Boolean | 37 |
| `Origine` | var | Private |  | String | 38 |
| `b` | var | Private |  | Integer | 39 |
| `qtec` | var | Private |  | Integer | 40 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 42-60 | Public | 3 | 16 | 0 | méthode spéciale |
| `ToggleButton1_Click` | 62-67 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton2_Click` | 69-74 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton3_Click` | 79-94 | Public | 2 | 13 | 0 | handler GUI |
| `ToggleButton4_Click` | 96-110 | Public | 2 | 12 | 0 | handler GUI |
| `fourman` | 115-127 | Public | 3 | 10 | 0 | portée réductible ? |
| `SelectionArt` | 130-151 | Public | 4 | 19 | 0 | portée réductible ? |
| `art_man` | 156-182 | Public | 6 | 24 | 0 | portée réductible ? |
| `Btn_Click` | 184-203 | Public | 6 | 14 | 0 | handler GUI |
| `Btn_KeyPress` | 205-212 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_KeyPress` | 214-276 | Public | 16 | 55 | 0 | handler GUI |
| `Cmpt_GotFocus` | 281-287 | Public | 1 | 5 | 0 | handler GUI |
| `Button2_Click` | 289-613 | Public | 73 | 305 | 0 | portée réductible ? |
| `Button1_Click` | 615-619 | Public | 1 | 3 | 0 | handler GUI |
| `CheckBox3_Click` | 621-623 | Public | 1 | 2 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et saisie

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. Son, centrage, `Frmt`/`Coulfond`
  lus et inutilisés, `Utils.Observers(Me)`, restauration de `CheckBox1`/`CheckBox2` depuis
  `/Soc<XX>/Edrupt/*` (`Try`), plages par défaut, focus sur `Four`.
- **`ToggleButton1_Click()` / `ToggleButton2_Click()`** [portée : nécessaire (handler)]
  [nature : GUI]. `Origine` puis `SelectionArt`.
- **`ToggleButton3_Click()` / `ToggleButton4_Click()`** [portée : nécessaire (handler)]
  [nature : GUI]. `TriCpt` fournisseur modal ; `Four`/`Four2` ← `Bval` si `Bsel` (jamais remis à
  faux) ; `fourman(…)` ; focus suivant.
- **`fourman(Org)`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Four WHERE
  fo_code = &1` (`Cbase.Table("TabFour")`) ; le message « Ce fournisseur n'existe pas ! » est dans
  le `Catch` : il ne s'affiche que sur **erreur SQL**, jamais pour un code inconnu (contrôle
  inopérant). `B = 1` n'est relu nulle part.
- **`SelectionArt()`** [portée : réductible] [nature : GUI]. `TriArticles` modal, `Art`/`Art2` ←
  `Bval`.
- **`art_man()`** [portée : réductible] [nature : mixte]. Identique à `EdArt1.art_man` (4 requêtes
  `TabArt`, ne contrôle que `Art.Text`).
- **`Cmpt_KeyPress()`** [portée : nécessaire (handler)] [nature : mixte] (CC 16). Tags 1-2 →
  `art_man` (tag 2 contrôle `Art.Text`) ; 3 → `Four2` ; 4 → `Button2` ; F1 aide ; F2 listes. ⚠️ `Jours`
  a le tag `3` comme `Four` : Entrée dans `Jours` envoie le focus sur `Four2`.
- **`Cmpt_GotFocus()`** [portée : nécessaire (handler)] [nature : GUI]. `Utils.SetEditColor`.
- **`Btn_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Tag 2 → impression ; tag 3 →
  suppression du PDF, **écriture et sauvegarde** de `/Soc<XX>/Edrupt/Nstock` et `/Rclient`, fermeture
  (tag 1 inatteignable).
- **`Btn_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. Impression pour toute touche
  sur `Button2`.
- **`Button1_Click()`** [portée : nécessaire (handler)] [nature : GUI]. `Doc.Open("Prodcom")`.
- **`CheckBox3_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Vide.

### Impression

- **`Button2_Click()`** [portée : réductible (`Button2` dans le groupe `btn`)] [nature : mixte]
  (CC 73).
  1. Curseur d'attente, `Shell "cd ~"` (sans effet), `New CArticles`, `Entete("Impression des
     produits en rupture")`, `Level13R` (si `CheckBox2`) ou `Level13`.
  2. `Crupt.Rupture(CheckBox1, CheckBox2, Four, Four2, Art, Art2, "EdRup")` : DDL `DROP`/`CREATE` de
     `Rupture`/`RuptureC` puis remplissage (voir Crupt).
  3. `SELECT * FROM Rupture LEFT JOIN Fiches_Art ON art_code = codea` (filtre `four = &1` si
     `Four = Four2`), ordre `codec, four, codea` ou `four, codea`. Par ligne : rupture de commande
     client (titre « Commande(s) client … ») si `CheckBox2` ; article retenu (`artbl`) s'il est
     stocké avec mini et maxi > 0, ou si `CheckBox1` ; quantité = `qtecom` relevée au minimum de
     commande `art_mincom` ; imprimé (`Level14`) si `qtecom > 0` et stocké, ou non stocké avec
     `CheckBox1`. ⚠️ Puis, si `CheckBox2`, `SELECT RuptureC WHERE codea = &1 AND codec = &2 AND
     intitulea = &3` et `UPdate RuptureC SET qtecom …` avec `codec`, `intitulea`, `numcom` **jamais
     affectés** (vides) : la mise à jour ne touche en pratique aucune ligne (l. 430-432).
  4. Si `CheckBox2` : `SELECT * FROM RuptureC LEFT JOIN Fiches_Art …` ; lignes « Dont commande(s)
     client » et `Level14` pour `qte > 0`.
  5. Si `CheckBox3` : nouvelle page « Ventes en Caisse sur les N derniers jours » (`Level13V`),
     `SELECT *, SUM(cast(qte as decimal(18,2))) AS totqte FROM Fiches_HisLigTickets LEFT JOIN
     Fiches_HisEntTickets … LEFT JOIN Fiches_Art … WHERE Date(date) >= &1 AND Date(date) <= &2 …
     AND suppr = 0 GROUP BY client, art_code | art_code`. ⚠️ La colonne `date` existe dans **les deux**
     tables de tickets (`db_control.csv`, `Laurux01.sql`) : référence ambiguë, erreur SQL probable
     sous MySQL et SQLite (l. 542, à confirmer en replay). `SELECT *` avec `GROUP BY` partiel échoue
     aussi en mode `ONLY_FULL_GROUP_BY`. Nom du client lu dans `Fiches_Cli` (en dur) ; ligne
     `Level14V` (quantité vendue, mini, maxi, stock `art_qte`).
  6. `Footer`, `Output`, `Visualiseur.Prog` si une section a produit des lignes, sinon message.
  Pagination à 275 mm (titre de la page de ventes différent : « sur les derniers N jours »). Si la
  section 1 est vide et `CheckBox3` coché, la première page ne contient que l'en-tête. Pas de
  `Catch` : une erreur SQL laisse le curseur en attente.
  Variables mortes : `Tabl`, `Nbpage`, `dte`, `Decm`, `Fourn2`, `stkact` partiel, `PosX`.

## État global utilisé

- `Start.Musique`, `Start.Son`/`Start.son`, `Start.Societe`, `Start.LocalSettings`
  (`/Soc<XX>/Edrupt/Nstock`, `/Rclient` lus **et écrits** + `Save`, `/Coul/Fnets`).
- `Utils.db.Exec`, `Utils.Observers`, `Utils.FColr`, `Utils.Coulfd`, `Utils.SetEditColor`,
  `Utils.Find_nbdec`, `Utils.cpoint`, `Cbase.Table` (`TabArt`, `TabFour`, `TabHisLigTck`,
  `TabHisEntTck`).
- `Crupt.Rupture` ; tables de travail `Rupture`, `RuptureC` (partagées avec `Changefam`).
- `LDate` (`.D`), `Visualiseur.Prog`, `Doc.Open`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Découper `Button2_Click` (CC 73) en `ImprimeRuptures(pdf)`, `ImprimeCommandesClients(pdf)`,
  `ImprimeVentes(pdf)` et `SautDePage(pdf, titre, niveau)`, en conservant l'ordre exact des
  requêtes et des appels PdfWriter.
- Supprimer les variables mortes, `Frmt`/`Coulfond`, le `Shell`, la branche `Else` vide (l. 437).
- `fourman` : séparer la requête de la tentative de contrôle ; corriger le contrôle est une
  anomalie (A02).

### Commonalisation avec d'autres fichiers

- Constantes `TabRupture`/`TabRuptureC` partagées avec `Crupt` et `Changefam` (CRUPT-004).
- `art_man`, `SelectionArt` : socle `EdSelection`
  ([EdArt1/architecture.md](../EdArt1.class/architecture.md#commonalisation-avec-dautres-fichiers)).
- Lecture du nom de client (`Fiches_Cli`) : même requête dans `Edart4.Butclig_Click`.

### Réduction de portée

- `fourman`, `SelectionArt`, `art_man`, `Button2_Click` : sans appelant externe (seul
  `Fmenu.class:2080`) → `Private`. `CheckBox3_Click` reste (handler).

### Séparation traitement / GUI

- Règle « article à commander » (stocké, mini/maxi, `CheckBox1`, minimum de commande) →
  `QuantiteACommander(rarts, bNonStockes) As Float` pure, testable en gb.test, à rapprocher de
  `Crupt.QuantiteACommander` (CRUPT-007).
- Requêtes de lecture (`Rupture`, `RuptureC`, ventes) dans des fonctions sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Remplacer `Rupture`/`RuptureC` par des tables temporaires de session (`CREATE TEMPORARY TABLE`)
  ou une colonne de poste : supprime la collision multi-poste (CRUPT-A05) et la DDL à chaque
  impression.
- Index `Fiches_HisLigTickets(date, code)` existe (`idx_date`) ; qualifier la colonne
  (`Fiches_HisLigTickets.date`) permettrait de l'utiliser.
