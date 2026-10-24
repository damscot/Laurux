# FTVA — Architecture

> Source : `.src/Compta/Impressions/FTVA.class`

## Vue d'ensemble

`FTVA` est l'écran **« Récapitulatif TVA »** (menu Compta, `Fmenu.Menu263_Click` → `FTVA.show()`).
Il affiche, pour une période (mois, trimestre ou année civile), le solde des comptes de TVA
déductible (`4456%`) et collectée (`4457%`) de type bilan (`type_cc = 'B'`), dans deux
`ColumnView` (`ColumnViewTVAachat`, `ColumnViewTVAvente`), puis calcule la « TVA à déclarer »
(`TextLabelTTVA`). Le bouton « Imprimer » produit `~/tmp/TVA.pdf` avec `Cbalances` (classe
`PdfWriter` partagée avec `BalanceM`) puis l'ouvre via `Visualiseur.Prog`.

Les écritures lues sont **uniquement** celles de `Fiches_Mvt` (exercice en cours), filtrées par
`month(dte)` / `year(dte)` ; ni `validee` ni `provisoire` ne sont filtrés. L'option « Détail des
écritures » (`Detail`) affiche une ligne par écriture au lieu d'une ligne par compte.

Le fichier est un écran GUI dont tout le calcul est noyé dans les handlers : trois handlers de
période (`RadioBtn*_Click`) au corps identique à 90 %, une fonction d'affichage `Affiche` qui mêle
SQL, cumul et remplissage du `ColumnView`, et un `button2_Click` (CC 51, max du fichier) qui
recalcule tout pour le PDF.

Nature globale : **mixte** (SQL + calcul + GUI dans les mêmes fonctions).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `rResultat` | var | Private |  | Result | 3 |
| `tot` | var | Private |  | Float | 4 |
| `DebP` | var | Private |  | Float | 5 |
| `CredP` | var | Private |  | Float | 6 |
| `Coulfond` | var | Private |  | New String[] | 7 |
| `PosY` | var | Private |  | Integer | 8 |
| `dten0` | var | Private |  | Date | 9 |
| `dten1` | var | Private |  | Date | 10 |
| `debit` | var | Private |  | Float | 11 |
| `credit` | var | Private |  | Float | 12 |
| `solde` | var | Private |  | Float | 13 |
| `totdeb` | var | Private |  | Float | 14 |
| `totcred` | var | Private |  | Float | 15 |
| `totsld` | var | Private |  | Float | 16 |
| `Tothtdeb` | var | Private |  | Float | 17 |
| `Tothtcred` | var | Private |  | Float | 18 |
| `Totht` | var | Private |  | Float | 19 |
| `debutOpen` | var | Private |  | Boolean | 20 |
| `dateedition` | var | Private |  | String | 21 |
| `moisencours` | var | Private |  | Integer | 22 |
| `mois1` | var | Private |  | Integer | 23 |
| `mois2` | var | Private |  | Integer | 24 |
| `datec2` | var | Private |  | String | 25 |
| `datec3` | var | Private |  | String | 26 |
| `annee` | var | Private |  | Integer | 27 |
| `annee1` | var | Private |  | String | 28 |
| `annee2` | var | Private |  | String | 29 |
| `exon` | var | Private |  | Boolean | 30 |
<!-- /AUTO:declarations -->

