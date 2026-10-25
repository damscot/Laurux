# ChxImp — Rework

> Source : `.src/Reports/ChxImp.class` · Message de commit (phase 4) : `reference/.src/Reports/ChxImp.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 20 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 6 |
| Complexité max (fonction) | 5 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 20 | 6 | 5 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CHXIMP-001 — [documentation] En-tête de classe en français : rôle, statut « jamais ouvert
  depuis 2016, suppression proposée (CHXIMP-A01) », lien avec `Variables.impr` · appelants :
  aucun · tests : aucun · sources : [ChxImp.class:_new](../../../../.src/Reports/ChxImp.class#L3-L21), [ChxImp.class:Button1_Click](../../../../.src/Reports/ChxImp.class#L23-L28)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CHXIMP-A01 — [anomalie] Supprimer le couple mort `ChxImp.class` + `ChxImp.form` (aucune
  ouverture dans le code ni dans l'historique depuis `e1b2d2b8`) ; avec VARIABLES-002, supprimer
  ensuite `Variables.impr` (écrit seulement ici) et le commentaire résiduel `Facturergbl:455` ·
  tests : aucun · sources : [ChxImp.class:_new](../../../../.src/Reports/ChxImp.class#L3-L21), [ChxImp.class:25](../../../../.src/Reports/ChxImp.class#L25), [Facturergbl.class:455](../../../../.src/Gestion/Facturation/Facturergbl.class#L455)
- [ ] CHXIMP-A02 — [anomalie] (si l'écran est conservé) lecture de `lpstat -p` : filtre
  `If Not InStr(…, "Rendering")` toujours vrai, `Lig[1]` hors bornes sur une ligne vide, mots
  parasites (lignes de continuation, « aucune destination »), fichier `~/tmp/resultat` jamais
  supprimé → fonction pure `ListeImprimantes` corrigée · tests : T01 · sources : [ChxImp.class:9](../../../../.src/Reports/ChxImp.class#L9), [ChxImp.class:14](../../../../.src/Reports/ChxImp.class#L14), [ChxImp.class:16](../../../../.src/Reports/ChxImp.class#L16)
