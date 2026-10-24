# Marques — Rework

> Source : `.src/Gestion/Tables/Marques.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Marques.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 240 |
| Lignes de commentaire | 22 |
| Fonctions | 29 |
| Fonctions Public | 29 |
| Complexité cyclomatique totale | 62 |
| Complexité max (fonction) | 8 (`Cpost_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 240 | 62 | 8 | 0 | 29 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MARQUES-001 — [documentation] En-tête : rôle, principe du filtre, noms hérités de Cpostaux
  (`Cpost`, `CpTable`, `ChkCp`) · appelants : aucun · tests : aucun · sources : [Marques.class:20](../../../../../.src/Gestion/Tables/Marques.class#L20)
- [ ] MARQUES-002 — [code mort] Supprimer `cpoint` (copie locale jamais appelée) · appelants :
  aucun · tests : T01 · sources : [Marques.class:cpoint](../../../../../.src/Gestion/Tables/Marques.class#L47-L51)
- [ ] MARQUES-003 — [réarchitecture] `Cbase.Table("TabMarq")` au lieu des noms en dur ; `CpTable`
  initialisé une fois · appelants : aucun · tests : T01-T05 · sources : [Marques.class:Form_Open](../../../../../.src/Gestion/Tables/Marques.class#L53-L62), [Marques.class:Button1_Click](../../../../../.src/Gestion/Tables/Marques.class#L197-L217), [Marques.class:Button3_Click](../../../../../.src/Gestion/Tables/Marques.class#L219-L234), [Marques.class:Colmarque_Data](../../../../../.src/Gestion/Tables/Marques.class#L64-L74)
- [ ] MARQUES-004 — [commonalisation] Socle « grille filtrable » (voir CPOSTAUX-005) · appelants :
  aucun · tests : T03, T04 · sources : [Marques.class:Deb2](../../../../../.src/Gestion/Tables/Marques.class#L88-L92), [Marques.class:Deb3](../../../../../.src/Gestion/Tables/Marques.class#L94-L98), [Marques.class:Dbclk](../../../../../.src/Gestion/Tables/Marques.class#L342-L352), [Marques.class:ChkCp](../../../../../.src/Gestion/Tables/Marques.class#L249-L257)
- [ ] MARQUES-005 — [séparation traitement/GUI] `EnregistreMarque`, `SupprimeMarque` sans
  contrôle · appelants : aucun · tests : T01, T02, T05 · sources : [Marques.class:Button1_Click](../../../../../.src/Gestion/Tables/Marques.class#L197-L217), [Marques.class:Button3_Click](../../../../../.src/Gestion/Tables/Marques.class#L219-L234)
- [ ] MARQUES-006 — [réduction de portée] `Tris`, `Deb2`, `Deb3`, `Refresh`, `Maj_Zones`,
  `Cleanchamps`, `Cmarque_LostFocus`, `Button1_Click`, `Button3_Click`, `Cpman`, `ChkCp`, `Ref`,
  `Dbclk` → `Private` ; `Colmarque_Click` reste `Public` (rejeu) · appelants : aucun · tests :
  T01-T05 · sources : [Marques.class:Tris](../../../../../.src/Gestion/Tables/Marques.class#L76-L86), [Marques.class:Cmarque_LostFocus](../../../../../.src/Gestion/Tables/Marques.class#L191-L195), [Marques.class:Cpman](../../../../../.src/Gestion/Tables/Marques.class#L236-L247), [Marques.class:Ref](../../../../../.src/Gestion/Tables/Marques.class#L333-L340)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MARQUES-A01 — [anomalie] Filtres `Form_Open`/`Deb2`/`Deb3` par concaténation de la frappe
  (`"` casse la requête) · tests : T04 · sources : [Marques.class:58](../../../../../.src/Gestion/Tables/Marques.class#L58), [Marques.class:90](../../../../../.src/Gestion/Tables/Marques.class#L90), [Marques.class:96](../../../../../.src/Gestion/Tables/Marques.class#L96)
- [ ] MARQUES-A02 — [anomalie] Code de marque limité aux chiffres par `ChkCp` (contrôle copié des
  codes postaux) · tests : T03 · sources : [Marques.class:152](../../../../../.src/Gestion/Tables/Marques.class#L152), [Marques.class:ChkCp](../../../../../.src/Gestion/Tables/Marques.class#L249-L257)
- [ ] MARQUES-A03 — [anomalie] Suppression de la ligne sélectionnée sans contrôle d'usage
  (articles, matériels) ; code non unique (UPDATE sur tous les doublons) · tests : T05 · sources : [Marques.class:229](../../../../../.src/Gestion/Tables/Marques.class#L229)
