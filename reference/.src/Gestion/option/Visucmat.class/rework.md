# Visucmat — Rework

> Source : `.src/Gestion/option/Visucmat.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/Visucmat.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 86 |
| Lignes de commentaire | 1 |
| Fonctions | 7 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 8 |
| Complexité max (fonction) | 2 (`_new`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 86 | 8 | 2 | 0 | 6 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VISUCMAT-001 — [documentation] En-tête en français : consultation des mouvements de la
  comptabilité matières, colonnes, rôle de `Bsel`/`Bval` (écrits par `TriGen`) · appelants :
  aucun · tests : T01-T02 · sources : [Visucmat.class:_new](../../../../../.src/Gestion/option/Visucmat.class#L11-L80), [Visucmat.class:Form_Open](../../../../../.src/Gestion/option/Visucmat.class#L82-L91)
- [ ] VISUCMAT-002 — [commonalisation] `Private Sub Filtre()` (ou `FiltrePeriode(dDeb, dFin) As
  String`) appelé par `Form_Open`, `dtdeb_LostFocus`, `dtfin_LostFocus` ; SQL identique ·
  appelants : aucun · tests : T01, T02 · sources : [Visucmat.class:Form_Open](../../../../../.src/Gestion/option/Visucmat.class#L82-L91),
  [Visucmat.class:dtdeb_LostFocus](../../../../../.src/Gestion/option/Visucmat.class#L114-L119), [Visucmat.class:dtfin_LostFocus](../../../../../.src/Gestion/option/Visucmat.class#L121-L126)
- [ ] VISUCMAT-003 — [complexité] Définition des 12 colonnes par un tableau (champ, titre,
  alignement, format) parcouru en boucle ; colonnes identiques · appelants : aucun · tests : T01 ·
  sources : [Visucmat.class:_new](../../../../../.src/Gestion/option/Visucmat.class#L11-L80)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VISUCMAT-A01 — [anomalie] `arrete` lu sans test (`Available`, valeur nulle) : date de début
  invalide si l'arrêté n'est pas paramétré ; table vide → colonnes non définies avant la création
  de `TriGen` · tests : T03, T04 · sources : [Visucmat.class:18](../../../../../.src/Gestion/option/Visucmat.class#L18), [Visucmat.class:24](../../../../../.src/Gestion/option/Visucmat.class#L24)
- [ ] VISUCMAT-A02 — [anomalie] Début de période = premier jour du mois de l'arrêté, alors
  qu'`Einvmat`/`Ecomptamat` font commencer l'exercice au mois **suivant** l'arrêté (à trancher
  par l'utilisateur, avec le format réel de `arrete`) · tests : T01 · sources :
  [Visucmat.class:20](../../../../../.src/Gestion/option/Visucmat.class#L20), [Einvmat.class:_new](../../../../../.src/Gestion/option/Einvmat.class#L9-L48)
- [ ] VISUCMAT-A03 — [anomalie] Écran non instrumenté (`Utils.Observers(Me)` absent) : non
  rejouable · tests : T01-T04 · sources : [Visucmat.class:_new](../../../../../.src/Gestion/option/Visucmat.class#L11-L80)
