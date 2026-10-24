# FClotureAn — Rework

> Source : `.src/Compta/Clotures/FClotureAn.class` · Message de commit (phase 4) : `reference/.src/Compta/Clotures/FClotureAn.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 583 |
| Lignes de commentaire | 39 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 88 |
| Complexité max (fonction) | 74 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 583 | 88 | 74 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FCLOTUREAN-001 — [documentation] En-tête en français : sens de `dteclec*`/`dtepc`, séquence
  des étapes, tables touchées, absence de transaction, prérequis (sauvegarde, périodes
  clôturées) ; correction du commentaire « date debut exo » de `datec2` · appelants : aucun ·
  tests : aucun · sources : [FClotureAn.class:32-33](../../../../../.src/Compta/Clotures/FClotureAn.class#L32-L33), [FClotureAn.class:Button1_Click](../../../../../.src/Compta/Clotures/FClotureAn.class#L120-L651)
- [ ] FCLOTUREAN-002 — [code mort] Supprimer les 15 cumuls de balance jamais lus (`Dclient`,
  `Cclient`, `Sclient`, `Dfournisseur`…, `Dbclient`…, `Dbfournisseur`…), `Type`, `Intit`, `num`,
  `b` et le `SELECT` inutilisé de la l. 586 (SQL modifié : un `SELECT`
  en moins, dump identique) · appelants : aucun · tests : T01, T02 ·
  sources : [FClotureAn.class:192-212](../../../../../.src/Compta/Clotures/FClotureAn.class#L192-L212), [FClotureAn.class:237-247](../../../../../.src/Compta/Clotures/FClotureAn.class#L237-L247), [FClotureAn.class:261-271](../../../../../.src/Compta/Clotures/FClotureAn.class#L261-L271), [FClotureAn.class:561](../../../../../.src/Compta/Clotures/FClotureAn.class#L561), [FClotureAn.class:586](../../../../../.src/Compta/Clotures/FClotureAn.class#L586)
- [ ] FCLOTUREAN-003 — [code mort] Supprimer les `UPDATE Fiches_Comptes … where compte_cc = Compt`
  des l. 479 et 510 (variable `Compt` périmée, effet écrasé par la remise à zéro l. 587 et le
  recalcul) et la purge `delete FROM Fiches_MvtM where dte <= …` (table recréée vide, seules des
  lignes postérieures y sont insérées) ; SQL modifié, dump identique · appelants : aucun ·
  tests : T01, T04, T05 · sources : [FClotureAn.class:479](../../../../../.src/Compta/Clotures/FClotureAn.class#L479), [FClotureAn.class:510](../../../../../.src/Compta/Clotures/FClotureAn.class#L510), [FClotureAn.class:626](../../../../../.src/Compta/Clotures/FClotureAn.class#L626)
- [ ] FCLOTUREAN-004 — [commonalisation] Recalcul des soldes après clôture (l. 584-615) par
  `Csolde.Recalc_solde` (même SQL, espaces près ; un seul `UPDATE … solde = 0` conservé) ·
  appelants : aucun · tests : T01, T06 · sources : [FClotureAn.class:584-615](../../../../../.src/Compta/Clotures/FClotureAn.class#L584-L615), [Csolde.module:Recalc_solde](../../../../../.src/Utils/Csolde.module#L11-L28)
- [ ] FCLOTUREAN-005 — [commonalisation] Recalcul avant clôture (l. 302-336) par une variante
  `Csolde.Recalc_solde(sDateMax)` (paramètre optionnel ajouté à `Csolde`, comportement par défaut
  inchangé) ; remise à zéro par compte → un seul `UPDATE … SET solde = 0` (SQL modifié, dump
  identique) · appelants : `Csolde` (paramètre optionnel, appelants inchangés) · tests : T01 ·
  sources : [FClotureAn.class:302-336](../../../../../.src/Compta/Clotures/FClotureAn.class#L302-L336), [Csolde.module:Solde_caisse](../../../../../.src/Utils/Csolde.module#L30-L63)
- [ ] FCLOTUREAN-006 — [commonalisation] Rotation des tables : helper privé `DecaleTables(sBase)`
  appelé pour `Fiches_Mvt`, `Fiches_MvtA`, `Fiches_MvtM` (SQL identique, ordre identique) ·
  appelants : aucun · tests : T01, T06 · sources : [FClotureAn.class:339-371](../../../../../.src/Compta/Clotures/FClotureAn.class#L339-L371)
- [ ] FCLOTUREAN-007 — [commonalisation] DDL `Report`/`ReportM` identiques → helper privé
  `CreeTableReport(sNom)` (SQL identique) · appelants : aucun · tests : T01 ·
  sources : [FClotureAn.class:374-435](../../../../../.src/Compta/Clotures/FClotureAn.class#L374-L435)
- [ ] FCLOTUREAN-008 — [commonalisation] Sauvegarde par `Utils.DumpBase` (SAUVESAUTO-003), ligne
  de commande et fichiers identiques ; `Sauve` renvoie un booléen sans changer l'enchaînement
  actuel · appelants : aucun · tests : T09, T10 · sources : [FClotureAn.class:Sauve](../../../../../.src/Compta/Clotures/FClotureAn.class#L653-L675), [SauvesAuto.module:19](../../../../../.src/Communs/SauvesAuto.module#L19)
- [ ] FCLOTUREAN-009 — [complexité] Étape 2 : `ReporteEcriture(r, sType)` (table des colonnes par
  type, même SQL) et `CumuleReport(sCompte, r, sIntitule)` pour les trois cumuls `Report`
  (C/F, B, G→`980000`) ; CC 74 → ≤ 25 visé pour `Button1_Click` · appelants : aucun ·
  tests : T01, T04, T07 · sources : [FClotureAn.class:464-551](../../../../../.src/Compta/Clotures/FClotureAn.class#L464-L551)
- [ ] FCLOTUREAN-010 — [complexité] Contrôle de balance extrait dans `ControleBalance() As String`
  (cumuls `G` et `B` seulement, **même arithmétique** : `Format$(…, "0.00")` à chaque pas) ·
  appelants : aucun · tests : T01, T02 · sources : [FClotureAn.class:217-283](../../../../../.src/Compta/Clotures/FClotureAn.class#L217-L283)
- [ ] FCLOTUREAN-011 — [séparation traitement/GUI] Extraire les étapes 1 à 3 dans des fonctions
  privées sans accès aux contrôles (`datecl`, `dateprc`, `Me.Mouse`) ; `Calc_Daterpt` reçoit
  l'année au lieu de lire `datecl.Text` ; le handler garde questions, messages et `ProgBar` ·
  appelants : aucun · tests : T01-T11, T13 · sources : [FClotureAn.class:Button1_Click](../../../../../.src/Compta/Clotures/FClotureAn.class#L120-L651), [FClotureAn.class:Calc_Daterpt](../../../../../.src/Compta/Clotures/FClotureAn.class#L98-L112)
- [ ] FCLOTUREAN-012 — [commonalisation] Dates d'exercice via `LDate` (`Exercice_Fin`,
  `Exercice_Cloture`, `FinMois`) au lieu de `Left`/`Mid`/`Utils.Cdate_*` ; valeurs écrites
  identiques · appelants : aucun · tests : T01, T13 · sources : [FClotureAn.class:Form_Open](../../../../../.src/Compta/Clotures/FClotureAn.class#L53-L82), [FClotureAn.class:Aff_date](../../../../../.src/Compta/Clotures/FClotureAn.class#L84-L96), [LDate.class:Exercice_Cloture](../../../../../.src/Utils/LDate.class#L648-L672)
- [ ] FCLOTUREAN-013 — [commonalisation] Noms de tables par `Cbase.Table` (`TabMvt`, `TabMvt1`…,
  `TabMvtA*`, `TabParam`, `TabComptes`) et argument de `Sha1Calc.CalcSha1_all` (SQL identique) ·
  appelants : aucun · tests : T01 · sources : [FClotureAn.class:177-185](../../../../../.src/Compta/Clotures/FClotureAn.class#L177-L185), [FClotureAn.class:339-350](../../../../../.src/Compta/Clotures/FClotureAn.class#L339-L350), [FClotureAn.class:631](../../../../../.src/Compta/Clotures/FClotureAn.class#L631)
- [ ] FCLOTUREAN-014 — [réduction de portée] `Aff_date`, `Calc_Daterpt`, `Sauve` → `Private` ·
  appelants : aucun · tests : T01, T09 · sources : [FClotureAn.class:Aff_date](../../../../../.src/Compta/Clotures/FClotureAn.class#L84-L96), [FClotureAn.class:Calc_Daterpt](../../../../../.src/Compta/Clotures/FClotureAn.class#L98-L112), [FClotureAn.class:Sauve](../../../../../.src/Compta/Clotures/FClotureAn.class#L653-L675)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FCLOTUREAN-A01 — [anomalie] **Sauvegarde impossible mais clôture poursuivie** : `Sauve`
  affiche l'erreur et fait `Me.Close`, puis `Button1_Click` continue toute la clôture sans
  sauvegarde · tests : T10 · sources : [FClotureAn.class:300](../../../../../.src/Compta/Clotures/FClotureAn.class#L300), [FClotureAn.class:670-672](../../../../../.src/Compta/Clotures/FClotureAn.class#L670-L672)
- [ ] FCLOTUREAN-A02 — [anomalie] `Sauve` : si la compression échoue, `Move` puis `Kill` du
  fichier déjà déplacé (erreur non interceptée) ; mot de passe visible dans `ps`, port et tunnel
  SSH ignorés · tests : T09 · sources : [FClotureAn.class:663](../../../../../.src/Compta/Clotures/FClotureAn.class#L663), [FClotureAn.class:665-669](../../../../../.src/Compta/Clotures/FClotureAn.class#L665-L669)
- [ ] FCLOTUREAN-A03 — [anomalie] SQLite non supporté : `mysqldump` (A01 → clôture sans
  sauvegarde), `ALTER TABLE x Rename y` sans `TO` (syntaxe SQLite, à confirmer), `CopieTable` qui
  ne crée pas la table (DB_CONNECTION-A04) ; la base est détruite. Bloquer la clôture sous
  SQLite ou corriger les trois points · tests : T12 · sources : [FClotureAn.class:351-371](../../../../../.src/Compta/Clotures/FClotureAn.class#L351-L371), [DB_Connection.class:CopieTable](../../../../../.src/Utils/DB_Connection.class#L646-L654)
- [ ] FCLOTUREAN-A04 — [anomalie] Report des écritures postérieures : colonnes perdues (tous types :
  `control`, `lind2` ; C/F en plus : `datee`, `dteval`, `relance`, `export` ; G en plus : `nrlv`,
  `dateech`, `datee`, `dteval`, `relance`, `export`), `lind` renuméroté, `lettree` forcé à 0 pour G, `validee` à 0
  pour C/F/B puis à 1 (A06) · tests : T04 · sources : [FClotureAn.class:475](../../../../../.src/Compta/Clotures/FClotureAn.class#L475), [FClotureAn.class:515](../../../../../.src/Compta/Clotures/FClotureAn.class#L515), [FClotureAn.class:539](../../../../../.src/Compta/Clotures/FClotureAn.class#L539)
- [ ] FCLOTUREAN-A05 — [anomalie] Écriture postérieure sur un compte absent de `Fiches_Comptes`
  ou de type hors C/F/B/G : non reprise dans le nouvel exercice (reste dans `Fiches_Mvt1`) ;
  aucune alerte · tests : T07 · sources : [FClotureAn.class:470-472](../../../../../.src/Compta/Clotures/FClotureAn.class#L470-L472)
- [ ] FCLOTUREAN-A06 — [anomalie] `UPDATE Fiches_Mvt SET validee = 1` sans filtre : les
  écritures provisoires déjà saisies sur le nouvel exercice deviennent validées (intention à
  confirmer) · tests : T08 · sources : [FClotureAn.class:591](../../../../../.src/Compta/Clotures/FClotureAn.class#L591)
- [ ] FCLOTUREAN-A07 — [anomalie] Tables de travail `Report` et `ReportM` laissées dans la base ;
  `ReportM` jamais utilisée (sa suppression change le dump) · tests : T01 ·
  sources : [FClotureAn.class:405-435](../../../../../.src/Compta/Clotures/FClotureAn.class#L405-L435)
- [ ] FCLOTUREAN-A08 — [anomalie] Incohérence de bornes : la balance de contrôle prend
  `dte >= datec2` (fin de l'exercice précédent incluse), la clôture `dte > datec2` (à confirmer) ·
  tests : T02 · sources : [FClotureAn.class:228](../../../../../.src/Compta/Clotures/FClotureAn.class#L228), [FClotureAn.class:484](../../../../../.src/Compta/Clotures/FClotureAn.class#L484)
- [ ] FCLOTUREAN-A09 — [anomalie] Aucune pré-condition métier : ni caisses connectées, ni ticket
  Z, ni moulinage, ni autres postes en saisie ; fenêtre **non modale** (`Fmenu.class:851`), d'autres
  écrans restent utilisables pendant la clôture. Proposition : helper commun avec `Calcstock` et
  `Moulinage` · tests : T01 · sources : [FClotureAn.class:Button1_Click](../../../../../.src/Compta/Clotures/FClotureAn.class#L120-L651), [Fmenu.class:851](../../../../../.src/Communs/Fmenu.class#L851), [Calcstock.class:Button2_Click](../../../../../.src/Utils/Calcstock.class#L50-L111), [Moulinage.class:Button1_Click](../../../../../.src/Caisse/Moulinage.class#L71-L104)
- [ ] FCLOTUREAN-A10 — [anomalie] `Form_Open` lit `Fiches_Parametres` sans test `Available` et
  `Aff_date` formate `datec3` avant son calcul (l. 67 vs l. 73) ; table vide → erreur
  non interceptée (à confirmer) · tests : manuel · sources : [FClotureAn.class:61-73](../../../../../.src/Compta/Clotures/FClotureAn.class#L61-L73), [FClotureAn.class:92](../../../../../.src/Compta/Clotures/FClotureAn.class#L92)
