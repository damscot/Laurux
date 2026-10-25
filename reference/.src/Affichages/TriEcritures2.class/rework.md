# TriEcritures2 — Rework

> Source : `.src/Affichages/TriEcritures2.class` · Message de commit (phase 4) : `reference/.src/Affichages/TriEcritures2.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 520 |
| Lignes de commentaire | 2 |
| Fonctions | 59 |
| Fonctions Public | 59 |
| Complexité cyclomatique totale | 176 |
| Complexité max (fonction) | 11 (`Ecrit_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 520 | 176 | 11 | 0 | 59 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Ces étapes ne s'appliquent que si l'anomalie TRIECRITURES2-A01 (suppression) est **refusée**.

- [ ] TRIECRITURES2-001 — [documentation] En-tête signalant que la classe n'est appelée nulle part et
  renvoyant à `TriEcritures` · appelants : aucun · tests : T01 · sources : [TriEcritures2.class:_new](../../../../.src/Affichages/TriEcritures2.class#L13-L35)
- [ ] TRIECRITURES2-002 — [code mort] Supprimer `Debe1`, `Debe2`, `Debe3`, `Debe4` (jamais appelées,
  vérifié) · appelants : aucun · tests : T01 · sources : [TriEcritures2.class:Debe1](../../../../.src/Affichages/TriEcritures2.class#L649-L654), [TriEcritures2.class:Debe2](../../../../.src/Affichages/TriEcritures2.class#L656-L661), [TriEcritures2.class:Debe3](../../../../.src/Affichages/TriEcritures2.class#L663-L668), [TriEcritures2.class:Debe4](../../../../.src/Affichages/TriEcritures2.class#L670-L675)
- [ ] TRIECRITURES2-003 — [réduction de portée] `Entete`, `Dbclk2`, `Tris2`, `Deplacement`, `Debn1`, `Debn2`, `Debn3`, `Debn4` → `Private` (aucun appelant) · appelants : aucun · tests : T01 · sources : [TriEcritures2.class:Entete](../../../../.src/Affichages/TriEcritures2.class#L37-L48), [TriEcritures2.class:Deplacement](../../../../.src/Affichages/TriEcritures2.class#L638-L647), [TriEcritures2.class:Debn1](../../../../.src/Affichages/TriEcritures2.class#L677-L682)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRIECRITURES2-A01 — [anomalie] Classe morte : supprimer le couple `TriEcritures2.class` +
  `TriEcritures2.form` (jamais référencée depuis l'import du dépôt en 2016 ; copie à 88 % de
  `TriEcritures` sans filtres `cloturee`/`pointee`) ; mettre à jour en même temps la doc de
  `Comptabilite` (tableau des écrivains) · tests : T01 · sources : [TriEcritures2.class:_new](../../../../.src/Affichages/TriEcritures2.class#L13-L35), [TriEcritures2.class:Ecrit_Click](../../../../.src/Affichages/TriEcritures2.class#L547-L555), [TriEcritures.class:_new](../../../../.src/Affichages/TriEcritures.class#L15-L37)
