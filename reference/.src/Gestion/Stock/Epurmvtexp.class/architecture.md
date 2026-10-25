# Epurmvtexp — Architecture

> Source : `.src/Gestion/Stock/Epurmvtexp.class` · Formulaire : `.src/Gestion/Stock/Epurmvtexp.form`

## Vue d'ensemble

`Epurmvtexp` est l'écran **« Épuration des régularisations »** (menu Gestion › Stock,
`Fmenu.Menu229_Click`, `EpurMvtexp.ShowModal()`) : il supprime les mouvements de stock
exceptionnels (`Fiches_Mvtexp`, saisis par [Mvtex](../Mvtex.class/architecture.md)) antérieurs ou
égaux à une date de fin de période.

À l'ouverture, `Form_Open` propose :
- `date1` (début) : premier jour du mois suivant `dteclec1` de `Fiches_Parametres` ;
- `date2` (fin) : `dteclec` (date de clôture) de `Fiches_Parametres`.

`Button1` (« Traitement ») demande confirmation puis parcourt **toute** la table et, pour chaque
mouvement dont la date est ≤ `date2`, exécute un `DELETE`. `date1` n'est jamais utilisée pour
filtrer.

⚠️ **Défaut critique** (EPURMVTEXP-A01) : le `DELETE` est écrit
`"DELETE FROM Fiches_Mvtexp WHERE mind"` avec `rResult!mind` passé en argument **sans
marqueur `&1`**. La condition devient `WHERE mind` (vrai pour toute ligne, `mind` étant un
auto-incrément ≥ 1) : dès le premier mouvement antérieur à `date2`, **toute la table est vidée**,
y compris les mouvements postérieurs. `Fiches_Mvtexp` entre dans le recalcul du stock
([Cstock](../../../Utils/Cstock.module/architecture.md), `qtep - qtem` depuis la date
d'inventaire) et dans [Stockmvt](../../Stockmvt.class/architecture.md) (ligne « Mouvements
exceptionnels » du tableau des sources) : la purge fausse donc le stock recalculé et l'historique.
`Fiches_Mvtexpdc` (produits composés, [MvtProdcomp](../MvtProdcomp.class/architecture.md)) n'est
pas concernée.

Nature globale : **mixte** (SQL dans le handler du bouton).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 28 |
| `Dtpc` | var | Private |  | String | 29 |
| `Dpc` | var | Private |  | String | 30 |
| `datec2` | var | Private |  | String | 31 |
| `dtepc` | var | Private |  | String | 32 |
| `jour` | var | Private |  | String | 33 |
| `dterpt` | var | Private |  | String | 34 |
| `B` | var | Private |  | Integer | 35 |
| `son` | var | Private |  | Integer | 36 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 38-44 | Public | 1 | 5 | 0 | méthode spéciale |
| `Form_Open` | 46-66 | Public | 1 | 18 | 0 | handler GUI |
| `Aff_date` | 68-78 | Public | 2 | 9 | 0 | portée réductible ? |
| `date1_LostFocus` | 83-97 | Public | 2 | 12 | 0 | portée réductible ? |
| `date2_LostFocus` | 102-125 | Public | 6 | 22 | 0 | portée réductible ? |
| `Button3_Click` | 127-131 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 133-163 | Public | 7 | 28 | 0 | handler GUI |
| `Button2_Click` | 165-169 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI]. `Utils.Observers(Me)`,
  `Music.Load(Start.Musique)`, centrage.
- **`Form_Open()`** [handler] [nature : mixte]. Lit `Fiches_Parametres` (sans test `Available`),
  calcule `date1` via `Aff_date` à partir de `dteclec1` (mois + 1) et `date2` à partir de
  `dteclec` (`Utils.Cdate_Aff`, reformatage `dd.mm.yyyy`). La variable locale `Dtpc` masque le
  membre de même nom. `dterpt` et `jour` sont calculés mais jamais relus.
