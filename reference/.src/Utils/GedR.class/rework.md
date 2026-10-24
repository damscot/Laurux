# GedR — Rework

> Source : `.src/Utils/GedR.class` · Message de commit (phase 4) : `reference/.src/Utils/GedR.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 387 |
| Lignes de commentaire | 12 |
| Fonctions | 21 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 88 |
| Complexité max (fonction) | 20 (`ChangerUrl_Click`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 387 | 88 | 20 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] GEDR-001 — [documentation] En-tête : rôle de l'écran, sélection multiple, liste des actions
  en masse et de leurs effets (épuration globale, URL sans déplacement de fichier) · appelants :
  aucun · tests : T01-T07 · sources : [GedR.class:_New](../../../../.src/Utils/GedR.class#L16-L33)
- [ ] GEDR-002 — [code mort] Supprimer `Tableau`, `Obj`, le membre `seltags`, `Public List` et
  l'affectation sans effet `Val = ""` · appelants : aucun · tests : T02, T05 · sources : [GedR.class:3-12](../../../../.src/Utils/GedR.class#L3-L12), [GedR.class:TriGen_MajSel](../../../../.src/Utils/GedR.class#L273-L295)
- [ ] GEDR-003 — [réarchitecture] Tables en dur → `Cbase.Table("TabDocGed")`, `("TabDocTag")`,
  `("TabTag")` ; filtre de type via `Utils.db.Subst` (même SQL produit) · appelants : aucun ·
  tests : T01-T06 · sources : [GedR.class:Filter_Calc](../../../../.src/Utils/GedR.class#L179-L217), [GedR.class:Update_Req](../../../../.src/Utils/GedR.class#L219-L269)
- [ ] GEDR-004 — [complexité] `AjoutTags_Click` : un `LGed` par document et `AddTags` (mêmes
  écritures) · appelants : aucun · tests : T06 · sources : [GedR.class:AjoutTags_Click](../../../../.src/Utils/GedR.class#L469-L507)
- [ ] GEDR-005 — [complexité] `ChangerUrl_Click` : fonction pure `PrefixeCommun(urls)` (CC 20 → ≤ 10
  visé) · appelants : aucun · tests : T04 · sources : [GedR.class:ChangerUrl_Click](../../../../.src/Utils/GedR.class#L323-L403)
- [ ] GEDR-006 — [séparation traitement/GUI] Fonctions SQL privées `RemplaceUrl(ids, ancien,
  nouveau)` et `RetireTag(tag, ids)` · appelants : aucun · tests : T04, T05 · sources : [GedR.class:ChangerUrl_Click](../../../../.src/Utils/GedR.class#L323-L403), [GedR.class:SupprimerTags_Click](../../../../.src/Utils/GedR.class#L405-L467)
- [ ] GEDR-007 — [commonalisation] Utiliser des opérations de tags par lot de `LGed` (à créer dans
  le rework de `LGed`) au lieu du SQL direct · appelants : aucun · tests : T05, T06 · sources : [GedR.class:SupprimerTags_Click](../../../../.src/Utils/GedR.class#L405-L467), [GedR.class:AjoutTags_Click](../../../../.src/Utils/GedR.class#L469-L507)
- [ ] GEDR-008 — [commonalisation] Sélection multiple sur `TriGen` mutualisée avec `TriFacture` et
  `Pointage` (à décider en phase 3 ; dépend de `TriGen`) · appelants : `TriFacture`, `Pointage` ·
  tests : T02 · sources : [GedR.class:SelectAllFil_Click](../../../../.src/Utils/GedR.class#L59-L76), [GedR.class:TriGen_MajSel](../../../../.src/Utils/GedR.class#L273-L295)
- [ ] GEDR-009 — [réduction de portée] `Update_Req`, `PB_Epuration` → `Private` (ne pas toucher
  `Select_Click`, `Bsel`, `Bval`) · appelants : aucun · tests : T01, T03 · sources : [GedR.class:Update_Req](../../../../.src/Utils/GedR.class#L219-L269), [GedR.class:PB_Epuration](../../../../.src/Utils/GedR.class#L115-L130)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] GEDR-A01 — [anomalie] `GROUP_CONCAT(tag SEPARATOR ',')` propre à MySQL : écran GED
  inutilisable sous SQLite · tests : à créer sur `Laurux01.sqlite` · sources : [GedR.class:230](../../../../.src/Utils/GedR.class#L230)
- [ ] GEDR-A02 — [anomalie] Filtre de tags concaténé dans le SQL (guillemet = erreur SQL ;
  injection possible) · tests : T08 · sources : [GedR.class:206](../../../../.src/Utils/GedR.class#L206)
- [ ] GEDR-A03 — [anomalie] `ChangerUrl` : `REPLACE` sur toute l'URL au lieu du seul préfixe ·
  tests : T04 · sources : [GedR.class:396](../../../../.src/Utils/GedR.class#L396)
- [ ] GEDR-A04 — [anomalie] `Supprimer_Click` supprime sans demande de confirmation, puis lance une
  épuration globale (documents sans tag hors sélection compris) · tests : T03 · sources : [GedR.class:Supprimer_Click](../../../../.src/Utils/GedR.class#L132-L151)
- [ ] GEDR-A05 — [anomalie] `Ouvrir_Click` exécute une requête d'existence redondante avant le
  chargement `LGed` (sans effet visible ; à supprimer seulement si l'utilisateur accepte un log
  `Exec_SQL` différent) · tests : replay d'ouverture (manuel) · sources : [GedR.class:104](../../../../.src/Utils/GedR.class#L104)
