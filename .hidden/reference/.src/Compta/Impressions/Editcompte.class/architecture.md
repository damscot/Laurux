# Editcompte — Architecture

> Source : `.src/Compta/Impressions/Editcompte.class`

## Vue d'ensemble

`Editcompte` est l'**écran d'édition des grands livres** (menu Comptabilité > Impressions > Grands
livres, `Fmenu.Menu38_Click` → `Editcompte.Show`, auto-instance), malgré l'en-tête du source qui
parle d'« extraits de compte ». Il offre :

- cinq natures (`Bclient` `C`, `Bfournisseur` `F`, `Bgestion` `G`, `Bbilan` `B`, `Bgen` `BG` =
  gestion + bilan), mémorisées dans `type` ;
- la même sélection d'exercice que [`Balance`](../Balance.class/architecture.md) (`E0`, `E1`,
  `N1`…`N5` → `Ex1`, `Exo`, `Exo1`…`Exo5`, table `Tab0` = `Fiches_Mvt`…`Fiches_Mvt5`, ici **en dur**) ;
- une plage de comptes (`cpt`, `cpt2`, `TriCpt` en F2), avec contrôle du préfixe du compte selon la
  nature dans `Cmpt_KeyPress` ;
- **Imprimer** → [`EditcompteM.Imprime`](../EditcompteM.module/architecture.md) (PDF
  `~/tmp/Glivre.pdf`) ; **Exporter** → `Button2_Click`, fichier texte `;` `~/tmp/Glivre.txt`, logique
  locale, avec **centralisation mensuelle** des comptes `cent_cc = 1` dans la table de travail `Ctrln`.

La classe partage 491 lignes (en séquence, hors commentaires) avec
[`EditcompteA`](../EditcompteA.class/architecture.md), copie adaptée à l'analytique, et 83 lignes avec
`EditcompteM` (`Raz`, `Centralisation`, `finmois` identiques).

