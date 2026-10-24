# DB_Log — Rework

> Source : `.src/Utils/DB_Log.class` · Message de commit (phase 4) : `reference/.src/Utils/DB_Log.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 224 |
| Lignes de commentaire | 2 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 42 |
| Complexité max (fonction) | 9 (`DebugView_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 224 | 42 | 9 | 0 | 15 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] DB_LOG-001 — [documentation] En-tête : rôle, panneaux (grille, sauvegarde, filtres, niveaux),
  format des 9 colonnes · appelants : aucun · tests : aucun · sources : [DB_Log.class:_new](../../../../.src/Utils/DB_Log.class#L8-L46)
- [ ] DB_LOG-002 — [séparation traitement/GUI] Extraire `LireLog(chemin) As String[][]` (même
  découpage `Split(…, ";")`, fichier fermé après lecture) ; `Refresh` ne fait que l'affichage ·
  appelants : aucun · tests : T01, T02, T07 · sources : [DB_Log.class:Refresh](../../../../.src/Utils/DB_Log.class#L48-L89)
- [ ] DB_LOG-003 — [commonalisation] `AfficherPanneau(mode)` pour les bascules de visibilité de
  `Quitter_Click`, `Sauvegarder_Click`, `Enregistrer_Click`, `Filtres_Click` (états identiques) ;
  `MajLibelles()` partagée par `Form_Open` et `Refresh` · appelants : aucun · tests : T03, T04, T05 · sources : [DB_Log.class:Quitter_Click](../../../../.src/Utils/DB_Log.class#L120-L135), [DB_Log.class:Sauvegarder_Click](../../../../.src/Utils/DB_Log.class#L150-L164), [DB_Log.class:Enregistrer_Click](../../../../.src/Utils/DB_Log.class#L176-L193), [DB_Log.class:Filtres_Click](../../../../.src/Utils/DB_Log.class#L195-L222), [DB_Log.class:Form_Open](../../../../.src/Utils/DB_Log.class#L91-L99)
- [ ] DB_LOG-004 — [commonalisation] Utiliser l'énumération des champs du log (DB_CONNECTION-013)
  pour les colonnes de la grille · appelants : aucun · tests : T01, T07 · sources : [DB_Log.class:_new](../../../../.src/Utils/DB_Log.class#L8-L46), [DB_Log.class:GridView1_Data](../../../../.src/Utils/DB_Log.class#L101-L105)
- [ ] DB_LOG-005 — [commonalisation] `DebugView_Click` : helper `NiveauSuivant(iHandler)` pour les
  colonnes 2 et 3 · appelants : aucun · tests : T06 · sources : [DB_Log.class:DebugView_Click](../../../../.src/Utils/DB_Log.class#L261-L290)
- [ ] DB_LOG-006 — [code mort] Variables inutilisées `Dir` (`Sauvegarder_Click`), `logd` remplacé par
  un parcours des clés · appelants : aucun · tests : T04, T06 · sources : [DB_Log.class:Sauvegarder_Click](../../../../.src/Utils/DB_Log.class#L150-L164), [DB_Log.class:Niveau_Click](../../../../.src/Utils/DB_Log.class#L224-L241)
- [ ] DB_LOG-007 — [réduction de portée] `Refresh` → `Private` · appelants : aucun · tests : T01, T03 · sources : [DB_Log.class:Refresh](../../../../.src/Utils/DB_Log.class#L48-L89)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] DB_LOG-A01 — [anomalie] Découpage `Split(sLine, ";")` non borné : message tronqué si le SQL
  contient `;` ; ligne de continuation d'un SQL multiligne → erreur d'indice dans `GridView1_Data` ·
  tests : T02 · sources : [DB_Log.class:72](../../../../.src/Utils/DB_Log.class#L72), [DB_Log.class:GridView1_Data](../../../../.src/Utils/DB_Log.class#L101-L105)
- [ ] DB_LOG-A02 — [anomalie] `Refresh` : `Copy` sans `Try` (log absent) et fichier `hFile` jamais
  fermé ; chaque rafraîchissement ferme et recrée le logger (`DB_Con.Refresh`) · tests : T01, T03 · sources : [DB_Log.class:57](../../../../.src/Utils/DB_Log.class#L57), [DB_Log.class:65](../../../../.src/Utils/DB_Log.class#L65), [DB_Log.class:66](../../../../.src/Utils/DB_Log.class#L66)
- [ ] DB_LOG-A03 — [anomalie] `DirChooser1_Change` utilise `DirChooser1.Root` au lieu du répertoire
  sélectionné (à confirmer à l'écran) · tests : T04 · sources : [DB_Log.class:171](../../../../.src/Utils/DB_Log.class#L171)
