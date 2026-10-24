# FCollectif — Rework

> Source : `.src/Compta/Tables/FCollectif.class` · Message de commit (phase 4) : `reference/.src/Compta/Tables/FCollectif.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 172 |
| Lignes de commentaire | 25 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 43 |
| Complexité max (fonction) | 10 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 172 | 43 | 10 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FCOLLECTIF-001 — [documentation] En-tête en français : règles des collectifs (préfixes,
  valeurs `coll`/`cent_cc`/`solde`), contrôles de suppression · appelants : aucun · tests : aucun · sources : [FCollectif.class:Button2_Click](../../../../../.src/Compta/Tables/FCollectif.class#L197-L237), [FCollectif.class:Button1_Click](../../../../../.src/Compta/Tables/FCollectif.class#L162-L195)
- [ ] FCOLLECTIF-002 — [réarchitecture] `Cbase.Table("TabComptes")`/`Cbase.Table("TabMvt")` à la
  place des locales `Tab`/`Tab2` (SQL identique) · appelants : aucun · tests : T01-T05 · sources : [FCollectif.class:Form_Open](../../../../../.src/Compta/Tables/FCollectif.class#L44-L62), [FCollectif.class:cptman](../../../../../.src/Compta/Tables/FCollectif.class#L147-L160), [FCollectif.class:Button1_Click](../../../../../.src/Compta/Tables/FCollectif.class#L162-L195), [FCollectif.class:Button2_Click](../../../../../.src/Compta/Tables/FCollectif.class#L197-L237)
- [ ] FCOLLECTIF-003 — [séparation traitement/GUI] `EnregistreCollectif(...)` et
  `SupprimeCollectif(sCode)` sans contrôle, codes retour pour les messages ; SQL inchangé (y compris
  l'UPDATE concaténé jusqu'à A01) · appelants : aucun · tests : T01-T05 · sources : [FCollectif.class:Button1_Click](../../../../../.src/Compta/Tables/FCollectif.class#L162-L195), [FCollectif.class:Button2_Click](../../../../../.src/Compta/Tables/FCollectif.class#L197-L237)
- [ ] FCOLLECTIF-004 — [réduction de portée] `Maj_Zones`, `CleanChamps`, `Refresh`, `cptman` →
  `Private` · appelants : aucun · tests : T01-T05 · sources : [FCollectif.class:Maj_Zones](../../../../../.src/Compta/Tables/FCollectif.class#L64-L71), [FCollectif.class:CleanChamps](../../../../../.src/Compta/Tables/FCollectif.class#L73-L79), [FCollectif.class:Refresh](../../../../../.src/Compta/Tables/FCollectif.class#L81-L86), [FCollectif.class:cptman](../../../../../.src/Compta/Tables/FCollectif.class#L147-L160)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FCOLLECTIF-A01 — [anomalie] UPDATE par concaténation : un intitulé avec apostrophe provoque
  une erreur SQL ; proposition : paramètres `&1…` · tests : T03 · sources : [FCollectif.class:219](../../../../../.src/Compta/Tables/FCollectif.class#L219)
- [ ] FCOLLECTIF-A02 — [anomalie] Toute modification d'intitulé remet `solde = '0,00'` ; un
  changement de type seul est ignoré · tests : T03 · sources : [FCollectif.class:218](../../../../../.src/Compta/Tables/FCollectif.class#L218), [FCollectif.class:219](../../../../../.src/Compta/Tables/FCollectif.class#L219)
- [ ] FCOLLECTIF-A03 — [anomalie] La suppression accepte n'importe quel compte saisi (pas seulement
  un collectif) et ne contrôle les mouvements que dans `Fiches_Mvt` (ni `Mvt1-5`, ni `MvtM*`) ·
  tests : T04 · sources : [FCollectif.class:174](../../../../../.src/Compta/Tables/FCollectif.class#L174), [FCollectif.class:178](../../../../../.src/Compta/Tables/FCollectif.class#L178)
- [ ] FCOLLECTIF-A04 — [anomalie] Le message autorise `456` mais le test le refuse · tests : T02 · sources : [FCollectif.class:207](../../../../../.src/Compta/Tables/FCollectif.class#L207), [FCollectif.class:211](../../../../../.src/Compta/Tables/FCollectif.class#L211)