État d'instance réellement utile : `rResultat` (comptes de TVA en cours d'affichage), `Tot`,
`solde`, `mois1`/`mois2`/`Annee` (période courante), `datec2`/`datec3` (dates de clôture lues à
l'ouverture), `PosY` (ordonnée PDF), `debit`/`credit`/`totdeb`/`totcred`/`totsld` (cumuls PDF).
Variables écrites mais jamais lues (code mort) : `dten0`, `dten1`, `Coulfond`, `DebP`, `CredP`,
`Tothtdeb`, `Tothtcred`, `exon`, `annee1`, `annee2` (seulement passées en paramètres inutilisés
d'un `Exec`), `moisencours` (sert de variable de travail locale dans deux fonctions). `Totht`
n'est jamais calculé : il vaut toujours 0 (affiché dans `Totventesht`/`Totachatsht`, invisibles
dans le `.form`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Form_Open` | 32-70 | Public | 5 | 36 | 0 | handler GUI |
| `Affiche` | 72-222 | Public | 23 | 144 | 0 | portée réductible ? |
| `Button1_Click` | 224-228 | Public | 1 | 3 | 0 | handler GUI |
| `RadioBtnTrimestre_Click` | 230-282 | Public | 10 | 51 | 0 | handler GUI |
| `RadioBtnmensuel_Click` | 284-332 | Public | 9 | 46 | 0 | handler GUI |
| `RadioBtnAnnuel_Click` | 334-377 | Public | 8 | 41 | 0 | handler GUI |
| `trimestre` | 379-396 | Public | 10 | 16 | 0 | portée réductible ? |
| `moiscalc` | 398-402 | Public | 1 | 3 | 0 | portée réductible ? |
| `anneecalc` | 404-408 | Public | 1 | 3 | 0 | portée réductible ? |
| `ComboBoxYear_Click` | 410-429 | Public | 5 | 18 | 0 | handler GUI |
| `ComboBoxMois_Click` | 431-435 | Public | 1 | 3 | 0 | handler GUI |
| `ComboBoxTrimestre_Click` | 437-441 | Public | 1 | 3 | 0 | handler GUI |
| `button2_Click` | 443-729 | Public | 51 | 284 | 0 | handler GUI |
| `Raz` | 731-742 | Public | 1 | 10 | 0 | portée réductible ? |
| `Detail_Click` | 744-750 | Public | 4 | 5 | 0 | handler GUI |
| `Texercice_Click` | 752-756 | Public | 2 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture et période

- **`Form_Open()`** [portée : nécessaire (handler)] [nature : mixte]. Lit `Fiches_Parametres`
  (nom en dur, sans `Cbase.Table`, sans test `Available`) : `datec2 = Cdate_Comp(dteclec1)`,
  `datec3 = Cdate_Comp(dteclec)`, `Annee` = année de la clôture courante. Remplit
  `ComboBoxYear` avec cette année et la précédente, puis force le texte à l'année **courante**
  (`Now`), le mois courant (`moiscalc`) et le trimestre courant (`trimestre`). Si le mode
  trimestriel est actif, calcule `dten0`/`dten1` (chaînes `"01/MM/yy"` converties en `Date`) qui ne
  sont **jamais lus** (code mort). Le mode par défaut du `.form` est **mensuel** : `mois1`/`mois2`
  ne sont initialisés que si l'affectation de `ComboBoxMois.text` déclenche `ComboBoxMois_Click`
  (à confirmer), sinon une impression immédiate porte sur le mois 0 (voir FTVA-A05).
- **`trimestre()`** [portée : réductible] [nature : GUI]. Positionne `ComboBoxTrimestre` selon le
  mois courant. ⚠️ Tests incomplets : mois 3 (`< 3` faux, `> 3` faux) et mois 9 (`< 9` faux)
  tombent dans le `Else` → « Trimestre 4 » (FTVA-A01). Chaque branche répète l'affectation sous
  `If debutOpen` : sans effet (code mort).
- **`moiscalc()`**, **`anneecalc()`** [portée : réductible] [nature : GUI]. Mois / année courants
  dans les combos.
- **`ComboBoxYear_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Refuse une année
  antérieure de 5 ans ou plus (`Message.Warning`), sinon relance le handler du mode actif.
- **`ComboBoxMois_Click()`**, **`ComboBoxTrimestre_Click()`**, **`Detail_Click()`**,
  **`Texercice_Click()`** [portée : nécessaire (handlers)] [nature : GUI]. Relancent le calcul du
  mode concerné. `Texercice` est invisible dans le `.form` : son handler est inatteignable par
  l'utilisateur (la branche « TVA sur exercice » n'a jamais été terminée : `datec2`/`datec3` et
  `annee1`/`annee2` ne servent à rien).
- **`Button1_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Ferme.

### Calcul et affichage écran

- **`RadioBtnTrimestre_Click()`**, **`RadioBtnmensuel_Click()`**, **`RadioBtnAnnuel_Click()`**
  [portée : nécessaire (handlers)] [nature : mixte]. Même séquence, seule la détermination de
  `mois1`/`mois2` diffère (trimestre → index × 3 ; mensuel → `ComboBoxMois.Text` sous `Try` ;
  annuel → 1..12 sauf si `Texercice`) :
  1. vide les deux vues et `TextLabelTTVA` ;
  2. `SELECT * FROM Fiches_Comptes WHERE compte_cc like '4457%' and type_cc = 'B' order by
     cast(compte_cc AS char)` (via `Cbase.Table("TabComptes")`) puis `Affiche(ColumnViewTVAvente)` ;
  3. idem `4456%` → `Affiche(ColumnViewTVAachat)` ;
  4. `TextLabelTVente`/`TextLabelTAchat` ← `Tot` formaté `",0.00"` ;
  5. « TVA à déclarer » : quatre branches dont trois identiques (`Vente - Val(Achat)`), la
     quatrième (`Vente >= Achat` et `Achat <= 0`) calcule `Achat + Vente`. Le second opérande est
     lu par `Val(TextLabelTAchat.Text)` **sans** `Utils.cpoint`, sur un texte formaté avec
     séparateur de milliers (FTVA-A03, à confirmer).
  `RadioBtnmensuel_Click` déclare deux locales `Totd`/`Totc` inutiles et remet `Tot = 0` avant
  les achats (sans effet : `Affiche` le remet à 0).
- **`Affiche(ColView)`** (CC 23) [portée : réductible] [nature : mixte]. Configure 11 colonnes
  (largeurs selon `Detail`), puis pour chaque compte de `rResultat` :
  `SELECT * FROM Fiches_Mvt where compte = &4 and month(dte) >= &1 and month(dte) <= &2 and
  year(dte) = &3 order by dte` (mode annuel : `year(dte) = &3` seul, avec 4 paramètres inutilisés).
  Pour chaque écriture, une requête `Fiches_Journaux` **inutilisée** (`JtResult`) et un `Print`
  sur la sortie standard (`Print cptresult.count`, trace de débogage). Le sens du solde dépend du
  **nom** du contrôle : ventes `crédit - débit`, achats `débit - crédit`. En mode non détaillé,
  une ligne par compte (`.Add` avec la clé `CptResult.index & compte`). `Tot` cumule les soldes
  des comptes. Les montants sont comparés à la chaîne `"0.00"` (dépend du format renvoyé par le
  pilote ; sous SQLite un montant nul peut valoir `"0"`, à confirmer).

### Impression

- **`button2_Click()`** (CC 51, 284 lignes) [portée : nécessaire (handler)] [nature : mixte].
  1. Construit `dateedition` (libellé du trimestre ou du mois, `Select Case` de 12 cas ; « fèvrier »
     mal orthographié, FTVA-A06) ; calcule `tmpMois`/`tmpMois2` jamais utilisés.
  2. `SELECT * FROM Fiches_Societes Where cd_sc = &1` (nom en dur) → « Société  <int_sc> ».
  3. `New Cbalances("Portrait","mm","A4")`, `Entete`, `Level0T`, `Level1T`.
  4. Deux passes (`nombreDeTVA` = 1 achats `4456%`, 2 ventes `4457%`). Pour chaque compte :
     `SELECT * FROM Fiches_Mvt … month/year …` (via `Cbase.Table("TabMvt")`) ; si au moins une
     écriture : **`DROP TABLE IF EXISTS Ctrln` + `CREATE TABLE Ctrln`** (table de travail jamais
     alimentée ici : code mort SQL), `Level3T`, puis une ligne `Level2T` par écriture en mode
     détaillé (requête `Fiches_Journaux` inutilisée à chaque ligne), cumul par sens, `Level4T`
     par compte, `Level4TVA` par passe. Le bloc « saut de page » (`If PosY >= 273` →
     `Entete`/`Level0T`/`Level1T`) est copié 5 fois ; la copie de la ligne 671 appelle
     `Level0T(dateedition, …)` sans le préfixe « Sélection du » (FTVA-A04).
  5. Total `Abs(SldtotV) - SldtotA` (`Level5T`, dont les paramètres `Slddeb`/`Sldcred`, jamais
     affectés, valent 0 et ne sont pas imprimés), `BasPage` (pied de page **uniquement sur la
     dernière page**), `Output`, `Visualiseur.Prog`.
  `Shell "cd " & User.Home` (ligne 485) est sans effet. Le message « Aucune ecriture pour cette
  demande » n'apparaît que s'il n'existe **aucun compte** 4456/4457, pas en l'absence d'écritures.
- **`Raz()`** [portée : réductible (aucun appel externe, `grep -rn "FTVA\."` vide)] [nature :
  calcul]. Remet les cumuls à 0 (`solde` affecté deux fois).

## État global utilisé

- `Utils.db` (toutes les requêtes), `Utils.Cdate_Comp`, `Utils.Cdate_Aff`, `Utils.cpoint`,
  `Utils.Coulfd` (résultat inutilisé).
- `Cbase.Table("TabComptes"|"TabMvt"|"TabJour")` ; noms en dur : `Fiches_Parametres` (l. 38),
  `Fiches_Mvt` (l. 81), `Fiches_Comptes` (l. 481), `Fiches_Societes` (l. 482), `Ctrln` (l. 480).
- `Start.Societe` (en-tête PDF).
- Fichier `~/tmp/TVA.pdf` (écrasé à chaque impression).

## Propositions d'amélioration

### Réécriture / refactorisation

- Un seul calcul de récapitulatif `Calcul_Recap()` appelé par les trois `RadioBtn*_Click` après
  détermination de `mois1`/`mois2` (même ordre de requêtes, mêmes affectations).
- `TextLabelTTVA` : réduire les quatre branches à deux en conservant **exactement** les
  expressions actuelles (dont le `Val` sans `cpoint`).
- `Affiche` : sens du solde passé en paramètre (`bVente As Boolean`) au lieu du test sur
  `ColView.Name` ; suppression du test redondant de la ligne 145.
- `button2_Click` : helper privé `SautPage(pdf, sTitre)` pour les 5 blocs ; tableaux constants
  des libellés de mois et de trimestres ; une fonction de cumul par compte.
- `trimestre` : `ComboBoxTrimestre.Index = (Month(Now) - 1) \ 3` **seulement** après validation
  de FTVA-A01 (changement de comportement en mars et septembre).

### Commonalisation avec d'autres fichiers

- **Socle commun des éditions comptables** (proposition transverse, voir aussi
  [EcrM](../EcrM.class/architecture.md), [Echeancier](../Echeancier.class/architecture.md),
  [EdNlettrees](../EdNlettrees.class/architecture.md),
  [EdNjustifiees](../EdNjustifiees.class/architecture.md),
  [EdImpayes](../EdImpayes.class/architecture.md), [Balance](../Balance.class/architecture.md),
  [Journaux](../Journaux.class/architecture.md), [Editcompte](../Editcompte.class/architecture.md)) :
  à rattacher au socle d'édition PDF paginée proposé par EDITCOMPTE-006
  ([Editcompte/rework.md](../Editcompte.class/rework.md)) : un module `EditionCompta` (nom à arrêter en phase 3) fournissant
  `LibelleSociete()` (« Société  » & `int_sc`, copié dans 12 fichiers),
  `FichierPdf(sNom)` (`User.Home & "/tmp/" & sNom`), `Termine(pdf, sFichier)` (`Output` +
  `Visualiseur.Prog`), `TableCtrln()` (DDL de la table de travail `Ctrln`, copiée dans
  FTVA, EdImpayes, Editcompte, EditcompteM, Extrait) et un saut de page paramétrable. Le
  `Shell "cd " & User.Home` (86 fichiers) disparaît avec.
- Dates de clôture : `LDate.Exercice_Cloture(0|1)` (voir [LDate](../../../Utils/LDate.class/rework.md),
  LDATE-008) remplace la lecture manuelle de `dteclec`/`dteclec1`.
- Libellés de mois : `LDate.MonStr` existe déjà ([LDate](../../../Utils/LDate.class/architecture.md)) ;
  à vérifier caractère par caractère (accents, « d'avril », « de août ») avant de l'utiliser.
- `Cbalances` n'est utilisé que par FTVA et [BalanceM](../BalanceM.module/architecture.md) : les
  méthodes `Level*T` sont propres à FTVA.

### Réduction de portée

- `Affiche`, `trimestre`, `moiscalc`, `anneecalc`, `Raz` → `Private` (aucun appel hors du fichier,
  vérifié par `grep -rn "FTVA\." .src` : seul `Fmenu` appelle `FTVA.show()`). Les handlers restent
  `Public` (règle PLAN : `ReplayObserver`).

### Séparation traitement / GUI

- Extraire `SoldesTVA(sPrefixe, iMois1, iMois2, iAnnee, bDetail, bVente) As Variant[]` (lignes et
  total, sans accès aux contrôles) ; `Affiche` et `button2_Click` ne font plus que l'affichage.
- Le calcul « TVA à déclarer » devient une fonction pure `TvaADeclarer(sVente, sAchat) As Float`
  reproduisant les quatre branches.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les requêtes `month(dte)`/`year(dte)` empêchent l'usage d'un index sur `dte` ; un filtre
  `dte BETWEEN` suffirait sans changement de schéma (prévu en rework seulement si le dump et les
  lignes affichées restent identiques), mais un index `(compte, dte)` sur `Fiches_Mvt*`
  accélérerait toutes les éditions de ce lot.
- Une colonne « taux / type de TVA » sur `Fiches_Comptes` éviterait la sélection par préfixe
  `4456%`/`4457%`.
- `Ctrln` (table de travail partagée, recréée par plusieurs écrans) gagnerait à devenir une table
  temporaire (`CREATE TEMPORARY TABLE`).
