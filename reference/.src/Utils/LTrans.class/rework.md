# LTrans — Rework

> Source : `.src/Utils/LTrans.class` · Message de commit (phase 4) : `reference/.src/Utils/LTrans.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 22 |
| Lignes de commentaire | 2 |
| Fonctions | 5 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 1 (`New`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 22 | 5 | 1 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LTRANS-001 — [documentation] En-tête en français : rôle, contrat `List = Null` tant que rien
  n'est sélectionné, copie à l'écriture · appelants : aucun · tests : T01-T03 · sources : [LTrans.class:List_Write](../../../../.src/Utils/LTrans.class#L40-L44)
- [ ] LTRANS-002 — [code mort] Supprimer la méthode `New()` jamais appelée (l'état initial
  `List = Null` est conservé) · appelants : aucun · tests : T01, T04, T05 · sources : [LTrans.class:New](../../../../.src/Utils/LTrans.class#L15-L20)
- [ ] LTRANS-003 — [réarchitecture] `TriFacture` écrit dans l'objet reçu (`Obj.List`) et `Caisse`
  relit `Selection.List` au lieu de l'auto-instance (modification minimale de `Caisse`, 1 ligne) ·
  appelants : `TriFacture.class:82/285/294`, `Caisse.class:7162` · tests : T04 · sources : [TriFacture.class:82](../../../../.src/Affichages/TriFacture.class#L82), [Caisse.class:7162](../../../../.src/Caisse/Caisse.class#L7162)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LTRANS-A01 — [anomalie] `New()` était probablement destiné à être le constructeur `_new` ;
  le renommer rendrait `List` non Null dès la création et casserait les tests de sélection vide de
  `GedR` (l. 443, 490) et `LGed.Copier_Click` (l. 953). À ne faire qu'avec adaptation de ces
  appelants · tests : T01, T05 · sources : [LTrans.class:New](../../../../.src/Utils/LTrans.class#L15-L20), [GedR.class:443](../../../../.src/Utils/GedR.class#L443), [LGed.class:953](../../../../.src/Utils/LGed.class#L953)
