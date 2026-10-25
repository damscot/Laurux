# VisStatTypCli — Rework

> Source : `.src/Statistiques/VisStatTypCli.class` · Message de commit (phase 4) : `reference/.src/Statistiques/VisStatTypCli.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 206 |
| Lignes de commentaire | 23 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 30 |
| Complexité max (fonction) | 10 (`Affichage`) |
| Variables globales | 0 |
| Variables Public | 6 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 206 | 30 | 10 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VISSTATTYPCLI-001 — [documentation] En-tête en français, colonnes, formule du % N/N-1 ·
  appelants : aucun · tests : T01-T04 · sources : [VisStatTypCli.class:_New](../../../../.src/Statistiques/VisStatTypCli.class#L43-L90), [VisStatTypCli.class:Affichage](../../../../.src/Statistiques/VisStatTypCli.class#L92-L140)
- [ ] VISSTATTYPCLI-002 — [code mort] Supprimer `total`, `value`, `CoulZns`, `CoulZnaf`,
  `CoulFc`, `Coulfond`, `Frmt`, `Tab`, la boucle `Totl` (+ `MoveFirst`) et `Shell "cd"` ·
  appelants : aucun · tests : T01-T04 · sources : [VisStatTypCli.class:_New](../../../../.src/Statistiques/VisStatTypCli.class#L43-L90), [VisStatTypCli.class:112](../../../../.src/Statistiques/VisStatTypCli.class#L112), [VisStatTypCli.class:216](../../../../.src/Statistiques/VisStatTypCli.class#L216)
- [ ] VISSTATTYPCLI-003 — [réduction de portée] `Affichage`, `Sens_Aff`, `Dtn0`, `Dtn1`, `Tri`,
  `sens` → `Private` · appelants : aucun · tests : T01, T02 · sources : [VisStatTypCli.class:Affichage](../../../../.src/Statistiques/VisStatTypCli.class#L92-L140), [VisStatTypCli.class:Sens_Aff](../../../../.src/Statistiques/VisStatTypCli.class#L142-L150)
- [ ] VISSTATTYPCLI-004 — [commonalisation] `Sens_Aff`, requête de tri et boucle d'impression
  vers le socle `StatCommun` (voir VISSTATCOMM-004) ; même SQL, même PDF · appelants : aucun ·
  tests : T01-T04 · sources : [VisStatTypCli.class:Sens_Aff](../../../../.src/Statistiques/VisStatTypCli.class#L142-L150), [VisStatTypCli.class:Button2_Click](../../../../.src/Statistiques/VisStatTypCli.class#L195-L264), [VisStatComm.class:Sens_Aff](../../../../.src/Statistiques/VisStatComm.class#L170-L178)
- [ ] VISSTATTYPCLI-005 — [commonalisation] Pourcentage d'évolution dans une fonction pure
  `StatCommun.Evolution(n, n1, sFormat)` (comportement actuel conservé : base N-1, `> 0`) ·
  appelants : aucun · tests : T01 · sources : [VisStatTypCli.class:125](../../../../.src/Statistiques/VisStatTypCli.class#L125), [VisStatTypCli.class:136](../../../../.src/Statistiques/VisStatTypCli.class#L136)
- [ ] VISSTATTYPCLI-006 — [séparation traitement/GUI] Extraire `LignesTotal(sTri, sSens, bBrut)`
  ; `Affichage` remplit la grille et les totaux · appelants : aucun · tests : T01, T02, T05 · sources : [VisStatTypCli.class:Affichage](../../../../.src/Statistiques/VisStatTypCli.class#L92-L140)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VISSTATTYPCLI-A01 — [anomalie] Saut de page jamais déclenché (`p` jamais incrémenté) : au-delà
  d'une page, les lignes débordent (pas de nouvel en-tête ni de pied) · tests : T03 · sources : [VisStatTypCli.class:246](../../../../.src/Statistiques/VisStatTypCli.class#L246)
- [ ] VISSTATTYPCLI-A02 — [anomalie] Total imprimé de la colonne % = somme des pourcentages des
  lignes (non formatée), différent de l'évolution globale affichée à l'écran (`Netnn2`) ·
  tests : T03 · sources : [VisStatTypCli.class:240](../../../../.src/Statistiques/VisStatTypCli.class#L240), [VisStatTypCli.class:257](../../../../.src/Statistiques/VisStatTypCli.class#L257)
- [ ] VISSTATTYPCLI-A03 — [anomalie] PDF enregistré sous l'extension `.ps` (`~/tmp/StatTypcli.ps`) :
  le visualiseur choisi par extension peut échouer · tests : T04 · sources : [VisStatTypCli.class:217](../../../../.src/Statistiques/VisStatTypCli.class#L217)
