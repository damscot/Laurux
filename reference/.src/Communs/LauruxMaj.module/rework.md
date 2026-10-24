# LauruxMaj — Rework

> Source : `.src/Communs/LauruxMaj.module` · Message de commit (phase 4) : `reference/.src/Communs/LauruxMaj.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 5100 |
| Lignes de commentaire | 188 |
| Fonctions | 110 |
| Fonctions Public | 110 |
| Complexité cyclomatique totale | 2251 |
| Complexité max (fonction) | 550 (`Maj369`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 5100 | 2251 | 550 | 0 | 110 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Consigne utilisateur : **interdiction de refactoriser les étapes de mise à jour** (toutes les `MajXXX`,
y compris `Maj369`) **et leur dispatch** dans `Verif_Version`. Aucune case de refactorisation, de
commonalisation, de complexité, de réduction de portée ni de code mort. Les défauts relevés relèvent
d'une future migration et sont listés dans architecture.md, section « Optimisations possibles
(changement de schéma futur) ».

- [ ] LAURUXMAJ-001 — [documentation] En-tête du module en français (commentaires uniquement, avant
  `Verif_Version`, aucune ligne des étapes ni des blocs de dispatch modifiée) : rôle, flux d'exécution
  (prologue `SET NAMES`, trois générations de stockage de la version — `/dbase/Version`,
  `/Societes/Soc<XX>`, `Fiches_Parametres.version` —, drapeau `/dbase/Maj` qui ne conditionne que
  l'appel, `Catch` global et son message, migration de la base de la société ouverte), règle « une
  migration publiée est figée : toute évolution = nouvelle `MajXYZ()` + bloc de dispatch + bump de
  `.project`/`.version` + `db_control.csv` + `Laurux01.{sql,sqlite}` » · appelants : aucun · tests : T01 ·
  sources : [LauruxMaj.module:Verif_Version](../../../../.src/Communs/LauruxMaj.module#L17-L1122), [LauruxMaj.module:20](../../../../.src/Communs/LauruxMaj.module#L20), [LauruxMaj.module:1103](../../../../.src/Communs/LauruxMaj.module#L1103)

### Anomalies : changement de comportement, validation utilisateur requise

Aucune case : la correction des défauts des migrations ne peut passer que par une future migration
(changement de schéma, hors périmètre). Voir architecture.md, dernière section.
