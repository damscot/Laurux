# rechtour — Rework

> Source : `.src/Gestion/option/rechtour.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/rechtour.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 40 |
| Lignes de commentaire | 1 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 10 |
| Complexité max (fonction) | 3 (`GridView1_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 40 | 10 | 3 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RECHTOUR-001 — [documentation] En-tête en français : rôle, événement `trouve` et convention
  de l'espace pour « effacer », liste des quatre appelants et de leurs handlers · appelants :
  aucun · tests : T01-T04 · sources : [rechtour.class:_new](../../../../../.src/Gestion/option/rechtour.class#L7-L22), [rechtour.class:GridView1_KeyPress](../../../../../.src/Gestion/option/rechtour.class#L45-L53)
- [ ] RECHTOUR-002 — [code mort] Supprimer la variable locale `res` inutilisée de `GridView1_Data` ·
  appelants : aucun · tests : T01, T03 · sources : [rechtour.class:GridView1_Data](../../../../../.src/Gestion/option/rechtour.class#L24-L36)
- [ ] RECHTOUR-003 — [réarchitecture] Nom de table via une clé `Cbase.Table("TabTourne")` (à
  créer dans `Cbase.module`, SQL identique), avec TTOURNE-004 · appelants : aucun · tests : T01-T04 ·
  sources : [rechtour.class:_new](../../../../../.src/Gestion/option/rechtour.class#L7-L22), [Ttourne.class:form_Open](../../../../../.src/Gestion/option/Ttourne.class#L8-L21)
- [ ] RECHTOUR-004 — [commonalisation] Fenêtres de recherche code/libellé du lot option
  (`rechtour`, `rechcons`, `rechtipp`) : composant commun de liste + événement `trouve`, décision en
  phase 3 après comparaison ; handlers et noms de contrôles inchangés · appelants : `Facture`,
  `Facturefm`, `FClient` (inchangés si l'événement est conservé) · tests : T01-T04 · sources :
  [rechtour.class:_new](../../../../../.src/Gestion/option/rechtour.class#L7-L22), [rechtour.class:GridView1_Activate](../../../../../.src/Gestion/option/rechtour.class#L38-L43)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RECHTOUR-A01 — [anomalie] `SELECT * FROM Fiches_tourne` sans `ORDER BY` : ordre d'affichage
  non garanti (ordre physique, différent de `Ttourne` qui trie par code) ; correction =
  `ORDER BY code` · tests : T03 · sources : [rechtour.class:19](../../../../../.src/Gestion/option/rechtour.class#L19)
- [ ] RECHTOUR-A02 — [anomalie] Fenêtre non instrumentée (`Utils.Observers(Me)` absent) : choix de
  tournée non journalisé, donc non rejouable ; l'ajout modifie le log produit · tests : T01-T03 ·
  sources : [rechtour.class:_new](../../../../../.src/Gestion/option/rechtour.class#L7-L22)
