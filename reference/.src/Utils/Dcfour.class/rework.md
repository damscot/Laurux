# Dcfour — Rework

> Source : `.src/Utils/Dcfour.class` · Message de commit (phase 4) : `reference/.src/Utils/Dcfour.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 60 |
| Lignes de commentaire | 2 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 16 |
| Complexité max (fonction) | 14 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 60 | 16 | 14 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] DCFOUR-001 — [documentation] En-tête : rôle, fichier produit, limites · tests : aucun · sources : [Dcfour.class:Button2_Click](../../../../.src/Utils/Dcfour.class#L17-L72)
- [ ] DCFOUR-002 — [séparation traitement/GUI] `ListerDoublons(sFichier) As Integer` sans contrôle,
  sortie identique · tests : T01-T03 · sources : [Dcfour.class:Button2_Click](../../../../.src/Utils/Dcfour.class#L17-L72)
- [ ] DCFOUR-003 — [commonalisation] Helper `RapportTexte` partagé avec `VisPmp` (écriture, fin de
  traitement, ouverture de l'éditeur) en conservant l'ordre actuel des opérations · tests : T01, T02,
  VISPMP-T01 · sources : [Dcfour.class:60-70](../../../../.src/Utils/Dcfour.class#L60-L70), [VisPmp.class:Button2_Click](../../../../.src/Utils/VisPmp.class#L17-L50)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] DCFOUR-A01 — [anomalie] Chaque groupe de *k* doublons est écrit *k* fois · tests : T01 · sources : [Dcfour.class:34-41](../../../../.src/Utils/Dcfour.class#L34-L41)
- [ ] DCFOUR-A02 — [anomalie] Passe 2 (`art_code = art_cfour`, `count > 1`) jamais vraie : la
  détection « références produits et fournisseurs » ne fonctionne pas ; boucle non protégée par
  `Available` · tests : T01, T03 · sources : [Dcfour.class:45-59](../../../../.src/Utils/Dcfour.class#L45-L59)
- [ ] DCFOUR-A03 — [anomalie] Fichier fermé après l'ouverture de l'éditeur (contenu possiblement
  incomplet à l'affichage) · tests : T01 · sources : [Dcfour.class:65-70](../../../../.src/Utils/Dcfour.class#L65-L70)
