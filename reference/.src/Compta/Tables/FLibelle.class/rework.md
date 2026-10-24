# FLibelle — Rework

> Source : `.src/Compta/Tables/FLibelle.class` · Message de commit (phase 4) : `reference/.src/Compta/Tables/FLibelle.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 134 |
| Lignes de commentaire | 22 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 35 |
| Complexité max (fonction) | 10 (`Lib_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 134 | 35 | 10 | 0 | 15 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FLIBELLE-001 — [documentation] En-tête en français : table, usage par la saisie des
  écritures, procédures `num_*`/`intitule_*` appelées explicitement (groupe `Lib`) · appelants :
  aucun · tests : aucun · sources : [FLibelle.class:_New](../../../../../.src/Compta/Tables/FLibelle.class#L30-L44), [FLibelle.class:Lib_KeyPress](../../../../../.src/Compta/Tables/FLibelle.class#L85-L113)
- [ ] FLIBELLE-002 — [complexité] Un seul `Refresh()` après insertion dans `Button2_Click`, `Else`
  vide supprimé — SQL modifié (un SELECT de moins), dump identique · appelants : aucun · tests :
  T01, T02 · sources : [FLibelle.class:194](../../../../../.src/Compta/Tables/FLibelle.class#L194), [FLibelle.class:198](../../../../../.src/Compta/Tables/FLibelle.class#L198), [FLibelle.class:178](../../../../../.src/Compta/Tables/FLibelle.class#L178)
- [ ] FLIBELLE-003 — [réarchitecture] `Cbase.Table("TabLibel")` à la place de la locale `Tab`
  (SQL identique) · appelants : aucun · tests : T01-T03 · sources : [FLibelle.class:Form_Open](../../../../../.src/Compta/Tables/FLibelle.class#L46-L60), [FLibelle.class:Button1_Click](../../../../../.src/Compta/Tables/FLibelle.class#L160-L181), [FLibelle.class:Button2_Click](../../../../../.src/Compta/Tables/FLibelle.class#L183-L206)
- [ ] FLIBELLE-004 — [séparation traitement/GUI] `EnregistreLibelle(sNum, sLib)` et
  `SupprimeLibelle(sNum)` sans contrôle · appelants : aucun · tests : T01-T03 · sources : [FLibelle.class:Button1_Click](../../../../../.src/Compta/Tables/FLibelle.class#L160-L181), [FLibelle.class:Button2_Click](../../../../../.src/Compta/Tables/FLibelle.class#L183-L206)
- [ ] FLIBELLE-005 — [réduction de portée] `Maj_Zones`, `CleanChamps`, `Refresh` → `Private` ·
  appelants : aucun · tests : T01-T03 · sources : [FLibelle.class:Maj_Zones](../../../../../.src/Compta/Tables/FLibelle.class#L62-L69), [FLibelle.class:CleanChamps](../../../../../.src/Compta/Tables/FLibelle.class#L71-L76), [FLibelle.class:Refresh](../../../../../.src/Compta/Tables/FLibelle.class#L78-L83)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FLIBELLE-A01 — [anomalie] La suppression vise la ligne sélectionnée (`colcol.Current[0]`) et
  non le numéro saisi ; erreur si aucune ligne n'est sélectionnée · tests : T03 · sources : [FLibelle.class:170](../../../../../.src/Compta/Tables/FLibelle.class#L170)
