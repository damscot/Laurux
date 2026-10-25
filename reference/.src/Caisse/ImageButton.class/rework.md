# ImageButton — Rework

> Source : `.src/Caisse/ImageButton.class` · Message de commit (phase 4) : `reference/.src/Caisse/ImageButton.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 103 |
| Lignes de commentaire | 5 |
| Fonctions | 16 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 22 |
| Complexité max (fonction) | 7 (`View_Draw`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 103 | 22 | 7 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IMAGEBUTTON-001 — [documentation] En-tête : rôle (touche de caisse tactile), utilisateurs
  (`Caisse`, `Attrib`), propriétés exposées, masquage de `Background` par `BackGround`,
  événement `Click` levé au relâchement · appelants : aucun · tests : aucun · sources : [ImageButton.class:_new](../../../../.src/Caisse/ImageButton.class#L23-L29), [ImageButton.class:View_MouseUp](../../../../.src/Caisse/ImageButton.class#L66-L72)
- [ ] IMAGEBUTTON-002 — [code mort] Supprimer la propriété `Position` (`$iPosition`,
  `Position_Read`, `Position_Write`, jamais utilisée) et les lignes commentées de `View_Draw` et
  `Picture_Write` · appelants : aucun · tests : T01-T03 · sources : [ImageButton.class:Position_Read](../../../../.src/Caisse/ImageButton.class#L74-L79), [ImageButton.class:Position_Write](../../../../.src/Caisse/ImageButton.class#L81-L86), [ImageButton.class:View_Draw](../../../../.src/Caisse/ImageButton.class#L88-L124), [ImageButton.class:Picture_Write](../../../../.src/Caisse/ImageButton.class#L132-L139)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] IMAGEBUTTON-A01 — [anomalie] `Click` est levé au relâchement même si le pointeur a quitté
  le bouton ; aucune activation au clavier malgré `Focus = True` ; `Text`/`BackGround`/`Picture`
  ne redessinent pas le contrôle · tests : T02, T03 · sources : [ImageButton.class:View_MouseUp](../../../../.src/Caisse/ImageButton.class#L66-L72), [ImageButton.class:Text_Write](../../../../.src/Caisse/ImageButton.class#L147-L151), [ImageButton.class:BackGround_Write](../../../../.src/Caisse/ImageButton.class#L159-L163)
