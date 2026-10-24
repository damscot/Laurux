# VisPmp — Rework

> Source : `.src/Utils/VisPmp.class` · Message de commit (phase 4) : `reference/.src/Utils/VisPmp.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 38 |
| Lignes de commentaire | 2 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 7 |
| Complexité max (fonction) | 5 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 38 | 7 | 5 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VISPMP-001 — [documentation] En-tête et correction du commentaire « clients » (l.28) · tests : aucun · sources : [VisPmp.class:28](../../../../.src/Utils/VisPmp.class#L28)
- [ ] VISPMP-002 — [séparation traitement/GUI] `ListerPmpNegatifs(sFichier) As Integer` · tests : T01, T02 · sources : [VisPmp.class:Button2_Click](../../../../.src/Utils/VisPmp.class#L17-L50)
- [ ] VISPMP-003 — [commonalisation] Helper `RapportTexte` partagé avec `Dcfour` · tests : T01, T02,
  DCFOUR-T01 · sources : [VisPmp.class:38-48](../../../../.src/Utils/VisPmp.class#L38-L48), [Dcfour.class:Button2_Click](../../../../.src/Utils/Dcfour.class#L17-L72)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] VISPMP-A01 — [anomalie] Fichier fermé après l'ouverture de l'éditeur ; fichier vide créé quand il
  n'y a rien à signaler · tests : T01, T02 · sources : [VisPmp.class:27](../../../../.src/Utils/VisPmp.class#L27), [VisPmp.class:43-48](../../../../.src/Utils/VisPmp.class#L43-L48)
