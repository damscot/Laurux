# Psms — Rework

> Source : `.src/Gestion/SMS/Psms.class` · Message de commit (phase 4) : `reference/.src/Gestion/SMS/Psms.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 51 |
| Lignes de commentaire | 1 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 13 |
| Complexité max (fonction) | 5 (`api_LostFocus`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 51 | 13 | 5 | 0 | 6 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] PSMS-001 — [documentation] En-tête signalant le formulaire inaccessible, la table
  `Fiches_Psms` inexistante et le paramétrage réel dans `Prefs` (`/Soc<XX>/Support`…) ·
  appelants : aucun · tests : T01 · sources : [Psms.class:Form_Open](../../../../../.src/Gestion/SMS/Psms.class#L5-L16)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] PSMS-A01 — [anomalie] Couple `Psms.class` + `Psms.form` mort : aucun point d'entrée et table
  `Fiches_Psms` inexistante ; suppression proposée (décision utilisateur) · tests : T01 ·
  sources : [Psms.class:Form_Open](../../../../../.src/Gestion/SMS/Psms.class#L5-L16), [Psms.class:Button3_Click](../../../../../.src/Gestion/SMS/Psms.class#L43-L54)
- [ ] PSMS-A02 — [anomalie] Si le formulaire est conservé : `UPdate … WHERE lind = &5` sans
  5ᵉ argument, `Truncate Table` non supporté par SQLite, table nommée en dur sans `Cbase`, clé
  API Spot-Hit en HTTP clair et sur la ligne de commande · tests : T01 ·
  sources : [Psms.class:48](../../../../../.src/Gestion/SMS/Psms.class#L48), [Psms.class:59](../../../../../.src/Gestion/SMS/Psms.class#L59), [Psms.class:24](../../../../../.src/Gestion/SMS/Psms.class#L24)
