# ValidinvT — Architecture

> Source : `.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class`

## Vue d'ensemble

Écran de **validation de l'inventaire tournant** (menu 100,
[`Fmenu.class:1123`](../../../../../Communs/Fmenu.class/architecture.md), `ValidinvT.Show`).
Déroulement de `Button2_click` :

1. `CREATE TABLE IF NOT EXISTS Fiches_HisInvT` (même DDL que `LauruxMaj.Maj303`) ;
2. `mysqldump` vers `~/Sauve/LauruxInvT.sqlAAAAMMJJ` — base **`Laurux` en dur** ;
3. si la 1re ligne de `Fiches_InvT` a `inv_valid = 1` → « déjà validé » ; sinon confirmation ;
4. pour chaque ligne : écart `qtep` (surplus) / `qtem` (manque) = `inv_qtecomptee - inv_qtestock` ;
   - comptée → `art_qte = inv_qtecomptee` ;
   - non comptée et « Mettre le stock à zéro » (`RadioButton1`) → `art_qte = 0` ;
   - non comptée et « Laisser » → `art_qte` inchangé ;
   - `inv_valid = 1` sur la ligne ;
   - si écart ≠ 0 : `INSERT INTO Fiches_Mvtexp (code, daterecpt = inv_date, qtep, qtem, Com =
     "Inentaire tournant du …")` — **y compris pour les lignes non comptées** (`qtec = 0` → `qtem =
     inv_qtestock`) quelle que soit l'option ;
5. copie des lignes **comptées** dans `Fiches_HisInvT` sous un nouveau `inv_num` (max + 1) ;
6. `DROP TABLE Fiches_InvT`.

`art_stkdep` et `dteinv` ne sont pas touchés (différence majeure avec
[Validinv](../../Fin-annee/Validinv.class/architecture.md), 64 lignes communes).

### Cohérence avec Cstock et Stockmvt

Cohérent avec le tableau des sources de [Stockmvt](../../../../Stockmvt.class/architecture.md)
(STOCKMVT-A05) : [`Cstock.Calc_stock`](../../../../../Utils/Cstock.module/architecture.md) repart,
pour un article présent dans `Fiches_HisInvT` après `dteinv`, de `inv_qtestock` (stock théorique
**à la génération**) et ajoute les mouvements depuis `inv_date`, dont l'écart écrit ici dans
`Fiches_Mvtexp` : on retombe sur `inv_qtecomptee` + mouvements postérieurs. `Stockmvt` n'utilise
pas `Fiches_HisInvT` mais voit les `Fiches_Mvtexp`.

Conséquences (anomalies) :
- **non comptés + « Laisser »** : `art_qte` est conservé mais une sortie `qtem = inv_qtestock` est
  écrite dans `Fiches_Mvtexp` ; ces articles n'étant pas historisés, le prochain recalcul part de
  `art_stkdep` et retranche cette sortie fictive (VALIDINVT-A02) ;
- mouvements entre génération et comptage comptés deux fois au recalcul, alors que `art_qte` est
  écrasé immédiatement par le comptage (VALIDINVT-A03, à confirmer) ;
- stock par dépôt (`Fiches_StkDepots`, `Fiches_Sdepots`) non ajusté, comme Validinv.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | String | 27 |
<!-- /AUTO:declarations -->

- `son As String` : jamais initialisé → aucun son.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 29-35 | Public | 1 | 5 | 0 | méthode spéciale |
| `Button2_click` | 37-155 | Public | 23 | 110 | 0 | handler GUI |
| `Button3_Click` | 157-162 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 164-168 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Utils.Observers(Me)`,
  `Music.Load`, `Me.Center`.
- **`Button2_click()`** [portée : nécessaire (handler, « Validation »)] [nature : mixte] (CC 23).
  Décrit ci-dessus. Variables inutilisées : `Rdate` (`SELECT * FROM Fiches_Parametres` sans
  usage), `rarts` (`SELECT * FROM Fiches_Art` par ligne sans usage), `qteAch`, `qteVtes`, `Tpe`,
  `dte`. Indentation incohérente (l. 73-146). Tables en dur (`Fiches_Art`, `Fiches_Parametres`,
  `Fiches_InvT`, `Fiches_HisInvT`, `Fiches_Mvtexp`). Pas de transaction : une interruption laisse
  `inv_valid = 1` sur une partie des lignes et des `Fiches_Mvtexp` partiels ; le contrôle « déjà
  validé » ne lit que la première ligne. `daterecpt` reçoit `Format$(inv_date, "yyyymmdd")` (chaîne)
  dans une colonne `datetime`. Partie extractible : tout le traitement (paramètre : option).
- **`Button3_Click()`** [handler] [GUI]. Quitter.
- **`Button1_Click()`** [handler] [GUI]. Aide `Doc.Open("Vinv")`.

## État global utilisé

- `Start.LocalSettings["/dbase/Host"]`, `Start.Musique` ; `Utils.db` (`Login`, `Password`,
  `Exec`, `Engine`), `Utils.Observers`.
- Tables : `Fiches_InvT` (lecture, `UPDATE`, `DROP`), `Fiches_Art` (`art_qte`), `Fiches_Mvtexp`
  (insertion), `Fiches_HisInvT` (création, insertion), `Fiches_Parametres` (lecture inutile).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les lectures inutiles (`Fiches_Parametres`, `Fiches_Art` par ligne) : SQL modifié,
  dump identique. Réindenter et aplatir les `If`.

### Commonalisation avec d'autres fichiers

- `Utils.DumpBase` (SAUVESAUTO-003) avec [Validinv](../../Fin-annee/Validinv.class/architecture.md).
- Module `Inventaire` : `Lignes("T")`, `Supprimer("T")` (voir
  [Geninv](../../Fin-annee/Geninv.class/architecture.md)).
- Écriture d'un mouvement exceptionnel : même table que les écrans de mouvements exceptionnels du
  stock et que les mouvements de produits composés ; helper `MvtExceptionnel(code, date, qtep, qtem,
  com)` à partager (phase 3).
- Le DDL de `Fiches_HisInvT` duplique `LauruxMaj.Maj303` : `LauruxMaj` est intouchable, le
  `CREATE IF NOT EXISTS` reste ici (documenté).

### Réduction de portée

- Aucune (méthode spéciale et handlers).

### Séparation traitement / GUI

- `Button2_click` → `Valider(bZeroNonSaisis As Boolean) As Integer` ; `Historiser() As Integer`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_HisInvT` : ajouter le dépôt et la date de validation ; `Fiches_Mvtexp.qtep/qtem` en
  décimal ; table d'inventaire permanente avec statut (voir Geninv).
