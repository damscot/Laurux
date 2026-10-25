# MvtProdcomp — Architecture

> Source : `.src/Gestion/Stock/MvtProdcomp.class` · Formulaire : `.src/Gestion/Stock/MvtProdcomp.form`

## Vue d'ensemble

`MvtProdcomp` est l'écran **« Entrées des produits composés »** (menu Gestion › Stock,
`Fmenu.Menu230_Click`, après contrôle du tunnel de réplication) : fabrication (entrée) ou
démontage (sortie) d'un produit composé, avec mouvement inverse sur ses composants.

Contrairement à [Mvtex](../Mvtex.class/architecture.md) (dont il reprend l'en-tête et une partie
du code), **chaque appui sur « Enregistrer » écrit immédiatement en base** ; la grille `Colrcp`
n'est qu'un journal de la session (aucune étape « Valider »). Pour un produit `P` et une quantité
`q` :

1. `Fiches_Art.art_qte` de `P` est remplacé par la valeur affichée `Artstock` (stock lu + ou − `q`,
   calculé côté client) ;
2. une ligne `Fiches_Mvtexpdc` de type `P` (`qtep` = `q` en entrée, `qtem` = `q` en sortie,
   `mind = Num`) ;
3. pour chaque composant `C` de `Fiches_PrdComp` (`codep = P`) : `art_qte` de `C` diminué
   (entrée) ou augmenté (sortie) de `q × qte_composant`, et une ligne `Fiches_Mvtexpdc` de type
   `C` avec le même `mind`.

`Num` (identifiant de lot) est lu une fois à l'ouverture (`MAX(mind)`) puis incrémenté localement.

Place dans le calcul du stock (voir le tableau des sources de
[Stockmvt](../../Stockmvt.class/architecture.md)) : `Fiches_Mvtexpdc` est relue par
[Cstock](../../../Utils/Cstock.module/architecture.md) (`qtep - qtem` depuis l'inventaire) et
`Stockmvt` (« Mouvements exceptionnels … produits composés »). Les nomenclatures sont gérées par
[Prodcomposes](../../Tables/Prodcomposes.class/architecture.md) (`Fiches_PrdComp`) ; la
facturation décompose aussi les produits composés
([Facture](../../Facturation/Facture.class/architecture.md), lecture de `TabPrdComp`). Aucun
PMP n'est recalculé ici (contrairement à `Prodcomposes.Calc_Pmp`).

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
| `son` | var | Private |  | Integer | 32 |
| `Num` | var | Private |  | Integer | 33 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-58 | Public | 3 | 20 | 0 | méthode spéciale |
| `CleanChamps` | 63-70 | Public | 1 | 6 | 0 | portée réductible ? |
| `RazBl` | 75-81 | Public | 1 | 5 | 0 | portée réductible ? |
| `Rcpt_KeyPress` | 86-142 | Public | 14 | 46 | 0 | handler GUI |
| `Rcpt_GotFocus` | 147-153 | Public | 1 | 5 | 0 | handler GUI |
| `Btn_KeyPress` | 158-177 | Public | 5 | 15 | 0 | handler GUI |
| `Btn_Click` | 179-199 | Public | 4 | 16 | 0 | handler GUI |
| `art_man` | 204-243 | Public | 5 | 37 | 0 | portée réductible ? |
| `SelectionArt` | 248-304 | Public | 6 | 54 | 0 | portée réductible ? |
| `Colart_Click` | 309-318 | Public | 1 | 8 | 0 | handler GUI |
| `Colart_KeyPress` | 323-346 | Public | 6 | 20 | 0 | handler GUI |
| `Quantite` | 351-373 | Public | 4 | 19 | 0 | portée réductible ? |
| `qterecue_LF` | 378-391 | Public | 3 | 12 | 0 | portée réductible ? |
| `Maj_qte` | 396-409 | Public | 4 | 11 | 0 | portée réductible ? |
| `Maj_qtem` | 414-428 | Public | 4 | 11 | 0 | portée réductible ? |
| `ToggleButton2_Click` | 430-434 | Public | 1 | 3 | 0 | handler GUI |
| `Maj_colrcp` | 439-494 | Public | 10 | 52 | 0 | portée réductible ? |
| `Maj_Composants` | 499-529 | Public | 3 | 26 | 0 | portée réductible ? |
| `Maj_qtec` | 534-550 | Public | 4 | 13 | 0 | portée réductible ? |
| `Maj_qtemc` | 555-571 | Public | 4 | 13 | 0 | portée réductible ? |
| `Sortie_Click` | 573-577 | Public | 2 | 3 | 0 | handler GUI |
| `Entree_Click` | 579-583 | Public | 2 | 3 | 0 | handler GUI |
| `Button4_Click` | 588-592 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et remise à blanc

- **`_New()`** [portée : nécessaire] [GUI + SQL]. Observateurs, musique, colonnes de `Colrcp`
  (Code, Désignation, Qté entrée), `datej` = aujourd'hui (`TextBox`, sans contrôle de format),
  `Num = MAX(mind)` de `Cbase.Table("TabMvtexpdc")` (0 si table vide, via `Try`).
- **`CleanChamps()`** [portée : réductible] [GUI]. Vide `Cart`, `Dart`, `Artstock`, `qterecue`.
- **`RazBl()`** [**code mort** : jamais appelée] [GUI]. `CleanChamps`, `Comment.clear`,
  `Colrcp.Clear`. ⚠️ `MvtProdcomp.form` n'a **aucun** contrôle `Comment` : `Comment` désigne la
  classe formulaire `Comment` (`.src/Gestion/Tables/Comment.class`, son auto-instance), qui n'a
  pas de méthode `Clear` (ni elle, ni `Form`) : l'appel lèverait une erreur s'il était exécuté.
  Confirmé : `RazBl` n'a aucun appelant (`deps.py` `unused`, grep), le défaut est donc latent ;
  il disparaît avec la suppression du code mort (MVTPRODCOMP-002). Copie de `Mvtex.RazBl`, où
  `Comment` est bien un contrôle.

### Événements de saisie (groupe `Rcpt` : `Datej` 1, `Cart` 2, `Dart` 3, `Qterecue` 4)

- **`Rcpt_KeyPress()`** (CC 14) [handler] [mixte]. Entrée/Retour/Tab : tag 2 → contrôle de
  `Cart` vide, `*code-barre` (`Utils.Find_cbarre`) puis `art_man` ; tag 3 → focus quantité ;
  tag 4 → `qterecue_LF` puis focus `Button1` ; tag 5 (aucun contrôle) → focus bouton. Tag 1
  (date) non traité : aucune validation de la date. F1 → aide ; F2 sur `Cart` → `SelectionArt`.
- **`Rcpt_GotFocus()`** [handler] [GUI]. `Utils.SetEditColor(Me, Last)`.
- **`Btn_KeyPress()`** / **`Btn_Click()`** [handlers du groupe `Btn` : `Button1` 1, `Button3`
  3] [mixte]. Tag 1 : `qterecue_LF`, `Maj_colrcp` (écriture en base), `CleanChamps`. Tag 3 :
  `Me.Close`.
- **`ToggleButton2_Click()`** [handler] : `SelectionArt`.
- **`Colart_Click()`** [handler, **doit rester `Public`** : appelé par `ReplayObserver` via
  `Object.Call` (`replay_dynamic`)] [GUI]. Reprend le code sélectionné, masque la liste,
  `art_man`.
- **`Colart_KeyPress()`** [handler] [GUI]. Entrée : idem `Colart_Click` ; F1 : aide ;
  Échap/F2 : masque la liste.
- **`Sortie_Click()` / `Entree_Click()`** [handlers] [GUI]. Vident la grille (affichage
  seulement : les écritures déjà faites restent en base).
- **`Button4_Click()`** [handler] : `Doc.Open("ProduitsComposes")`.

### Article

- **`art_man()`** [portée : réductible] [mixte]. Lecture de `Fiches_Art` (en dur) ; article
  stocké : désignation, stock, quantité 1 formatée (`Utils.Cdec(art_dec)`) ; sinon message.
  `Tab2 = "Fiches_Tvaav"` inutilisé. Aucun contrôle que l'article est un produit composé (un
  article simple saisi au clavier est accepté ; `Maj_Composants` échoue alors, voir A03).
