# menuopt — Rework

> Source : `.src/Gestion/option/menuopt.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/menuopt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 127 |
| Lignes de commentaire | 2 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 18 |
| Complexité max (fonction) | 3 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 127 | 18 | 3 | 0 | 14 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MENUOPT-001 — [documentation] En-tête : table des entrées créées par option, menu masqué,
  écrans ouverts sur leur auto-instance · appelants : aucun · tests : aucun · sources : [menuopt.class:_new](../../../../../.src/Gestion/option/menuopt.class#L8-L35)
- [ ] MENUOPT-002 — [complexité] `_new` : table `[option, parent, groupe, libellé]` parcourue par
  une boucle, même ordre de création et mêmes noms de groupes · appelants : `Fmenu` (inchangé) ·
  tests : T01, T02 · sources : [menuopt.class:_new](../../../../../.src/Gestion/option/menuopt.class#L8-L35)
- [ ] MENUOPT-003 — [séparation traitement/GUI] `btn_Click` : impression déléguée à
  `EditeTipp(mois, annee)` · appelants : aucun · tests : T03 · sources : [menuopt.class:btn_Click](../../../../../.src/Gestion/option/menuopt.class#L161-L174)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MENUOPT-A01 — [anomalie, à confirmer] `win_close` rappelle `$win.Close` dans l'événement
  `Close` de la même fenêtre (ré-entrance) ; suppression à valider · tests : T03 · sources : [menuopt.class:win_close](../../../../../.src/Gestion/option/menuopt.class#L176-L180)
- [ ] MENUOPT-A02 — [anomalie] Aucun contrôle de l'année ; mois invalide : `Stop Event` sur
  `LostFocus` n'empêche pas la validation par OK (à confirmer) · tests : T03 · sources : [menuopt.class:mois_lostfocus](../../../../../.src/Gestion/option/menuopt.class#L144-L153), [menuopt.class:annee_lostfocus](../../../../../.src/Gestion/option/menuopt.class#L155-L159)
