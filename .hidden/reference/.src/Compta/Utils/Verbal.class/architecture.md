# Verbal — Architecture

> Source : `.src/Compta/Utils/Verbal.class`

## Vue d'ensemble

`Verbal` (« vérification des balances ») est un écran de contrôle comptable ouvert en modal par
Comptabilité > Outils > Vérification des balances (`Fmenu.Menu132_Click`). Sur une période
`DteN0`…`DteN1` (format `dd.mm.yyyy`), il cumule les débits et crédits des écritures **validées**
de l'exercice courant (`Fiches_Mvt`) par catégorie de compte de `Fiches_Comptes` :

| Ligne de l'écran | Comptes retenus (`type_cc`, `coll`, préfixe) | Champs D / C / S |
|---|---|---|
| Collectif clients | `B`, `coll = 1`, `41…` | `Dclient`, `Cclient`, `Sclient` |
| Collectif fournisseurs | `B`, `coll = 1`, `40…` | `Dfournisseur`, `Cfournisseur`, `Sfournisseur` |
| Balance clients | `C` | `Dbclient`, `Cbclient`, `Sbclient` |
| Balance fournisseurs | `F` | `Dbfournisseur`, `Cbfournisseur`, `Sbfournisseur` |
| Balance gestion | `G` | `Dgestion`, `Cgestion`, `Sgestion` |
| Balance bilan | `B` | `Dbilan`, `Cbilan`, `Sbilan` |
| Balance générale | gestion + bilan | `Dgenerale`, `Cgenerale`, `Sgenerale` |

Le contrôle attendu est l'égalité « collectif clients = balance clients », « collectif fournisseurs
= balance fournisseurs » et un solde général nul ; l'écran n'en compare que le dernier (fond
rouge de `Sgenerale` et `Syntheses.Message`). Les cumuls sont faits **dans le texte des champs**
(`Format$(Val(cpoint(champ)) + montant, "0.00")` à chaque écriture), donc arrondis à 2 décimales à
chaque pas et dépendants du séparateur décimal de la locale.

Nature globale : **mixte** ; le calcul est entièrement mêlé aux contrôles.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `TotSldHP` | var | Private |  | Float | 28 |
| `debit` | var | Private |  | Float | 29 |
| `credit` | var | Private |  | Float | 30 |
| `dte` | var | Private |  | String | 31 |
| `dte1` | var | Private |  | String | 32 |
| `dte2` | var | Private |  | String | 33 |
| `Txt` | var | Private |  | String | 34 |
| `jour` | var | Private |  | String | 35 |
| `Compt` | var | Private |  | String | 36 |
| `son` | var | Private |  | Integer | 37 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 42-82 | Public | 2 | 38 | 0 | méthode spéciale |
| `date1` | 87-101 | Public | 1 | 12 | 0 | portée réductible ? |
| `Cmpt_KeyPress` | 106-126 | Public | 6 | 16 | 0 | handler GUI |
| `Btn_Click` | 131-164 | Public | 3 | 29 | 0 | handler GUI |
| `Cmpt_GotFocus` | 169-180 | Public | 2 | 10 | 0 | handler GUI |
| `Ex1` | 185-204 | Public | 2 | 17 | 0 | portée réductible ? |
| `Exo` | 209-223 | Public | 1 | 12 | 0 | portée réductible ? |
| `dteN0_LF` | 228-250 | Public | 5 | 21 | 0 | portée réductible ? |
| `dteN1_LF` | 255-283 | Public | 8 | 26 | 0 | portée réductible ? |
| `Compdate` | 285-298 | Public | 4 | 12 | 0 | portée réductible ? |
| `compdate2` | 300-313 | Public | 4 | 12 | 0 | portée réductible ? |
| `Button2_Click` | 318-426 | Public | 19 | 99 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et dates

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. Observateurs de replay,
  `Music.Load`, centrage, 21 champs à `"0,00"`, `jour` = date du jour. Appelle `Ex1` ; si la date
  du jour est postérieure à `DteN1`, rappelle `Ex1`, puis `DteN0 = DteN1` et `DteN1 = jour` ;
  sinon `Exo`. Les comparaisons de dates se font en recomposant `yyyymmdd` par
  `Right$`/`Mid$`/`Left$` sur des chaînes `dd.mm.yyyy`.
