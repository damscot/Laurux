# MyStyle — Rework

> Source : `.src/Caisse/MyStyle.class` · Message de commit (phase 4) : `reference/.src/Caisse/MyStyle.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 38 |
| Lignes de commentaire | 2 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 5 (`DrawButton`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 38 | 5 | 5 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MYSTYLE-001 — [documentation] En-tête : rôle, contexte `Paint` requis, signification des
  drapeaux (seuls 2 et 6 changent le rendu), seul utilisateur `ImageButton` · appelants : aucun ·
  tests : aucun · sources : [MyStyle.class:DrawButton](../../../../.src/Caisse/MyStyle.class#L10-L47)
- [ ] MYSTYLE-002 — [code mort] Supprimer les constantes `Normal` et `Active` (jamais
  référencées) et la ligne commentée `Paint.AntiAlias` · appelants : aucun · tests : T01, T02 · sources : [MyStyle.class:4](../../../../.src/Caisse/MyStyle.class#L4), [MyStyle.class:8](../../../../.src/Caisse/MyStyle.class#L8), [MyStyle.class:29](../../../../.src/Caisse/MyStyle.class#L29)
- [ ] MYSTYLE-003 — [réarchitecture] Intégrer `DrawButton` et les constantes utilisées dans
  `ImageButton` (privés), puis supprimer `MyStyle.class` (sans `.form`) et son dossier de
  référence ; rendu identique · appelants : `ImageButton` · tests : T01, IMAGEBUTTON-T03 · sources : [MyStyle.class:DrawButton](../../../../.src/Caisse/MyStyle.class#L10-L47), [ImageButton.class:View_Draw](../../../../.src/Caisse/ImageButton.class#L88-L124)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MYSTYLE-A01 — [anomalie] Drapeaux comparés par égalité (`Flag = 2 Or Flag = 6`) : l'état
  `Disabled` n'est jamais dessiné, le survol seul non plus, et un bouton désactivé avec focus perd
  son cadre ; le cadre ignore `X`/`Y` · tests : T01 · sources : [MyStyle.class:41](../../../../.src/Caisse/MyStyle.class#L41), [MyStyle.class:43](../../../../.src/Caisse/MyStyle.class#L43)