Nature globale : **GUI** + un export **mixte** (SQL, DDL de table de travail, fichier).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `DebHP` | var | Private |  | Float | 27 |
| `CredHP` | var | Private |  | Float | 28 |
| `TotSldHP` | var | Private |  | Float | 29 |
| `TotDeb` | var | Private |  | Float | 30 |
| `TotCred` | var | Private |  | Float | 31 |
| `TotSld` | var | Private |  | Float | 32 |
| `Slddeb` | var | Private |  | Float | 33 |
| `Sldcred` | var | Private |  | Float | 34 |
| `Sldtot` | var | Private |  | Float | 35 |
| `debit` | var | Private |  | Float | 36 |
| `credit` | var | Private |  | Float | 37 |
| `solde` | var | Private |  | Float | 38 |
| `montantd` | var | Private |  | Float | 39 |
| `montantc` | var | Private |  | Float | 40 |
| `mnt` | var | Private |  | Float | 41 |
| `mnt1` | var | Private |  | Float | 42 |
| `dte` | var | Private |  | String | 43 |
| `dte1` | var | Private |  | String | 44 |
| `dte2` | var | Private |  | String | 45 |
| `Txt` | var | Private |  | String | 46 |
| `Filename` | var | Private |  | String | 47 |
| `Filetxt` | var | Private |  | String | 48 |
| `type` | var | Private |  | String | 49 |
| `hfile` | var | Private |  | File | 50 |
| `Tab0` | var | Private |  | String | 51 |
| `Tab1` | var | Private |  | String | 52 |
| `jour` | var | Private |  | String | 53 |
| `Centr` | var | Private |  | Boolean | 54 |
| `Mois` | var | Private |  | String | 55 |
| `Datj` | var | Private |  | String | 56 |
| `libelle` | var | Private |  | String | 57 |
| `Compt` | var | Private |  | String | 58 |
| `IntituleCpt` | var | Private |  | String | 59 |
| `cResult` | var | Private |  | Result | 60 |
| `rResult` | var | Private |  | Result | 61 |
| `rrResult` | var | Private |  | Result | 62 |
| `Tab2` | var | Private |  | String | 63 |
| `son` | var | Private |  | Integer | 64 |
| `Bsel` | var | Public |  | Boolean | 66 |
| `Bval` | var | Public |  | String | 67 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 72-94 | Public | 2 | 20 | 0 | méthode spéciale |
| `Ex1` | 99-118 | Public | 2 | 17 | 0 | portée réductible ? |
| `Exo` | 123-142 | Public | 1 | 17 | 0 | portée réductible ? |
| `Exo1` | 147-162 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo2` | 167-182 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo3` | 187-202 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo4` | 207-222 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo5` | 227-245 | Public | 1 | 16 | 0 | portée réductible ? |
| `Cmpt_KeyPress` | 250-350 | Public | 56 | 86 | 0 | handler GUI |
| `Btn_Click` | 355-374 | Public | 6 | 11 | 0 | handler GUI |
| `Cmpt_GotFocus` | 379-385 | Public | 1 | 5 | 0 | handler GUI |
| `dteN0_LostFocus` | 387-407 | Public | 5 | 18 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 409-437 | Public | 8 | 26 | 0 | portée réductible ? |
| `Compdate` | 439-450 | Public | 3 | 10 | 0 | portée réductible ? |
| `compdate2` | 452-463 | Public | 3 | 10 | 0 | portée réductible ? |
| `Raz` | 468-481 | Public | 1 | 12 | 0 | portée réductible ? |
| `Bclient_Click` | 486-495 | Public | 1 | 8 | 0 | handler GUI |
| `Bfournisseur_Click` | 500-509 | Public | 1 | 8 | 0 | handler GUI |
| `Bgestion_Click` | 514-523 | Public | 1 | 8 | 0 | handler GUI |
| `Bbilan_Click` | 528-537 | Public | 1 | 8 | 0 | handler GUI |
| `Bgen_Click` | 542-551 | Public | 1 | 8 | 0 | handler GUI |
| `E0_Click` | 556-561 | Public | 1 | 4 | 0 | handler GUI |
| `E1_Click` | 566-571 | Public | 1 | 4 | 0 | handler GUI |
| `N1_Click` | 576-581 | Public | 1 | 4 | 0 | handler GUI |
| `N2_Click` | 586-591 | Public | 1 | 4 | 0 | handler GUI |
| `N3_Click` | 596-601 | Public | 1 | 4 | 0 | handler GUI |
| `N4_Click` | 606-611 | Public | 1 | 4 | 0 | handler GUI |
| `N5_Click` | 616-621 | Public | 1 | 4 | 0 | handler GUI |
| `Button4_Click` | 626-637 | Public | 2 | 9 | 0 | handler GUI |
| `Button5_Click` | 642-653 | Public | 2 | 9 | 0 | handler GUI |
| `content1` | 658-662 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees` | 664-668 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees2` | 670-674 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button1_Click` | 676-680 | Public | 1 | 3 | 0 | portée réductible ? |
| `Centralisation` | 685-708 | Public | 2 | 21 | 0 | portée réductible ? |
| `finmois` | 713-724 | Public | 2 | 9 | 0 | portée réductible ? |
| `Button2_Click` | 729-841 | Public | 18 | 108 | 0 | portée réductible ? |
| `Button3_Click` | 846-850 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. Observateurs, `filetxt =
  ~/tmp/Glivre.txt`, son, centrage, puis une séquence redondante : `E0_Click()` (`Tab0 = Fiches_Mvt`,
  `Ex1`), `Exo()`, puis si aujourd'hui est après la fin de l'exercice précédent `Ex1()` et
  `dteN1 = aujourd'hui`, sinon `Exo()` ; enfin `E0.Value = True`. Plage client par défaut
  `41100001` → `411999999` (9 chiffres, alors que `Bclient_Click` met `41999999`). Trois à quatre
  lectures de `Fiches_Parametres` pour un résultat égal à celui d'`E0_Click()` seul dans le cas
  courant (à confirmer par EDITCOMPTE-T01/T02).

### Bornes d'exercice

- **`Ex1`, `Exo`, `Exo1` … `Exo4`** [portée : réductible] [nature : mixte]. Identiques à ceux de
  `Balance`, sans `Catch` et avec `"Fiches_Parametres"` en dur (`Tab` local) au lieu de
  `Cbase.Table("TabParam")`. `Ex1` ne fait pas `Raz()` ; `Exo` vide d'abord les champs.
