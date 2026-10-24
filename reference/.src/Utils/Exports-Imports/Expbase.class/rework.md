# Expbase — Rework

> Source : `.src/Utils/Exports-Imports/Expbase.class` · Message de commit (phase 4) : `reference/.src/Utils/Exports-Imports/Expbase.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 42 |
| Lignes de commentaire | 23 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 10 (`button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 42 | 14 | 10 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EXPBASE-001 — [documentation] Corriger l'en-tête (nom du fichier, rôle « envoi de la
  sauvegarde par courriel »), documenter les réglages lus · tests : aucun · sources : [Expbase.class:21-24](../../../../../.src/Utils/Exports-Imports/Expbase.class#L21-L24)
- [ ] EXPBASE-002 — [séparation traitement/GUI] `CheminSauvegarde() As String` privé, sans contrôle
  · tests : T03 · sources : [Expbase.class:45-49](../../../../../.src/Utils/Exports-Imports/Expbase.class#L45-L49)
- [ ] EXPBASE-003 — [complexité] Helper privé pour « musique si `son` + `Message.Error` » (3
  occurrences) · tests : T02 · sources : [Expbase.class:55-58](../../../../../.src/Utils/Exports-Imports/Expbase.class#L55-L58), [Expbase.class:61-64](../../../../../.src/Utils/Exports-Imports/Expbase.class#L61-L64), [Expbase.class:67-70](../../../../../.src/Utils/Exports-Imports/Expbase.class#L67-L70)
- [ ] EXPBASE-004 — [commonalisation] Calcul du chemin de sauvegarde partagé avec `FSauve` et
  `SauvesAuto` (helper `Utils`) · appelants : `FSauve`, `SauvesAuto` · tests : T03 + tests de ces fichiers · sources : [Expbase.class:45-49](../../../../../.src/Utils/Exports-Imports/Expbase.class#L45-L49), [FSauve.class:68-81](../../../../../.src/Communs/FSauve.class#L68-L81), [SauvesAuto.module:20](../../../../../.src/Communs/SauvesAuto.module#L20)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] EXPBASE-A01 — [anomalie] Existence du fichier de sauvegarde non vérifiée ; le message « La base
  n'existe pas ! » est pratiquement inatteignable · tests : T03 · sources : [Expbase.class:50](../../../../../.src/Utils/Exports-Imports/Expbase.class#L50), [Expbase.class:64](../../../../../.src/Utils/Exports-Imports/Expbase.class#L64)
