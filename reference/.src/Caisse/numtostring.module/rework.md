# numtostring — Rework

> Source : `.src/Caisse/numtostring.module` · Message de commit (phase 4) : `reference/.src/Caisse/numtostring.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 166 |
| Lignes de commentaire | 2 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 92 |
| Complexité max (fonction) | 62 (`nbtostring`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 166 | 92 | 62 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Préfixe `NUMTOSTRING_CAISSE` (unicité vis-à-vis de `Utils/Numtostring.module`). Tant que
NUMTOSTRING_CAISSE-A01 n'est pas tranchée, le module n'est pas exécuté par Laurux : ses reworks
n'ont aucun effet observable et ne valent que si le module est conservé.

- [ ] NUMTOSTRING_CAISSE-001 — [documentation] En-tête en français : rôle (montant des chèques de
  caisse), limites (6 chiffres, orthographe, locale), collision de noms avec `Utils/Numtostring` ·
  appelants : aucun · tests : aucun · sources : [numtostring.module:nbtostring](../../../../.src/Caisse/numtostring.module#L81-L186)
- [ ] NUMTOSTRING_CAISSE-002 — [complexité] Fusionner les branches identiques `Case 4`, `5`, `6`
  en `Case 4 To 6` (CC 62 → ≈ 40, sorties identiques) ; seulement si le module est conservé
  (décision A01) · appelants : aucun · tests : T02-T05 · sources : [numtostring.module:138-181](../../../../.src/Caisse/numtostring.module#L138-L181)
- [ ] NUMTOSTRING_CAISSE-003 — [réduction de portée] `Calc_unite`, `Calc_Dizaine` → `Private` ·
  appelants : aucun · tests : T02-T04 · sources : [numtostring.module:Calc_unite](../../../../.src/Caisse/numtostring.module#L5-L33), [numtostring.module:Calc_Dizaine](../../../../.src/Caisse/numtostring.module#L35-L79)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] NUMTOSTRING_CAISSE-A01 — [anomalie] Homonymie à la casse près avec `Utils/Numtostring` : un
  seul `.gambas/NUMTOSTRING` est produit (version `Utils`, sans `nbtostring`) ; l'impression d'un
  chèque en caisse (`Caisse.Imp_Cheque`) appelle un symbole absent et échoue. Choix : (a) appeler
  `Numtostring.Num2Text` depuis la caisse (orthographe de `Utils`, cf. NUMTOSTRING-A04) et
  supprimer ce module, ou (b) renommer ce module (ex. `NbLettresCaisse`) et mettre à jour les 4
  appels de `Caisse` · appelants : `Caisse` (`Imp_Cheque`, `Imp_Cheque1`) · tests : T01, T06 · sources : [numtostring.module:nbtostring](../../../../.src/Caisse/numtostring.module#L81-L186), [Caisse.class:5064](../../../../.src/Caisse/Caisse.class#L5064), [Caisse.class:5069](../../../../.src/Caisse/Caisse.class#L5069), [Caisse.class:5149](../../../../.src/Caisse/Caisse.class#L5149), [Caisse.class:5154](../../../../.src/Caisse/Caisse.class#L5154)
- [ ] NUMTOSTRING_CAISSE-A02 — [anomalie] Orthographe : « vingt un », « soixante onze »,
  « quatre-vingt un » (ni « et », ni traits d'union), « quatre-vingt » sans « s », « deux cents
  mille » · tests : T02, T03 · sources : [numtostring.module:100-111](../../../../.src/Caisse/numtostring.module#L100-L111), [numtostring.module:135](../../../../.src/Caisse/numtostring.module#L135)
- [ ] NUMTOSTRING_CAISSE-A03 — [anomalie] Contrôle d'entrée `InStr("0123456789,.", nombre) = 1` :
  rejette les préfixes de la chaîne (`"0"`, `"01"`, `"012"`…) au lieu des caractères invalides (les
  centimes `01` donnent `""`) ; 7 à 9 chiffres → chaîne vide sans erreur ; découpe dépendante de
  la locale (`Str()` avec virgule) · tests : T02, T04, T05 · sources : [numtostring.module:87-88](../../../../.src/Caisse/numtostring.module#L87-L88), [numtostring.module:96-98](../../../../.src/Caisse/numtostring.module#L96-L98), [numtostring.module:183](../../../../.src/Caisse/numtostring.module#L183)
