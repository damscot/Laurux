# Numtostring — Rework

> Source : `.src/Utils/Numtostring.module` · Message de commit (phase 4) : `reference/.src/Utils/Numtostring.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 144 |
| Lignes de commentaire | 12 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 73 |
| Complexité max (fonction) | 58 (`Num2Text`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 144 | 73 | 58 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] NUMTOSTRING-001 — [documentation] En-tête et commentaires en français (remplacer l'espagnol),
  description des limites (10¹², orthographe) · appelants : aucun · tests : aucun · sources : [Numtostring.module:Convertir](../../../../.src/Utils/Numtostring.module#L3-L52), [Numtostring.module:palabraPlural](../../../../.src/Utils/Numtostring.module#L54-L58), [Numtostring.module:Num2Text](../../../../.src/Utils/Numtostring.module#L64-L179)
- [ ] NUMTOSTRING-002 — [code mort] Supprimer la ligne inatteignable l.137 (`value = 800`) et les
  blocs commentés l.88-97 · tests : T01, T02 · sources : [Numtostring.module:137](../../../../.src/Utils/Numtostring.module#L137), [Numtostring.module:88-97](../../../../.src/Utils/Numtostring.module#L88-L97)
- [ ] NUMTOSTRING-003 — [complexité] Tables `Unites[0..19]` et `Dizaines[]` à la place de la cascade
  de `If` ; sorties identiques à l'octet · tests : T01, T02 · sources : [Numtostring.module:Num2Text](../../../../.src/Utils/Numtostring.module#L64-L179)
- [ ] NUMTOSTRING-004 — [réduction de portée] `palabraPlural` → `Private` (couvert par T03) ·
  tests : T03, T06 (T06 supprimé ou réécrit via `Convertir`) · sources : [Numtostring.module:palabraPlural](../../../../.src/Utils/Numtostring.module#L54-L58)
- [ ] NUMTOSTRING-005 — [commonalisation] Étudier la fusion avec `Caisse/numtostring.module`
  (`nbtostring`) : d'abord tests de caractérisation des deux modules, fusion seulement si les sorties
  sont identiques, sinon renvoi en anomalie · appelants : `Caisse.Imp_Cheque` · tests : T01-T05 +
  tests du module caisse · sources : [Numtostring.module:Num2Text](../../../../.src/Utils/Numtostring.module#L64-L179), [Caisse.class:5064-5069](../../../../.src/Caisse/Caisse.class#L5064-L5069)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] NUMTOSTRING-A01 — [anomalie] `Convertir` renvoie `""` pour 0, pour moins d'un centime et
  quand les centimes tronqués valent 0 (ex. 2,004) · tests : T04 · sources : [Numtostring.module:24-30](../../../../.src/Utils/Numtostring.module#L24-L30), [Numtostring.module:40-47](../../../../.src/Utils/Numtostring.module#L40-L47)
- [ ] NUMTOSTRING-A02 — [anomalie] Centimes tronqués au lieu d'arrondis (2,456 → 45) et non arrondis
  quand la partie entière est nulle (0,29 → résultat dépendant de l'erreur Float) · tests : T04 · sources : [Numtostring.module:23](../../../../.src/Utils/Numtostring.module#L23), [Numtostring.module:40-41](../../../../.src/Utils/Numtostring.module#L40-L41)
- [ ] NUMTOSTRING-A03 — [anomalie] `Num2Text(1000000)` = « un million zéro » ; espaces parasites
  (« mille », « millions ») ; aucune valeur entre 10¹² et 2·10¹² · tests : T02 · sources : [Numtostring.module:145-147](../../../../.src/Utils/Numtostring.module#L145-L147), [Numtostring.module:160-171](../../../../.src/Utils/Numtostring.module#L160-L171)
- [ ] NUMTOSTRING-A04 — [anomalie] Orthographe : pas de pluriel (devise, centimes, vingts, cents),
  pas de traits d'union, « quatre vingt et un » · tests : T01, T03 · sources : [Numtostring.module:56](../../../../.src/Utils/Numtostring.module#L56), [Numtostring.module:103-106](../../../../.src/Utils/Numtostring.module#L103-L106), [Numtostring.module:115-116](../../../../.src/Utils/Numtostring.module#L115-L116)
