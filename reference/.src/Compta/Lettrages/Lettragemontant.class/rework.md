# Lettragemontant — Rework

> Source : `.src/Compta/Lettrages/Lettragemontant.class` · Message de commit (phase 4) : `reference/.src/Compta/Lettrages/Lettragemontant.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 104 |
| Lignes de commentaire | 23 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 23 |
| Complexité max (fonction) | 16 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 104 | 23 | 16 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LETTRAGEMONTANT-001 — [documentation] En-tête en français : algorithme réel (première ligne
  non lettrée, deux passes, lot `M`), tables touchées, absence de confirmation · appelants : aucun ·
  tests : aucun · sources : [Lettragemontant.class:Button2_Click](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L68-L146)
- [ ] LETTRAGEMONTANT-002 — [code mort] Supprimer `clear`, les membres `TT`/`TD`/`TC`, `TotE`, le
  commentaire `'ENDIF` ; `Tab2` devient locale · appelants : aucun · tests : T01-T04 · sources : [Lettragemontant.class:clear](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L60-L66), [Lettragemontant.class:28](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L28), [Lettragemontant.class:132](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L132)
- [ ] LETTRAGEMONTANT-003 — [complexité] UPDATE exécuté une fois par groupe, puis `CalcSha1` une
  fois par `numero` distinct, `B` inchangé (nombre de lignes du groupe) — SQL modifié, dump
  identique · appelants : aucun · tests : T01-T04 · sources : [Lettragemontant.class:123-127](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L123-L127)
- [ ] LETTRAGEMONTANT-004 — [commonalisation] Fonction privée `EcrituresMontant(sCompte, fMnt)`
  pour la requête dupliquée trois fois (SQL identique) · appelants : aucun · tests : T01-T03 · sources : [Lettragemontant.class:104](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L104), [Lettragemontant.class:108](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L108), [Lettragemontant.class:120](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L120)
- [ ] LETTRAGEMONTANT-005 — [réarchitecture] `Cbase.Table("TabComptes")` / `Cbase.Table("TabMvt")`
  pour les noms en dur, y compris l'argument de `Sha1Calc.CalcSha1` (SQL identique) · appelants :
  aucun · tests : T01 · sources : [Lettragemontant.class:86](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L86), [Lettragemontant.class:87](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L87), [Lettragemontant.class:126](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L126)
- [ ] LETTRAGEMONTANT-006 — [séparation traitement/GUI] `LettrerParMontant(sType) As Integer`
  sans accès aux contrôles ; `Button2_Click` garde curseur, son et message · appelants : aucun ·
  tests : T01-T05 · sources : [Lettragemontant.class:Button2_Click](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L68-L146)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LETTRAGEMONTANT-A01 — [anomalie] Montant de référence nul (première ligne au crédit pour un
  client, au débit pour un fournisseur) : le filtre `montantd = 0 or montantc = 0` sélectionne
  presque toutes les lignes non lettrées du compte, qui sont lettrées ensemble si elles s'équilibrent
  (lettrage « par solde » et non « par montant ») · tests : T03 · sources : [Lettragemontant.class:102](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L102), [Lettragemontant.class:104](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L104)
- [ ] LETTRAGEMONTANT-A02 — [anomalie] Si la condition `montantd <> ""` échoue, `EcrResult` et
  `Mnt` gardent les valeurs du compte précédent (ou `Null` → erreur au premier compte) ·
  tests : T03 · sources : [Lettragemontant.class:102-110](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L102-L110)
- [ ] LETTRAGEMONTANT-A03 — [anomalie] Lot `"M" & Right$(num, 9)` : vaut `"M"` pour toutes les
  écritures sans lot ; tous les groupes lettrés partagent le même lot (indiscernables pour
  `Listextcpt.rechechelot`) · tests : T03 · sources : [Lettragemontant.class:122](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L122)
- [ ] LETTRAGEMONTANT-A04 — [anomalie] Au plus deux groupes lettrés par compte et par lancement
  (`For i = 1 To 2`) ; égalité stricte `Tote = 0` sur des Float ; seules les écritures de
  `Fiches_Mvt` sont traitées · tests : T03 · sources : [Lettragemontant.class:98](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L98), [Lettragemontant.class:119](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L119)
