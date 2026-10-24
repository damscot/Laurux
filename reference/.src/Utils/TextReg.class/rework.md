# TextReg — Rework

> Source : `.src/Utils/TextReg.class` · Message de commit (phase 4) : `reference/.src/Utils/TextReg.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 536 |
| Lignes de commentaire | 14 |
| Fonctions | 52 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 177 |
| Complexité max (fonction) | 31 (`butb_keypress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 536 | 177 | 31 | 0 | 15 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TEXTREG-001 — [documentation] En-tête en français : rôle, types de données, constantes de
  regex, recherche et historique (raccourcis), mode scanner, partage du nom d'événement `butb` entre
  le contrôle, la fenêtre et la grille ; commentaires `'''` sur chaque propriété et méthode Public
  · appelants : aucun · tests : T01-T09 · sources : [TextReg.class:_new](../../../../.src/Utils/TextReg.class#L76-L87)
- [ ] TEXTREG-002 — [code mort] Supprimer `Dim i` de `butb_gotfocus` et `Dim ch` de `champs` ·
  appelants : aucun · tests : T05, T06 · sources : [TextReg.class:butb_gotfocus](../../../../.src/Utils/TextReg.class#L231-L244), [TextReg.class:champs](../../../../.src/Utils/TextReg.class#L481-L488)
- [ ] TEXTREG-003 — [commonalisation] Helper privé `ChoisirDate()` partagé par `butb_DblClick` et
  la branche F2 de `butb_keypress` · appelants : aucun · tests : T08 · sources : [TextReg.class:butb_DblClick](../../../../.src/Utils/TextReg.class#L196-L206), [TextReg.class:142-149](../../../../.src/Utils/TextReg.class#L142-L149)
- [ ] TEXTREG-004 — [complexité] `butb_keypress` : scinder en `ToucheCtrl()` / `ToucheNormale()`
  privés, même ordre de traitement et mêmes `Stop Event` (CC 31 → ≤ 12 visé) · appelants : aucun ·
  tests : T06-T08 · sources : [TextReg.class:butb_keypress](../../../../.src/Utils/TextReg.class#L112-L177)
- [ ] TEXTREG-005 — [complexité] `butb_change` : remplacer `Match "." And EstNum` par le seul test
  du type (équivalent) · appelants : aucun · tests : T04 · sources : [TextReg.class:butb_change](../../../../.src/Utils/TextReg.class#L208-L229), [TextReg.class:224](../../../../.src/Utils/TextReg.class#L224)
- [ ] TEXTREG-006 — [séparation traitement/GUI] `affgrd` : extraire `Recherche(texte) As Result`
  (motif `LIKE` selon `lke` + SQL) · appelants : aucun · tests : T06 · sources : [TextReg.class:affgrd](../../../../.src/Utils/TextReg.class#L561-L601)
- [ ] TEXTREG-007 — [séparation traitement/GUI] Fonction pure `LitNombre(texte) As Float`
  (conversion de `Text_Write`/`butb_lostfocus`) ; `frm()` rendue testable (ou remplacée par
  `Utils.FormatDecimales`, TEXTREG-008) · appelants : aucun · tests : T01, T05, T10 · sources : [TextReg.class:Text_Write](../../../../.src/Utils/TextReg.class#L320-L349), [TextReg.class:butb_lostfocus](../../../../.src/Utils/TextReg.class#L246-L281), [TextReg.class:frm](../../../../.src/Utils/TextReg.class#L499-L510)
- [ ] TEXTREG-008 — [commonalisation] Helper `Utils.FormatDecimales(n)` partagé avec
  `Utils.Find_nbdec` (et formats d'`ObjProp`), chaînes produites identiques · appelants : `Utils`
  · tests : T01, T10 · sources : [TextReg.class:frm](../../../../.src/Utils/TextReg.class#L499-L510), [Utils.module:Find_nbdec](../../../../.src/Utils/Utils.module#L637-L652), [ObjProp.class:frmt](../../../../.src/Utils/ObjProp.class#L145-L164)
- [ ] TEXTREG-009 — [réduction de portée] `Unselect` → `Private` (aucun appelant ; vérification par
  replay des écrans à saisie) ; `lke` et `champs` restent `Public` (utilisés) · appelants : aucun ·
  tests : T04-T08 · sources : [TextReg.class:Unselect](../../../../.src/Utils/TextReg.class#L475-L479)
- [ ] TEXTREG-010 — [complexité] `butb_gotfocus` : ne recréer `$prop` que si la clé
  `<Fenêtre>/<Nom>` a changé (fichier relu une fois) — uniquement si T05/T07 restent identiques ·
  appelants : aucun · tests : T05, T07 · sources : [TextReg.class:butb_gotfocus](../../../../.src/Utils/TextReg.class#L231-L244), [TextReg.class:Name_Write](../../../../.src/Utils/TextReg.class#L647-L653)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TEXTREG-A01 — [anomalie] `butb_KeyRelease:186` : `Utils.de.SendKeys` (méthode `Desktop`)
  au lieu de `Utils.de.SendKey` : le Retour automatique du mode scanner ne passe pas par `ydotool`
  sous Wayland · tests : T09 · sources : [TextReg.class:186](../../../../.src/Utils/TextReg.class#L186), [DB_Desktop.class:SendKey](../../../../.src/Utils/DB_Desktop.class#L23-L35)
- [ ] TEXTREG-A02 — [anomalie] `MaxLength_Read:386` renvoie `Me.Editor.Value` (propriété
  inexistante) : erreur à toute lecture de `MaxLength` (aucune lecture trouvée dans le code ; l'IDE
  peut en faire) · tests : T01 · sources : [TextReg.class:386](../../../../.src/Utils/TextReg.class#L386)
- [ ] TEXTREG-A03 — [anomalie] `Type_Write:666,670,681` : passer en `EstText`/`EstNum` met
  `dte = Null` (retour vers une date en erreur) ; en `EstDate`, `Me.value = 0` agit encore selon
  l'ancien type (texte « 0 » si l'ancien type était `EstNum`) · tests : T03 · sources : [TextReg.class:666](../../../../.src/Utils/TextReg.class#L666), [TextReg.class:670](../../../../.src/Utils/TextReg.class#L670), [TextReg.class:681](../../../../.src/Utils/TextReg.class#L681)
- [ ] TEXTREG-A04 — [anomalie] `butb_keypress:155,159` : accès à `$grd` sans test de validité ni de
  ligne sélectionnée (`Row = -1`) en mode historique/recherche ; `recherche_Write:405` ajoute
  l'infobulle à chaque affectation · tests : T06, T07 · sources : [TextReg.class:155](../../../../.src/Utils/TextReg.class#L155), [TextReg.class:159](../../../../.src/Utils/TextReg.class#L159), [TextReg.class:405](../../../../.src/Utils/TextReg.class#L405)