- **`Exo5`** [portée : réductible] [nature : mixte]. Calcule le début par manipulation de chaîne :
  `dteclec5` (Date) converti en `String` (`mm/jj/aaaa`), année − 1, puis `Calc_mois` → 1er jour du
  mois suivant. Équivalent à `Balance.Exo5` pour un exercice de 12 mois ; la variable de classe
  `Mois` (String) est détournée pour stocker l'année. Sous SQLite, si la colonne revient en chaîne
  `aaaa-mm-jj`, le calcul est faux (à confirmer).

### Saisie

- **`Cmpt_KeyPress()`** (CC 56, max du fichier) [portée : nécessaire, handler du groupe `Cmpt`]
  [nature : GUI]. Entrée/Tab : tag 1 → `dteN0_LostFocus()` puis `dteN1` ; tag 2 →
  `dteN1_LostFocus()` puis `cpt` ; tags 3/4 : contrôle du préfixe de `cpt`/`cpt2` selon la nature
  (`411`, `401`, classe 6/7, classes 1-5/8/9), `Message.Warning` et retour au champ, sinon champ
  suivant. ⚠️ Pour `cpt2` en gestion (l. 312), la condition utilise `Or` : tout compte est refusé
  (anomalie EDITCOMPTE-A01). Le message l. 273 est fautif (« n'est un compte client »). Aucun
  contrôle pour `Bgen`. F1 : aide ; F2 : `TriCpt`.
- **`Cmpt_GotFocus()`** [portée : nécessaire, handler] [nature : GUI]. `Utils.SetEditColor`.
- **`dteN0_LostFocus()` / `dteN1_LostFocus()`** [portée : à garder `Public` (nom de handler), mais ce
  ne sont **pas** des handlers effectifs : `dteN0`/`dten1` appartiennent au groupe `Cmpt`, les
  événements sont donc levés sous le nom du groupe ; seuls `Cmpt_KeyPress` les appelle] [nature :
  mixte]. Même logique que `Balance.dteN0_LF`/`dteN1_LF`. ⚠️ `dteN1_LostFocus` appelle `Compdate`
  (focus sur `dteN0`) pour une date de fin trop basse, au lieu de `compdate2` (anomalie EDITCOMPTE-A03).
- **`Compdate()` / `compdate2()`** [portée : réductible] [nature : GUI]. Comme dans `Balance` :
  période remise sur `Exo` et `E0` coché (anomalie EDITCOMPTE-A04).
- **`Raz()`** [portée : réductible] [nature : calcul]. Remise à zéro des cumuls (`solde` deux fois).

### Boutons

- **`Btn_Click()`** [portée : nécessaire, handler] [nature : GUI]. Tag 1 export, 2 impression,
  3 fermeture (`Try Kill filename` : `Filename` n'est jamais affecté dans cette classe).
- **`Bclient_Click`, `Bfournisseur_Click`, `Bgestion_Click`, `Bbilan_Click`, `Bgen_Click`**
  [portée : nécessaire, handlers] [nature : GUI]. Fixent `cpt`, `cpt2`, `type`.
- **`E0_Click`, `E1_Click`, `N1_Click` … `N5_Click`** [portée : nécessaire, handlers] [nature :
  mixte]. `Tab0` en dur puis bornes.
- **`Button4_Click` / `Button5_Click`** [portée : nécessaire, handlers] [nature : GUI].
  `New TriCpt(type, TriCpt.Sans_Solde, Me)` ; pour `type = "BG"`, `TriCpt` ne reconnaît pas la
  chaîne et reste sur `Tous` (valeur 0 de l'énumération). Retour par `Bsel`/`Bval`.
- **`Button1_Click()`** [portée : nécessaire, handler] [nature : GUI].
  `EditcompteM.Imprime(cpt, cpt2, Type, dten0, dten1, Bgen.Value, Tab0)`.
- **`Button3_Click()`** [portée : nécessaire, handler] [nature : GUI]. `Doc.Open("Extraits")`.

### Export texte et centralisation

- **`Button2_Click()`** (CC 18) [portée : nécessaire, handler] [nature : mixte]. Pas de `Catch`.
  1. Réécrit `~/tmp/Glivre.txt`.
  2. Comptes de `Fiches_Comptes` (en dur) dans la plage et du `type` (ou `G` puis `B` pour `BG`,
     tri `type_cc, compte`). Les colonnes `cprincipal`, `type_cc` sont lues sans être utilisées.
  3. Pour chaque compte : toutes les écritures validées de `Tab0` (`order by dte`), filtrées par date
     **en Gambas** (`Cdate_Comp`), alors qu'`EditcompteM` filtre en SQL.
  4. Si le compte a au moins une écriture : `DROP TABLE IF EXISTS Ctrln` puis `CREATE TABLE Ctrln`
     (DDL **dans la boucle**, à chaque compte, table laissée en base à la fin).
  5. Compte non centralisé : une ligne par écriture `compte;intitulé;libellé;jour;date;numéro;lot;
     débit;crédit;solde` (`donnees`). Compte centralisé : `Centralisation()` cumule par mois dans
     `Ctrln`, puis une ligne par mois (« Centralisation », jour de `Ctrln`, date de fin de mois).
  6. Les cumuls « hors période » (écritures du jour `dteN0` seulement) et les totaux généraux
     (`Slddeb`, `Sldcred`, `Sldtot`) sont calculés mais **jamais écrits** (`donnees2` en commentaire).
  7. `Close #hFile` uniquement si des comptes ont été trouvés (sinon fichier laissé ouvert) ; le
     message annonce « extrait.txt » (anomalie EDITCOMPTE-A05).
- **`Centralisation()`** [portée : réductible] [nature : calcul + SQL]. Lit l'état de classe
  (`Compt`, `Datj`, `montantd`, `montantc`, `jour`, `IntituleCpt`) ; calcule `Mois = aaaamm` et la
  date de fin de mois `aaaammjj` (`finmois`) ; `SELECT` dans `Ctrln` puis `UPDATE` (cumul) ou
  `INSERT` (libellé « Centralisation » concaténé dans le SQL, constant). Identique à
  `EditcompteM.Centralisation` ; même schéma dans `EditcompteA` (table `Ctrlnc`) et `Extrait`.
- **`finmois(Jrs As Date) As Integer`** [portée : réductible] [nature : calcul]. Dernier jour du mois
  de `Jrs`. Copié dans 6 fichiers (`EditcompteM`, `EditcompteA`, `Extrait`, `ExportJdv`, `ExportA47`) ;
  équivalent à `LDate.Fin_Mois()`.
- **`donnees(p1…p10)`** [portée : réductible] [nature : calcul]. Ligne `;` dans `hFile`.
- **`content1`, `donnees2`** [portée : réductible] — **code mort** (appels en commentaire).

## État global utilisé

- `Utils.db` ; tables en dur : `Fiches_Parametres`, `Fiches_Mvt`…`Fiches_Mvt5`, `Fiches_Comptes` ;
  table de travail `Ctrln` (créée/détruite ici, partagée par nom avec `EditcompteM`, `Extrait`,
  `FTVA`, `EdImpayes`, `EdNjustifiees`, avec des structures différentes).
- `Utils.Calc_mois`, `Cdate_aff`, `Cdate_calc`, `Cdate_dbase`, `Cdate_Comp`, `SetEditColor`,
  `Observers`, `db.Engine()`.
- `Start.Son` (copié à l'instanciation), `Start.Musique`.
- `Bsel`/`Bval` : écrits par `TriCpt` (`Object.SetProperty`) — à garder `Public`.
- Auto-instance : `EditcompteM` modifie `Editcompte.Mouse`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Cmpt_KeyPress` : extraire `MessageCompte(compte As String) As String` (préfixe attendu selon la
  nature, message ou `""`), en conservant **à l'identique** la condition fautive de `cpt2` en gestion
  (tant que A01 n'est pas validée) ; CC 56 → ~10.
- `Exo`…`Exo4` → un chargeur privé, comme pour `Balance` ; `Cbase.Table("TabParam")`,
  `Cbase.Table("TabMvt…")`, `Cbase.Table("TabComptes")` à la place des noms en dur (SQL identique).
- `_New` : réduire la séquence à `E0_Click()` si les replays T01/T02 confirment l'équivalence
  (SQL modifié : moins de lectures de `Fiches_Parametres`, dump identique).
- `Button2_Click` : filtrer les dates en SQL comme `EditcompteM` (SQL modifié, dump identique) et
  sortir le DDL de `Ctrln` de la boucle **seulement** si le contenu final de `Ctrln` reste identique
  (il ne contient aujourd'hui que le dernier compte centralisé traité : un `DELETE` par compte
  remplacerait le `DROP/CREATE`).

### Commonalisation avec d'autres fichiers

- **Socle commun Editcompte / EditcompteA / EditcompteM** (le « trio ») :
  - écran : `Ex1`…`Exo5`, `Btn_Click`, `Cmpt_GotFocus`, `Compdate`, `compdate2`, `Raz`,
    `Bgestion_Click`, `Bbilan_Click`, `E0_Click`…`N5_Click`, `Button4_Click`, `Button5_Click`,
    `Button3_Click`, `content1`, `donnees`, `donnees2`, `finmois` sont **identiques** entre
    `Editcompte` et `EditcompteA` (29 fonctions), `dteN0_LostFocus`/`dteN1_LostFocus` à 0,91-0,94
    (prétraitement de date en plus dans A), `Exo5` à 0,83, `Centralisation` à 0,95 (nom de table) ;
  - centralisation : `Centralisation`, `finmois`, `Raz` **identiques** avec `EditcompteM` ; même
    fonction dans [`Extrait`](../../Extrait.class/architecture.md).
  Socle proposé : un module `Compta/Utils` « centralisation » (`Cumule(table, compte, intitule,
  dateAff, montantd, montantc, jour)`, `CreeTable(table, typeDte, longIntitule)` qui reproduit les
  deux DDL existants, `FinMois(d)` délégant à `LDate.Fin_Mois`), et pour les écrans un helper de
  bornes partagé avec `Balance` (voir BALANCE-004). Les handlers restent dans chaque classe (noms
  intouchables) et deviennent des appels d'une ligne.
- **Export** : `Button2_Click` (106 lignes) est à 94 % identique à `EditcompteA.Button2_Click`, qui
  est du code mort ; la logique d'export et celle d'`EditcompteM.Imprime` parcourent les mêmes
  données : un itérateur commun « écritures d'un compte avec centralisation » alimenterait le PDF et
  le texte (après validation des écarts actuels : `jour` des lignes centralisées, filtre de dates).
- `Balance` : mêmes fonctions de bornes et de contrôle de date (voir
  [Balance](../Balance.class/architecture.md)).

### Réduction de portée

- `Ex1`, `Exo`…`Exo5`, `Compdate`, `compdate2`, `Raz`, `donnees`, `Centralisation`, `finmois` →
  `Private` (aucun appelant externe, vérifié par `grep -rn "Editcompte\."`) ; `content1`,
  `donnees2` supprimés.
- `Bsel`/`Bval` : faux positifs (écrits par `TriCpt`). `dteN0_LostFocus`/`dteN1_LostFocus` : gardés
  `Public` (nom de handler, règle du PLAN).

### Séparation traitement / GUI

- `Button2_Click` → `ExporteGrandLivre(fichier, cpt, cpt2, type, d0, d1, tab0) As Boolean` sans
  contrôle ; le handler garde messages et son.
- `Cmpt_KeyPress` → `MessageCompte` pur (ci-dessus).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Ctrln` est une table permanente recréée à chaque édition et partagée par six écrans avec des
  structures différentes : collisions possibles en multi-poste (MySQL partagé). Une table
  `TEMPORARY` (propre à la connexion) ou une table de travail par édition supprimerait le risque ;
  cela change le contenu du dump (la table ne persiste plus).
- La centralisation mensuelle peut être calculée par `GROUP BY compte, YEAR(dte), MONTH(dte)` sans
  table de travail (attention à la traduction SQLite).
- Voir `Balance` pour `compte_cc` numérique et les 6 tables d'écritures.
