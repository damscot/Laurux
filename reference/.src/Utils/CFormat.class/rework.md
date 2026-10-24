# CFormat — Rework

> Source : `.src/Utils/CFormat.class` · Message de commit (phase 4) : `reference/.src/Utils/CFormat.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 123 |
| Lignes de commentaire | 5 |
| Fonctions | 19 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 48 |
| Complexité max (fonction) | 18 (`ToString`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 123 | 48 | 18 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CFORMAT-001 — [documentation] En-tête en français : rôle, grammaire de la chaîne de format
  (clés, séparateurs, valeurs), convention « -1 = non défini », exemples réels de `Laurux.conf` ·
  appelants : aucun · tests : T01-T06 · sources : [CFormat.class:_Get](../../../../.src/Utils/CFormat.class#L25-L61), [CFormat.class:ToString](../../../../.src/Utils/CFormat.class#L63-L86)
- [ ] CFORMAT-002 — [code mort] Supprimer `Copy` (aucun appelant) et les `New` inutiles de `_Get`
  · appelants : aucun · tests : T01-T06 · sources : [CFormat.class:Copy](../../../../.src/Utils/CFormat.class#L148-L156), [CFormat.class:_Get](../../../../.src/Utils/CFormat.class#L25-L61)
- [ ] CFORMAT-003 — [complexité] `ToString` : helper privé `Defini(v)` et helper de recherche du
  nom d'alignement (même résultat, y compris le dernier symbole en l'absence de correspondance)
  (CC 18 → ≤ 8 visé) · appelants : `SetColors` (inchangé) · tests : T05, T06 · sources : [CFormat.class:ToString](../../../../.src/Utils/CFormat.class#L63-L86)
- [ ] CFORMAT-004 — [commonalisation] Ajouter `Public Sub Applique(hCtrl As Object)` (sémantique
  de `SetColors.InitTxtB` : replis `Color.TextBackground`, `Color.TextForeground`, `Align.Left`,
  police) puis l'utiliser dans `SetColors` (`Coul_DblClick`, `InitTxtB`) et `FSetFormat.Form_Open`
  (voir SETCOLORS-003, FSETFORMAT-003) ; `Attrib` en phase Caisse · appelants : `SetColors`,
  `FSetFormat`, `Attrib` · tests : T06, SETCOLORS-T02, FSETFORMAT-T01 · sources : [SetColors.class:InitTxtB](../../../../.src/Utils/SetColors.class#L68-L86), [SetColors.class:Coul_DblClick](../../../../.src/Utils/SetColors.class#L39-L66), [FSetFormat.class:Form_Open](../../../../.src/Utils/FSetFormat.class#L40-L50)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CFORMAT-A01 — [anomalie] `_Get:51` : `Format = Val(spl[1])` convertit le format numérique en
  nombre (`"0.000"` → `"0"`) ; impact : colonne « Remise » de `Remisec` si elle est lue comme
  Float (à confirmer) · tests : T03 · sources : [CFormat.class:51](../../../../.src/Utils/CFormat.class#L51)
- [ ] CFORMAT-A02 — [anomalie] `_Get:33` : `LCase` sur toute la chaîne (nom de police et nom
  d'alignement en minuscules) ; à confirmer par T02 que `Align` est bien retrouvé · tests : T02 · sources : [CFormat.class:33](../../../../.src/Utils/CFormat.class#L33)
- [ ] CFORMAT-A03 — [anomalie] `ToString:73-78` : un alignement sans constante correspondante est
  sérialisé sous le nom du dernier symbole de `Align` · tests : T05 · sources : [CFormat.class:73-78](../../../../.src/Utils/CFormat.class#L73-L78)
