# MajEqu — Rework

> Source : `.src/Gestion/Stock/Tarifs/MajEqu.module` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Tarifs/MajEqu.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 47 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 29 |
| Complexité max (fonction) | 24 (`Maj`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 47 | 29 | 24 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MAJEQU-001 — [documentation] En-tête de module en français : rôle de `Fiches_Cequ`
  (fermeture symétrique et transitive), contrat de `Maj(code, cequ)` (ordre des arguments),
  doublons ignorés par la clé primaire, commentaires `'''` sur `Maj` et `Recup` · appelants :
  aucun · tests : T01-T04 · sources : [MajEqu.module:Maj](../../../../../../.src/Gestion/Stock/Tarifs/MajEqu.module#L3-L43), [MajEqu.module:Recup](../../../../../../.src/Gestion/Stock/Tarifs/MajEqu.module#L45-L58)
- [ ] MAJEQU-002 — [commonalisation] Procédure privée `Lien(sCodep, sCodequ)` pour les 17
  `INSERT` sous `Try` ; les 4 `INSERT` écrits `(codequ, codep)` sont réordonnés (SQL modifié,
  dump identique) · appelants : aucun · tests : T01-T04 · sources : [MajEqu.module:Maj](../../../../../../.src/Gestion/Stock/Tarifs/MajEqu.module#L3-L43), [MajEqu.module:Recup](../../../../../../.src/Gestion/Stock/Tarifs/MajEqu.module#L45-L58)
- [ ] MAJEQU-003 — [complexité] Procédure privée `PropageDepuis(sDepart, sCode)` pour les deux
  blocs identiques de `Maj` (lignes 13-21 et 22-30), même ordre de requêtes ; CC 24 → ≤ 10 visé ·
  appelants : aucun · tests : T01, T02, T03 · sources : [MajEqu.module:Maj](../../../../../../.src/Gestion/Stock/Tarifs/MajEqu.module#L3-L43)
- [ ] MAJEQU-004 — [commonalisation] Garde d'export `Variables.Sprix And Variables.Sexport And
  Variables.SMajArt` remplacée par `Serveur.Actif` (SERVEUR-008, à faire après lui) · appelants :
  aucun · tests : T05 · sources : [MajEqu.module:41](../../../../../../.src/Gestion/Stock/Tarifs/MajEqu.module#L41)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MAJEQU-A01 — [anomalie] `Recup` sur une table `Fiches_Cequ` vide : lecture de
  `requ2!codequ` sans test `Available`, hors `Try` → erreur non interceptée · tests : T04 ·
  sources : [MajEqu.module:51](../../../../../../.src/Gestion/Stock/Tarifs/MajEqu.module#L51)
- [ ] MAJEQU-A02 — [anomalie] Doublons ignorés par `Try` : avec `/dbase/backtrace` actif,
  `DB_Connection.Exec` ouvre une boîte d'erreur par doublon avant de propager (à confirmer par T06) ;
  correction possible par un test d'existence préalable ou un `INSERT` ignorant les doublons ·
  tests : T06 · sources : [MajEqu.module:Maj](../../../../../../.src/Gestion/Stock/Tarifs/MajEqu.module#L3-L43), [DB_Connection.class:Exec](../../../../../../.src/Utils/DB_Connection.class#L317-L450)
