# VisStatComm — Rework

> Source : `.src/Statistiques/VisStatComm.class` · Message de commit (phase 4) : `reference/.src/Statistiques/VisStatComm.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 219 |
| Lignes de commentaire | 26 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 32 |
| Complexité max (fonction) | 14 (`Affichage`) |
| Variables globales | 0 |
| Variables Public | 6 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 219 | 32 | 14 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VISSTATCOMM-001 — [documentation] En-tête en français : deux modes (détail/synthèse),
  colonnes, dépendance à la structure de `Total` de `StatComm` · appelants : aucun · tests :
  T01-T05 · sources : [VisStatComm.class:_New](../../../../.src/Statistiques/VisStatComm.class#L43-L97)
- [ ] VISSTATCOMM-002 — [code mort] Supprimer `Bnet2_MouseDown` (aucun contrôle `Bnet2`),
  `total`, `value`, `CoulZns`, `CoulZnaf`, `CoulFc`, `Coulfond`, `Frmt`, `Tab`, `page`, la
  boucle `Totl` (+ `MoveFirst`), `Shell "cd"` et les cumuls `htn`/`rmT`/`netT` non imprimés ·
  appelants : aucun · tests : T01-T05 · sources : [VisStatComm.class:Bnet2_MouseDown](../../../../.src/Statistiques/VisStatComm.class#L219-L224), [VisStatComm.class:_New](../../../../.src/Statistiques/VisStatComm.class#L43-L97), [VisStatComm.class:130](../../../../.src/Statistiques/VisStatComm.class#L130), [VisStatComm.class:Button2_Click](../../../../.src/Statistiques/VisStatComm.class#L226-L281)
- [ ] VISSTATCOMM-003 — [réduction de portée] `Affichage`, `Sens_Aff`, `Dtn0`, `Dtn1`, `Tri`,
  `sens` → `Private` · appelants : aucun · tests : T01-T03 · sources : [VisStatComm.class:Affichage](../../../../.src/Statistiques/VisStatComm.class#L99-L168), [VisStatComm.class:Sens_Aff](../../../../.src/Statistiques/VisStatComm.class#L170-L178)
- [ ] VISSTATCOMM-004 — [commonalisation] `Sens_Aff` → `StatCommun.SensInverse`, requête de tri
  → `StatCommun.RequeteTotal`, boucle d'impression → `StatCommun.ImprimeListe` (communs aux 5
  `VisStat*`, voir StatComm) ; même SQL et même PDF · appelants : aucun · tests : T01-T05 · sources : [VisStatComm.class:Sens_Aff](../../../../.src/Statistiques/VisStatComm.class#L170-L178), [VisStatComm.class:Affichage](../../../../.src/Statistiques/VisStatComm.class#L99-L168), [VisStatComm.class:Button2_Click](../../../../.src/Statistiques/VisStatComm.class#L226-L281), [VisStatComArt.class:Sens_Aff](../../../../.src/Statistiques/VisStatComArt.class#L145-L153)
- [ ] VISSTATCOMM-005 — [complexité] Requête `Fiches_Commerciaux` par ligne → `INNER JOIN` dans
  la requête principale (SQL modifié, lecture seule, grille identique) · appelants : aucun ·
  tests : T01-T03 · sources : [VisStatComm.class:136](../../../../.src/Statistiques/VisStatComm.class#L136), [VisStatComm.class:138](../../../../.src/Statistiques/VisStatComm.class#L138)
- [ ] VISSTATCOMM-006 — [séparation traitement/GUI] Extraire `LignesTotal(bDetail, sTri, sSens,
  bBrut)` (requête + commission) ; `Affichage` ne fait que remplir `Liste` et les totaux ·
  appelants : aucun · tests : T01-T03, T06 · sources : [VisStatComm.class:Affichage](../../../../.src/Statistiques/VisStatComm.class#L99-L168)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VISSTATCOMM-A01 — [anomalie] Tris inopérants : les handlers réagissent à `MouseDown` (avant
  le changement de valeur du RadioButton) et `Affichage` force `Tri = "commercial"` quand
  `Bnom.value` est faux → tris Brut/Remise/Net jamais appliqués, tri par nom au second clic
  seulement (à confirmer par replay) · tests : T03 · sources : [VisStatComm.class:117](../../../../.src/Statistiques/VisStatComm.class#L117), [VisStatComm.class:124](../../../../.src/Statistiques/VisStatComm.class#L124), [VisStatComm.class:Bbrut_MouseDown](../../../../.src/Statistiques/VisStatComm.class#L198-L203)
- [ ] VISSTATCOMM-A02 — [anomalie] Lignes dont le commercial est introuvable (client sans
  commercial en détail) masquées et exclues des totaux, sans signalement · tests : T01 · sources : [VisStatComm.class:140](../../../../.src/Statistiques/VisStatComm.class#L140)
- [ ] VISSTATCOMM-A03 — [anomalie] PDF sans ligne de total (`Level4C`/`Level5c` commentés) et
  fichier `~/tmp/Statcli.pdf` partagé avec `VisStatComArt` (la fermeture de l'un supprime le PDF
  de l'autre) · tests : T04, T05 · sources : [VisStatComm.class:235](../../../../.src/Statistiques/VisStatComm.class#L235), [VisStatComm.class:272](../../../../.src/Statistiques/VisStatComm.class#L272), [VisStatComArt.class:191](../../../../.src/Statistiques/VisStatComArt.class#L191)
