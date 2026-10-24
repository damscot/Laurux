# FAbout — Rework

> Source : `.src/Communs/FAbout.class` · Message de commit (phase 4) : `reference/.src/Communs/FAbout.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 43 |
| Lignes de commentaire | 1 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 3 (`_New`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 43 | 9 | 3 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FABOUT-001 — [documentation] En-tête : rôle, origine des champs de version (`sha1.txt`,
  `branch.txt`), commentaire sur le handler vide `Grad1_MouseDown` conservé · appelants : aucun ·
  tests : aucun · sources : [FAbout.class:_New](../../../../.src/Communs/FAbout.class#L3-L27), [FAbout.class:Grad1_MouseDown](../../../../.src/Communs/FAbout.class#L62-L64)
- [ ] FABOUT-002 — [commonalisation] Helper privé `Degrade(hImage, bInverse)` pour les deux boucles
  de dégradé (images identiques) · appelants : aucun · tests : T01 · sources : [FAbout.class:15-25](../../../../.src/Communs/FAbout.class#L15-L25)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FABOUT-A01 — [anomalie] Minuteur `Temps` actif dès l'ouverture avec `Delay = 0` (défilement
  continu d'un panneau masqué) ; ne l'activer qu'au clic « Remerciements » (modification de la
  classe seulement, le `.form` reste inchangé) · tests : T02 · sources : [FAbout.class:Button2_Click](../../../../.src/Communs/FAbout.class#L46-L60), [FAbout.class:Temps_Timer](../../../../.src/Communs/FAbout.class#L36-L44)
