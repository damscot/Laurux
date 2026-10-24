# FSetFormat — Rework

> Source : `.src/Utils/FSetFormat.class` · Message de commit (phase 4) : `reference/.src/Utils/FSetFormat.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 57 |
| Lignes de commentaire | 1 |
| Fonctions | 9 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 16 |
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
| initial | `6b6b9dfc` | 2026-10-24 | 57 | 16 | 4 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FSETFORMAT-001 — [documentation] En-tête en français : protocole `Format` → `Run()` →
  `Format` (objet partagé, sans annulation), contrôles masqués, usage caisse du cadre logo ·
  appelants : aucun · tests : T01-T04 · sources : [FSetFormat.class:Run](../../../../.src/Utils/FSetFormat.class#L34-L38)
- [ ] FSETFORMAT-002 — [code mort] Supprimer `Rouge`, `Vert`, `Bleu`, `Couleur` de
  `ColorButton1_Change` et le paramètre inutilisé de `FileFilter` · appelants : aucun ·
  tests : T01, T04 · sources : [FSetFormat.class:ColorButton1_Change](../../../../.src/Utils/FSetFormat.class#L13-L25), [FSetFormat.class:FileFilter](../../../../.src/Utils/FSetFormat.class#L78-L88)
- [ ] FSETFORMAT-003 — [commonalisation] `Form_Open` : utiliser `CFormat.Applique` pour l'aperçu
  si la sémantique est identique (attention : le fond de l'aperçu n'a pas de repli aujourd'hui ;
  sinon garder le code) · appelants : aucun · tests : T01, T03 · sources : [FSetFormat.class:Form_Open](../../../../.src/Utils/FSetFormat.class#L40-L50)
- [ ] FSETFORMAT-004 — [séparation traitement/GUI] `Lgo2_Click` : extraire l'`UPDATE` dans
  `MajFondTouche(chemin, touche)` privée · appelants : aucun · tests : T04 · sources : [FSetFormat.class:Lgo2_Click](../../../../.src/Utils/FSetFormat.class#L65-L76)
- [ ] FSETFORMAT-005 — [réarchitecture] Remplacer la lecture de `Attrib.fnd` par une touche fournie
  par l'appelant (`Run(Optional touche As String)` ou membre statique) ; `Attrib` passe `fnd`
  · appelants : `Attrib`, `SetColors` · tests : T03, T04, T05 · sources : [FSetFormat.class:72](../../../../.src/Utils/FSetFormat.class#L72), [FSetFormat.class:Run](../../../../.src/Utils/FSetFormat.class#L34-L38)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FSETFORMAT-A01 — [anomalie] `Lgo2_Click:72` : `UPDATE … WHERE touche = &2` sans `cai` :
  le logo est appliqué à la touche de **toutes** les caisses · tests : T04 · sources : [FSetFormat.class:72](../../../../.src/Utils/FSetFormat.class#L72)
- [ ] FSETFORMAT-A02 — [anomalie] Le cadre logo est visible depuis `SetColors` : « Choisir »
  instancie implicitement le formulaire `Attrib` et met à jour la touche `""` (à confirmer) ;
  masquer `Panlogo` hors caisse · tests : T05 · sources : [FSetFormat.class:Lgo2_Click](../../../../.src/Utils/FSetFormat.class#L65-L76)
- [ ] FSETFORMAT-A03 — [anomalie] `Button3_Click` ne met pas `ColorButton1.Color` à jour ;
  `Form_Open` applique un fond `-1` à l'aperçu sans repli · tests : T02 · sources : [FSetFormat.class:Button3_Click](../../../../.src/Utils/FSetFormat.class#L58-L63), [FSetFormat.class:46](../../../../.src/Utils/FSetFormat.class#L46)
- [ ] FSETFORMAT-A04 — [anomalie] (ajoutée après le lot Caisse, voir ATTRIB-A03) l. 72 : l'image de fond
  d'une touche est enregistrée par `UPDATE … where touche = &2` sans filtre sur la caisse (`cai`) : elle
  s'applique à la touche de même numéro dans **toutes** les caisses ; `Attrib.fnd` est lu sur
  l'auto-instance d'`Attrib` · tests : replay attribution de touche (lot Caisse, ATTRIB) · sources : [FSetFormat.class:72](../../../../.src/Utils/FSetFormat.class#L72), [Attrib.class:7](../../../../.src/Caisse/Attrib.class#L7), [Attrib.class:113](../../../../.src/Caisse/Attrib.class#L113)
