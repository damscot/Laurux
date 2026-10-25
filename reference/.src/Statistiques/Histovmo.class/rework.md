# Histovmo — Rework

> Source : `.src/Statistiques/Histovmo.class` · Message de commit (phase 4) : `reference/.src/Statistiques/Histovmo.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 674 |
| Lignes de commentaire | 92 |
| Fonctions | 31 |
| Fonctions Public | 31 |
| Complexité cyclomatique totale | 163 |
| Complexité max (fonction) | 39 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 674 | 163 | 39 | 0 | 31 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] HISTOVMO-001 — [documentation] En-tête en français : rôle, plages, sources `Facn`/`Face`/`Fact`,
  case `Bl`, groupes de contrôles (`Btn`, `Cmpt`, `Dte`) et méthodes non levées · appelants : aucun ·
  tests : aucun · sources : [Histovmo.class:_New](../../../../.src/Statistiques/Histovmo.class#L35-L64), [Histovmo.class:Button2_Click](../../../../.src/Statistiques/Histovmo.class#L710-L854)
- [ ] HISTOVMO-002 — [code mort] Supprimer `Level1` et `Level2` (jamais appelés : les appels
  `pdf.Level1`/`pdf.level2` visent `Chistoriques`), le `Case 1` inatteignable de `Btn_Click`, `Frmt`,
  `Coulfond`, l'affectation `HistoMo.ps`, `Shell "cd …"` et les `With Utils` vides · appelants : aucun ·
  tests : T01, T06 · sources : [Histovmo.class:Level1](../../../../.src/Statistiques/Histovmo.class#L857-L876), [Histovmo.class:Level2](../../../../.src/Statistiques/Histovmo.class#L879-L893), [Histovmo.class:Btn_Click](../../../../.src/Statistiques/Histovmo.class#L596-L612), [Histovmo.class:746](../../../../.src/Statistiques/Histovmo.class#L746)
- [ ] HISTOVMO-003 — [commonalisation] `ToggleButton1..6_Click` → `EdSelection.ListeCodes` (EDART1-003,
  EDMO-005 ; SQL identique) ; handlers conservés · appelants : aucun · tests : T05 · sources : [Histovmo.class:ToggleButton1_Click](../../../../.src/Statistiques/Histovmo.class#L140-L173), [Histovmo.class:ToggleButton6_Click](../../../../.src/Statistiques/Histovmo.class#L458-L491), [EdArt1.class:ToggleButton3_Click](../../../../.src/Gestion/Impressions/EdArt1.class#L80-L113)
- [ ] HISTOVMO-004 — [commonalisation] `Col*_KeyPress` / `Col*_Click` : helper privé `FermeListe(cv,
  zone)` et `ChoisitCode(cv, zone, suivante)` appelés par les 12 handlers (noms et portée inchangés,
  focus actuels conservés) · appelants : aucun · tests : T05 · sources : [Histovmo.class:Colmo_KeyPress](../../../../.src/Statistiques/Histovmo.class#L178-L199), [Histovmo.class:Colfour2_KeyPress](../../../../.src/Statistiques/Histovmo.class#L496-L517), [Histovmo.class:Colmo_Click](../../../../.src/Statistiques/Histovmo.class#L522-L530), [Histovmo.class:Colfour2_Click](../../../../.src/Statistiques/Histovmo.class#L587-L594)
- [ ] HISTOVMO-005 — [commonalisation] Dates et période par défaut : `dteN0_LF`/`dteN1_LF` →
  `StatCommun.DateSaisie` (HITCARTE-006), lecture `dteclec1` → `PeriodeParDefaut()` (RELVMO-007),
  `Fiches_Parametres` via `Cbase.Table("TabParam")` · appelants : aucun · tests : T07 · sources : [Histovmo.class:dteN0_LF](../../../../.src/Statistiques/Histovmo.class#L97-L110), [Histovmo.class:dteN1_LF](../../../../.src/Statistiques/Histovmo.class#L115-L135), [Histovmo.class:_New](../../../../.src/Statistiques/Histovmo.class#L35-L64)
- [ ] HISTOVMO-006 — [commonalisation] Noms de tables `Tab` à `Tab9` via `Cbase.Table` (texte SQL
  identique) · appelants : aucun · tests : T01, T03 · sources : [Histovmo.class:Button2_Click](../../../../.src/Statistiques/Histovmo.class#L710-L854)
- [ ] HISTOVMO-007 — [séparation traitement/GUI] Extraire de `Button2_Click` `VentesMo(bornes,
  iSource, bBl) As Collection` (requêtes et cumuls, mêmes requêtes dans le même ordre) et
  `ImprimeHistoMo(ventes, titre)` ; le handler lit les zones, gère le curseur et le message ·
  appelants : aucun · tests : T01-T04, T06, T09 · sources : [Histovmo.class:Button2_Click](../../../../.src/Statistiques/Histovmo.class#L710-L854)
- [ ] HISTOVMO-008 — [complexité] Choix des tables selon `Facn`/`Face`/`Fact` fait une fois avant la
  boucle (helper `Sources()`), au lieu de 9 `If` par MO et par ligne (CC 39 → ≤ 15 visé, SQL identique)
  · appelants : aucun · tests : T01, T03, T04 · sources : [Histovmo.class:Button2_Click](../../../../.src/Statistiques/Histovmo.class#L710-L854)
- [ ] HISTOVMO-009 — [réduction de portée] `dteN0_LF`, `dteN1_LF`, `Button2_Click` (non levé : groupe
  `btn`) → `Private` · appelants : aucun · tests : T01, T07, T08 · sources : [Histovmo.class:dteN0_LF](../../../../.src/Statistiques/Histovmo.class#L97-L110), [Histovmo.class:dteN1_LF](../../../../.src/Statistiques/Histovmo.class#L115-L135), [Histovmo.class:Button2_Click](../../../../.src/Statistiques/Histovmo.class#L710-L854)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] HISTOVMO-A01 — [anomalie] Avec `Bl` coché, `WHERE numbl = &1 and type = &2 or type = &3` (priorité
  `AND`/`OR`) renvoie aussi toutes les factures `F` : la date testée peut être celle d'un autre
  document, d'où des lignes MO comptées ou ignorées à tort · tests : T04 · sources : [Histovmo.class:808](../../../../.src/Statistiques/Histovmo.class#L808), [Histovmo.class:809](../../../../.src/Statistiques/Histovmo.class#L809), [Histovmo.class:810](../../../../.src/Statistiques/Histovmo.class#L810)
- [ ] HISTOVMO-A02 — [anomalie] En mode `Fact`, la partie `Fiches_LigblM` de l'union filtre
  `typel_ligbl <> 'M'` : les lignes MO des documents matériel en cours sont exclues et des lignes non
  MO de même code sont comptées · tests : T03 · sources : [Histovmo.class:803](../../../../.src/Statistiques/Histovmo.class#L803)
- [ ] HISTOVMO-A03 — [anomalie] La plage fournisseur (`Four`–`Four2`) n'est appliquée qu'avec le tri
  par code (`RadioButton1`) · tests : T02 · sources : [Histovmo.class:761](../../../../.src/Statistiques/Histovmo.class#L761), [Histovmo.class:764](../../../../.src/Statistiques/Histovmo.class#L764)
- [ ] HISTOVMO-A04 — [anomalie] `Btn_KeyPress` lance l'impression pour toute touche sur **Imprimer**
  (Tab compris) ; Espace imprime deux fois (`KeyPress` puis `Click`, à confirmer au rejeu) · tests : T08 ·
  sources : [Histovmo.class:Btn_KeyPress](../../../../.src/Statistiques/Histovmo.class#L614-L621)
- [ ] HISTOVMO-A05 — [anomalie] Échap/F2 sur `Colfam2`/`Colfour2` donne le focus à `fam`/`four` mais
  sélectionne `fam2`/`four2` ; F1 ouvre l'aide « Edtar » (tarif articles) · tests : T05 · sources : [Histovmo.class:385](../../../../.src/Statistiques/Histovmo.class#L385), [Histovmo.class:512](../../../../.src/Statistiques/Histovmo.class#L512), [Histovmo.class:Button1_Click](../../../../.src/Statistiques/Histovmo.class#L895-L899)
- [ ] HISTOVMO-A06 — [anomalie] Factures `F` en cours comptées sans filtre `imp` (contrairement à
  `RelvMo` et `TBord` qui exigent `imp = 1`) et quantité nulle comptée pour 1 sans montant (à confirmer
  avec l'utilisateur) · tests : T04 · sources : [Histovmo.class:812](../../../../.src/Statistiques/Histovmo.class#L812), [Histovmo.class:790](../../../../.src/Statistiques/Histovmo.class#L790)
