# TriHistos — Architecture

> Source : `.src/Affichages/TriHistos.class`

## Vue d'ensemble

`TriHistos` affiche l'**historique des ventes ou des achats d'un article** sur une période de 1 à 5
ans (`ComboBox1`), ouvert depuis la fiche article (`Articles.Btn_click`, boutons de tag 4 « ventes »
et 5 « achats ») avec `New TriHistos(code, Cfour.text, Dec.text, Tri, "V"|"A")`.

- **Ventes (`Type = "V"`)** : `Histo_ventes` **recrée la table de travail `Fiches_Stat`**
  (`DROP TABLE IF EXISTS` + `CREATE TABLE`, `Cbase.Table("TabStat")`) et l'alimente ligne par ligne
  avec : les lignes article des documents en cours (`Fiches_Ligbl` + `Fiches_Bl` de type B ou F), les
  lignes de factures archivées (`Fiches_HistoLigfac` + `Fiches_HistoFac`) et les sorties
  exceptionnelles (`Fiches_Mvtexp.qtem`). `Aff_StatVE` relit `Fiches_Stat` triée et remplit la
  `ColumnView` `Colhisto` et le total des quantités.
- **Achats (`Type = "A"`)** : `Aff_StatAC` lit directement `Fiches_Ligrecpt` (réceptions) et les
  entrées exceptionnelles (`Fiches_Mvtexp.qtep`).
- Les en-têtes `TextBox` (`DA`, `COD`, `NM`, `NFAC`) changent la colonne de tri à la prise de focus
  et inversent l'ordre au double-clic.
- Un clic (ou Entrée) sur une ligne ouvre le **détail du document** dans un panneau intégré :
  `DocVentes` (facture archivée, sinon BL) dans `Panel4`/`Colrcp3`, `DocAchat` (réception) dans
  `Panel3`/`Colrcp2`.

Aucun retour vers l'appelant (consultation seule). L'écran **n'appelle pas `Utils.Observers(Me)`**
(il utilise seulement `ObsGotf`/`ObsLstf` pour la couleur de focus).