- **`Aff_date()`** [portée : réductible, appelée seulement par `Form_Open`] [nature : mixte].
  Incrémente le mois `dtepc` (passage d'année si > 12, en lisant le membre `Dtpc`, vide à ce
  moment), affecte `date1.Text`.
- **`date1_LostFocus()` / `date2_LostFocus()`** [handlers **inactifs**] [nature : GUI].
  `Date1` et `Date2` appartiennent au groupe `Cmpt` dans le `.form` : Gambas lève
  `Cmpt_LostFocus`, qui n'existe pas. Ces deux fonctions (normalisation de la date, contrôle
  `date2 >= date1` avec `Balloon.Warning`) ne sont **jamais exécutées** (`handlers_inactifs` et
  `unused` de `deps.py`, vérifié dans le `.form`). Les dates saisies ne sont donc pas contrôlées.
  Le drapeau `B` qu'elles positionnent n'est lu nulle part.
- **`Button1_Click()`** [handler] [nature : mixte]. Confirmation (`Message.Question`), puis
  `SELECT * FROM Fiches_Mvtexp` et boucle `Repeat … Until MoveNext` : comparaison
  `Utils.Cdate_Comp(daterecpt) <= datec2` (chaînes `yyyymmdd`) et `DELETE` défectueux (A01). Pas
  de transaction. Message « Traitement terminé », puis `Me.Close` (aussi en cas de « Non »).
- **`Button2_Click()`** [handler] : `Doc.Open("Epurationmvtexp")`.
- **`Button3_Click()`** [handler] : `Me.Close`.

## État global utilisé

- `Start.Son`, `Start.Musique` (son), `Utils.Observers`, `Utils.Cdate_Aff`, `Utils.Cdate_calc`,
  `Utils.Cdate_Comp`, `Utils.db`.
- Membres non typés hérités du style ancien (`Tab`, `Dtpc`, `Dpc`, `datec2`, `dtepc`, `jour`,
  `dterpt`, `B`, `son`) : `jour`, `dterpt` et `B` sont inutiles.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer la boucle de lecture + `DELETE` ligne à ligne par un seul
  `DELETE FROM … WHERE daterecpt <= &1` : **change le comportement** (corrige A01), donc à faire
  avec l'anomalie, pas en rework autonome.
- Supprimer les membres et handlers morts (`jour`, `dterpt`, `B`, `date1_LostFocus`,
  `date2_LostFocus`) : sans effet observable puisque les handlers ne sont jamais levés.

### Commonalisation avec d'autres fichiers

- Le calcul de la période proposée à partir de `dteclec1`/`dteclec` est répété dans les écrans de
  purge et de clôture (ex. `Quittedate` de [ValidBR](../ValidBR.class/architecture.md),
  [Facturergbl](../../Facturation/Facturergbl.class/architecture.md)) : à rapprocher de
  `LDate.Exercice_Debut/Fin` (voir notes transverses, dates).
- Normalisation de date `Cdate_calc` + `Cdate_aff` + test `"00.00.0:00"` : idiome partagé avec
  `ValidBR.Datej_KeyPress`/`Button1_Click` et de nombreux écrans ; un `TextReg` de type
  `EstDate` (comme dans [Mvtex](../Mvtex.class/architecture.md)) le remplace.

### Réduction de portée

- `Aff_date` → `Private`. Les handlers (`Button*_Click`, `Form_Open`) restent `Public`.
  `date1_LostFocus`/`date2_LostFocus` sont supprimés (code mort) plutôt que réduits.

### Séparation traitement / GUI

- Isoler la purge dans `Purge(sDateFin As String)` sans accès aux contrôles (SQL identique,
  défaut A01 conservé tant que l'anomalie n'est pas validée), appelée par `Button1_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index sur `Fiches_Mvtexp.daterecpt` pour une purge par plage de dates.
- Archivage plutôt que suppression (table d'historique) pour ne pas fausser le recalcul de stock
  par `Cstock` lorsque la purge porte sur une période postérieure au dernier inventaire.
