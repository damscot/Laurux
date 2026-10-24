# LCoul — Rework

> Source : `.src/Utils/LCoul.class` · Message de commit (phase 4) : `reference/.src/Utils/LCoul.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 92 |
| Lignes de commentaire | 2 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 5 (`_New`) |
| Variables globales | 0 |
| Variables Public | 14 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 92 | 9 | 5 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LCOUL-001 — [documentation] En-tête : rôle, format des clés `/Coul/*`, couleurs en dur,
  usage des fragments `bgcolor` · appelants : aucun · tests : T01-T04 · sources : [LCoul.class:_New](../../../../.src/Utils/LCoul.class#L29-L96)
- [ ] LCOUL-002 — [code mort] Supprimer les quatre paramètres inutilisés de `_New` (copiés de
  `LPrix`) ; tous les appelants font `New LCoul` sans argument · appelants : `TriArticles`,
  `TriFacture`, `Articles` (inchangés) · tests : T01, T02 · sources : [LCoul.class:29](../../../../.src/Utils/LCoul.class#L29)
- [ ] LCOUL-003 — [commonalisation] Helper privé `LitCouleur(cle)` pour les quatre couleurs
  d'article, en reproduisant **à l'identique** la ligne 56 (tant que LCOUL-A01 n'est pas validée) ·
  appelants : aucun · tests : T01, T02, T03 · sources : [LCoul.class:_New](../../../../.src/Utils/LCoul.class#L29-L96)
- [ ] LCOUL-004 — [complexité] Helper privé de construction des `CASE WHEN … END as bgcolor`
  (chaînes produites identiques caractère pour caractère) · appelants : aucun · tests : T01, T04 · sources : [LCoul.class:Art_DB_bgcolor](../../../../.src/Utils/LCoul.class#L98-L102), [LCoul.class:Fac_DB_bgcolor](../../../../.src/Utils/LCoul.class#L104-L108), [LCoul.class:Ecr_DB_bgcolor](../../../../.src/Utils/LCoul.class#L110-L120)
- [ ] LCOUL-005 — [réduction de portée] Les 14 champs `SColor` → `Private` · appelants : aucun ·
  tests : T01 · sources : [LCoul.class:11-26](../../../../.src/Utils/LCoul.class#L11-L26)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LCOUL-A01 — [anomalie] Ligne 56 : `Art_Epuise = "&HFFFFFF&"` au lieu de
  `Art_Epuise.Bg = …` (erreur de type si `Fcolr` renvoie `Null`) · tests : T03 · sources : [LCoul.class:56](../../../../.src/Utils/LCoul.class#L56)
- [ ] LCOUL-A02 — [anomalie] `Fac_DB_bgcolor` n'utilise pas `Fac_Proforma` (proformas en blanc) ·
  appelants : `TriFacture` · tests : T01 · sources : [LCoul.class:Fac_DB_bgcolor](../../../../.src/Utils/LCoul.class#L104-L108)
- [ ] LCOUL-A03 — [anomalie] Couleurs de documents et d'écritures en dur alors que
  `/Coul/Prf`, `/Coul/Devis`, `/Coul/Cmde`, `/Coul/Bl` sont paramétrables (`SetColors`) : le
  paramétrage utilisateur est ignoré dans `TriFacture` · tests : T01, T02 · sources : [LCoul.class:74-94](../../../../.src/Utils/LCoul.class#L74-L94)
