# RecupN — Rework

> Source : `.src/Utils/RecupN.class` · Message de commit (phase 4) : `reference/.src/Utils/RecupN.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 23 |
| Lignes de commentaire | 2 |
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
| initial | `6b6b9dfc` | 2026-10-24 | 23 | 4 | 4 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RECUPN-001 — [documentation] Avertissement en tête : script ponctuel, constante 424, non
  idempotent, colonnes non copiées · tests : aucun · sources : [RecupN.class:run](../../../../.src/Utils/RecupN.class#L5-L30)
- [ ] RECUPN-002 — [code mort] Variable `numcol` jamais affectée remplacée par la valeur littérale
  passée aujourd'hui (chaîne vide) · tests : T01 · sources : [RecupN.class:10](../../../../.src/Utils/RecupN.class#L10), [RecupN.class:23](../../../../.src/Utils/RecupN.class#L23)
- [ ] RECUPN-003 — [séparation traitement/GUI] `Message.Info` déplacé dans `Prgm` (même texte) ·
  appelants : `Prgm` · tests : T01 · sources : [RecupN.class:28](../../../../.src/Utils/RecupN.class#L28)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] RECUPN-A01 — [anomalie] Script de réparation propre à une base (plage 1-424 en dur), sans
  confirmation ni transaction, non idempotent : **retirer de `Prgm` et supprimer** (ou paramétrer et
  protéger) · appelants : `Prgm.class:64` · tests : T01, T02 · sources : [RecupN.class:19](../../../../.src/Utils/RecupN.class#L19), [Prgm.class:64](../../../../.src/Communs/Prgm.class#L64)
- [ ] RECUPN-A02 — [anomalie] `numcol` non recopié, numérotation avec trous, sommes de contrôle non
  recalculées · tests : T01 · sources : [RecupN.class:23](../../../../.src/Utils/RecupN.class#L23), [RecupN.class:26](../../../../.src/Utils/RecupN.class#L26)
- [ ] RECUPN-A03 — [anomalie] `Fiches_Mvt` vide → erreur sur `MoveLast` · tests : T03 · sources : [RecupN.class:17-18](../../../../.src/Utils/RecupN.class#L17-L18)
