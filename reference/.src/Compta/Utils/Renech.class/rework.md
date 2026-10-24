# Renech — Rework

> Source : `.src/Compta/Utils/Renech.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/Renech.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 15 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 3 |
| Complexité max (fonction) | 3 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 15 | 3 | 3 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RENECH-001 — [documentation] En-tête : format de `~/Dtech.txt`, lien avec `RecupDech`
  (chemins différents), effet sur `dateech` · appelants : aucun · tests : T01 · sources : [Renech.class:run](../../../../../.src/Compta/Utils/Renech.class#L5-L21)
- [ ] RENECH-002 — [complexité] Fichier en variable locale et `Close` en fin de lecture (aucun effet
  sur les données) · appelants : aucun · tests : T01, T03 · sources : [Renech.class:3](../../../../../.src/Compta/Utils/Renech.class#L3), [Renech.class:run](../../../../../.src/Compta/Utils/Renech.class#L5-L21)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RENECH-A01 — [anomalie] Fichier absent ou ligne incomplète → erreur d'exécution ; date avec
  heure → `dateech` invalide ; aucune confirmation (PRGM-A02). Retirer le script avec
  `RecupDech` ou le fiabiliser (`Try`, `LDate`, confirmation) · tests : T02 · sources : [Renech.class:10](../../../../../.src/Compta/Utils/Renech.class#L10), [Renech.class:16](../../../../../.src/Compta/Utils/Renech.class#L16), [Prgm.class:84](../../../../../.src/Communs/Prgm.class#L84)
- [ ] RENECH-A02 — [anomalie] Chemins incohérents avec `RecupDech` (`~/Dtech.txt` lu,
  `~/tmp/Dtech.txt` écrit) · tests : T01 · sources : [Renech.class:10](../../../../../.src/Compta/Utils/Renech.class#L10), [RecupDech.class:9](../../../../../.src/Compta/Utils/RecupDech.class#L9)
