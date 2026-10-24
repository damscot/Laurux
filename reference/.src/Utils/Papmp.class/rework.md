# Papmp — Rework

> Source : `.src/Utils/Papmp.class` · Message de commit (phase 4) : `reference/.src/Utils/Papmp.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 18 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 4 |
| Complexité max (fonction) | 4 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 18 | 4 | 4 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] PAPMP-001 — [code mort] Supprimer la variable `pmp` affectée non lue · tests : T01 · sources : [Papmp.class:7](../../../../.src/Utils/Papmp.class#L7), [Papmp.class:15](../../../../.src/Utils/Papmp.class#L15)
- [ ] PAPMP-002 — [commonalisation] Utiliser la fonction `PmpEgalPrvt()` créée par RAZART-004 ;
  `run` ne garde que question, curseur et message · appelants : `Prgm` (inchangé) · tests : T01, T02,
  RAZART-T02 · sources : [Papmp.class:run](../../../../.src/Utils/Papmp.class#L3-L23), [RazArt.class:34-41](../../../../.src/Utils/RazArt.class#L34-L41)
- [ ] PAPMP-003 — [réarchitecture] (optionnel, transverse) Regrouper les scripts `run` de `Prgm`
  dans un module `Maintenance` · appelants : `Prgm.class:64-111` · tests : T01 + tests des autres scripts · sources : [Papmp.class:run](../../../../.src/Utils/Papmp.class#L3-L23), [Prgm.class:64-111](../../../../.src/Communs/Prgm.class#L64-L111)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] PAPMP-A01 — [anomalie] Message « prix d'achat » mais copie de `art_prvt` ; curseur de `Prgm`
  laissé en attente si aucun article · tests : T01 · sources : [Papmp.class:9](../../../../.src/Utils/Papmp.class#L9), [Papmp.class:18](../../../../.src/Utils/Papmp.class#L18)
