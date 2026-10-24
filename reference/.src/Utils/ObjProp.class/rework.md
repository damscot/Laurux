# ObjProp — Rework

> Source : `.src/Utils/ObjProp.class` · Message de commit (phase 4) : `reference/.src/Utils/ObjProp.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 161 |
| Lignes de commentaire | 1 |
| Fonctions | 19 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 45 |
| Complexité max (fonction) | 9 (`frmt`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 161 | 45 | 9 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] OBJPROP-001 — [documentation] En-tête en français : les deux usages (descripteur de
  contrôle, paramètres persistants de `TextReg`), liste des propriétés appliquées par réflexion et
  dépendances invisibles qui en découlent, fichier `Laurux-AutoParams-<société>.conf` · appelants :
  aucun · tests : T01-T07 · sources : [ObjProp.class:_new](../../../../.src/Utils/ObjProp.class#L35-L58)
- [ ] OBJPROP-002 — [code mort] Supprimer `CondFilter_Read` (aucune propriété déclarée), la branche
  `Utils.CDec` inatteignable de `frmt`, `Dim e` de `LecParam` · appelants : aucun · tests : T03, T04 · sources : [ObjProp.class:CondFilter_Read](../../../../.src/Utils/ObjProp.class#L174-L178), [ObjProp.class:157](../../../../.src/Utils/ObjProp.class#L157), [ObjProp.class:135](../../../../.src/Utils/ObjProp.class#L135)
- [ ] OBJPROP-003 — [commonalisation] Helper privé de jonction des valeurs (`AddChamp`/`ModChamp`)
  · appelants : aucun · tests : T02 · sources : [ObjProp.class:AddChamp](../../../../.src/Utils/ObjProp.class#L60-L70), [ObjProp.class:ModChamp](../../../../.src/Utils/ObjProp.class#L72-L86)
- [ ] OBJPROP-004 — [réduction de portée] `AjoutCondfilter`, `CondFilter` (aucun appelant) →
  suppression ou `Private` ; `LecParam` → `Private` · appelants : aucun · tests : T04, T06 · sources : [ObjProp.class:AjoutCondfilter](../../../../.src/Utils/ObjProp.class#L101-L105), [ObjProp.class:CondFilter](../../../../.src/Utils/ObjProp.class#L107-L111), [ObjProp.class:LecParam](../../../../.src/Utils/ObjProp.class#L133-L143)
- [ ] OBJPROP-005 — [séparation traitement/GUI] `frmt` → fonction pure `FormatTexte(frm, texte)` ;
  mise à jour de l'historique → fonction pure `MajHistorique` (Public pour gb.test) · appelants :
  aucun · tests : T03, T05 · sources : [ObjProp.class:frmt](../../../../.src/Utils/ObjProp.class#L145-L164), [ObjProp.class:EcriParam](../../../../.src/Utils/ObjProp.class#L113-L131)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] OBJPROP-A01 — [anomalie] `historique` initialisé à `New String[10]` (10 chaînes vides) : la
  fenêtre d'historique de `TextReg` affiche des lignes vides et les sauvegarde (à confirmer) ·
  tests : T04, T05 · sources : [ObjProp.class:22](../../../../.src/Utils/ObjProp.class#L22)
- [ ] OBJPROP-A02 — [anomalie] `EcriParam:118-128` : les propriétés sont écrites dans `$conf` à
  chaque perte de focus, mais `Save` n'est appelé que si le texte est non vide ; `$conf` vaut
  `Null` hors type `Param` (erreur masquée par l'appelant) · tests : T05 · sources : [ObjProp.class:118-128](../../../../.src/Utils/ObjProp.class#L118-L128)
