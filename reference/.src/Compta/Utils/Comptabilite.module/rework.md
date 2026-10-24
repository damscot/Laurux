# Comptabilite — Rework

> Source : `.src/Compta/Utils/Comptabilite.module` · Message de commit (phase 4) : `reference/.src/Compta/Utils/Comptabilite.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 6 |
| Lignes de commentaire | 1 |
| Fonctions | 0 |
| Fonctions Public | 0 |
| Complexité cyclomatique totale | 0 |
| Complexité max (fonction) | 0 |
| Variables globales | 6 |
| Variables Public | 6 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 6 | 0 | 0 | 6 | 0 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] COMPTABILITE-001 — [documentation] En-tête : protocole d'échange `TriEcritures` →
  `Saisecrit`/`Tresor`, rôle de chaque variable · appelants : aucun · tests : T01, T02 · sources : [Comptabilite.module:3](../../../../../.src/Compta/Utils/Comptabilite.module#L3)
- [ ] COMPTABILITE-002 — [code mort] Supprimer `sdesg` (aucun usage hors commentaires) ·
  appelants : aucun · tests : T01, T02 · sources : [Comptabilite.module:5](../../../../../.src/Compta/Utils/Comptabilite.module#L5)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] COMPTABILITE-A01 — [anomalie] `TresorFac.compte` lit `Comptabilite.Bsel`/`sCmpt` alors que
  `TriCpt` écrit `Bsel`/`Bval` sur la fenêtre appelante ; `sCmpt` n'est jamais renseignée (toujours
  `""`). Classe `TresorFac` apparemment morte : à traiter dans son lot (suppression ou
  correction) · tests : aucun · sources : [TresorFac.class:193](../../../../../.src/Gestion/Reglements/TresorFac.class#L193), [TriEcritures.class:19](../../../../../.src/Affichages/TriEcritures.class#L19)
