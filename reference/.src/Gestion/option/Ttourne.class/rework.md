# Ttourne — Rework

> Source : `.src/Gestion/option/Ttourne.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/Ttourne.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 147 |
| Lignes de commentaire | 3 |
| Fonctions | 21 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 46 |
| Complexité max (fonction) | 7 (`bar1_valide`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 147 | 46 | 7 | 0 | 18 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TTOURNE-001 — [documentation] En-tête en français : rôle, table `Fiches_tourne`, cycle
  transactionnel de `Barselection`, onglet statistiques `Gridvi` ; renommer le paramètre `anul` en
  `modif` dans `bar1_valide` (nom du handler inchangé) · appelants : aucun · tests : T01-T06 ·
  sources : [Ttourne.class:form_Open](../../../../../.src/Gestion/option/Ttourne.class#L8-L21), [Ttourne.class:bar1_valide](../../../../../.src/Gestion/option/Ttourne.class#L128-L148)
- [ ] TTOURNE-002 — [séparation traitement/GUI] `ChargeTournees() As Result` (requête triée écrite
  trois fois) et `TourneeExiste(code) As Boolean` (deux fois), sans accès aux contrôles ; SQL
  identique · appelants : aucun · tests : T01-T05 · sources : [Ttourne.class:form_Open](../../../../../.src/Gestion/option/Ttourne.class#L8-L21),
  [Ttourne.class:Textnum_LostFocus](../../../../../.src/Gestion/option/Ttourne.class#L29-L50), [Ttourne.class:bar1_annule](../../../../../.src/Gestion/option/Ttourne.class#L64-L73), [Ttourne.class:bar1_valide](../../../../../.src/Gestion/option/Ttourne.class#L128-L148)
- [ ] TTOURNE-003 — [complexité] `bar1_valide` : extraire `ValideTournee(code) As String` (motif de
  refus) ; le handler garde `Stop Event` (CC 7 → ≤ 4 visé) · appelants : aucun · tests : T01, T02 ·
  sources : [Ttourne.class:bar1_valide](../../../../../.src/Gestion/option/Ttourne.class#L128-L148)
- [ ] TTOURNE-004 — [réarchitecture] Clé `Cbase.Table("TabTourne")` pour `Fiches_tourne` (avec
  RECHTOUR-003), SQL identique · appelants : aucun · tests : T01-T05 · sources :
  [Ttourne.class:form_Open](../../../../../.src/Gestion/option/Ttourne.class#L8-L21), [Ttourne.class:bar1_creer](../../../../../.src/Gestion/option/Ttourne.class#L75-L84), [Ttourne.class:bar1_modif](../../../../../.src/Gestion/option/Ttourne.class#L95-L100),
  [rechtour.class:_new](../../../../../.src/Gestion/option/rechtour.class#L7-L22)
- [ ] TTOURNE-005 — [commonalisation] Cycle `Barselection` commun (navigation, création et
  modification transactionnelles, rechargement et repositionnement) avec `Tregion`, `Tregie`,
  `Tconsigne`, `Mreglement` (MREGLEMENT-006) ; handlers `bar1_*` conservés, réduits à un appel ·
  appelants : aucun · tests : T01-T06 · sources : [Ttourne.class:bar1_creer](../../../../../.src/Gestion/option/Ttourne.class#L75-L84),
  [Ttourne.class:bar1_annule](../../../../../.src/Gestion/option/Ttourne.class#L64-L73), [Ttourne.class:bar1_suivant](../../../../../.src/Gestion/option/Ttourne.class#L120-L126), [Tregion.class:bar1_creer](../../../../../.src/Gestion/option/Tregion.class#L53-L63),
  [Mreglement.class:bar1_creer](../../../../../.src/Gestion/Tables/Mreglement.class#L105-L113)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TTOURNE-A01 — [anomalie] `form_Close` appelle `bar1_valide` sans argument (signature à
  deux `Boolean`) : « Not enough arguments » quand l'utilisateur répond « Oui » à
  l'enregistrement avant fermeture (vérifié avec `gbs3`) ; correction :
  `bar1_valide($bs.estcreer, $bs.estmodif)` · tests : T08 · sources : [Ttourne.class:192](../../../../../.src/Gestion/option/Ttourne.class#L192)
- [ ] TTOURNE-A02 — [anomalie] Transaction ouverte (`Begin`) pendant toute la saisie ; fermeture
  avec « Non » sans `Rollback` : la transaction reste ouverte sur la connexion partagée (même
  défaut que MREGLEMENT-A01) · tests : T07 · sources : [Ttourne.class:78](../../../../../.src/Gestion/option/Ttourne.class#L78), [Ttourne.class:97](../../../../../.src/Gestion/option/Ttourne.class#L97),
  [Ttourne.class:form_Close](../../../../../.src/Gestion/option/Ttourne.class#L189-L196)
- [ ] TTOURNE-A03 — [anomalie] Table vide à l'ouverture : `$grv` n'est pas créé, et la première
  validation appelle `affichedonne` → `$grv.code` sur `Null` (erreur « Null object ») · tests : T09 ·
  sources : [Ttourne.class:15](../../../../../.src/Gestion/option/Ttourne.class#L15), [Ttourne.class:203](../../../../../.src/Gestion/option/Ttourne.class#L203)
- [ ] TTOURNE-A04 — [anomalie] Bouton Suppression affiché (`"111111111"`) mais `bar1_suprimer`
  vide : la validation ne supprime rien et n'affiche rien ; implémenter (avec contrôle d'usage
  de la tournée) ou masquer le bouton · tests : T06 · sources : [Ttourne.class:bar1_suprimer](../../../../../.src/Gestion/option/Ttourne.class#L150-L154),
  [Ttourne.class:form_Open](../../../../../.src/Gestion/option/Ttourne.class#L8-L21)
