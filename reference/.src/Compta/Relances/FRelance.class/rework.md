# FRelance — Rework

> Source : `.src/Compta/Relances/FRelance.class` · Message de commit (phase 4) : `reference/.src/Compta/Relances/FRelance.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 74 |
| Lignes de commentaire | 22 |
| Fonctions | 9 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 18 |
| Complexité max (fonction) | 4 (`Form_Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 74 | 18 | 4 | 0 | 9 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FRELANCE-001 — [documentation] En-tête en français : rôle des niveaux, signification de
  `libell1`/`libell2`, écrans consommateurs (`FEditrel`, `Ligcli`) · appelants : aucun · tests :
  aucun · sources : [FRelance.class:_New](../../../../../.src/Compta/Relances/FRelance.class#L30-L37)
- [ ] FRELANCE-002 — [complexité] Constante privée pour `Fiches_Txt_Relances` à la place des 4
  variables locales `Tab` (SQL identique) · appelants : aucun · tests : T01-T04 · sources :
  [FRelance.class:Form_Open](../../../../../.src/Compta/Relances/FRelance.class#L39-L57), [FRelance.class:Button2_Click](../../../../../.src/Compta/Relances/FRelance.class#L65-L81), [FRelance.class:niveau_Click](../../../../../.src/Compta/Relances/FRelance.class#L83-L98), [FRelance.class:Button1_Click](../../../../../.src/Compta/Relances/FRelance.class#L112-L128)
- [ ] FRELANCE-003 — [séparation traitement/GUI] Fonctions privées `ChargeNiveaux`, `LitTexte`,
  `EnregistreTexte`, `SupprimeTexte` sans accès aux contrôles ; handlers réduits à l'affichage
  (SQL identique) · appelants : aucun · tests : T01-T05 · sources : [FRelance.class:Form_Open](../../../../../.src/Compta/Relances/FRelance.class#L39-L57),
  [FRelance.class:Button2_Click](../../../../../.src/Compta/Relances/FRelance.class#L65-L81), [FRelance.class:niveau_Click](../../../../../.src/Compta/Relances/FRelance.class#L83-L98), [FRelance.class:Button1_Click](../../../../../.src/Compta/Relances/FRelance.class#L112-L128)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FRELANCE-A01 — [anomalie] « Supprimer » : la question est posée même sans niveau saisi, et
  les zones sont vidées même si l'utilisateur répond « Non » · tests : T04 · sources :
  [FRelance.class:120](../../../../../.src/Compta/Relances/FRelance.class#L120), [FRelance.class:124-126](../../../../../.src/Compta/Relances/FRelance.class#L124-L126)
- [ ] FRELANCE-A02 — [anomalie] `Form_Open` : `Catch` vide, une erreur SQL (table absente) laisse
  un écran vide sans message · tests : T01 · sources : [FRelance.class:55](../../../../../.src/Compta/Relances/FRelance.class#L55)
- [ ] FRELANCE-A03 — [anomalie] Niveau non numérique accepté par `Button2_Click` (colonne
  `int(11)`) ; ajouter un contrôle de saisie · tests : T05 · sources : [FRelance.class:70-77](../../../../../.src/Compta/Relances/FRelance.class#L70-L77)
