# journauxSetting — Rework

> Source : `.src/Compta/Impressions/journauxSetting.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/journauxSetting.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 123 |
| Lignes de commentaire | 6 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 35 |
| Complexité max (fonction) | 16 (`BtnValider_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 123 | 35 | 16 | 0 | 10 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] JOURNAUXSETTING-001 — [documentation] En-tête en français : rôle, contrat des clés
  `/ExportJournal<soc>/Entete<i>`/`Titre<i>` avec `Journaux` (indices 0-11, `" "` = absent) ·
  appelants : aucun · tests : aucun · sources : [journauxSetting.class:BtnValider_Click](../../../../../.src/Compta/Impressions/journauxSetting.class#L5-L56)
- [ ] JOURNAUXSETTING-002 — [code mort] Supprimer `trouver` et le double usage de `dragText`
  (compteur local entier dans `BtnValider_Click` et `testColonne`) · appelants : aucun · tests :
  T01-T03 · sources : [journauxSetting.class:3](../../../../../.src/Compta/Impressions/journauxSetting.class#L3), [journauxSetting.class:12-15](../../../../../.src/Compta/Impressions/journauxSetting.class#L12-L15), [journauxSetting.class:108-112](../../../../../.src/Compta/Impressions/journauxSetting.class#L108-L112)
- [ ] JOURNAUXSETTING-003 — [complexité] Tableau constant privé des 12 libellés (indice =
  valeur `Entete`) utilisé par `Form_Open` et `BtnValider_Click` à la place de la liste et du
  `Select Case` (CC 16 → ≤ 5 visé) ; clés et valeurs écrites identiques · appelants : aucun ·
  tests : T01, T02 · sources : [journauxSetting.class:18-43](../../../../../.src/Compta/Impressions/journauxSetting.class#L18-L43), [journauxSetting.class:142-153](../../../../../.src/Compta/Impressions/journauxSetting.class#L142-L153)
- [ ] JOURNAUXSETTING-004 — [commonalisation] Lecture et écriture des clés `/ExportJournal…` par
  des helpers partagés avec `Journaux.Colonnes`/`Button4_Click` (`ImpCompta.TitresExport`,
  `ImpCompta.ColonnesExport`, `ImpCompta.EnregistreColonnes`) · appelants : `Journaux` (même
  commit, voir JOURNAUX-006) · tests : T01, T02, JOURNAUX-T06 · sources : [journauxSetting.class:44-50](../../../../../.src/Compta/Impressions/journauxSetting.class#L44-L50), [journauxSetting.class:156-160](../../../../../.src/Compta/Impressions/journauxSetting.class#L156-L160), [Journaux.class:Colonnes](../../../../../.src/Compta/Impressions/Journaux.class#L793-L808)
- [ ] JOURNAUXSETTING-005 — [séparation traitement/GUI] `BtnValider_Click` délègue l'écriture
  de la configuration à une fonction sans contrôle recevant la liste des titres · appelants :
  aucun · tests : T01, T02, T04 · sources : [journauxSetting.class:BtnValider_Click](../../../../../.src/Compta/Impressions/journauxSetting.class#L5-L56)
- [ ] JOURNAUXSETTING-006 — [réduction de portée] `testColonne` → `Private` (aucun appelant
  externe) · appelants : aucun · tests : T03 · sources : [journauxSetting.class:testColonne](../../../../../.src/Compta/Impressions/journauxSetting.class#L102-L131)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] JOURNAUXSETTING-A01 — [anomalie] Valider avec une liste vide n'efface pas la configuration :
  l'ancien ordre de colonnes reste actif pour l'export · tests : T04 · sources : [journauxSetting.class:13-51](../../../../../.src/Compta/Impressions/journauxSetting.class#L13-L51)
- [ ] JOURNAUXSETTING-A02 — [anomalie] Dépôt sur `ListBox1` : ajout sans contrôle (doublons dans
  la liste des champs) et sans retrait de `ListBox2` · tests : T05 · sources : [journauxSetting.class:ListBox1_Drop](../../../../../.src/Compta/Impressions/journauxSetting.class#L78-L82)
