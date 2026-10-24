# Changefam — Rework

> Source : `.src/Utils/Changefam.class` · Message de commit (phase 4) : `reference/.src/Utils/Changefam.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 548 |
| Lignes de commentaire | 63 |
| Fonctions | 28 |
| Fonctions Public | 28 |
| Complexité cyclomatique totale | 106 |
| Complexité max (fonction) | 14 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 548 | 106 | 14 | 0 | 28 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CHANGEFAM-001 — [documentation] En-tête en français (4 modes de traitement, tables touchées,
  verrouillage) et commentaire `'''` sur `Modifart`, `Change2`, `verrou` · appelants : aucun ·
  tests : aucun · sources : [Changefam.class:Modifart](../../../../.src/Utils/Changefam.class#L500-L555), [Changefam.class:Change2](../../../../.src/Utils/Changefam.class#L430-L460), [Changefam.class:verrou](../../../../.src/Utils/Changefam.class#L730-L734)
- [ ] CHANGEFAM-002 — [code mort] Supprimer `verifart` (jamais appelé), le `SELECT` inutilisé de
  `AjoutArt`, la variable `b` et les branches `If b = 1` / `Case 3` de `Cmpt_KeyPress`, les locales
  `Tab1..3`/`r2Result` de `Change2`, le paramètre `$hOrg` inutilisé (signature privée de fait),
  `With utils` d'`art_man` · appelants : aucun · tests : T01, T05, T10 · sources : [Changefam.class:verifart](../../../../.src/Utils/Changefam.class#L707-L728), [Changefam.class:AjoutArt](../../../../.src/Utils/Changefam.class#L164-L184), [Changefam.class:Cmpt_KeyPress](../../../../.src/Utils/Changefam.class#L52-L112), [Changefam.class:Change2](../../../../.src/Utils/Changefam.class#L430-L460), [Changefam.class:Change](../../../../.src/Utils/Changefam.class#L410-L425), [Changefam.class:art_man](../../../../.src/Utils/Changefam.class#L130-L147)
- [ ] CHANGEFAM-003 — [complexité] `Modifart` : tables et colonnes dans des tableaux constants
  parcourus en boucle, **même ordre d'émission SQL** (diff du log vide) · tests : T01, T02, T05, T08 · sources : [Changefam.class:Modifart](../../../../.src/Utils/Changefam.class#L500-L555)
- [ ] CHANGEFAM-004 — [commonalisation] `fam_Man2/3/4` → un helper privé
  `LireFamille(hSaisie, hLibelle, hSuivantOk, hSuivantKo)` ; `fam_Man` garde son comportement
  (double message) tant que CHANGEFAM-A04 n'est pas validée · tests : T04, T07, T11 · sources : [Changefam.class:fam_Man](../../../../.src/Utils/Changefam.class#L325-L339), [Changefam.class:fam_Man2](../../../../.src/Utils/Changefam.class#L345-L363), [Changefam.class:fam_Man3](../../../../.src/Utils/Changefam.class#L365-L384), [Changefam.class:fam_Man4](../../../../.src/Utils/Changefam.class#L386-L405)
- [ ] CHANGEFAM-005 — [commonalisation] Avec `Changefour` : extraire le formulaire d'import CSV
  dynamique (`Fichier_Click`, `Bouton1_Click`, `Bouton3_Click`) et la gestion de la table
  temporaire de liste (`Liste_Click`, `AjoutArt`) dans une classe commune ; les handlers restent
  dans chaque écran et délèguent · appelants : `Changefour` (même commit) · tests : T05, T08,
  CHANGEFOUR-T04, CHANGEFOUR-T06 · sources : [Changefam.class:Fichier_Click](../../../../.src/Utils/Changefam.class#L582-L626), [Changefam.class:Bouton1_Click](../../../../.src/Utils/Changefam.class#L628-L644), [Changefam.class:Bouton3_Click](../../../../.src/Utils/Changefam.class#L736-L741), [Changefam.class:Liste_Click](../../../../.src/Utils/Changefam.class#L557-L580), [Changefam.class:AjoutArt](../../../../.src/Utils/Changefam.class#L164-L184), [Changefour.class:Fichier_Click](../../../../.src/Utils/Changefour.class#L438-L482), [Changefour.class:Liste_Click](../../../../.src/Utils/Changefour.class#L416-L436)
- [ ] CHANGEFAM-006 — [séparation traitement/GUI] Extraire `ChangeFamilleGlobale(ancienne,
  nouvelle)` de `Change2` et `TraiterListe()` de `Change3`, sans accès aux contrôles ; messages et
  focus restent dans les appelants · tests : T05, T07, T12 · sources : [Changefam.class:Change2](../../../../.src/Utils/Changefam.class#L430-L460), [Changefam.class:Change3](../../../../.src/Utils/Changefam.class#L465-L498)
- [ ] CHANGEFAM-007 — [complexité] Helper privé `FinTraitement(sMessage, hFocus)` pour les 6 blocs
  son + `Message.Warning` + focus · tests : T01, T05, T07 · sources : [Changefam.class:Change](../../../../.src/Utils/Changefam.class#L410-L425), [Changefam.class:Change2](../../../../.src/Utils/Changefam.class#L430-L460), [Changefam.class:Change3](../../../../.src/Utils/Changefam.class#L465-L498)
- [ ] CHANGEFAM-008 — [réarchitecture] Remplacer les noms de table en dur par `Cbase.Table(...)`
  là où une clé existe (`TabArt`, `TabFam`, `TabHisLigFac`, `TabLigbl`…) ; même nom physique, SQL
  identique · tests : tous les replays · sources : [Changefam.class:art_man](../../../../.src/Utils/Changefam.class#L130-L147), [Changefam.class:Modifart](../../../../.src/Utils/Changefam.class#L500-L555), [Changefam.class:Change2](../../../../.src/Utils/Changefam.class#L430-L460)
- [ ] CHANGEFAM-009 — [réduction de portée] `art_man`, `AjoutArt`, `SelectionArt`, `SelectionFam`,
  `fam_Man`, `fam_Man2..4`, `Change`, `Change2`, `Change3`, `Modifart`, `verifam`, `verrou` →
  `Private` (aucun appelant externe ; couverts par les replays) · tests : tous · sources : [Changefam.class:art_man](../../../../.src/Utils/Changefam.class#L130-L147), [Changefam.class:SelectionFam](../../../../.src/Utils/Changefam.class#L243-L277), [Changefam.class:Modifart](../../../../.src/Utils/Changefam.class#L500-L555), [Changefam.class:verrou](../../../../.src/Utils/Changefam.class#L730-L734)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CHANGEFAM-A01 — [anomalie] `Bouton2_Click:672` : le contrôle du nouveau code teste
  `art_code = NFam.Text` (la famille !) et la condition est inversée (« existe déjà » si **absent**) :
  l'import par fichier ne traite quasiment aucune ligne · tests : T08 · sources : [Changefam.class:672](../../../../.src/Utils/Changefam.class#L672), [Changefam.class:Bouton2_Click](../../../../.src/Utils/Changefam.class#L646-L691)
- [ ] CHANGEFAM-A02 — [anomalie] `Bouton2_Click` : `verrou()` est appelé **avant** un `SELECT` sur
  `Fiches_Fam`, non verrouillée → erreur MySQL « Table was not locked with LOCK TABLES » ; de plus
  une ligne sans 3ᵉ champ provoque un dépassement d'indice (`Lig2[2]`) · tests : T08 · sources : [Changefam.class:657](../../../../.src/Utils/Changefam.class#L657), [Changefam.class:665](../../../../.src/Utils/Changefam.class#L665), [Changefam.class:Bouton2_Click](../../../../.src/Utils/Changefam.class#L646-L691)
- [ ] CHANGEFAM-A03 — [anomalie] `verrou()` verrouille `Rupture`/`RuptureC`, absentes tant que
  l'édition des ruptures n'a jamais été lancée : sur une base neuve (MariaDB), tous les traitements
  échouent ; et toute erreur entre `verrou()` et `UNLOCK` laisse les tables verrouillées (pas de
  `Catch`) · tests : T03, T09 · sources : [Changefam.class:732](../../../../.src/Utils/Changefam.class#L732), [Changefam.class:verrou](../../../../.src/Utils/Changefam.class#L730-L734)
- [ ] CHANGEFAM-A04 — [anomalie] `fam_Man` lit le libellé sans tester `Available` : famille inconnue
  → `Message.Error` technique **et** avertissement · tests : T04 · sources : [Changefam.class:331](../../../../.src/Utils/Changefam.class#L331), [Changefam.class:fam_Man](../../../../.src/Utils/Changefam.class#L325-L339)
- [ ] CHANGEFAM-A05 — [anomalie] `Change` n'appelle pas `verifart` : un nouveau code déjà utilisé
  provoque une erreur de clé primaire sur `Fiches_Art` en cours de traitement (mises à jour
  partielles) · tests : T03 · sources : [Changefam.class:Change](../../../../.src/Utils/Changefam.class#L410-L425), [Changefam.class:verifart](../../../../.src/Utils/Changefam.class#L707-L728)
- [ ] CHANGEFAM-A06 — [anomalie] `Cmpt_KeyPress` cas `Tag 1` : `fam_Man()` est appelé même après
  une saisie vide ou un article inconnu (message d'erreur superflu) · tests : T10 · sources : [Changefam.class:89](../../../../.src/Utils/Changefam.class#L89), [Changefam.class:Cmpt_KeyPress](../../../../.src/Utils/Changefam.class#L52-L112)
