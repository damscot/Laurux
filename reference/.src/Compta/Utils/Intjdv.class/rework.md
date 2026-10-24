# Intjdv — Rework

> Source : `.src/Compta/Utils/Intjdv.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/Intjdv.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 308 |
| Lignes de commentaire | 65 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 58 |
| Complexité max (fonction) | 11 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 308 | 58 | 11 | 0 | 14 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] INTJDV-001 — [documentation] En-tête : fenêtre **non appelée** et traitement inopérant
  (insertions commentées), renvoi vers INTJDV-A01 et vers le couple ExportJdv/ImpJdv · appelants :
  aucun · tests : aucun · sources : [Intjdv.class:Button2_Click](../../../../../.src/Compta/Utils/Intjdv.class#L329-L419)
- [ ] INTJDV-002 — [code mort] (si INTJDV-A01 est refusée) Supprimer dans `Button2_Click` les
  variables et cumuls inutilisés (`Tab`, `numero`, `montantTD`, `montantTC`) et le `SELECT` par
  ligne dont les deux branches sont vides (SQL modifié, dump identique), ainsi que `intitule` de
  `journauxman` · appelants : aucun · tests : T01 · sources : [Intjdv.class:Button2_Click](../../../../../.src/Compta/Utils/Intjdv.class#L329-L419), [Intjdv.class:journauxman](../../../../../.src/Compta/Utils/Intjdv.class#L143-L180)
- [ ] INTJDV-003 — [réduction de portée] (si INTJDV-A01 est refusée) `journauxman`, `journaux` →
  `Private` · appelants : aucun · tests : T01 · sources : [Intjdv.class:journauxman](../../../../../.src/Compta/Utils/Intjdv.class#L143-L180), [Intjdv.class:journaux](../../../../../.src/Compta/Utils/Intjdv.class#L186-L221)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] INTJDV-A01 — [anomalie] Supprimer le couple `Intjdv.class` + `Intjdv.form` : aucun appelant
  (vérifié par `grep`) et traitement sans effet (INSERT/UPDATE commentés) · tests : aucun (gbc3 +
  grep) · sources : [Intjdv.class:_new](../../../../../.src/Compta/Utils/Intjdv.class#L35-L52), [Intjdv.class:400-405](../../../../../.src/Compta/Utils/Intjdv.class#L400-L405)
- [ ] INTJDV-A02 — [anomalie] `Button2_Click` supprime et recrée la table de travail
  `centralisation`, homonyme de celle de `Jourcent` (structure différente), et ignore les dates
  saisies ; le message « Importation terminée » est trompeur · tests : T01 · sources : [Intjdv.class:356-364](../../../../../.src/Compta/Utils/Intjdv.class#L356-L364), [Intjdv.class:407](../../../../../.src/Compta/Utils/Intjdv.class#L407), [Jourcent.class:626](../../../../../.src/Compta/Impressions/Jourcent.class#L626)
