# Variables — Rework

> Source : `.src/Utils/Variables.module` · Message de commit (phase 4) : `reference/.src/Utils/Variables.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 42 |
| Lignes de commentaire | 1 |
| Fonctions | 0 |
| Fonctions Public | 0 |
| Complexité cyclomatique totale | 0 |
| Complexité max (fonction) | 0 |
| Variables globales | 40 |
| Variables Public | 40 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 42 | 0 | 0 | 40 | 0 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VARIABLES-001 — [code mort] Supprimer les 14 déclarations jamais utilisées : `Simport`,
  `OrgTarCli`, `OrgTarTypeCli`, `$TarTypeCli`, `Codearticle`, `Cfour`, `obs`, `$fic`, `$doc`,
  `$Codeclient`, `numerobl`, `Bselection`, `hpb`, `hlb` · appelants : aucun · tests : T01 · sources : [Variables.module:6](../../../../.src/Utils/Variables.module#L6), [Variables.module:12-15](../../../../.src/Utils/Variables.module#L12-L15), [Variables.module:21-25](../../../../.src/Utils/Variables.module#L21-L25), [Variables.module:27](../../../../.src/Utils/Variables.module#L27), [Variables.module:33](../../../../.src/Utils/Variables.module#L33), [Variables.module:37](../../../../.src/Utils/Variables.module#L37), [Variables.module:43-44](../../../../.src/Utils/Variables.module#L43-L44)
- [ ] VARIABLES-002 — [code mort] Supprimer les variables écrites jamais lues `$Codemo`, `inumr`,
  `FMateriel`, `impr` et leurs affectations · appelants : `TriMo:63`, `ValidBR:703`,
  `Facture:12063,12065`, `ChxImp:25` · tests : T03, T04, replays `TriMo`/`ValidBR`/`ChxImp` du lot
  concerné · sources : [Variables.module:29](../../../../.src/Utils/Variables.module#L29), [Variables.module:34](../../../../.src/Utils/Variables.module#L34), [Variables.module:39-40](../../../../.src/Utils/Variables.module#L39-L40), [TriMo.class:63](../../../../.src/Affichages/TriMo.class#L63), [ValidBR.class:703](../../../../.src/Gestion/Stock/ValidBR.class#L703), [Facture.class:12063-12065](../../../../.src/Gestion/Facturation/Facture.class#L12063-L12065), [ChxImp.class:25](../../../../.src/Reports/ChxImp.class#L25)
- [ ] VARIABLES-003 — [code mort] Supprimer `EnvoiMail`, `TypeL`, `Qte`, `bImpref` (jamais écrites)
  et simplifier les branches inatteignables de `Cdocuments` (109-118, 272, 308, 512, 570, 644-674) ·
  appelants : `Cdocuments` · tests : T06 · sources : [Variables.module:20](../../../../.src/Utils/Variables.module#L20), [Variables.module:26](../../../../.src/Utils/Variables.module#L26), [Variables.module:35](../../../../.src/Utils/Variables.module#L35), [Variables.module:42](../../../../.src/Utils/Variables.module#L42), [Cdocuments.class:109-118](../../../../.src/Reports/Cdocuments.class#L109-L118), [Cdocuments.class:644-674](../../../../.src/Reports/Cdocuments.class#L644-L674)
- [ ] VARIABLES-004 — [documentation] Regrouper les déclarations restantes (réglages / échanges entre
  écrans) et indiquer en commentaire l'écrivain et le lecteur de chacune · appelants : aucun ·
  tests : T01 · sources : [Variables.module:3-42](../../../../.src/Utils/Variables.module#L3-L42)
- [ ] VARIABLES-005 — [commonalisation] `TBord` lit `Start.Musique` au lieu de `Variables.Musique`,
  puis suppression de `Variables.Musique` (même valeur constante) · appelants : `TBord` · tests :
  T01 (son non testable) · sources : [Variables.module:11](../../../../.src/Utils/Variables.module#L11), [TBord.class:22](../../../../.src/Statistiques/TBord.class#L22)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite.

- [ ] VARIABLES-A01 — [anomalie, à confirmer] Les réglages `Sprix`, `Sexport`, `SMajArt`, `SMajFour`,
  `SMajCli`, `Schmprix`, `son` sont figés au premier accès au module : un changement de société
  (`Fsoc`) ou de préférences en cours de session n'est pas pris en compte par `Serveur`, `FClient`,
  `FFournisseur`, `Articles` et les écrans de tarifs. Correction : fonctions d'accès relisant
  `Start.LocalSettings` · tests : T01 + scénario changement de société · sources : [Variables.module:3-10](../../../../.src/Utils/Variables.module#L3-L10)
- [ ] VARIABLES-A02 — [anomalie, à confirmer] `Cdocuments` teste `EnvoiMail = "Mail"` et
  `TypeL = "B"`, jamais vrais : le logo « mail » et la présentation de type `B` ne sont jamais
  appliqués. À vérifier avec l'utilisateur avant VARIABLES-003 (fonction perdue ou abandonnée ?) ·
  tests : T06 · sources : [Cdocuments.class:113](../../../../.src/Reports/Cdocuments.class#L113), [Cdocuments.class:644](../../../../.src/Reports/Cdocuments.class#L644)
