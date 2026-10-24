# Visualiseur — Rework

> Source : `.src/Utils/Visualiseur.module` · Message de commit (phase 4) : `reference/.src/Utils/Visualiseur.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 8 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 2 |
| Complexité max (fonction) | 2 (`Prog`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 8 | 2 | 2 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VISUALISEUR-001 — [documentation] Commentaire : rôle, réglage `CmdVis` (saisi en préférences
  de caisse, appliqué partout), paramètre `mime_type` ignoré · appelants : aucun · tests : aucun · sources : [Visualiseur.module:Prog](../../../../.src/Utils/Visualiseur.module#L3-L13)
- [ ] VISUALISEUR-002 — [code mort] Supprimer la variable `$Exec` ; `Prog` déclarée `Sub` sans
  retour ; une seule lecture du réglage · appelants : aucun changement de code (110 appels
  inchangés) · tests : T01, T02 · sources : [Visualiseur.module:3-8](../../../../.src/Utils/Visualiseur.module#L3-L8)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] VISUALISEUR-A01 — [anomalie] Chemin non quoté dans `Shell CmdVis & " " & Fic` : échec si le
  chemin contient un espace (répertoires `/Soc<XX>/Fichiers` personnalisés) · tests : T01 · sources : [Visualiseur.module:8](../../../../.src/Utils/Visualiseur.module#L8)