- **`Ex1()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Parametres` ;
  `DteN0 = LDate(dteclec).L` (date de **fin** de l'exercice courant, malgré le commentaire) ; si
  aujourd'hui est antérieur → `Exo`, sinon `DteN1 = jour`, `dte1 = DteN0`, `dte2 = DteN1`.
- **`Exo()`** [portée : réductible] [nature : mixte]. `DteN0 = dteclec1 + 1 jour`, `DteN1 =
  dteclec` (exercice courant complet) ; `dte1`/`dte2` mémorisent les bornes.
- **`date1()`** [portée : réductible] [nature : mixte] — **code mort** (aucun appel). Variante avec
  `Utils.Calc_mois(dteclec1)` et `Utils.Cdate_Aff(dteclec)`.
- **`dteN0_LF()` / `dteN1_LF()`** [portée : réductible] [nature : mixte]. Appelées par
  `Cmpt_KeyPress` (Entrée/Tab, tags 1 et 2). Normalisent la saisie (`Cdate_calc` puis `Cdate_aff`,
  `"00.00.0:00"` → date du jour), puis comparent aux bornes `dte1` et `année(dte2) + 1` : hors
  bornes → `Compdate`/`compdate2` (avertissement puis remise des dates par `Ex1` ou `Exo`). Une fin
  antérieure au début ne provoque qu'un avertissement, le traitement reste possible. `Catch` →
  focus sur le champ.
- **`Compdate()` / `compdate2()`** [portée : réductible] [nature : GUI]. Son, `Message.Warning(Txt)`,
  puis `Ex1` ou `Exo` selon la date du jour.
- **`Cmpt_KeyPress()`**, **`Cmpt_GotFocus()`** [portée : nécessaire (handlers)] [nature : GUI].
  `Cmpt_GotFocus` applique `Utils.SetEditColor` puis recolore `Sgenerale` (bleu `&HF51B03&` si non
  nul, gris `&HD4D0C8&` sinon).

### Boutons et calcul

- **`Btn_Click()`** [portée : nécessaire (handler de groupe)] [nature : GUI]. Tag 2 →
  `Button2_Click` ; tag 3 → vide les 21 champs puis `Me.Close`. ⚠️ Le tag 1 (`Button1`, icône
  d'aide « Doc HTML ») n'est pas traité : le bouton est sans effet.
- **`Button2_Click()`** (CC 19) [portée : nécessaire (appelé par `Btn_Click`)] [nature : mixte].
  Remet les 21 champs à `"0,00"`, puis :
  1. `SELECT * FROM Fiches_Comptes order by cast(compte_cc AS char)` ;
  2. **pour chaque compte**, `SELECT * FROM Fiches_Mvt WHERE compte = &1 and validee = 1 and dte
     >= &3 and dte <= &4` (dates `yyyymmdd` par `Utils.Cdate_Dbase`) : N+1 requêtes ;
  3. pour chaque écriture, ajoute débit et crédit aux champs de la catégorie (`C`, `F`, `G`, `B`,
     et `B` + `coll = "1"` + préfixe `41`/`40`), solde recalculé à chaque pas ;
  4. totaux généraux = gestion + bilan ; si `Sgenerale.Text <> "0,00"`, fond rouge `&hFF1E1E&` et
     `Syntheses.Message("Attention ! Votre balance n'est pas équilibrée.")` ;
  5. son et `Message.Info(" Traitement terminé")`.
  Les écritures d'un exercice antérieur (`Fiches_Mvt1`…) ne sont jamais lues, même si la période
  saisie s'y trouve. Partie extractible : étapes 1 à 4, sous la forme d'une fonction qui renvoie les
  21 valeurs.

SQL émis : `Fiches_Parametres` (lecture, 1 à 3 fois à l'ouverture et à chaque remise des dates),
`Fiches_Comptes` (1 requête), `Fiches_Mvt` (1 requête par compte). Aucune écriture.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Music`.
- `Utils.db`, `Utils.cpoint`, `Utils.Cdate_calc`, `Utils.Cdate_Aff`, `Utils.Cdate_Dbase`,
  `Utils.Calc_mois` (code mort), `Utils.SetEditColor`, `Utils.Observers`, `LDate(…).L`.
- `Syntheses.Message` (son + synthèse vocale si `/son2`, aucun affichage).
- Variables de classe : `dte1`/`dte2` (bornes), `jour`, `Txt` (message), `debit`/`credit`
  (variables de boucle), `Compt` ; `TotSldHP`, `dte` jamais utiles (`TotSldHP` remis à 0, jamais lu).

## Propositions d'amélioration

### Réécriture / refactorisation

- Calcul : une fonction `CalculeBalances(sDeb, sFin) As Float[]` qui accumule en `Float` avec
  arrondi à 2 décimales à chaque pas (reproduire exactement `Format$(…, "0.00")` puis `Val`), les
  champs n'étant écrits qu'une fois à la fin. Le texte affiché doit rester identique (test T02).
- Remplacer les N+1 requêtes par `SELECT c.compte_cc, c.type_cc, c.coll, m.montantd, m.montantc
  FROM Fiches_Comptes c JOIN Fiches_Mvt m ON m.compte = c.compte_cc WHERE …` triée comme
  aujourd'hui (lecture seule, mêmes montants ; l'ordre d'accumulation influe sur les arrondis
  intermédiaires : à valider par T02/T03).
- 21 champs : un tableau de contrôles (`[Dclient, Cclient, …]`) parcouru pour la remise à zéro et
  l'effacement, sans toucher au `.form`.
- Supprimer l'effacement des champs avant `Me.Close` (sans effet visible).

### Commonalisation avec d'autres fichiers

- Dates d'exercice : `Ex1`/`Exo` lisent `dteclec`/`dteclec1` à la main ; utiliser
  `LDate.Exercice_Cloture(0)` et `LDate.Exercice_Cloture(1)` (voir
  [LDate](../../../Utils/LDate.class/architecture.md)), avec attention à l'heure 23:59:59.999
  renvoyée (seule la partie date est utilisée ici via `.L`). Même idiome `Ex1`/`Exo` dans
  [RubImp](../../Impressions/RubImp.class/architecture.md) et 8 autres écrans de
  `Compta/Impressions` (`Balance`, `EcrM`, `EditcompteA`, `Editcompte`, `ExportA47`, `Jourcent`,
  `Journaux`, `JournauxA`).
- Comparaison de dates `dd.mm.yyyy` par recomposition `yyyymmdd` : à remplacer par des `LDate`
  (même remarque pour `RubImp`).
- Noms de tables : `Cbase.Table("TabParam")`, `("TabComptes")`, `("TabMvt")` (SQL identique).

### Réduction de portée

- `Ex1`, `Exo`, `dteN0_LF`, `dteN1_LF`, `Compdate`, `compdate2` → `Private` (aucun appelant externe,
  vérifié par `grep`). `date1` est supprimée (code mort).

### Séparation traitement / GUI

- `CalculeBalances` (ci-dessus) et `BornesExercice() As String[]` sans contrôles ; les handlers
  affichent, colorent et jouent les sons.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index `(compte, validee, dte)` sur `Fiches_Mvt` pour la requête par compte (à vérifier dans
  `db_control.csv`), ou agrégat par compte côté base (`GROUP BY`) qui ne demande pas de schéma.
