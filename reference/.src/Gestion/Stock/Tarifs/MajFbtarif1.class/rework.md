# MajFbtarif1 — Rework

> Source : `.src/Gestion/Stock/Tarifs/MajFbtarif1.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Tarifs/MajFbtarif1.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 161 |
| Lignes de commentaire | 11 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 43 |
| Complexité max (fonction) | 21 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 161 | 43 | 21 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MAJFBTARIF1-001 — [documentation] En-tête de classe en français indiquant que l'écran
  n'est ouvert par aucun menu (remplacé par l'option `MajFtbt` d'`Impart`) et renvoyant à
  MAJFBTARIF1-A01 ; à ne faire que si A01 est refusée · appelants : aucun · tests : T01 ·
  sources : [MajFbtarif1.class:_new](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif1.class#L5-L11)
- [ ] MAJFBTARIF1-002 — [code mort] Variable locale `Intitule` de `Button2_Click` affectée mais
  jamais lue (sans changement SQL) ; à ne faire que si A01 est refusée · appelants : aucun ·
  tests : T01 · sources : [MajFbtarif1.class:Button2_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif1.class#L122-L192)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MAJFBTARIF1-A01 — [anomalie] Écran inaccessible (aucune référence hors du fichier, menu
  « Future base tarif » limité à `MajFbtarif2` et `Etiqfbtarif`) : supprimer le couple
  `MajFbtarif1.class` + `MajFbtarif1.form` (dérogation « .form intouchable », validation au cas
  par cas) · tests : T01 · sources : [MajFbtarif1.class:_new](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif1.class#L5-L11), [MajFbtarif1.class:Button2_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif1.class#L122-L192)
- [ ] MAJFBTARIF1-A02 — [anomalie] (seulement si l'écran est conservé) Mode centrale : un
  code-barre vide (longueur ≠ 13) sélectionne un article quelconque de la centrale sans code-barre, dont `art_pbfbt` est alors
  écrasé · tests : T01 · sources : [MajFbtarif1.class:171](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif1.class#L171), [MajFbtarif1.class:172](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif1.class#L172)
