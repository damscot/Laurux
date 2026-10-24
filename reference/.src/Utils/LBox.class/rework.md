# LBox — Rework

> Source : `.src/Utils/LBox.class` · Message de commit (phase 4) : `reference/.src/Utils/LBox.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 181 |
| Lignes de commentaire | 6 |
| Fonctions | 12 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 46 |
| Complexité max (fonction) | 11 (`_New`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 181 | 46 | 11 | 0 | 9 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LBOX-001 — [documentation] En-tête : tableau des modes (entrée, contrôle, sortie), contrat de
  retour de `ShowModal`, ordre des arguments du constructeur (parent de fenêtre en 3e position) ·
  appelants : aucun · tests : T01-T06 · sources : [LBox.class:_New](../../../../.src/Utils/LBox.class#L17-L80)
- [ ] LBOX-002 — [complexité] `UpdateOut` : helper privé commun aux cinq branches · appelants :
  aucun · tests : T01, T03, T04, T05 · sources : [LBox.class:UpdateOut](../../../../.src/Utils/LBox.class#L82-L126)
- [ ] LBOX-003 — [complexité] `ListSelection` et `ListInv_Click` : une seule exécution de
  l'expression et affectation directe de `Selected` · appelants : aucun · tests : T03, T06 · sources : [LBox.class:ListSelection](../../../../.src/Utils/LBox.class#L176-L215), [LBox.class:ListInv_Click](../../../../.src/Utils/LBox.class#L158-L174)
- [ ] LBOX-004 — [réduction de portée] `ListSelection` → `Private` · appelants : aucun · tests : T03 · sources : [LBox.class:ListSelection](../../../../.src/Utils/LBox.class#L176-L215)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LBOX-A01 — [anomalie] `L_Read` échoue (`Null.Copy`) si la boîte a été utilisée en mode
  texte ou annulée ; propriété inutilisée aujourd'hui · tests : aucun (latent) · sources : [LBox.class:L_Read](../../../../.src/Utils/LBox.class#L131-L135)
