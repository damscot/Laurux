# Equilibrage — Rework

> Source : `.src/Compta/Utils/Equilibrage.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/Equilibrage.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 55 |
| Lignes de commentaire | 30 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 11 |
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
| initial | `6b6b9dfc` | 2026-10-24 | 55 | 11 | 7 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EQUILIBRAGE-001 — [documentation] En-tête : journal traité, règle de correction (dernière
  ligne), limites (clé et soldes non recalculés), accès par `Prgm` · appelants : aucun · tests :
  aucun · sources : [Equilibrage.class:_New](../../../../../.src/Compta/Utils/Equilibrage.class#L30-L36)
- [ ] EQUILIBRAGE-002 — [complexité] Cumuls en `Float`, constante pour le journal `"70"`,
  `Cbase.Table("TabMvt")` (SQL et dump identiques) · appelants : aucun · tests : T01, T02 ·
  sources : [Equilibrage.class:Button2_Click](../../../../../.src/Compta/Utils/Equilibrage.class#L58-L102)
- [ ] EQUILIBRAGE-003 — [séparation traitement/GUI] `Reequilibre(journal)` privé sans contrôle ;
  `Button2_Click` garde souris, son et message · appelants : aucun · tests : T01, T02 · sources :
  [Equilibrage.class:Button2_Click](../../../../../.src/Compta/Utils/Equilibrage.class#L58-L102)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EQUILIBRAGE-A01 — [anomalie] La dernière écriture du journal n'est jamais contrôlée (pas de
  traitement après la boucle) · tests : T01 · sources : [Equilibrage.class:76-92](../../../../../.src/Compta/Utils/Equilibrage.class#L76-L92)
- [ ] EQUILIBRAGE-A02 — [anomalie] `montantc` modifié sans recalcul de la clé `control`
  (`Sha1Calc`) ni du solde des comptes : rupture de la chaîne d'intégrité · tests : T01 · sources :
  [Equilibrage.class:81](../../../../../.src/Compta/Utils/Equilibrage.class#L81)
- [ ] EQUILIBRAGE-A03 — [anomalie] Écriture sans crédit jamais corrigée ; `UPDATE` sur `compte` +
  `numero` modifie toutes les lignes du même compte dans l'écriture ; journal `"70"` en dur · tests :
  T01 · sources : [Equilibrage.class:72](../../../../../.src/Compta/Utils/Equilibrage.class#L72), [Equilibrage.class:78](../../../../../.src/Compta/Utils/Equilibrage.class#L78), [Equilibrage.class:81](../../../../../.src/Compta/Utils/Equilibrage.class#L81)
