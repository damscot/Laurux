# calculdroit1 — Rework

> Source : `.src/Gestion/option/calculdroit1.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/calculdroit1.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 167 |
| Lignes de commentaire | 1 |
| Fonctions | 17 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 50 |
| Complexité max (fonction) | 7 (`LecDra`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 167 | 50 | 7 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CALCULDROIT1-001 — [documentation] En-tête en français : règle de calcul (assiette volume ou
  alcool pur, seuil de degré, suspendu/acquitté, accise différenciée), montants unitaires, ordre
  des paramètres du constructeur hérité, différence avec `calculdroit` · appelants : aucun ·
  tests : T01-T09 · sources : [calculdroit1.class:_new](../../../../../.src/Gestion/option/calculdroit1.class#L25-L36), [calculdroit1.class:LecDra](../../../../../.src/Gestion/option/calculdroit1.class#L38-L70)
- [ ] CALCULDROIT1-002 — [réduction de portée] `taxe_droit` → `Private` (aucun appelant externe ;
  couvert par `droit_Read`, `secu_droit`, `accise_droit`) · appelants : aucun · tests : T03, T05 ·
  sources : [calculdroit1.class:taxe_droit](../../../../../.src/Gestion/option/calculdroit1.class#L84-L97)
- [ ] CALCULDROIT1-003 — [code mort] Supprimer la variable `famille` (jamais lue) en conservant le
  paramètre `fam` de `_new` (signature inchangée pour `Moulinage`) · appelants : aucun · tests :
  T09 · sources : [calculdroit1.class:12](../../../../../.src/Gestion/option/calculdroit1.class#L12), [calculdroit1.class:_new](../../../../../.src/Gestion/option/calculdroit1.class#L25-L36)
- [ ] CALCULDROIT1-004 — [commonalisation] Helper privé `PrixAvecTaxe(montant_taxe As LTaxe,
  taux_tva) As LPrix` partagé par `droit_Read`, `secu_Read`, `accise_Read` (même construction,
  types de taxe inchangés) · appelants : aucun · tests : T09 · sources : [calculdroit1.class:droit_Read](../../../../../.src/Gestion/option/calculdroit1.class#L127-L140), [calculdroit1.class:secu_Read](../../../../../.src/Gestion/option/calculdroit1.class#L142-L155), [calculdroit1.class:accise_Read](../../../../../.src/Gestion/option/calculdroit1.class#L158-L171)
- [ ] CALCULDROIT1-005 — [réarchitecture] `Cbase.Table("TabTvav")` et `Cbase.Table("TabParam")`
  dans `LecDra` (SQL identique) · appelants : aucun · tests : T06, T07 · sources : [calculdroit1.class:LecDra](../../../../../.src/Gestion/option/calculdroit1.class#L38-L70)
- [ ] CALCULDROIT1-006 — [commonalisation] Lecture de la régie et des deux taux de TVA en fonction
  `Static` partagée avec `calculdroit._new` (mêmes 3 `SELECT`, même ordre ; messages d'erreur
  propres à chaque classe) · appelants : aucun · tests : T06, T07, CALCULDROIT-T01 à T06 ·
  sources : [calculdroit1.class:LecDra](../../../../../.src/Gestion/option/calculdroit1.class#L38-L70), [calculdroit.class:_new](../../../../../.src/Gestion/option/calculdroit.class#L43-L98)
- [ ] CALCULDROIT1-007 — [code mort] Propriétés `droit` et `secu` (aucun lecteur, vérifié par
  `grep`) : suppression après confirmation en phase 3 qu'aucun accès `Variant` (`AutresObj`) ne les
  lit · appelants : aucun · tests : T09 · sources : [calculdroit1.class:droit_Read](../../../../../.src/Gestion/option/calculdroit1.class#L127-L140), [calculdroit1.class:secu_Read](../../../../../.src/Gestion/option/calculdroit1.class#L142-L155)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CALCULDROIT1-A01 — [anomalie] `_new` teste `opt <> "B"` (membre Boolean) au lieu de
  `op <> "B"` : vérifié avec `gbs3`, `opt` passe à `True` pour toute option autre que `T`. En
  option `B` (boissons seules), droits, sécu et accise ne sont pas calculés, `code` renvoie `Null`
  (pas de ligne `Fiches_ligregie` dans `Achat`) et `Moulinage` facture sans retirer l'accise ·
  tests : T01, T10, CONSIGNE-T06 · sources : [calculdroit1.class:33](../../../../../.src/Gestion/option/calculdroit1.class#L33), [Achat.class:958](../../../../../.src/Gestion/Entrées/Achat.class#L958), [Moulinage.class:2812](../../../../../.src/Caisse/Moulinage.class#L2812)
- [ ] CALCULDROIT1-A02 — [anomalie] `Error.Raise(msg, "OK")` à deux arguments : l'erreur levée est
  « Too many arguments » au lieu du message (TVA sécu absente, régie absente) · tests : T07 ·
  sources : [calculdroit1.class:51](../../../../../.src/Gestion/option/calculdroit1.class#L51), [calculdroit1.class:54](../../../../../.src/Gestion/option/calculdroit1.class#L54)
- [ ] CALCULDROIT1-A03 — [anomalie, à confirmer] `volume_Write`/`degre_Write` appellent
  `LecDra($resdr!code)` sans régie lue (`$resdr` `Null`) : erreur « Null object » quand `Achat`
  réaffecte `ccd.volume` sur une ligne créée pour un article sans régie ; `taxe_droit` lit
  `$resdr!ap` sans test · tests : T08 · sources : [calculdroit1.class:219](../../../../../.src/Gestion/option/calculdroit1.class#L219), [calculdroit1.class:233](../../../../../.src/Gestion/option/calculdroit1.class#L233), [calculdroit1.class:90](../../../../../.src/Gestion/option/calculdroit1.class#L90), [Achat.class:216](../../../../../.src/Gestion/Entrées/Achat.class#L216)
- [ ] CALCULDROIT1-A04 — [anomalie, à reporter dans Achat] `Achat.EnrRec` enregistre
  `volume = volume_total().TotBHT.G × qte` alors que `TotBHT` inclut déjà la quantité (volume ×
  qte², à confirmer) · tests : CONSIGNE-T06 · sources : [Achat.class:967](../../../../../.src/Gestion/Entrées/Achat.class#L967), [calculdroit1.class:volume_total](../../../../../.src/Gestion/option/calculdroit1.class#L72-L82)
