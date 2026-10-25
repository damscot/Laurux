# Ttourne — Architecture

> Source : `.src/Gestion/option/Ttourne.class`

## Vue d'ensemble

Écran **« Gestion des tournées »** : saisie de la table `Fiches_tourne` (`code` char(15) clé
primaire, `tourne` char(50) ; table présente dans `db_control.csv:1916-1917` et dans
`Laurux01.sql`, vide) et onglet **Statistiques** par tournée. Ouvert par
`Fmenu.Menu327_Click` (`Fmenu.class:2467`, `Ttourne.Show`). Les tournées sont affectées aux
clients (`FClient`) et aux documents (`Facture`, `Facturefm`) via la fenêtre de recherche
[rechtour](../rechtour.class/architecture.md).

Construction sur la barre d'actions `Barselection("111111111", panel1)` (tous les boutons, y
compris recherche) : navigation premier/précédent/suivant/dernier dans `$restour`, création et
modification dans une **transaction ouverte entre l'action et sa validation**
(`Utils.db.Begin` → `Create9`/`Edit` → `Commit`/`Rollback`), comme
[Mreglement](../../Tables/Mreglement.class/architecture.md), [Tregion](../Tregion.class/architecture.md),
[Tregie](../Tregie.class/architecture.md) et [Tconsigne](../Tconsigne.class/architecture.md).
La suppression est affichée mais **non implémentée** (`bar1_suprimer` vide).

L'onglet statistiques est délégué à [`Gridvi`](../../../Utils/gridvi.class/architecture.md)
(`New Gridvi(TabStrip1, "T")`, propriété `code`) : il cumule par mois le CA et la marge par
`tour_ligfac`/`tour_ligbl` dans `Fiches_HistoFac`/`Fiches_HistoLigfac`, `Fiches_Bl`/`Fiches_Ligbl`
**et** leurs variantes `*M` (`Fiches_HistoFacM`/`Fiches_HistoLigfacM`, `Fiches_BlM`/`Fiches_LigblM`,
c'est-à-dire les bons et factures d'entretien du matériel décrits dans
[Materiel](../../Tables/Materiel.class/architecture.md)). Ttourne n'émet lui-même aucune requête
sur ces tables.

Situation par rapport au socle « table code/libellé » de
[Centrales](../../Tables/Centrales.class/architecture.md) : Ttourne est aussi une table
code/libellé, mais son ergonomie est celle de `Barselection` (fiche par fiche + transaction), pas
celle de la `ColumnView` à observateurs `OBS`. Il relève donc du **socle `Barselection`**
(MREGLEMENT-006), pas du socle Centrales.

