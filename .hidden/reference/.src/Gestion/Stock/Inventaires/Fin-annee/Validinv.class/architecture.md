# Validinv — Architecture

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class`

## Vue d'ensemble

Écran de **validation de l'inventaire de fin d'exercice** (menu 84,
[`Fmenu.class:1064`](../../../../../Communs/Fmenu.class/architecture.md), `Validinv.Show`). C'est
le seul écran de la chaîne fin d'exercice qui **modifie le stock** :

1. sauvegarde `mysqldump` dans `~/Sauve/LauruxInv.sqlAAAAMMJJ` (avant toute question) ;
2. pour chaque ligne de `Fiches_Inv` :
   - ligne comptée (`inv_comptee` vrai) → `art_qte = art_stkdep = inv_qtecomptee` ;
   - ligne non comptée et option « Mettre le stock à zéro » (`RadioButton1`, défaut) →
     `art_qte = art_stkdep = 0` ;
   - ligne non comptée et « Laisser la valeur d'origine » → `art_qte = art_stkdep = art_qte`
     **courant** (pas `inv_qtestock`) ;
3. `Fiches_Parametres.dteinv` = date saisie (`dtinv`, date du jour par défaut) : c'est la date de
   départ des recalculs de stock (`Cstock.date_ex`, `Stockmvt.Checksdp`) ;
4. `Cstock.Calc_stock("", "")` — **sans effet** (CSTOCK-A01 : lit les radios de l'instance
   automatique de `Calcstock`, requête `art_code = ''`) ;
5. `TRUNCATE` de `Fiches_HisInvT` (historique des inventaires tournants, repart de zéro).

`Fiches_Inv` n'est **ni supprimée ni marquée validée** (le `DROP` est commenté) alors que le texte
du `.form` l'annonce. Le bouton « Compta matière » (`button4_Click`, visible avec l'option boissons
`B`/`T`) produit le stock de départ de la comptabilité matière (`Fiches_ligregie`, type `I`).

Variante tournante : [ValidinvT](../../Tournant/ValidinvT.class/architecture.md) (41 % de lignes
communes), dont la logique est **différente** : elle ne touche pas `art_stkdep` ni `dteinv`, mais
écrit l'écart dans `Fiches_Mvtexp` et historise dans `Fiches_HisInvT`.

### Cohérence avec les sources de mouvements de stock

Cohérent avec [Stockmvt](../../../../Stockmvt.class/architecture.md) (tableau des sources,
STOCKMVT-A05) : `Validinv` écrit le **stock de départ** `art_stkdep` et sa date `dteinv` ; les
recalculs ultérieurs (`Cstock.Calc_stock`, `Stockmvt`) repartent de ce couple et rajoutent les
mouvements postérieurs, dont les sorties du dépôt `01` de `Fiches_Sdepots` et `Fiches_Mvtexp`.
Ils ignorent désormais l'historique tournant (vidé).

**Stock par dépôt** : `Validinv` ne touche ni `Fiches_StkDepots` (stock par dépôt) ni
`Fiches_Sdepots` (journal des mouvements de dépôts). Après validation, `art_qte` global ne
correspond plus forcément à la somme des stocks par dépôt (VALIDINV-A07, règle métier à confirmer).

Les quantités sont comptées à la date de génération (`inv_date`) mais `dteinv` prend la date
saisie à la validation : les mouvements intervenus entre les deux ne sont pas corrigés (le code de
correction, l. 86-158, est commenté) → VALIDINV-A08, à confirmer.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | String | 27 |
| `$soption` | var | Private |  | String | 28 |
<!-- /AUTO:declarations -->

- `son As String` : **jamais initialisé** → les `If son Then Music.Play` ne jouent jamais (les
  autres écrans utilisent `son As Integer = Start.Son`).
- `$soption` : option boissons (`Utils.Option()`), lue seulement dans `_New` (pourrait être locale).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 30-42 | Public | 3 | 11 | 0 | méthode spéciale |
| `Button2_click` | 44-218 | Public | 20 | 92 | 0 | handler GUI |
| `button4_Click` | 221-271 | Public | 7 | 47 | 0 | handler GUI |
| `Button3_Click` | 273-278 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 280-284 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Utils.Observers(Me)`,
  `Music.Load`, bouton « Compta matière » visible si option `B` ou `T`, date du jour dans `dtinv`.
