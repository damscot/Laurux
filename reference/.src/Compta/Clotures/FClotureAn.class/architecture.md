# FClotureAn — Architecture

> Source : `.src/Compta/Clotures/FClotureAn.class`

## Vue d'ensemble

Écran de **clôture annuelle** (clôture d'exercice). C'est le traitement le plus destructeur de
la comptabilité : il fait tourner les tables d'archives d'exercice, reconstruit l'exercice
courant et génère les écritures d'**à-nouveaux**. Ouvert **non modal** par
`Fmenu.Menu60_Click` (`FClotureAn.Show()`), après contrôle du tunnel de réplication.

Dates manipulées (lues dans `Fiches_Parametres`, converties en `yyyymmdd` par
`Utils.Cdate_Comp`) :

| Variable | Champ | Sens |
|---|---|---|
| `datec2` | `dteclec1` | fin de l'exercice précédent (le commentaire l. 32 dit « début », inexact) |
| `datec3` | `dteclec` | fin de l'exercice à clôturer |
| `datec` | `dtepc` | dernière période mensuelle clôturée |
| `dterpt` | calculé | premier jour suivant `dteclec` : date des écritures d'à-nouveaux |

Séquence de `Button1_Click` (CC 74, 530 lignes) :

1. **Questions** : sauvegarde faite ? puis **contrôle de la balance** : pour chaque compte, cumul
   débit/crédit des écritures validées de l'exercice (`dte >= datec2 and dte <= datec3`), par
   type (`G`, `B`, `C`, `F`, collectifs 41/40). Seul le solde `G + B` (`Sgenerale`) est utilisé :
   ≠ 0 → refus.
2. **Confirmation** puis contrôle `datec >= datec3` (toutes les périodes clôturées), sinon refus.
3. **Étape 1** (`ProgBar` 6 pas) : sauvegarde `mysqldump` (`Sauve`), remise à zéro et recalcul
   des soldes de `Fiches_Comptes` sur les écritures `≤ datec3` ; **rotation des tables** :
   `DROP Fiches_Mvt5`, `RENAME Mvt4→5 … Mvt→Mvt1`, `CopieTable(Mvt1, Mvt)` (structure seule,
   `CREATE TABLE … LIKE`) ; idem pour `Fiches_MvtA*` et `Fiches_MvtM*` ; création des tables de
   travail `Report` et `ReportM` (`ReportM` n'est jamais utilisée) ; reprise dans `Fiches_MvtA` et
   `Fiches_MvtM` des lignes de `MvtA1`/`MvtM1` postérieures à `datec3` (supprimées de `*1`).
4. **Étape 2** (une itération par écriture de `Fiches_Mvt1`, l'ancien exercice) selon le type du
   compte (`Fiches_Comptes.type_cc`) :
   - écriture postérieure à `datec3` (types `C`, `F`, `B`, `G`) : **réinsérée** dans
     `Fiches_Mvt` (colonnes reprises différentes selon le type, `validee` forcée à 0 pour C/F/B,
     `numerodef` mis à 0 si non clôturée) et supprimée de `Mvt1` ;
   - écriture de l'exercice (`> datec2 et ≤ datec3`) : cumul dans `Report` par compte (C, F, B) ou
     sur le compte fictif `980000` (G = résultat).
5. **Étape 3** : pour chaque ligne de `Report`, insertion d'une écriture d'à-nouveau au journal
   `jdr`, datée `dterpt`, numéro provisoire `numecr1` et définitif `numecr3` communs ; la ligne
   `980000` est passée sur `cptrsplus` (perte) ou `cptrsmoins` (bénéfice) avec l'intitulé
   « Resultat ». Puis `solde = 0`, **`UPDATE Fiches_Mvt SET validee = 1`** (toutes les
   écritures), recalcul des soldes (identique à `Csolde.Recalc_solde`), décalage des dates
   d'exercice et des compteurs dans `Fiches_Parametres`, purge de `Fiches_MvtM ≤ datec3`
   (sans effet, la table vient d'être recréée), et **recalcul de toutes les clés SHA-1**
   (`Sha1Calc.CalcSha1_all("Fiches_Mvt")`).

Aucune transaction (les `RENAME`/`DROP` MySQL ne sont pas transactionnels) : un échec en cours
laisse une base intermédiaire, d'où la sauvegarde préalable. Le moteur **SQLite n'est pas
supporté** en pratique (voir anomalies).

Nature globale : **mixte**, sans séparation : le traitement entier est dans un handler GUI.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 28 |
| `Dtpc` | var | Private |  | String | 29 |
| `Dpc` | var | Private |  | String | 30 |
| `datec` | var | Private |  | String | 31 |
| `datec2` | var | Private |  | String | 32 |
| `datec3` | var | Private |  | String | 33 |
| `dtepc` | var | Private |  | String | 34 |
| `jour` | var | Private |  | String | 35 |
| `Rp` | var | Private |  | String | 36 |
| `Rplus` | var | Private |  | String | 37 |
| `rmoins` | var | Private |  | String | 38 |
| `dterpt` | var | Private |  | String | 39 |
| `Rslt` | var | Private |  | String | 40 |
| `cpt` | var | Private |  | String | 41 |
| `Jrl` | var | Private |  | String | 42 |
| `son` | var | Private |  | Integer | 43 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 45-51 | Public | 1 | 5 | 0 | méthode spéciale |
| `Form_Open` | 53-82 | Public | 1 | 26 | 0 | handler GUI |
| `Aff_date` | 84-96 | Public | 2 | 11 | 0 | portée réductible ? |
| `Calc_Daterpt` | 98-112 | Public | 2 | 13 | 0 | portée réductible ? |
| `Button3_Click` | 114-118 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 120-651 | Public | 74 | 486 | 0 | handler GUI |
| `Sauve` | 653-675 | Public | 6 | 20 | 0 | portée réductible ? |
| `Button2_Click` | 677-681 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI]. Observateurs de replay, son, centrage.
- **`Form_Open()`** [portée : nécessaire, handler] [nature : mixte]. Texte d'avertissement ;
  `SELECT * FROM Fiches_Parametres` (sans test `Available`) ; calcule `Dtpc`, `dtepc`, `Dpc`
  depuis `dteclec1` puis `Aff_date` ; `datecl` = `dteclec` en clair ; `Calc_Daterpt(dteclec)` ;
  `datec`, `datec2`, `datec3` (`Cdate_Comp`) ; comptes de résultat `cptrsplus`/`cptrsmoins` ;
  journal `jdr` ; `jour` = date du jour (`dd.mm.yyyy`).
- **`Aff_date()`** [portée : réductible] [nature : GUI]. Calcule le mois suivant `dteclec1`
  (début de l'exercice à clôturer) et l'affiche dans `dateprc` ; réaffiche `datecl` depuis
  `datec3`. Note : `datec3` n'est pas encore calculé lors de l'appel depuis `Form_Open` (l. 67
  avant l. 73) ; `datecl` est ensuite réécrit l. 68-69 (à confirmer : la ligne 92 est sans effet
  visible).
- **`Calc_Daterpt(Dtpc2)`** [portée : réductible] [nature : calcul]. Date des à-nouveaux
  (`dterpt`, `yyyymmdd`) = 1er du mois suivant le mois de `Dtpc2`, l'année étant lue dans
  `datecl.Text` (couplage à un contrôle). `Left(Dtpc2, 2)` suppose une chaîne `mm/dd/yyyy`
  (conversion implicite d'une `Date` en chaîne).
- **`Button3_Click()`** [portée : nécessaire, handler] [nature : GUI]. Ferme.
- **`Button1_Click()`** (CC 74, max du fichier) [portée : nécessaire, handler] [nature : mixte].
  Séquence décrite en vue d'ensemble. Tables touchées : `Fiches_Parametres`, `Fiches_Comptes`,
  `Fiches_Mvt`…`Fiches_Mvt5`, `Fiches_MvtA`…`A5`, `Fiches_MvtM`…`M5`, `Report`, `ReportM`, toutes
  par nom en dur. Code mort interne : 15 cumuls de balance jamais lus (`Dclient`, `Sbclient`,
  `Dfournisseur`…), `Type` (l. 561), `Intit`, `num`, `b`, `rrResult` de la l. 586 ; les `UPDATE`
  des l. 479 et 510 utilisent `Compt`, variable **périmée** (dernier compte de la boucle de
  recalcul), mais leur effet est écrasé par la remise à zéro l. 587 et le recalcul l. 592-615.
  Les deux recalculs de soldes (l. 304-336 avec borne `≤ datec3`, l. 586-615 sans borne)
  dupliquent [`Csolde`](../../../Utils/Csolde.module/architecture.md).
- **`Sauve()`** [portée : réductible] [nature : mixte]. `mysqldump -h <Host> -u <Login>
  -p<Password> <Base> --add-drop-table > ~/<Base>_<ddmmyyyy>.sql` (`Shell … Wait`), compression
  zlib vers `~/Sauve/<Base>AvCL_<ddmmyyyy>.sql.gz` ; si la compression échoue, déplacement du
  `.sql` puis `Kill` du fichier source **déjà déplacé** (erreur non interceptée). Si le dump est
  absent : `Message.Error` et `Me.Close`, mais **la clôture continue** dans `Button1_Click`.
  Mot de passe visible dans `ps`, port et tunnel SSH ignorés.
- **`Button2_Click()`** [portée : nécessaire, handler] [nature : GUI]. `Doc.Open("ClotureAn")`.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.LocalSettings["/dbase/Host"]`.
- `Utils.db` (`Exec`, `CopieTable`, `AutoIncrement`, `Engine`, `Login`, `Password`, `Name`),
  `Utils.Cdate_Aff`, `Utils.Cdate_Comp`, `Utils.Cdate_Dbase`, `Utils.cpoint`, `Utils.PointBase`,
  `Utils.Observers`.
- `Sha1Calc.CalcSha1_all`, `ProgBar`, `LDate`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Découper `Button1_Click` en étapes privées : `ControleBalance()`, `RecalculSoldes(sDateMax)`,
  `DecaleTables(sBase)`, `CreeTableReport(sNom)`, `ReprendEcrituresPosterieures()`,
  `CumuleReport(...)`, `GenereANouveaux()`, `DecaleParametres()` (FCLOTUREAN-006 à 010).
- Contrôle de balance : supprimer les cumuls inutilisés ; garder **exactement** l'arithmétique
  actuelle (arrondi `Format$(…, "0.00")` à chaque pas) pour `G` et `B`, car le test final
  `Val(Sgenerale) <> 0` y est sensible.
- Les 6 `INSERT INTO Fiches_Mvt` de l'étape 2 diffèrent par la liste de colonnes et la valeur de
  `numerodef` : une fonction `ReporteEcriture(r, sType)` avec une table de colonnes par type,
  SQL identique.
- Remise à zéro par compte (l. 304-307) → un seul `UPDATE … SET solde = 0` (SQL modifié, dump
  identique).

### Commonalisation avec d'autres fichiers

- **Sauvegarde** : `mysqldump` construit à la main, comme dans 16 autres endroits ; helper
  `Utils.DumpBase` proposé par [SAUVESAUTO-003](../../../Communs/SauvesAuto.module/rework.md)
  (voir aussi [`FSauve`](../../../Communs/FSauve.class/architecture.md)).
- **Copie de structure** : `DB_Connection.CopieTable` ne crée pas la table sous SQLite
  ([DB_CONNECTION-A04](../../../Utils/DB_Connection.class/rework.md)).
- **Soldes** : recalcul après clôture = `Csolde.Recalc_solde` (même SQL, espaces près) ; recalcul
  avant clôture = même boucle avec borne de date ([`Csolde`](../../../Utils/Csolde.module/architecture.md),
  [`Calcsolde`](../../../Utils/Calcsolde.class/architecture.md)).
- **Dates d'exercice** : `dteclec*` lues et découpées à la main ; [`LDate`](../../../Utils/LDate.class/architecture.md)
  fournit `EDeb`, `EFin`, `Exercice_Debut`, `Exercice_Fin`, `Exercice_Cloture(i)`. Les
  `Utils.Cdate_*` recouvrent `LDate.L`/`D` (voir notes transverses).
- **Pré-conditions** : aucune vérification de caisse connectée, de ticket Z ou de moulinage alors
  que [`Calcstock.Button2_Click`](../../../Utils/Calcstock.class/architecture.md) et
  `Moulinage.Button1_Click` les font ; un helper commun `Utils.ControlePreCloture()` servirait à
  `Calcstock`, `Validinv`, `Moulinage` et à cet écran (son ajout ici change le comportement :
  anomalie FCLOTUREAN-A09).
- **Contrôle du tunnel** avant ouverture : dupliqué dans `Fmenu.Menu46_Click`/`Menu60_Click`.
- **Clôture mensuelle** [`FCloture`](../FCloture.class/architecture.md) : même lecture de
  `Fiches_Parametres` et mêmes calculs de mois suivant.

### Réduction de portée

- `Aff_date`, `Calc_Daterpt`, `Sauve` → `Private` (aucun appelant externe, couverts par replay).

### Séparation traitement / GUI

- Extraire tout le traitement dans des fonctions sans accès aux contrôles (`datecl`, `dateprc`,
  `Me.Mouse`) ; `Calc_Daterpt` doit recevoir l'année au lieu de lire `datecl.Text`. Le handler
  garde questions, messages et barres de progression (passées en paramètre).
- À terme (hors périmètre), un module `ClotureAnnuelle` testable sans GUI.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Remplacer les 18 tables `Fiches_Mvt*`/`MvtA*`/`MvtM*` par une colonne `exercice` indexée :
  la clôture deviendrait un `UPDATE` de statut, sans `RENAME`/`DROP` ni perte de colonnes.
- Tables de travail `Report`/`ReportM` en `TEMPORARY TABLE` (ou supprimées en fin de traitement).
- Journal des clôtures (date, utilisateur, version, empreinte des tables) pour l'audit fiscal.
- Conserver `lind` et les colonnes non reprises (`control`, `lind2`, `datee`, `dteval`…) lors du
  report des écritures postérieures.
