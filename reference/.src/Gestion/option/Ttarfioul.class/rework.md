# Ttarfioul — Rework

> Source : `.src/Gestion/option/Ttarfioul.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/Ttarfioul.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 267 |
| Lignes de commentaire | 4 |
| Fonctions | 14 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 60 |
| Complexité max (fonction) | 10 (`Button3_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 267 | 60 | 10 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TTARFIOUL-001 — [documentation] En-tête : barème dégressif fioul (marge de zone, supplément
  petites quantités, tranches), formule des prix, unité des bornes, deux modes d'ouverture ·
  appelants : aucun · tests : T01-T04 · sources : [Ttarfioul.class:_new](../../../../../.src/Gestion/option/Ttarfioul.class#L17-L66), [Ttarfioul.class:Button2_Click](../../../../../.src/Gestion/option/Ttarfioul.class#L256-L286)
- [ ] TTARFIOUL-002 — [séparation traitement/GUI] Fonction privée `PrixTranche(...)` (calcul pur)
  utilisée par `Button2_Click` · appelants : aucun · tests : T02, T05 · sources : [Ttarfioul.class:Button2_Click](../../../../../.src/Gestion/option/Ttarfioul.class#L256-L286)
- [ ] TTARFIOUL-003 — [commonalisation] Helper privé `VersTTC`/`VersHT` pour les 6 conversions de
  `tableview1_Save`, `tableview2_Save`, `affiche`, `Button2_Click` · appelants : aucun · tests :
  T01-T03 · sources : [Ttarfioul.class:tableview1_Save](../../../../../.src/Gestion/option/Ttarfioul.class#L144-L165), [Ttarfioul.class:tableview2_Save](../../../../../.src/Gestion/option/Ttarfioul.class#L178-L192), [Ttarfioul.class:affiche](../../../../../.src/Gestion/option/Ttarfioul.class#L209-L254)
- [ ] TTARFIOUL-004 — [code mort] `tableview1_Click`/`tableview2_Click` : supprimer le `New
  TextBox(…) As "txb"` immédiatement écrasé (aucun gestionnaire `txb_*`) ; variables `i, j` inutiles
  d'`affiche` · appelants : aucun · tests : T01-T03 · sources : [Ttarfioul.class:134](../../../../../.src/Gestion/option/Ttarfioul.class#L134), [Ttarfioul.class:171](../../../../../.src/Gestion/option/Ttarfioul.class#L171), [Ttarfioul.class:affiche](../../../../../.src/Gestion/option/Ttarfioul.class#L209-L254)
- [ ] TTARFIOUL-005 — [réarchitecture] `Cbase.Table("TabArt")`, `Cbase.Table("TabTvav")` (SQL
  identique) · appelants : aucun · tests : T01 · sources : [Ttarfioul.class:Textcode_LostFocus](../../../../../.src/Gestion/option/Ttarfioul.class#L102-L129)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TTARFIOUL-A01 — [anomalie, à confirmer] `Button3_Click` : `While i < tableview2.Rows.Max`
  n'enregistre pas la dernière ligne de `TableView2` (dernière tranche perdue après « calcul ») ;
  boucle `Repeat` sur `TableView1` sans garde si elle est vide · tests : T02, T03 · sources : [Ttarfioul.class:309](../../../../../.src/Gestion/option/Ttarfioul.class#L309), [Ttarfioul.class:319](../../../../../.src/Gestion/option/Ttarfioul.class#L319)
- [ ] TTARFIOUL-A02 — [anomalie] `button1_Click` remet `Variables.Bsel` à `False` au lieu de
  `Me.Bsel` : une recherche annulée réutilise la sélection précédente · tests : T02 · sources : [Ttarfioul.class:199](../../../../../.src/Gestion/option/Ttarfioul.class#L199)
- [ ] TTARFIOUL-A03 — [anomalie, à confirmer] Couleurs lues dans `Settings` au lieu de
  `Start.LocalSettings` (fichier de configuration `-c` ignoré) ; `affiche` sans `ORDER BY ligne` ·
  tests : T01 · sources : [Ttarfioul.class:23](../../../../../.src/Gestion/option/Ttarfioul.class#L23), [Ttarfioul.class:215](../../../../../.src/Gestion/option/Ttarfioul.class#L215)
