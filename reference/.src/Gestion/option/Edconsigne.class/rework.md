# Edconsigne — Rework

> Source : `.src/Gestion/option/Edconsigne.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/Edconsigne.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 244 |
| Lignes de commentaire | 11 |
| Fonctions | 7 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 35 |
| Complexité max (fonction) | 15 (`edition`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 244 | 35 | 15 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDCONSIGNE-001 — [documentation] En-tête : sources réunies (réceptions, BL, factures),
  inversion de signe consignes/déconsignes, modes et bornes, paramètres `&1`-`&8` · appelants :
  aucun · tests : T01-T04 · sources : [Edconsigne.class:Butedit_Click](../../../../../.src/Gestion/option/Edconsigne.class#L49-L126)
- [ ] EDCONSIGNE-002 — [séparation traitement/GUI] Fonction privée `RequeteSuivi(mode, detail) As
  String` (texte SQL identique) appelée par `Butedit_Click` · appelants : aucun · tests : T01-T04,
  T06 · sources : [Edconsigne.class:Butedit_Click](../../../../../.src/Gestion/option/Edconsigne.class#L49-L126)
- [ ] EDCONSIGNE-003 — [code mort] Supprimer `$coul` (calculée dans `_new`, jamais lue) · appelants :
  aucun · tests : T01 · sources : [Edconsigne.class:5](../../../../../.src/Gestion/option/Edconsigne.class#L5), [Edconsigne.class:28](../../../../../.src/Gestion/option/Edconsigne.class#L28)
- [ ] EDCONSIGNE-004 — [réarchitecture] `Cbase.Table` pour `Fiches_Cli`, `Fiches_Four`, `Fiches_Bl`,
  `Fiches_Ligbl`, `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_Entrecpt`, `Fiches_Ligrecpt`
  (SQL identique) · appelants : aucun · tests : T01-T04, T06 · sources : [Edconsigne.class:Butedit_Click](../../../../../.src/Gestion/option/Edconsigne.class#L49-L126), [Edconsigne.class:tcli](../../../../../.src/Gestion/option/Edconsigne.class#L275-L286), [Edconsigne.class:tfou](../../../../../.src/Gestion/option/Edconsigne.class#L288-L299)
- [ ] EDCONSIGNE-005 — [commonalisation] `tcli`/`tfou` : fonction utilitaire commune de libellé de
  tiers (phase 3) · appelants : aucun · tests : T03, T04 · sources : [Edconsigne.class:tcli](../../../../../.src/Gestion/option/Edconsigne.class#L275-L286), [Edconsigne.class:tfou](../../../../../.src/Gestion/option/Edconsigne.class#L288-L299)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDCONSIGNE-A01 — [anomalie, à confirmer] Jointure `Fiches_consigne.code = Fiches_ligcons.code`
  (identifiant auto-incrémenté) au lieu de `codecons`, et colonne « code » affichée = identifiant :
  l'état ne rapproche pas les bons mouvements · tests : T01-T04 · sources : [Edconsigne.class:80](../../../../../.src/Gestion/option/Edconsigne.class#L80), [Edconsigne.class:84](../../../../../.src/Gestion/option/Edconsigne.class#L84), [Edconsigne.class:88](../../../../../.src/Gestion/option/Edconsigne.class#L88), [Edconsigne.class:92](../../../../../.src/Gestion/option/Edconsigne.class#L92)
- [ ] EDCONSIGNE-A02 — [anomalie, à confirmer] Jointures sur le seul numéro de document : chaque
  mouvement est répété (et sommé) autant de fois que le document a de lignes · tests : T01, T02 ·
  sources : [Edconsigne.class:80](../../../../../.src/Gestion/option/Edconsigne.class#L80), [Edconsigne.class:96](../../../../../.src/Gestion/option/Edconsigne.class#L96)
- [ ] EDCONSIGNE-A03 — [anomalie] Mode cumul : la requête BL ne filtre pas `type <> 'E'` (le détail
  le fait) ; pas d'`ORDER BY` pour les ruptures client/fournisseur · tests : T02, T03 · sources : [Edconsigne.class:96](../../../../../.src/Gestion/option/Edconsigne.class#L96), [Edconsigne.class:edition](../../../../../.src/Gestion/option/Edconsigne.class#L128-L273)
- [ ] EDCONSIGNE-A04 — [anomalie] Boutons de recherche des bornes (`Butcli`, `Butclis`, `Butfou`,
  `Butcli4`, `But`, `Buts`) sans gestionnaire ; sélection vide sans message · tests : T05 ·
  sources : [Edconsigne.class:Butedit_Click](../../../../../.src/Gestion/option/Edconsigne.class#L49-L126)
