# Monip — Rework

> Source : `.src/Utils/Monip.module` · Message de commit (phase 4) : `reference/.src/Utils/Monip.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 30 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 3 |
| Complexité max (fonction) | 3 (`Monip`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 30 | 3 | 3 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MONIP-001 — [documentation] Commentaire de rôle en français, dépendance à `curl` et à
  `ifconfig.me` · appelants : aucun · tests : aucun · sources : [Monip.module:Monip](../../../../.src/Utils/Monip.module#L3-L35)
- [ ] MONIP-002 — [code mort] Supprimer `Shell "cd " & User.Home` (sans effet) et renommer la
  variable locale `$hform` en `hForm` · appelants : aucun · tests : T01 · sources : [Monip.module:5](../../../../.src/Utils/Monip.module#L5), [Monip.module:24](../../../../.src/Utils/Monip.module#L24)
- [ ] MONIP-003 — [séparation traitement/GUI] Extraire la lecture de l'IP dans une fonction privée ;
  la fenêtre reste construite à l'identique · appelants : aucun · tests : T01, T02 · sources : [Monip.module:Monip](../../../../.src/Utils/Monip.module#L3-L35)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] MONIP-A01 — [anomalie] `curl` écrit `monip` dans le répertoire courant mais le fichier est lu
  dans `$HOME` : IP absente ou périmée si Laurux n'est pas lancé depuis `$HOME` ; le fichier n'est
  jamais supprimé. Correction : `Shell … To` · tests : T01 (variante `cwd_autre`) · sources : [Monip.module:25-26](../../../../.src/Utils/Monip.module#L25-L26)