Nature : **GUI** avec SQL dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$bs` | var | Private |  | Barselection | 3 |
| `$restour` | var | Private |  | Result | 4 |
| `$ind` | var | Private |  | Integer | 5 |
| `$grv` | var | Private |  | Gridvi | 6 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `form_Open` | 8-21 | Public | 2 | 11 | 0 | handler GUI |
| `Textnum_GotFocus` | 23-27 | Public | 2 | 3 | 0 | handler GUI |
| `Textnum_LostFocus` | 29-50 | Public | 4 | 17 | 0 | handler GUI |
| `Texttour_GotFocus` | 52-56 | Public | 2 | 3 | 0 | handler GUI |
| `Texttour_LostFocus` | 58-62 | Public | 2 | 3 | 0 | handler GUI |
| `bar1_annule` | 64-73 | Public | 2 | 9 | 0 | handler GUI |
| `bar1_creer` | 75-84 | Public | 1 | 8 | 0 | handler GUI |
| `bar1_dernier` | 86-93 | Public | 2 | 6 | 0 | handler GUI |
| `bar1_modif` | 95-100 | Public | 1 | 4 | 0 | handler GUI |
| `bar1_precedent` | 102-109 | Public | 3 | 6 | 0 | handler GUI |
| `bar1_premier` | 111-118 | Public | 2 | 6 | 0 | handler GUI |
| `bar1_suivant` | 120-126 | Public | 2 | 5 | 0 | handler GUI |
| `bar1_valide` | 128-148 | Public | 7 | 18 | 0 | handler GUI |
| `bar1_suprimer` | 150-154 | Public | 1 | 2 | 0 | handler GUI |
| `bar1_quitter` | 156-160 | Public | 1 | 3 | 0 | handler GUI |
| `bar1_recherche` | 162-179 | Public | 3 | 14 | 0 | handler GUI |
| `ListView1_Activate` | 181-187 | Public | 1 | 5 | 0 | handler GUI |
| `form_Close` | 189-196 | Public | 4 | 6 | 0 | handler GUI |
| `affichedonne` | 198-205 | Private | 2 | 6 | 0 |  |
| `mablanc` | 207-212 | Private | 1 | 4 | 0 |  |
| `affectedonne` | 214-219 | Private | 1 | 4 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture et focus

- **`form_Open()`** [handler] [nature : mixte] : `Utils.Observers(Me)`, création de la barre
  (`bar1`), `SELECT * FROM Fiches_tourne ORDER BY code` dans `$restour` ; **si la table n'est pas
  vide** seulement : création de `$grv` (statistiques) puis affichage de la première fiche.
  `$ind = 0`. Si la table est vide, `$grv` reste `Null` (voir TTOURNE-A03).
- **`Textnum_GotFocus` / `Texttour_GotFocus` / `Texttour_LostFocus`** [handler] [nature : GUI] :
  `Try Utils.ObsGotf/ObsLstf(Last)` (journalisation du focus pour le replay).
- **`Textnum_LostFocus()`** [handler] [nature : mixte] : journalise, puis
  `SELECT * FROM Fiches_tourne WHERE code=&1` : si le code existe, ballon « Tournée déja créer »
  et retour du focus ; si le code est vide, ballon « Code ne peut pas être vide ». `Stop Event`
  dans un `LostFocus` est sans effet. La zone n'est active qu'en création.

### Barre d'actions (événements de `Barselection`)

- **`bar1_creer()`** [handler] [nature : mixte] : mémorise `$ind = $restour.Index`,
  `Utils.db.Begin`, `$restour = Utils.db.Create9("Fiches_tourne")`, vide les zones, active
  `textnum`.
- **`bar1_modif()`** [handler] [nature : mixte] : `Begin`,
  `$restour = Utils.db.Edit("Fiches_tourne", "code=&1", textnum.Text)`.
- **`bar1_valide(creer, anul)`** [handler] [nature : mixte] (CC 7, max du fichier) : le second
  paramètre s'appelle `anul` mais reçoit `estmodif` (voir `Barselection.butval_Click`). En
  création, refuse silencieusement (`Stop Event`, la barre reste en validation) un code vide ou
  déjà existant (même requête que `Textnum_LostFocus`). Ni création ni modification (cas de la
  suppression) : retour sans rien faire. Sinon `affectedonne`, `$restour.Update`, `Commit`,
  rechargement trié et repositionnement sur `$ind`.
- **`bar1_annule(creer, anul)`** [handler] [nature : mixte] : `Rollback`, rechargement,
  repositionnement, `textnum` désactivé.
- **`bar1_suprimer()`** [handler] : vide (« a completer ») ; la barre passe pourtant en mode
  « Suppression ? » et la validation ne fait rien (TTOURNE-A04).
- **`bar1_premier` / `bar1_precedent` / `bar1_suivant` / `bar1_dernier`** [handler] [nature : GUI] :
  navigation dans `$restour`. `bar1_suivant` ne teste pas `Available` (sans effet visible sur une
  table vide : `Index = Max`).
- **`bar1_recherche()`** [handler] [nature : GUI] : bascule `ListView1` ; la remplit avec
  « code tournée » pour chaque ligne (clé = index dans `$restour`).
- **`ListView1_Activate()`** [handler] [nature : GUI] : se positionne sur la ligne choisie.
- **`bar1_quitter()`** [handler] : `Me.Close`.

### Fermeture

- **`form_Close()`** [handler] [nature : GUI] : en création ou modification, demande
  « Voullez-vous enregister vos modifications… » ; sur « Oui », appelle **`bar1_valide` sans
  argument** alors que la méthode attend deux `Boolean` → erreur d'exécution « Not enough
  arguments » (vérifié avec `gbs3` sur une méthode de même signature) : TTOURNE-A01. Sur « Non »,
  ni `Rollback` ni `Commit` : la transaction reste ouverte sur la connexion partagée (TTOURNE-A02).
  Se termine par `Me.Close` dans son propre handler de fermeture (réentrance, à confirmer).

### Fonctions privées

- **`affichedonne()`** [Private] [nature : GUI] : si `$ind <> -1`, recopie `code`/`tourne` dans les
  zones et positionne `$grv.code` (erreur « Null object » si `$grv` n'a pas été créé).
- **`mablanc()`** [Private] [nature : GUI] : vide les deux zones.
- **`affectedonne()`** [Private] [nature : GUI] : recopie les zones dans `$restour`.

## État global utilisé

- `Utils.db` (`Exec`, `Begin`, `Commit`, `Rollback`, `Create9`, `Edit`) ; transaction ouverte
  sur la connexion **partagée** pendant toute la saisie.
- `Utils.Observers`, `Utils.ObsGotf`, `Utils.ObsLstf` (journalisation pour le replay).

## Propositions d'amélioration

### Réécriture / refactorisation

- `ChargeTournees() As Result` : la requête `SELECT * FROM Fiches_tourne ORDER BY code` est écrite
  trois fois (`form_Open`, `bar1_annule`, `bar1_valide`).
- `TourneeExiste(code) As Boolean` : contrôle d'existence écrit deux fois (`Textnum_LostFocus`,
  `bar1_valide`).
- Renommer le paramètre `anul` en `modif` dans `bar1_valide` (nom de handler inchangé).

### Commonalisation avec d'autres fichiers

- **Cycle `Barselection`** (création/modification transactionnelle, navigation, rechargement et
  repositionnement) commun avec [Tregion](../Tregion.class/architecture.md),
  [Tregie](../Tregie.class/architecture.md), [Tconsigne](../Tconsigne.class/architecture.md) et
  [Mreglement](../../Tables/Mreglement.class/architecture.md) (MREGLEMENT-006). Les sept
  `bar1_premier/precedent/suivant/dernier/annule/creer/modif` sont des copies à un nom de table et
  de `Result` près. Proposition : un helper (classe `FicheBarre` ou méthodes de `Barselection`) qui
  porte le `Result`, la table, l'index mémorisé et un rappel d'affichage ; les handlers restent
  dans chaque formulaire et se réduisent à un appel.
- Requête des tournées partagée avec [rechtour](../rechtour.class/architecture.md) : clé
  `Cbase.Table("TabTourne")`.

### Réduction de portée

Rien à réduire : les 18 méthodes `Public` sont des handlers (doivent rester `Public`) ; les trois
fonctions utilitaires sont déjà `Private`.

### Séparation traitement / GUI

- `TourneeExiste(code)` et `ChargeTournees()` sans accès aux contrôles, appelés par les handlers.
- `bar1_valide` : isoler la validation (`ValideTournee(code) As String` qui renvoie le motif de
  refus) ; le handler garde `Stop Event`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clé étrangère des clients et des lignes de documents (`tour_ligbl`, `tour_ligfac`) vers
  `Fiches_tourne.code`, pour empêcher la suppression d'une tournée utilisée (préalable à
  l'implémentation de `bar1_suprimer`).