- **`SelectionArt()`** [portée : réductible] [mixte]. Bascule l'affichage de `ColArt` : liste
  des articles `art_prdcomp = 1` (`ORDER BY CAST(art_code AS char)`), colonnes code, intitulé,
  famille, PV HT, taxe (`/Soc<XX>/Taxe`), PV TTC.
- **`Quantite()`** [**code mort**] : copie de `Mvtex.Quantite`, jamais appelée.
- **`qterecue_LF()`** [portée : réductible] [GUI]. Normalise la quantité (`Utils.cpoint`,
  `Utils.Cdec`) ; quantité nulle → 1 ; ⚠️ fixe ensuite `Decm = "2"` (effet de bord sur les
  formatages suivants).

### Écritures en base

- **`Maj_colrcp()`** (CC 10) [portée : réductible] [mixte]. `Colrcp.Add(code, code)` lève une
  erreur si le code est déjà dans la grille → bloc `Catch` (voir plus bas). Sinon : ligne de
  grille, `Maj_qte`/`Maj_qtem` (stock affiché ± quantité), `UPdate … SET art_qte = Artstock`
  (valeur texte calculée côté client), `Num += 1`, `INSERT` de la ligne `P`, `Maj_Composants`.
  **`Catch`** : interprète **toute** erreur comme un doublon (« 1 cumuler / 2 remplacer ») :
  - cumul : quantité cumulée dans la grille, `Maj_qte` (toujours **en plus**, même en sortie),
    `UPdate art_qte` du produit, **sans** ligne `Fiches_Mvtexpdc` ni mise à jour des composants
    (A01) ;
  - remplacement : `Artstock -= ancienne quantité`, puis `Maj_qte` **réécrit** `Artstock` à
    partir de la base (+ nouvelle quantité) : le retrait est perdu, le stock compte les deux
    quantités ; ni mouvement ni composants (A02).
  Aucune transaction.