Nature globale : **mixte** (DDL et écritures sur une table de travail, requêtes N+1, affichage).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tri` | var | Private |  | String | 3 |
| `Dbl` | var | Private |  | String | 4 |
| `Decm` | var | Private |  | String | 5 |
| `Type` | var | Private |  | String | 6 |
| `Code` | var | Private |  | String | 7 |
| `Cfour` | var | Private |  | String | 8 |
| `Dtejour` | var | Private |  | String | 9 |
| `Periode` | var | Private |  | Integer | 10 |
<!-- /AUTO:declarations -->

| Variable | Usage |
|---|---|
| `Tri` | colonne de tri (`date`, `code`, `nom`, `nfac` en ventes ; `daterecpt`, `four`, `numrecpt` en achats) |
| `Dbl` | `"1"` = ordre décroissant |
| `Decm` | nombre de décimales de l'article (`"0"`, `"2"`, `"3"`) pour `Utils.CDec` |
| `Type` | `"V"` ou `"A"` |
| `Code` | code article |
| `Cfour` | **jamais renseignée** : `_new` écrit `Four = Four` (paramètre affecté à lui-même) au lieu de `Cfour = Four` (TRIHISTOS-A01) |
| `Dtejour` | date de début de période (format `aaaammjj` en ventes, `aaaa-mm-jj` en achats) |
| `Periode` | nombre d'années (premier caractère de `ComboBox1.Text`) |

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 12-28 | Public | 2 | 15 | 0 | méthode spéciale |
| `Histo_ventes` | 30-137 | Public | 18 | 95 | 0 | portée réductible ? |
| `Aff_StatVE` | 139-189 | Public | 19 | 47 | 0 | portée réductible ? |
| `Histo_Achat` | 194-227 | Public | 2 | 32 | 0 | portée réductible ? |
| `Aff_StatAC` | 229-299 | Public | 22 | 68 | 0 | portée réductible ? |
| `aff_Histo` | 301-316 | Public | 3 | 14 | 0 | portée réductible ? |
| `COD_GotFocus` | 318-331 | Public | 3 | 12 | 0 | handler GUI |
| `COD_DblClick` | 333-349 | Public | 3 | 15 | 0 | handler GUI |
| `COD_LostFocus` | 351-355 | Public | 2 | 3 | 0 | handler GUI |
| `DA_GotFocus` | 357-370 | Public | 2 | 12 | 0 | handler GUI |
| `DA_Dblclick` | 372-389 | Public | 3 | 16 | 0 | handler GUI |
| `DA_LostFocus` | 391-395 | Public | 2 | 3 | 0 | handler GUI |
| `NM_GotFocus` | 397-411 | Public | 3 | 13 | 0 | handler GUI |
| `NM_DblClick` | 413-430 | Public | 3 | 16 | 0 | handler GUI |
| `NM_LostFocus` | 432-436 | Public | 2 | 3 | 0 | handler GUI |
| `NFAC_GotFocus` | 438-452 | Public | 3 | 13 | 0 | handler GUI |
| `Nfac_DblClick` | 454-471 | Public | 3 | 16 | 0 | handler GUI |
| `NFAC_LostFocus` | 473-477 | Public | 2 | 3 | 0 | handler GUI |
| `Colhisto_click` | 482-490 | Public | 2 | 7 | 0 | handler GUI |
| `DocVentes` | 492-597 | Public | 29 | 101 | 0 | portée réductible ? |
| `Colhisto_KeyPress` | 602-612 | Public | 5 | 9 | 0 | handler GUI |
| `DocAchat` | 617-677 | Public | 9 | 58 | 0 | portée réductible ? |
| `Button1_Click` | 679-684 | Public | 1 | 4 | 0 | handler GUI |
| `Button2_Click` | 686-691 | Public | 1 | 4 | 0 | handler GUI |
| `Button3_Click` | 693-698 | Public | 1 | 4 | 0 | handler GUI |
| `ComboBox1_Change` | 700-711 | Public | 2 | 10 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction

- **`_new(Codea, Four, decimale, Triart, Thisto)`** [portée : nécessaire (constructeur)]
  [nature : mixte] : centre, mémorise les paramètres (sauf `Four`, voir A01), fixe `ComboBox1.Text =
  "1 an"` (ce qui lève peut-être `ComboBox1_Change` et donc un premier calcul : à confirmer), puis
  `Histo_ventes` ou `Histo_Achat`. `Triart` est mémorisé puis écrasé par `Histo_ventes`/`Histo_Achat`.

### Ventes

- **`Histo_ventes()`** [portée : réductible] [nature : mixte, partie extractible = construction de
  `Fiches_Stat`] :
  - `Dtejour` = premier jour du mois courant moins `Periode` ans, au format compact `aaaamm01` ;
  - `DROP TABLE IF EXISTS Fiches_Stat` puis `CREATE TABLE Fiches_Stat (code, date, nom, pvb, rem,
    pvn, qte, nfac, nlig, lind auto-incrément)` avec `Utils.db.AutoIncrement`/`Engine` (MySQL et
    SQLite) ;
  - pour chaque ligne `Fiches_Ligbl` de l'article (`typel_ligbl = "A"`) : lecture du BL
    (`numbl = &1 and (datebl >= &2 or dtefac >= &2)`), et si type B ou F, `INSERT` dans
    `Fiches_Stat` (numéro de facture si `imp = "1"`, sinon numéro de BL) — **une requête par ligne** ;
  - pour chaque ligne `Fiches_HistoLigfac` de l'article : lecture de la facture (`datefac >= &2`) et
    `INSERT` (dans un `Try`) — une requête par ligne ;
  - sorties exceptionnelles `Fiches_Mvtexp` (`qtem` non nul, `daterecpt >= &2`) : `INSERT` partiel
    (date, libellé, quantité) ;
  - variables mortes : `Dtejour2`, `Dtejour3`, `dte3` (calculée, jamais lue), `LigcaiR`, `CaiR`,
    `Histofac` réutilisée ; bloc caisse commenté (lignes 113-121) ;
  - puis `Aff_StatVE`. Rien n'est fait si le code article est vide.
- **`Aff_StatVE()`** [réductible] [nature : mixte] : `SELECT * FROM Fiches_Stat ORDER BY <Tri>
  [desc]` (tri concaténé, valeur interne), une ligne `Colhisto` par enregistrement (clé `nfac & nlig
  & lind`), formats `0.00`/`0.000`, quantité par `Utils.CDec(Decm, qte)`, cumul de `Qte_totale`
  formaté selon `Decm` (variables `Nbd1`/`Nbd2`/`Nbd3`).

### Achats

- **`Histo_Achat()`** [réductible] [nature : GUI] : en-têtes et largeurs de la `ColumnView`, puis
  `Aff_StatAC` si le code est renseigné.
- **`Aff_StatAC()`** [réductible] [nature : mixte] : `Dtejour` = aujourd'hui moins `Periode` ans
  (format `aaaa-mm-jj`, au jour près, contrairement aux ventes) ; `SELECT * FROM Fiches_Ligrecpt WHERE
  code = &1 … OR code = &2 …` (`&2` = `Cfour`, toujours vide) ; pour chaque ligne, lecture du
  fournisseur (`fo_code = &1`) **sans test `Available`** (TRIHISTOS-A02) ; puis entrées
  exceptionnelles `Fiches_Mvtexp.qtep`. Les tests de longueur des lignes 255 et 258 portent sur une
  cellule encore vide : sans effet.

### En-têtes [portée : nécessaire (handlers)] [nature : GUI]

- **`aff_Histo()`** [réductible] : restaure les libellés des en-têtes.
- **`COD_GotFocus`, `DA_GotFocus`, `NM_GotFocus`, `NFAC_GotFocus`** : ordre croissant, colonne de tri
  selon `Type`, réaffichage (`Aff_StatVE` ou `Aff_StatAC`), couleur de focus.
- **`COD_DblClick`, `DA_Dblclick`, `NM_DblClick`, `Nfac_DblClick`** : inversent `Dbl` et réaffichent.
- **`COD_LostFocus`, `DA_LostFocus`, `NM_LostFocus`, `NFAC_LostFocus`** : couleur.

### Détail d'un document

- **`Colhisto_click()`** [handler ; rejoué par `Object.Call`, doit rester `Public`] : `DocVentes` ou
  `DocAchat`. **`Colhisto_KeyPress()`** : Entrée = clic, Échap/F2 = fermeture.
- **`DocVentes()`** [réductible] [nature : mixte] : client (`Fiches_Cli`), puis lignes de la facture
  archivée (`Fiches_HistoLigfac`, `num_ligfac = &1`) ; si aucune ligne, lignes du BL par
  `SELECT * FROM Fiches_Bl,Fiches_Ligbl WHERE num_ligbl=numbl and (num_ligbl = &1 or numfac=&1)`
  (**noms de tables en dur**, sans `Cbase.Table`). Commentaires multi-lignes éclatés (`Split(…, "\n")`).
  Total HT par `Val()` des montants stockés en texte (format localisé, saisi depuis les `TextBox` de
  `Facture`). Dans la branche facture, la quantité formatée (`Utils.CDec`) est écrite dans la colonne
  2 puis écrasée par la désignation : la quantité reste brute et le code n'est affiché que si l'article
  existe (TRIHISTOS-A05) ; la branche BL est correcte.
- **`DocAchat()`** [réductible] [nature : mixte] : fournisseur (sans test `Available`), lignes de
  réception (`numrecpt = &1 and four = &2`), quantité par `Utils.CDec`, total `paht × qte`.
- **`Button1_Click`** (fermer), **`Button2_Click`**/**`Button3_Click`** (masquer les panneaux de
  détail) [handlers].
- **`ComboBox1_Change()`** [handler] : nouvelle période puis recalcul ; les lignes qui recalculent
  `Dtejour` (sans le `"01"`) sont écrasées aussitôt par `Histo_ventes`/`Aff_StatAC` : code mort.

## État global utilisé

- `Utils.db` (`Exec`, `AutoIncrement`, `Engine`), `Utils.cpoint`, `Utils.CDec`, `Utils.Cdate_Aff`,
  `Utils.ObsGotf`, `Utils.ObsLstf` ; `Cbase.Table` ; `Start.Caisse` (libellé « N° Fac/Bl/Tck »).
- **Table de travail globale `Fiches_Stat`** : détruite et recréée à chaque ouverture en ventes,
  partagée par tous les postes (TRIHISTOS-A04).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les variables et le bloc commenté morts, les tests de longueur sans effet et le calcul
  inutile de `ComboBox1_Change`.
- Les 8 handlers `*_GotFocus`/`*_DblClick` → aide `TriColonne(sTriVentes, sTriAchats, hEntete,
  bInverse)` (handlers conservés).
- `Histo_ventes` : remplacer les requêtes N+1 par deux jointures (`Ligbl ⋈ Bl`, `HistoLigfac ⋈
  HistoFac`) **en conservant l'ordre d'insertion** (la colonne `lind` dépend de l'ordre de parcours ;
  « SQL modifié, dump identique » à vérifier sur `Fiches_Stat`).

### Commonalisation avec d'autres fichiers

- `DocVentes` (branche BL) duplique [`AFacture.DocVentes`](../AFacture.class/architecture.md)
  (58 lignes communes) et [`ACom.DocCom`](../ACom.class/architecture.md) (39) : même mise en page de
  `Colrcp3` (7 colonnes, mêmes titres) et même boucle de lignes. Aide commune proposée :
  `DetailDocument.Colonnes(hVue)` + `DetailDocument.LignesVente(hVue, rLignes, sSuffixe) As Float`
  (module à créer en phase 3) ; chaque écran garde ses contrôles.
- `Fiches_Stat` comme table de travail : même schéma que la table partagée `Ctrln` du lot Compta
  (collision multi-poste) ; une stratégie commune (table temporaire `CREATE TEMPORARY TABLE` ou nom
  suffixé par le poste) serait à décider globalement.

### Réduction de portée

- `Histo_ventes`, `Aff_StatVE`, `Histo_Achat`, `Aff_StatAC`, `aff_Histo`, `DocVentes`, `DocAchat` →
  `Private` (vérifié : aucun appel externe ; `Articles` n'utilise que le constructeur).

### Séparation traitement / GUI

- `ConstruireStatVentes(sCode, sDebut)` : DDL et alimentation de `Fiches_Stat` sans accès aux
  contrôles (testable en gb.test sur base) ; `Histo_ventes` garde la mise en page.
- `LignesReception(sCode, sFour, sDebut, sFin, bDesc) As Result` pour `Aff_StatAC`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les montants et quantités des lignes de documents (`pu_ligbl`, `qte_ligfac`, `netht_ligfac`…) sont
  des `varchar` au format localisé : des colonnes `DECIMAL` supprimeraient les `Val(Utils.cpoint())`.
- `Fiches_Stat` devrait être une table temporaire de session (pas de `DROP`/`CREATE` d'une table
  permanente).
- Index sur `Fiches_Ligbl.code_ligbl` et `Fiches_HistoLigfac.code_ligfac` pour l'historique par
  article (à vérifier dans `db_control.csv`).
