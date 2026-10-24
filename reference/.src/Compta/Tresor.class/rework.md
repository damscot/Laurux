# Tresor — Rework

> Source : `.src/Compta/Tresor.class` · Message de commit (phase 4) : `reference/.src/Compta/Tresor.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 2185 |
| Lignes de commentaire | 107 |
| Fonctions | 88 |
| Fonctions Public | 87 |
| Complexité cyclomatique totale | 579 |
| Complexité max (fonction) | 82 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 2185 | 579 | 82 | 0 | 87 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Fichier volumineux et sensible (écritures comptables, soldes, chaînage SHA1) : chaque étape est
ciblée et doit laisser le dump identique sur l'ensemble des replays T01 à T17.

- [ ] TRESOR-001 — [documentation] En-tête en français : cycle de vie d'une écriture (réservation
  du numéro, lignes provisoires, validation par suppression/réécriture, rappel), rôle des membres
  d'état (`b`, `b2`, `LF`, `cnt`, `nvlle`, `ecrA`, `Nv`, `Ext`), tables touchées ; `'''` sur les
  méthodes non-handlers · appelants : aucun · tests : T01-T17 · sources : [Tresor.class:_new](../../../../.src/Compta/Tresor.class#L78-L107), [Tresor.class:27-76](../../../../.src/Compta/Tresor.class#L27-L76)
- [ ] TRESOR-002 — [code mort] Supprimer `Maj_Zones`, `Totsl`, `FileFilter`, les membres écrits
  jamais lus (`Gntva`, `Prov`, `Vld`, `Tri`, `Montantsel`, `ecriture`, `Prg`, `n`), l'affectation
  écrasée `Ecrit1.Item[0] = cle` et les blocs commentés (`Encaisse`/`Decaisse`, anciens `UPDATE`) ·
  appelants : aucun · tests : T01-T10 · sources : [Tresor.class:Maj_Zones](../../../../.src/Compta/Tresor.class#L161-L165), [Tresor.class:Totsl](../../../../.src/Compta/Tresor.class#L761-L780), [Tresor.class:FileFilter](../../../../.src/Compta/Tresor.class#L2639-L2646), [Tresor.class:2527](../../../../.src/Compta/Tresor.class#L2527), [Tresor.class:2260-2272](../../../../.src/Compta/Tresor.class#L2260-L2272)
- [ ] TRESOR-003 — [code mort] `Enrg_Ecr` : supprimer l'`update … Where compte = &6` de la branche
  sans collectif, où `&6` vaut toujours `""` (SQL modifié, dump identique ; vérifier qu'aucune ligne
  de `Fiches_Mvt` n'a un compte vide dans les jeux de test) · appelants : aucun · tests : T01, T03 · sources : [Tresor.class:1661](../../../../.src/Compta/Tresor.class#L1661)
- [ ] TRESOR-004 — [commonalisation] Noms de tables via `Cbase.Table` : `TabMvt` pour
  `Sha1Calc.CalcSha1` (au lieu de `"Fiches_Mvt"`), `TabMvtM` (3 occurrences de `Fiches_MvtM`),
  `TabComptes`/`TabJour` dans `comptetresorerie` et `TextReg.champs` (sans changement SQL) ·
  appelants : aucun · tests : T01, T05, T06, T08 · sources : [Tresor.class:1695](../../../../.src/Compta/Tresor.class#L1695), [Tresor.class:2180](../../../../.src/Compta/Tresor.class#L2180), [Tresor.class:300](../../../../.src/Compta/Tresor.class#L300), [Tresor.class:1960](../../../../.src/Compta/Tresor.class#L1960), [Tresor.class:2079](../../../../.src/Compta/Tresor.class#L2079), [Tresor.class:comptetresorerie](../../../../.src/Compta/Tresor.class#L814-L834), [Tresor.class:88](../../../../.src/Compta/Tresor.class#L88)
- [ ] TRESOR-005 — [complexité] `Cmpt_KeyPress` (CC 82) : une fonction privée par tag et par touche
  de fonction, renvoyant `True` quand l'événement doit être stoppé ; le handler conserve le `Select
  Case Last.Tag` et les `Stop Event` (même ordre de focus et de messages) · appelants : aucun ·
  tests : T01, T11, T12, T15 · sources : [Tresor.class:Cmpt_KeyPress](../../../../.src/Compta/Tresor.class#L865-L1081)
- [ ] TRESOR-006 — [commonalisation] Déduction du type de compte par préfixe (4 copies) →
  `Private Sub Type_Depuis_Compte(compte)` ; `Type_compte` et `numcompte_LF` l'appellent ·
  appelants : aucun · tests : T01, T03, T09, T12 · sources : [Tresor.class:945-951](../../../../.src/Compta/Tresor.class#L945-L951), [Tresor.class:numcompte_LF](../../../../.src/Compta/Tresor.class#L1186-L1215), [Tresor.class:Type_compte](../../../../.src/Compta/Tresor.class#L2565-L2582), [Tresor.class:1840-1857](../../../../.src/Compta/Tresor.class#L1840-L1857)
- [ ] TRESOR-007 — [commonalisation] Petites duplications internes : `Bclient`/`Bfournisseur`/
  `Bgestion`/`Bbilan_Click` → `Choix_Type(type, condition, debit)` ; `Libutton_Click`/
  `Libutton2_Click` → `Bascule_Libelles(cible)` ; `Boutonmontant_Click`/`_KeyPress` → helper commun
  (handlers conservés) · appelants : aucun · tests : T03, T15 · sources : [Tresor.class:Bclient_Click](../../../../.src/Compta/Tresor.class#L2321-L2328), [Tresor.class:Bbilan_Click](../../../../.src/Compta/Tresor.class#L2348-L2355), [Tresor.class:Libutton_Click](../../../../.src/Compta/Tresor.class#L221-L235), [Tresor.class:Libutton2_Click](../../../../.src/Compta/Tresor.class#L237-L251), [Tresor.class:Boutonmontant_KeyPress](../../../../.src/Compta/Tresor.class#L1795-L1803)
- [ ] TRESOR-008 — [commonalisation] Largeurs de colonnes `/Col/LcolT` et `LcolTL` : helpers
  privés `Lit_Largeurs(cv, clef, n)` (`form_open`, `Lettrage`) et `Sauve_Largeurs(cv, clef, n)`
  (2 copies dans `Button1_Click`) ; même format de clé ; candidat au helper `Utils` commun avec
  `Saisecrit`, `Extrait`, `Facture`, `Archives` en phase 3 · appelants : aucun · tests : T04 · sources : [Tresor.class:form_open](../../../../.src/Compta/Tresor.class#L109-L159), [Tresor.class:566-615](../../../../.src/Compta/Tresor.class#L566-L615), [Tresor.class:Button1_Click](../../../../.src/Compta/Tresor.class#L1337-L1356)
- [ ] TRESOR-009 — [complexité] `EcritL_Click` (CC 32) : `Private Function Delta_Selection(td, tc)
  As Float` selon le type (client, fournisseur, bilan), la bascule appliquant le signe ; affichage
  identique · appelants : aucun · tests : T02, T16 · sources : [Tresor.class:EcritL_Click](../../../../.src/Compta/Tresor.class#L689-L759)
- [ ] TRESOR-010 — [commonalisation] `ecrit2`/`Ecrit3` : `Private Sub Archive_MvtM(r As Result)`
  (INSERT de 23 colonnes dupliqué) et `Private Sub Ajoute_Ligne(r As Result)` (remplissage
  d'`Ecrit1`) ; `Archive_MvtM` est candidat au helper commun avec `Saisecrit` et `FClotureAn` ·
  appelants : aucun · tests : T05, T06 · sources : [Tresor.class:1960](../../../../.src/Compta/Tresor.class#L1960), [Tresor.class:2079](../../../../.src/Compta/Tresor.class#L2079), [Tresor.class:1962-1980](../../../../.src/Compta/Tresor.class#L1962-L1980), [Tresor.class:2082-2101](../../../../.src/Compta/Tresor.class#L2082-L2101), [Saisecrit.class:2491](../../../../.src/Compta/Saisecrit.class#L2491)
- [ ] TRESOR-011 — [commonalisation] `LignAbt` : remplacer les 3 séquences `New LVar` / `AddDate`
  / `ParseResult` / `Evaluate` par le helper `LVar.Calcule` (LVAR-004) ; mêmes valeurs calculées ·
  appelants : `LVar` (prérequis LVAR-004) · tests : T10 · sources : [Tresor.class:2488-2525](../../../../.src/Compta/Tresor.class#L2488-L2525), [LVar.class:Evaluate](../../../../.src/Utils/LVar.class#L62-L78)
- [ ] TRESOR-012 — [commonalisation] Mise à jour incrémentale de solde (`SELECT solde` puis
  `UPDATE … SET solde`) dans `Enrg_Ecr` et `Ecrit3` → helper `Maj_Solde(cpt, delta)` commun avec
  `Trecarts` (TRECARTS-005) et `Saisecrit` ; mêmes requêtes et même ordre · appelants : aucun ·
  tests : T01, T03, T06 · sources : [Tresor.class:1636-1648](../../../../.src/Compta/Tresor.class#L1636-L1648), [Tresor.class:1674-1679](../../../../.src/Compta/Tresor.class#L1674-L1679), [Tresor.class:2113-2136](../../../../.src/Compta/Tresor.class#L2113-L2136), [Trecarts.class:228-233](../../../../.src/Compta/Trecarts.class#L228-L233)
- [ ] TRESOR-013 — [séparation traitement/GUI] `QuitteDate` : `Private Function Reserve_Numero() As
  Integer` qui regroupe `Ecritures("numecriture")` et `Majnum("numecriture")` (mêmes deux requêtes) ;
  `Ecritures`/`Majnum` sont supprimées si plus utilisées ; normalisation de date à sentinelle via le
  helper commun avec `Echeances` (ECHEANCES-005) · appelants : aucun · tests : T01, T11 · sources : [Tresor.class:QuitteDate](../../../../.src/Compta/Tresor.class#L1279-L1335), [Tresor.class:Ecritures](../../../../.src/Compta/Tresor.class#L508-L517), [Tresor.class:Majnum](../../../../.src/Compta/Tresor.class#L522-L526), [Echeances.class:Quittedate](../../../../.src/Compta/Echeances.class#L300-L311)
- [ ] TRESOR-014 — [séparation traitement/GUI] `Enrg_Ecr` : extraire `Ecrit_Definitif(lignes,
  journal, numero, date, banque, libelle_banque)` (lignes lues dans `Ecrit1` par l'appelant, même
  SQL dans le même ordre) ; la remise à zéro de l'écran reste dans `Enrg_Ecr` · appelants : aucun ·
  tests : T01-T03, T05, T06, T10 · sources : [Tresor.class:Enrg_Ecr](../../../../.src/Compta/Tresor.class#L1609-L1723)
- [ ] TRESOR-015 — [séparation traitement/GUI] `Ecrit3` (CC 36) : extraire `Annule_Ecriture(numero,
  banque)` (archivage `MvtM`, annulation des soldes, suppression des collectifs, délettrage, passage
  en provisoire) de l'affichage ; même SQL, même ordre · appelants : aucun · tests : T06, T07, T17 · sources : [Tresor.class:Ecrit3](../../../../.src/Compta/Tresor.class#L2012-L2195)
- [ ] TRESOR-016 — [séparation traitement/GUI] `Movt`, `DelEcr`, `DelMvt`, `DelMvt2` : passer les
  valeurs (numéro, compte, document, lot, montants…) en paramètres au lieu de lire les contrôles ;
  `DelMvt2` ne gère plus le focus (fait par `Button2_Click`) · appelants : aucun · tests : T04, T08,
  T09 · sources : [Tresor.class:Movt](../../../../.src/Compta/Tresor.class#L359-L380), [Tresor.class:DelEcr](../../../../.src/Compta/Tresor.class#L310-L330), [Tresor.class:DelMvt](../../../../.src/Compta/Tresor.class#L292-L308), [Tresor.class:DelMvt2](../../../../.src/Compta/Tresor.class#L1595-L1607)
- [ ] TRESOR-017 — [réduction de portée] → `Private` : `Lib`, `DelMvt`, `DelEcr`, `Cleanchamps`,
  `Movt`, `compte`, `compteman`, `Journauxman`, `Ecritures`, `Majnum`, `Journaux`, `Lettrage`,
  `ecritnv`, `ecritv`, `comptetresorerie`, `Journal_LF`, `Datej_LF`, `numcompte_LF`, `Montant_LF`,
  `numdoc_LF`, `datee_LF`, `QuitteDate`, `Calculsolde`, `DelMvt2`, `Enrg_Ecr`, `Recup_Type`,
  `ecrit2`, `Ecrit3`, `Clear`, `Aff_Mask`, `Deb3`, `LignAbt`, `Type_compte` (aucun appelant
  externe ; `Bsel`/`Bval`, `Ecrit_Click` et les `*_GotFocus` restent `Public`) · appelants : aucun ·
  tests : T01-T17 · sources : [Tresor.class:compteman](../../../../.src/Compta/Tresor.class#L406-L472), [Tresor.class:Enrg_Ecr](../../../../.src/Compta/Tresor.class#L1609-L1723), [Tresor.class:Ecrit3](../../../../.src/Compta/Tresor.class#L2012-L2195), [Tresor.class:LignAbt](../../../../.src/Compta/Tresor.class#L2470-L2563)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRESOR-A01 — [anomalie] `Btn_KeyPress` : **toute touche** sur `ToggleButton4` valide la ligne
  et toute touche sur `Button2` (y compris Tab) valide l'écriture · tests : T15 · sources : [Tresor.class:Btn_KeyPress](../../../../.src/Compta/Tresor.class#L1083-L1098)
- [ ] TRESOR-A02 — [anomalie] `Ecrit3` n'annule qu'un sens sur le solde du collectif (crédit pour
  un `41…`, débit sinon) alors qu'`Enrg_Ecr` applique `débit - crédit` : le solde des collectifs
  dérive à chaque modification d'une ligne « à contre-sens » (ex. remboursement client) ·
  tests : T06 · sources : [Tresor.class:2118-2136](../../../../.src/Compta/Tresor.class#L2118-L2136), [Tresor.class:1644-1647](../../../../.src/Compta/Tresor.class#L1644-L1647)
- [ ] TRESOR-A03 — [anomalie] `Ecrit3` délettre le lot sur le **compte banque** (`Cptt.Text`) alors
  que le lettrage a été posé sur le compte tiers : les factures restent lettrées après modification
  ou suppression du règlement (à confirmer) · tests : T06, T08 · sources : [Tresor.class:2174](../../../../.src/Compta/Tresor.class#L2174), [Tresor.class:1669](../../../../.src/Compta/Tresor.class#L1669)
- [ ] TRESOR-A04 — [anomalie] `DocActif.Get_lock` : résultat ignoré (modification possible d'une
  écriture verrouillée par un autre poste) ; verrou non libéré si l'on quitte sans valider ou si l'on
  supprime · tests : T07, T08, T17 · sources : [Tresor.class:2050](../../../../.src/Compta/Tresor.class#L2050), [Tresor.class:Button1_Click](../../../../.src/Compta/Tresor.class#L1337-L1356), [Tresor.class:Suppr_Click](../../../../.src/Compta/Tresor.class#L2312-L2319)
- [ ] TRESOR-A05 — [anomalie] Réservation du numéro d'écriture sans verrou (`SELECT` puis `UPDATE`) :
  doublons possibles en multi-poste ; numéro consommé même si l'écriture est abandonnée ·
  tests : T11 (mono-poste), test manuel · sources : [Tresor.class:1317-1325](../../../../.src/Compta/Tresor.class#L1317-L1325)
- [ ] TRESOR-A06 — [anomalie] Détection de la ligne banque différente entre `ecrit2` (préfixes
  `512`/`53`) et `Ecrit3` (`cde_banque` du journal) : avec un compte banque hors `512`/`53`, la ligne
  banque est rappelée comme une ligne ordinaire puis doublée à la validation · tests : T05 · sources : [Tresor.class:1961](../../../../.src/Compta/Tresor.class#L1961), [Tresor.class:2080](../../../../.src/Compta/Tresor.class#L2080)
- [ ] TRESOR-A07 — [anomalie] `Movt` écrit une ligne banque provisoire avec les montants de la ligne
  courante (et non le solde, ni le sens inverse) ; `SELECT` et `UPDATE` de cette ligne n'ont pas les
  mêmes critères : une écriture laissée en cours est déséquilibrée dans `Fiches_Mvt` · tests : T04 · sources : [Tresor.class:370-375](../../../../.src/Compta/Tresor.class#L370-L375)
- [ ] TRESOR-A08 — [anomalie] `Suppr` supprime l'écriture sans confirmation · tests : T08 · sources : [Tresor.class:Suppr_Click](../../../../.src/Compta/Tresor.class#L2312-L2319), [Tresor.class:DelMvt](../../../../.src/Compta/Tresor.class#L292-L308)
- [ ] TRESOR-A09 — [anomalie] Doublon de n° de document : la question est posée mais la réponse est
  ignorée · tests : T13 · sources : [Tresor.class:1247-1248](../../../../.src/Compta/Tresor.class#L1247-L1248)
- [ ] TRESOR-A10 — [anomalie] SQL par concaténation : `compte_cc like '<saisie>%'` dans `compteman`
  (apostrophe → erreur SQL) et `fo_code = <compte>` / `cli_code = <compte>` **sans guillemets** dans
  `Button5_Click` (code alphanumérique → erreur SQL) · tests : T12, T14 · sources : [Tresor.class:420-425](../../../../.src/Compta/Tresor.class#L420-L425), [Tresor.class:2607](../../../../.src/Compta/Tresor.class#L2607), [Tresor.class:2613](../../../../.src/Compta/Tresor.class#L2613)
- [ ] TRESOR-A11 — [anomalie] `Ecrit3` : journal inexistant → `Message.Error` + `Me.Close` mais le
  traitement continue ; le `Catch` propose de supprimer **toute l'écriture** sur n'importe quelle
  erreur · tests : T06 · sources : [Tresor.class:2066-2067](../../../../.src/Compta/Tresor.class#L2066-L2067), [Tresor.class:2186-2193](../../../../.src/Compta/Tresor.class#L2186-L2193)
- [ ] TRESOR-A12 — [anomalie] `ToggleButton4_Click` : le `Catch` affiche « écriture déjà saisie »
  pour toute erreur (message trompeur, erreur réelle masquée) · tests : T09 · sources : [Tresor.class:1518-1522](../../../../.src/Compta/Tresor.class#L1518-L1522)
- [ ] TRESOR-A13 — [anomalie] `compteman` : journal vide → message d'erreur puis poursuite du
  traitement ; précédence `And`/`Or` de la condition de lettrage à confirmer · tests : T12 · sources : [Tresor.class:411-418](../../../../.src/Compta/Tresor.class#L411-L418), [Tresor.class:444](../../../../.src/Compta/Tresor.class#L444)
- [ ] TRESOR-A14 — [anomalie] `datee_LF` normalise `Datej` (via `QuitteDate`) et non `datee` : la
  date d'échéance saisie n'est ni normalisée ni contrôlée (à confirmer) · tests : T11 · sources : [Tresor.class:datee_LF](../../../../.src/Compta/Tresor.class#L1273-L1277)
- [ ] TRESOR-A15 — [anomalie] `LignAbt` ajoute les lignes du masque dans `Ecrit1` sans écriture
  provisoire en base (contrairement à `ToggleButton4_Click`) : si l'on quitte, ces lignes sont
  perdues alors que le message annonce une écriture « non validée » · tests : T10 · sources : [Tresor.class:LignAbt](../../../../.src/Compta/Tresor.class#L2470-L2563)