- **`Maj_qte()` / `Maj_qtem()`** [portée : réductible] [mixte]. Relit `art_qte` du produit et
  affiche `Artstock = stock ± qterecue` (aucune écriture). Code dupliqué au signe près.
- **`Maj_Composants()`** [portée : réductible] [calcul]. Pour chaque composant de
  `Cbase.Table("TabPrdComp")` (`codep = Cart`) : relit la même ligne (`codec`, `codep`,
  requête redondante), `Qtet = q × qte`, `Maj_qtemc` (entrée) ou `Maj_qtec` (sortie), puis
  `INSERT` d'une ligne `C` (`qtem` ou `qtep` = `Qtet`). `Repeat` sans test `Available` : un
  produit sans composant lève une erreur, rattrapée par le `Catch` de `Maj_colrcp` (A03).
- **`Maj_qtec(Codec, Qtet)` / `Maj_qtemc(Codec, Qtet)`** [portée : réductible] [calcul].
  `art_qte = stock lu ± Qtet` (paramètre `String` réutilisé comme `Float`) ; puis, si le
  composant a déjà des mouvements, `UPdate Fiches_Mvtexpdc SET qtep|qtem = <nouveau stock>
  WHERE code = Codec AND mind = Num`. Appelée **avant** l'`INSERT` de la ligne `(Num, Codec)`,
  cette mise à jour ne touche normalement aucune ligne ; elle écrirait le stock total dans un
  mouvement si une ligne `(Num, Codec)` existait déjà (lot concurrent, A04).

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.LocalSettings["/Soc<XX>/Taxe"]`, `Start.Societe`.
- `Utils.db`, `Utils.cpoint`, `Utils.Cdec`, `Utils.Cdate_Dbase`, `Utils.Find_cbarre`,
  `Utils.SetEditColor`, `Utils.Observers`, `Cbase.Table` (`TabArt`, `TabMvtexpdc`, `TabPrdComp`).
- Membres non typés du style ancien : `B` (écrit, jamais lu), `Tab2` (inutilisé), `Tab`, `Decm`,
  `Stocke`, `son`, `Num` (identifiant de lot local).
- Auto-instance du formulaire `Comment` (référence latente dans `RazBl`, code mort).

## Propositions d'amélioration

### Réécriture / refactorisation

- Fusionner `Maj_qte`/`Maj_qtem` en `StockAffiche(signe)` et `Maj_qtec`/`Maj_qtemc` en
  `MajComposant(codec, qtet, signe)` (SQL identiques).
- `Maj_Composants` : utiliser `Cmpts!qte` au lieu de relire la ligne (`rPrdc`) : SQL modifié
  (un `SELECT` de moins par composant), dump identique.
- Remplacer le `Catch` « doublon » par un test `Colrcp.Exist(code)` : change le comportement en
  cas d'erreur réelle (A03), donc lié à l'anomalie.

### Commonalisation avec d'autres fichiers

- Saisie d'article stocké (`art_man`, `CleanChamps`, `Quantite`, `*code-barre`) : voir MVTEX-008
  ([Mvtex](../Mvtex.class/architecture.md), [MvtDepots](../../Depots/MvtDepots.class/architecture.md),
  [Sdepots](../../Depots/Sdepots.class/architecture.md)).
- Liste des produits composés (`SelectionArt` sur `art_prdcomp = 1`) : à rapprocher de la
  sélection de [Prodcomposes](../../Tables/Prodcomposes.class/architecture.md) (`SelectionArt`)
  et de `TriArticles`.
- Décomposition produit → composants (`Fiches_PrdComp`, `q × qte`) : même calcul dans
  `Facture` (facturation d'un produit composé) ; un helper `PrdComp.Composants(codep, q)`
  partagé est envisageable (phase 3, en conservant les arrondis de chaque appelant).

### Réduction de portée

- `CleanChamps`, `art_man`, `SelectionArt`, `qterecue_LF`, `Maj_qte`, `Maj_qtem`, `Maj_colrcp`,
  `Maj_Composants`, `Maj_qtec`, `Maj_qtemc` → `Private` (aucun appelant externe, grep).
  `RazBl` et `Quantite` sont supprimées (code mort). `Colart_Click` et tous les handlers restent
  `Public`.

### Séparation traitement / GUI

- Extraire de `Maj_colrcp` une fonction `EnregistreLot(code, q, entree, dte, num, stockAffiche)`
  sans accès aux contrôles, reproduisant exactement les écritures actuelles (y compris
  `art_qte = valeur calculée`) ; le handler garde la grille et le `Catch`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `mind` (identifiant de lot) sans séquence : une table de compteurs ou un auto-incrément de lot
  supprimerait le `MAX(mind)` lu à l'ouverture.
- `qtep`/`qtem` en `char(10)` (texte formaté) et `Fiches_PrdComp.qte` en `varchar(50)` :
  `DECIMAL` souhaitable.
- Index `(code, mind)` sur `Fiches_Mvtexpdc` pour les `SELECT`/`UPDATE` par composant.
