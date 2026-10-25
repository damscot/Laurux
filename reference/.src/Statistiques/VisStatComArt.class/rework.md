# VisStatComArt — Rework

> Source : `.src/Statistiques/VisStatComArt.class` · Message de commit (phase 4) : `reference/.src/Statistiques/VisStatComArt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 186 |
| Lignes de commentaire | 21 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 29 |
| Complexité max (fonction) | 9 (`Affichage`) |
| Variables globales | 0 |
| Variables Public | 6 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 186 | 29 | 9 | 0 | 10 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VISSTATCOMART-001 — [documentation] En-tête en français : colonnes, filtre commercial,
  dépendance à `Total` de `StatComArt` · appelants : aucun · tests : T01-T05 · sources : [VisStatComArt.class:_New](../../../../.src/Statistiques/VisStatComArt.class#L43-L97)
- [ ] VISSTATCOMART-002 — [code mort] Supprimer la boucle vide (+ `MoveFirst`), `total`, `value`,
  `CoulZns`, `CoulZnaf`, `CoulFc`, `Coulfond`, `Frmt`, `Tab`, `Page`, `Shell "cd"` · appelants :
  aucun · tests : T01-T05 · sources : [VisStatComArt.class:123](../../../../.src/Statistiques/VisStatComArt.class#L123), [VisStatComArt.class:_New](../../../../.src/Statistiques/VisStatComArt.class#L43-L97), [VisStatComArt.class:190](../../../../.src/Statistiques/VisStatComArt.class#L190)
- [ ] VISSTATCOMART-003 — [réduction de portée] `Affichage`, `Sens_Aff`, `Dtn0`, `Dtn1`, `Tri`,
  `sens` → `Private` · appelants : aucun · tests : T01-T03 · sources : [VisStatComArt.class:Affichage](../../../../.src/Statistiques/VisStatComArt.class#L99-L143), [VisStatComArt.class:Sens_Aff](../../../../.src/Statistiques/VisStatComArt.class#L145-L153)
- [ ] VISSTATCOMART-004 — [commonalisation] `Sens_Aff`, requête de tri (avec filtre) et boucle
  d'impression vers le socle `StatCommun` (voir VISSTATCOMM-004) · appelants : aucun · tests :
  T01-T05 · sources : [VisStatComArt.class:Sens_Aff](../../../../.src/Statistiques/VisStatComArt.class#L145-L153), [VisStatComArt.class:Affichage](../../../../.src/Statistiques/VisStatComArt.class#L99-L143), [VisStatComArt.class:Button2_Click](../../../../.src/Statistiques/VisStatComArt.class#L183-L230)
- [ ] VISSTATCOMART-005 — [complexité] Requête `Fiches_Commerciaux` par ligne → `INNER JOIN`
  (SQL modifié, lecture seule, grille identique) · appelants : aucun · tests : T01-T04 · sources : [VisStatComArt.class:127](../../../../.src/Statistiques/VisStatComArt.class#L127)
- [ ] VISSTATCOMART-006 — [séparation traitement/GUI] Extraire `LignesTotal(sCommercial, sTri,
  sSens, bBrut)` · appelants : aucun · tests : T01-T03, T06 · sources : [VisStatComArt.class:Affichage](../../../../.src/Statistiques/VisStatComArt.class#L99-L143)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VISSTATCOMART-A01 — [anomalie] Tris sur `MouseDown` : `Bnom.value` lu avant le changement
  du RadioButton, le mode de tri (brut ou `lpad`) est décalé d'un clic (à confirmer par replay)
  · tests : T03 · sources : [VisStatComArt.class:110](../../../../.src/Statistiques/VisStatComArt.class#L110), [VisStatComArt.class:Bnom_MouseDown](../../../../.src/Statistiques/VisStatComArt.class#L162-L167)
- [ ] VISSTATCOMART-A02 — [anomalie] Remplissage de `Comm` : « Tous les commerciaux » inséré à
  l'index 0 (`"00"` pris comme index) et `Comm_Change` possiblement levé pendant `_New` : filtre
  initial incertain (à confirmer par replay) · tests : T01 · sources : [VisStatComArt.class:66](../../../../.src/Statistiques/VisStatComArt.class#L66), [VisStatComArt.class:68](../../../../.src/Statistiques/VisStatComArt.class#L68)
- [ ] VISSTATCOMART-A03 — [anomalie] Lignes dont le commercial n'existe plus masquées et exclues
  de `NetHT`, sans signalement · tests : T04 · sources : [VisStatComArt.class:128](../../../../.src/Statistiques/VisStatComArt.class#L128)
- [ ] VISSTATCOMART-A04 — [anomalie] PDF `~/tmp/Statcli.pdf` partagé avec `VisStatComm` : la
  fermeture d'un écran supprime le PDF de l'autre (= VISSTATCOMM-A03) · tests : T05 · sources : [VisStatComArt.class:191](../../../../.src/Statistiques/VisStatComArt.class#L191), [VisStatComm.class:235](../../../../.src/Statistiques/VisStatComm.class#L235)
