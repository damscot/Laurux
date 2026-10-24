# Plancomptable — Rework

> Source : `.src/Compta/Impressions/Plancomptable.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/Plancomptable.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 155 |
| Lignes de commentaire | 22 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 42 |
| Complexité max (fonction) | 8 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 155 | 42 | 8 | 0 | 16 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] PLANCOMPTABLE-001 — [documentation] En-tête en français : plages par type, `Bsel`/`Bval`
  écrites par `TriCpt` (à garder `Public`), groupe `btn` · appelants : aucun · tests : T01-T03 · sources : [Plancomptable.class:_New](../../../../../.src/Compta/Impressions/Plancomptable.class#L35-L43), [Plancomptable.class:Btn_Click](../../../../../.src/Compta/Impressions/Plancomptable.class#L71-L87)
- [ ] PLANCOMPTABLE-002 — [code mort] Supprimer `Nbpage`, `dte`, `PosY + 160`, `Shell "cd"` de
  `Button2_Click` et le cas 1 inatteignable de `Btn_Click` · appelants : aucun · tests : T01 · sources : [Plancomptable.class:Button2_Click](../../../../../.src/Compta/Impressions/Plancomptable.class#L173-L234), [Plancomptable.class:Btn_Click](../../../../../.src/Compta/Impressions/Plancomptable.class#L71-L87)
- [ ] PLANCOMPTABLE-003 — [commonalisation] Helper privé `ChoixType(sDebut, sFin, sType)` pour les
  quatre handlers de type, et `ChoixCompte(hCible, hSuivant)` pour les deux `ToggleButton` ·
  appelants : aucun · tests : T01, T03 · sources : [Plancomptable.class:Bclient_Click](../../../../../.src/Compta/Impressions/Plancomptable.class#L133-L141), [Plancomptable.class:Bbilan_Click](../../../../../.src/Compta/Impressions/Plancomptable.class#L163-L171), [Plancomptable.class:ToggleButton2_Click](../../../../../.src/Compta/Impressions/Plancomptable.class#L45-L56), [Plancomptable.class:ToggleButton3_Click](../../../../../.src/Compta/Impressions/Plancomptable.class#L58-L69)
- [ ] PLANCOMPTABLE-004 — [séparation traitement/GUI] `ListeComptes(sDebut, sFin, sType) As Result`
  et `ImprimePlan(r, sTitre)` sans accès aux contrôles ; tables par `Cbase.Table("TabSoc")` /
  `Cbase.Table("TabComptes")` (même SQL) · appelants : aucun · tests : T01, T02 · sources : [Plancomptable.class:Button2_Click](../../../../../.src/Compta/Impressions/Plancomptable.class#L173-L234)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] PLANCOMPTABLE-A01 — [anomalie] F2 dans `Cpt` remplit `Cpt2` et F2 dans `Cpt2` remplit `Cpt`
  (handlers croisés, à confirmer à l'écran) ; `Bsel` jamais remis à `False` · tests : T03 · sources : [Plancomptable.class:95](../../../../../.src/Compta/Impressions/Plancomptable.class#L95), [Plancomptable.class:105](../../../../../.src/Compta/Impressions/Plancomptable.class#L105)
- [ ] PLANCOMPTABLE-A02 — [anomalie] Curseur final `Mouse.Pointing` au lieu de `Mouse.Default` ;
  lecture de `Fiches_Societes` sans test `Available` · tests : T01 · sources : [Plancomptable.class:232](../../../../../.src/Compta/Impressions/Plancomptable.class#L232), [Plancomptable.class:190](../../../../../.src/Compta/Impressions/Plancomptable.class#L190)
