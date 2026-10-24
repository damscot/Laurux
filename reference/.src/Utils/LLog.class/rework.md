# LLog — Rework

> Source : `.src/Utils/LLog.class` · Message de commit (phase 4) : `reference/.src/Utils/LLog.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 55 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 6 (`Log`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 55 | 14 | 6 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LLOG-001 — [documentation] En-tête : rôle (logger par module), échelle des niveaux et
  équivalence `Logger.*`, handlers 0/1, relais vers `DB_Connection`, niveau `MessageBox` ·
  appelants : aucun · tests : aucun · sources : [LLog.class:_new](../../../../.src/Utils/LLog.class#L23-L41)
- [ ] LLOG-002 — [complexité] Extraire `BacktraceTexte()` (même découpage `Extract(2, Length - 4)`)
  de `Log` · appelants : aucun · tests : T02, T04 · sources : [LLog.class:Log](../../../../.src/Utils/LLog.class#L43-L61), [LLog.class:50-54](../../../../.src/Utils/LLog.class#L50-L54)
- [ ] LLOG-003 — [séparation traitement/GUI] `DoitAfficher(iLevel) As Boolean` pure ; `Log` garde le
  `Message.Error` (même texte) · appelants : aucun · tests : T02 · sources : [LLog.class:Log](../../../../.src/Utils/LLog.class#L43-L61), [LLog.class:56-58](../../../../.src/Utils/LLog.class#L56-L58)
- [ ] LLOG-004 — [commonalisation] Chemin `~/tmp/Debug` via un helper commun avec `DB_Connection` et
  `Start.module` (`Utils.DebugDir()`) · appelants : `DB_Connection`, `Start` · tests : T01, T06 · sources : [LLog.class:_new](../../../../.src/Utils/LLog.class#L23-L41), [DB_Connection.class:Start](../../../../.src/Utils/DB_Connection.class#L48-L97)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LLOG-A01 — [anomalie] `Log` : `LogLevelName[iLevel]` non borné (erreur d'indice si niveau hors
  0–8) ; `Extract` de longueur négative sur pile courte · tests : T02, T05 · sources : [LLog.class:51](../../../../.src/Utils/LLog.class#L51), [LLog.class:57](../../../../.src/Utils/LLog.class#L57)
- [ ] LLOG-A02 — [anomalie] Niveaux 5 à 7 transmis à `DB_Connection.Log_Event` hors de l'échelle
  gb.logging (filtrage à confirmer) · tests : T04 · sources : [LLog.class:59](../../../../.src/Utils/LLog.class#L59)