- **`Button2_click()`** [portée : nécessaire (handler, « Lancer le traitement »)] [nature : mixte]
  (CC 20, 175 lignes dont 72 commentées).
  - `Shell "mysqldump -h <Host> -u <Login> -p<Password> <Name> --add-drop-table > ~/Sauve/…" Wait` :
    mot de passe en clair dans la ligne de commande, non échappé, sans port, sans contrôle du
    résultat, lancé même si l'utilisateur répond « Non » ensuite, inutile en SQLite.
  - `Try SELECT * FROM TabInv` ; aucune ligne / table absente → message, `Me.Close`.
  - Confirmation, puis `SELECT dteinv FROM TabParam` → `finexo` (**inutilisé** hors code commenté).
  - Boucle : `qteC`, `qteSt` (Null → 0) ; `qtevtes`/`qteach` toujours 0 → les l. 159-168 se
    réduisent à `qtest = qtec`. `SELECT * FROM TabArt WHERE art_code` à chaque ligne (lu seulement
    dans le 3e cas, sans `Available`). Trois `UPdate TabArt SET art_qte, art_stkdep` (le premier
    passe `qtest` en `&1` sans l'utiliser).
  - `Update TabParam SET dteinv = dtinv.dte.G` ; `Cstock.Calc_stock("", "")` ;
    `Tables.Exist("Fiches_HisInvT")` → `Truncate table Fiches_HisInvT` (non traduit pour SQLite :
    erreur non gérée en fin de traitement).
  - Pas de transaction : une erreur en cours de boucle laisse une validation partielle.
  Partie extractible : tout le traitement (paramètres : option non saisis, date).
- **`button4_Click()`** [portée : nécessaire (handler, « Compta matière »)] [nature : mixte]. Lit
  `arrete` dans `Fiches_Parametres` ; si `Fiches_ligregie` a déjà une ligne `type = 'I'` à
  `arrete + 13 mois` → « déjà une clôture » ; sinon date = `dtepec + 1 mois` (dates de contrôle et
  de création différentes, à confirmer). Question, `Begin`, puis pour chaque régie (`Fiches_regie`) :
  somme des volumes `Calculdroit(art_dra, art_volm, art_deg, inv_qtecomptee)` des lignes
  `Fiches_Inv JOIN Fiches_Art` de la régie, et insertion `Fiches_ligregie` (`Create9`) ;
  `Commit`. Pas de `Rollback` ni de message de fin ; noms de tables en dur.
- **`Button3_Click()`** [handler] [GUI]. Quitter.
- **`Button1_Click()`** [handler] [GUI]. Aide `Doc.Open("Vinv")`.

## État global utilisé

- `Start.LocalSettings["/dbase/Host"]`, `Start.Musique` ; `Utils.db` (`Login`, `Password`, `Name`,
  `Exec`, `Tables`, `Begin`, `Commit`, `Create9`), `Utils.Option`, `Utils.Observers` ;
  `Cstock.Calc_stock` (et, par lui, l'instance automatique de `Calcstock`) ; `Calculdroit`, `LDate`.
- Tables : `Fiches_Inv` (lecture), `Fiches_Art` (écriture `art_qte`, `art_stkdep`),
  `Fiches_Parametres` (`dteinv`, `arrete`, `dtepec`), `Fiches_HisInvT` (vidée), `Fiches_regie`,
  `Fiches_ligregie` (insertion).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les 72 lignes commentées et les variables mortes ; réduire la boucle à la décision
  `QteFinale(bComptee, fQteC, bZero, fQteActuelle)` et un seul `UPDATE` paramétré ; ne lire
  `Fiches_Art` que dans le cas « laisser » (SQL modifié, dump identique).

### Commonalisation avec d'autres fichiers

- Sauvegarde : helper `Utils.DumpBase` prévu par
  [SauvesAuto](../../../../../Communs/SauvesAuto.module/architecture.md) (SAUVESAUTO-003, UTILS-014),
  partagé avec [ValidinvT](../../Tournant/ValidinvT.class/architecture.md) et les autres copies du projet.
- Avec ValidinvT : lecture des lignes et décision « compté / non compté / option » communes dans
  le module `Inventaire` (voir [Geninv](../Geninv.class/architecture.md)) ; l'écriture diffère
  (stock de départ vs mouvement exceptionnel).
- Définition unique des mouvements de stock avec [Cstock](../../../../../Utils/Cstock.module/architecture.md),
  `DB_Connection.Lockstock` et [Stockmvt](../../../../Stockmvt.class/architecture.md) (STOCKMVT-A05,
  phase 3).
- Recalcul après inventaire : appeler une variante de `Cstock` sans lecture des contrôles de
  [Calcstock](../../../../../Utils/Calcstock.class/architecture.md) (CSTOCK-003 / CSTOCK-A01,
  même commit).

### Réduction de portée

- Aucune fonction (méthode spéciale et handlers). `$soption` → variable locale de `_New`.

### Séparation traitement / GUI

- `Button2_click` → `Valider(bZeroNonSaisis As Boolean, dDate As Date)` ; `button4_Click` →
  `StockDepartRegie(dDate) As Integer`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Statut et date de validation dans une table d'inventaire permanente (voir Geninv) ; journal de
  validation (`Fiches_Mvtexp` ou table dédiée) au lieu d'écraser `art_stkdep`.
- `Fiches_Mvtexp.qtep/qtem` en `varchar` (stockage textuel des quantités) : à typer en décimal.
- Stock par dépôt : rattacher l'inventaire à un dépôt (`inv_depot`) pour ajuster
  `Fiches_StkDepots`.
