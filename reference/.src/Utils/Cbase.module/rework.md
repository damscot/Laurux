# Cbase — Rework

> Source : `.src/Utils/Cbase.module` · Message de commit (phase 4) : `reference/.src/Utils/Cbase.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 248 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 122 |
| Complexité max (fonction) | 122 (`Table`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 248 | 122 | 122 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CBASE-001 — [documentation] En-tête du module : rôle, contrat (`""` pour une clé inconnue,
  sensibilité à la casse), liste des tables de travail hors `db_control.csv` · appelants : aucun ·
  tests : aucun · sources : [Cbase.module:Table](../../../../.src/Utils/Cbase.module#L3-L374)
- [ ] CBASE-002 — [code mort] Supprimer les doublons inatteignables `TabParam` (l. 47) et `TabTypec`
  (l. 236) · appelants : aucun · tests : T01 · sources : [Cbase.module:47-48](../../../../.src/Utils/Cbase.module#L47-L48), [Cbase.module:236-237](../../../../.src/Utils/Cbase.module#L236-L237)
- [ ] CBASE-003 — [complexité] Remplacer le `Select Case` par une `Collection` statique initialisée
  une fois (mode binaire, sensible à la casse), `""` pour une clé absente ; CC ~121 → 2 · appelants :
  aucun (190 fichiers inchangés) · tests : T01, T02, T04 · sources : [Cbase.module:Table](../../../../.src/Utils/Cbase.module#L3-L374)
- [ ] CBASE-004 — [code mort] Supprimer les clés jamais utilisées `TabCdFour`, `TabDocTag`,
  `TabIdentite`, `TabLibelFac`, `TabMvtA1`-`A5`, `TabMvtM1`-`M5`, `TabTag` **seulement** si
  l'utilisateur ne souhaite pas les conserver pour les reworks futurs (`TabIdentite` sert à
  UTILS / `Fill_Civilite`) : par défaut, on les conserve et on les documente · appelants : aucun ·
  tests : T01 · sources : [Cbase.module:Table](../../../../.src/Utils/Cbase.module#L3-L374)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] CBASE-A01 — [anomalie] Clés `TabBanques`, `TabCdocs`, `TabFdocs` absentes : `Glcr` n'affiche
  aucune banque, et la suppression d'un client/fournisseur émet un `DELETE FROM  WHERE …` invalide
  (erreur silencieuse). Correction à décider : mapper vers les tables actuelles (`Docs_Ged` via `LGed`
  ?) ou supprimer les appels dans `Glcr`, `FClient`, `FFournisseur` · tests : T02 + replays
  suppression tiers · sources : [Glcr.class:40](../../../../.src/Gestion/Lcr/Glcr.class#L40), [FClient.class:1653](../../../../.src/Gestion/Tables/FClient.class#L1653), [FFournisseur.class:1562](../../../../.src/Gestion/Tables/FFournisseur.class#L1562)
- [ ] CBASE-A02 — [anomalie, à confirmer] Une clé inconnue renvoie `""` sans trace : proposer un
  `Utils.Log` (niveau avertissement) pour détecter les clés erronées. Changement observable dans
  les journaux seulement · tests : T02 · sources : [Cbase.module:370-371](../../../../.src/Utils/Cbase.module#L370-L371)
