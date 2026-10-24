# ImpDepots — Rework

> Source : `.src/Gestion/Depots/ImpDepots.class` · Message de commit (phase 4) : `reference/.src/Gestion/Depots/ImpDepots.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 135 |
| Lignes de commentaire | 2 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 30 |
| Complexité max (fonction) | 11 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 135 | 30 | 11 | 0 | 10 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IMPDEPOTS-001 — [documentation] En-tête (absent) : rôle, modes chiffré/non chiffré,
  exclusion du dépôt `01` de la liste, absence d'instrumentation `Utils.Observers` · appelants :
  aucun · tests : aucun · sources : [ImpDepots.class:_new](../../../../../.src/Gestion/Depots/ImpDepots.class#L9-L19), [ImpDepots.class:aff_Depot](../../../../../.src/Gestion/Depots/ImpDepots.class#L34-L48)
- [ ] IMPDEPOTS-002 — [code mort] Supprimer `Coulfond` (affecté, jamais lu) et le `Shell "cd …"` ·
  appelants : aucun · tests : T01 · sources : [ImpDepots.class:12](../../../../../.src/Gestion/Depots/ImpDepots.class#L12), [ImpDepots.class:109](../../../../../.src/Gestion/Depots/ImpDepots.class#L109)
- [ ] IMPDEPOTS-003 — [complexité] Requête jointe `StkDepots`/`Art` au lieu d'une requête par
  article (SQL modifié, même PDF) · appelants : aucun · tests : T01, T02, T04 · sources : [ImpDepots.class:123](../../../../../.src/Gestion/Depots/ImpDepots.class#L123), [ImpDepots.class:126](../../../../../.src/Gestion/Depots/ImpDepots.class#L126)
- [ ] IMPDEPOTS-004 — [séparation traitement/GUI] `StockDepot(sCode) As Result` sans contrôle,
  mise en page conservée dans `Button2_Click` · appelants : aucun · tests : T01-T04 · sources : [ImpDepots.class:Button2_Click](../../../../../.src/Gestion/Depots/ImpDepots.class#L99-L171)
- [ ] IMPDEPOTS-005 — [commonalisation] `aff_Depot`/`Cman`/`Coldep_Click` via le module `Depot`
  (voir DEPOTS-004) · appelants : aucun · tests : T01 · sources : [ImpDepots.class:aff_Depot](../../../../../.src/Gestion/Depots/ImpDepots.class#L34-L48), [ImpDepots.class:Cman](../../../../../.src/Gestion/Depots/ImpDepots.class#L84-L91), [ImpDepots.class:Coldep_Click](../../../../../.src/Gestion/Depots/ImpDepots.class#L50-L57)
- [ ] IMPDEPOTS-006 — [réduction de portée] `aff_Depot`, `Cman` → `Private` ; `Coldep_Click` reste
  `Public` (rejeu) · appelants : aucun · tests : T01 · sources : [ImpDepots.class:aff_Depot](../../../../../.src/Gestion/Depots/ImpDepots.class#L34-L48), [ImpDepots.class:Cman](../../../../../.src/Gestion/Depots/ImpDepots.class#L84-L91)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] IMPDEPOTS-A01 — [anomalie] Dépôt vide ou inconnu : PDF créé inutilement, puis `Draw.End`
  sans `Draw.Begin` (erreur probable) ; code dépôt non vérifié · tests : T03 · sources : [ImpDepots.class:111](../../../../../.src/Gestion/Depots/ImpDepots.class#L111), [ImpDepots.class:167](../../../../../.src/Gestion/Depots/ImpDepots.class#L167)
- [ ] IMPDEPOTS-A02 — [anomalie] Écran non instrumenté (`Utils.Observers` absent) : ajouter
  l'appel change le log de rejeu (et la couleur des zones) · tests : T01 · sources : [ImpDepots.class:_new](../../../../../.src/Gestion/Depots/ImpDepots.class#L9-L19)
