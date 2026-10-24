# Lettragesoldes — Rework

> Source : `.src/Compta/Lettrages/Lettragesoldes.class` · Message de commit (phase 4) : `reference/.src/Compta/Lettrages/Lettragesoldes.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 68 |
| Lignes de commentaire | 22 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 7 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 68 | 14 | 7 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LETTRAGESOLDES-001 — [documentation] En-tête en français : règle réelle (solde global = 0,
  lot de la première ligne, lot `S`), tables touchées, absence de confirmation · appelants : aucun ·
  tests : aucun · sources : [Lettragesoldes.class:Button2_Click](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L68-L109)
- [ ] LETTRAGESOLDES-002 — [code mort] Supprimer `clear` et les membres `TT`/`TD`/`TC` ; `Tab2`
  devient locale · appelants : aucun · tests : T01-T03 · sources : [Lettragesoldes.class:clear](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L60-L66), [Lettragesoldes.class:28](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L28)
- [ ] LETTRAGESOLDES-003 — [complexité] UPDATE exécuté une fois par compte, puis `CalcSha1` une fois
  par `numero` distinct — SQL modifié, dump identique · appelants : aucun · tests : T01-T03 · sources : [Lettragesoldes.class:96-99](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L96-L99)
- [ ] LETTRAGESOLDES-004 — [réarchitecture] `Cbase.Table("TabComptes")` / `Cbase.Table("TabMvt")`, y
  compris pour `Sha1Calc.CalcSha1` (SQL identique) · appelants : aucun · tests : T01 · sources : [Lettragesoldes.class:78](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L78), [Lettragesoldes.class:79](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L79), [Lettragesoldes.class:98](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L98)
- [ ] LETTRAGESOLDES-005 — [séparation traitement/GUI] `LettrerComptesSoldes(sType) As Integer`
  sans contrôle ; `Button2_Click` garde curseur, son et message · appelants : aucun · tests : T01-T04 · sources : [Lettragesoldes.class:Button2_Click](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L68-L109)
- [ ] LETTRAGESOLDES-006 — [commonalisation] Module commun avec `Lettragemontant` (boucle sur les
  comptes d'un type, application d'un lot, SHA1), à réaliser dans le même commit que
  LETTRAGEMONTANT-006 · appelants : aucun · tests : T01-T04, LETTRAGEMONTANT-T01 à T05 · sources : [Lettragesoldes.class:Button2_Click](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L68-L109), [Lettragemontant.class:Button2_Click](../../../../../.src/Compta/Lettrages/Lettragemontant.class#L68-L146)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LETTRAGESOLDES-A01 — [anomalie] L'UPDATE ne lettre que les lignes dont le lot égale celui de
  la première ligne non lettrée ; si ce lot est `NULL`, rien n'est lettré mais le compte est compté
  dans le message · tests : T03 · sources : [Lettragesoldes.class:93](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L93), [Lettragesoldes.class:97](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L97)
- [ ] LETTRAGESOLDES-A02 — [anomalie] Seul `Fiches_Comptes.solde = 0` est testé (égalité Float) :
  aucun contrôle que les lignes non lettrées s'équilibrent, aucun filtre `validee`/`provisoire`,
  `Fiches_Mvt1-5` ignorées · tests : T03 · sources : [Lettragesoldes.class:87](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L87), [Lettragesoldes.class:91](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L91)
- [ ] LETTRAGESOLDES-A03 — [anomalie] Lot `"S" & Right$(num, 9)` commun (`"S"`) à tous les comptes
  dont la première ligne n'a pas de lot · tests : T03 · sources : [Lettragesoldes.class:94](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L94)
- [ ] LETTRAGESOLDES-A04 — [anomalie] Le bouton d'aide ouvre la page `Lettragemontant` (à confirmer :
  page dédiée absente ou erreur de copie) · tests : aucun · sources : [Lettragesoldes.class:Button1_Click](../../../../../.src/Compta/Lettrages/Lettragesoldes.class#L111-L115)
