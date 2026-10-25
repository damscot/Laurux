# VisStatFour — Rework

> Source : `.src/Statistiques/VisStatFour.class` · Message de commit (phase 4) : `reference/.src/Statistiques/VisStatFour.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 213 |
| Lignes de commentaire | 26 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 29 |
| Complexité max (fonction) | 8 (`Affichage`) |
| Variables globales | 0 |
| Variables Public | 6 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 213 | 29 | 8 | 0 | 14 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VISSTATFOUR-001 — [documentation] Corriger l'en-tête (`VisStatFour.class`, « CA par
  fournisseur »), décrire colonnes et formule du % · appelants : aucun · tests : T01-T03 · sources : [VisStatFour.class:21](../../../../.src/Statistiques/VisStatFour.class#L21), [VisStatFour.class:Affichage](../../../../.src/Statistiques/VisStatFour.class#L69-L103)
- [ ] VISSTATFOUR-002 — [code mort] Supprimer `Level0`, `Level1`, `level2`, `Level4`, `Level5`
  (jamais appelés), la boucle `Totl` (+ `MoveFirst`), `total`, `value`, `Coulfond`, `Page`,
  `Tab2`, le nom `Edstatfour.kud`, `Shell "cd"` et l'instruction sans effet de la ligne 197 ·
  appelants : aucun · tests : T01-T04 · sources : [VisStatFour.class:Level0](../../../../.src/Statistiques/VisStatFour.class#L208-L215), [VisStatFour.class:Level1](../../../../.src/Statistiques/VisStatFour.class#L218-L235), [VisStatFour.class:level2](../../../../.src/Statistiques/VisStatFour.class#L238-L249), [VisStatFour.class:Level4](../../../../.src/Statistiques/VisStatFour.class#L252-L265), [VisStatFour.class:Level5](../../../../.src/Statistiques/VisStatFour.class#L268-L281), [VisStatFour.class:88](../../../../.src/Statistiques/VisStatFour.class#L88), [VisStatFour.class:197](../../../../.src/Statistiques/VisStatFour.class#L197)
- [ ] VISSTATFOUR-003 — [réduction de portée] `Affichage`, `Sens_Aff`, `Dtn0`, `Dtn1`, `Tri`,
  `sens` → `Private` · appelants : aucun · tests : T01, T02, T04 · sources : [VisStatFour.class:Affichage](../../../../.src/Statistiques/VisStatFour.class#L69-L103), [VisStatFour.class:Sens_Aff](../../../../.src/Statistiques/VisStatFour.class#L105-L113)
- [ ] VISSTATFOUR-004 — [commonalisation] `Sens_Aff`, requête de tri et boucle d'impression vers
  le socle `StatCommun` (VISSTATCOMM-004) ; % via `StatCommun.Evolution` en gardant la base N ·
  appelants : aucun · tests : T01-T04 · sources : [VisStatFour.class:Sens_Aff](../../../../.src/Statistiques/VisStatFour.class#L105-L113), [VisStatFour.class:Button2_Click](../../../../.src/Statistiques/VisStatFour.class#L143-L205), [VisStatFour.class:98](../../../../.src/Statistiques/VisStatFour.class#L98)
- [ ] VISSTATFOUR-005 — [séparation traitement/GUI] Extraire `LignesTotal(sTri, sSens, bBrut)` ;
  `Affichage` ne fait que remplir `Liste` · appelants : aucun · tests : T01, T04 · sources : [VisStatFour.class:Affichage](../../../../.src/Statistiques/VisStatFour.class#L69-L103)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VISSTATFOUR-A01 — [anomalie] « % N/N-1 » calculé sur la base du montant **N** (`/ montant`),
  alors que `VisStatTypCli` divise par le N-1 ; idem pour le total imprimé (division par zéro si
  le total N est nul) · tests : T01, T03 · sources : [VisStatFour.class:98](../../../../.src/Statistiques/VisStatFour.class#L98), [VisStatFour.class:196](../../../../.src/Statistiques/VisStatFour.class#L196), [VisStatTypCli.class:125](../../../../.src/Statistiques/VisStatTypCli.class#L125)
- [ ] VISSTATFOUR-A02 — [anomalie] Titre des pages suivantes du PDF « Impression du CA clients »
  au lieu de « CA fournisseurs » · tests : T03 · sources : [VisStatFour.class:186](../../../../.src/Statistiques/VisStatFour.class#L186)
- [ ] VISSTATFOUR-A03 — [anomalie] Absence de `Utils.Observers(Me)` dans `_New` : écran non
  journalisé ni rejouable ; l'ajouter change le journal (`Exec_SQL`/événements) · tests : T01-T03 · sources : [VisStatFour.class:_New](../../../../.src/Statistiques/VisStatFour.class#L39-L67)
