# Ccompta — Rework

> Source : `.src/Reports/Ccompta.class` · Message de commit (phase 4) : `reference/.src/Reports/Ccompta.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 546 |
| Lignes de commentaire | 50 |
| Fonctions | 53 |
| Fonctions Public | 53 |
| Complexité cyclomatique totale | 60 |
| Complexité max (fonction) | 5 (`Level2s`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 546 | 60 | 5 | 0 | 53 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CCOMPTA-001 — [documentation] En-tête de classe en français : rôle (gabarit PDF sans SQL ni
  pagination), tableau des familles de niveaux → éditions appelantes, conventions (mm, `PosY` géré
  par l'appelant, `Entete` seul créateur de page, montants `String` formatés par `Format$`) ;
  commentaire `'''` par méthode, dont la signature attendue de `Level4C`/`level2J` (arités fausses
  chez EDITCOMPTEA-A01 / JOURNAUXA-A01) · appelants : aucun · tests : T01-T08 · sources : [Ccompta.class:_new](../../../../.src/Reports/Ccompta.class#L8-L14), [Ccompta.class:Level4C](../../../../.src/Reports/Ccompta.class#L548-L558), [Ccompta.class:level2J](../../../../.src/Reports/Ccompta.class#L289-L307)
- [ ] CCOMPTA-002 — [code mort] Supprimer `Level2sbis` et `Level3T` (aucun appelant, vérifié par
  grep) et `_free` (vide) · appelants : aucun · tests : T01, T05 · sources : [Ccompta.class:Level2sbis](../../../../.src/Reports/Ccompta.class#L530-L535), [Ccompta.class:Level3T](../../../../.src/Reports/Ccompta.class#L698-L713), [Ccompta.class:_free](../../../../.src/Reports/Ccompta.class#L16-L18)
- [ ] CCOMPTA-003 — [commonalisation] `Level2CA` délègue à `Level2C` et `Level2A` à `Level3`
  (corps identiques aux noms de paramètres près) ; signatures publiques conservées, PDF identique ·
  appelants : aucun · tests : T01, T04 · sources : [Ccompta.class:Level2C](../../../../.src/Reports/Ccompta.class#L488-L503), [Ccompta.class:Level2CA](../../../../.src/Reports/Ccompta.class#L751-L766), [Ccompta.class:Level3](../../../../.src/Reports/Ccompta.class#L176-L185), [Ccompta.class:Level2A](../../../../.src/Reports/Ccompta.class#L739-L748)
- [ ] CCOMPTA-004 — [commonalisation] Helper privé `TotalLigne(libellé, d, c, s, PosY)` pour
  `Level4`/`Level5` (même code, libellé différent) et helper privé `EnTeteColonnes(x, y, taille,
  libellés[], largeurs[], remplir)` pour les 12 en-têtes de colonnes ; même séquence d'appels
  `PdfWriter` (PDF identique à l'octet près) · appelants : aucun · tests : T01-T05 · sources : [Ccompta.class:Level4](../../../../.src/Reports/Ccompta.class#L188-L200), [Ccompta.class:Level5](../../../../.src/Reports/Ccompta.class#L216-L228), [Ccompta.class:Level1](../../../../.src/Reports/Ccompta.class#L70-L87), [Ccompta.class:Level1C](../../../../.src/Reports/Ccompta.class#L468-L485), [Ccompta.class:Level1J](../../../../.src/Reports/Ccompta.class#L269-L286)
- [ ] CCOMPTA-005 — [commonalisation] Helper privé `SoldeAffiche(s) As String` (`Format$` +
  `-0,00` → `0,00`) pour `level2J`, `level2M`, `level2JT` · appelants : aucun · tests : T03 · sources : [Ccompta.class:level2J](../../../../.src/Reports/Ccompta.class#L289-L307), [Ccompta.class:level2M](../../../../.src/Reports/Ccompta.class#L330-L349), [Ccompta.class:level2JT](../../../../.src/Reports/Ccompta.class#L367-L379)
- [ ] CCOMPTA-006 — [séparation traitement/GUI] `Level2s` : extraire le calcul du solde dans une
  fonction privée `SoldeDebitCredit(deb, cred) As String` (même `Val(Utils.cpoint(…))`, même
  `Format$`) ; rendu inchangé · appelants : aucun · tests : T01 · sources : [Ccompta.class:Level2s](../../../../.src/Reports/Ccompta.class#L506-L528)
- [ ] CCOMPTA-007 — [complexité] `Lines(PosY As String)` → `Lines(PosY As Integer)` (tous les
  appelants passent un entier) ; le `SetXY(7, PosY)` est **conservé** (position courante utilisée
  par les appelants) · appelants : les 10 appelants de `Lines` (appels inchangés) · tests : T01,
  T02, T09 · sources : [Ccompta.class:Lines](../../../../.src/Reports/Ccompta.class#L51-L57)
- [ ] CCOMPTA-008 — [commonalisation] (phase 3) Dériver `Ccompta` de la base commune `PdfLaurux`
  (voir architecture.md) : `_new`, `BasPage` (identique à `CLcr`, `Cbalances`, `Cbilan`,
  `Cresultat`, `Cecheancier`, `Cstocks`, `Cbordereaux.Footer`) et `Entete` (variante x = 4,
  200 mm, gras italique de `TitrePage`) deviennent des délégations ; PDF identique · appelants :
  aucun (méthodes publiques conservées) · tests : T01, T06 · sources : [Ccompta.class:_new](../../../../.src/Reports/Ccompta.class#L8-L14), [Ccompta.class:Entete](../../../../.src/Reports/Ccompta.class#L20-L28), [Ccompta.class:BasPage](../../../../.src/Reports/Ccompta.class#L31-L38), [CLcr.class:BasPage](../../../../.src/Gestion/Lcr/CLcr.class#L31-L38)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CCOMPTA-A01 — [anomalie] Couleur de remplissage non fixée : `Level4C` (« Total compte »)
  remplit avec la couleur laissée par l'appel précédent ; après `Level2s` (sous-comptes,
  `EditcompteM`) elle est **blanche** (255), après `Level5C` grise, sinon celle du thème.
  `Level1R`, `Level1T`, `Level3R` dépendent de même de la couleur fixée par `Entete`. Correction :
  `SetFillColor(R, G, B)` explicite (rendu modifié) · appelants : `EditcompteM`, `EditcompteA`,
  `Pointage`, `Traites`, `Lcr` · tests : T07 · sources : [Ccompta.class:Level4C](../../../../.src/Reports/Ccompta.class#L548-L558), [Ccompta.class:526](../../../../.src/Reports/Ccompta.class#L526), [Ccompta.class:Level5C](../../../../.src/Reports/Ccompta.class#L576-L587)
- [ ] CCOMPTA-A02 — [anomalie] `level7J` imprime le débit de centralisation par `Left$(db, 24)`
  sans `Format$` (ex. `1234.5`), alors que crédit et solde sont formatés (`1 234,50`) ; les trois
  appelants passent la valeur brute `db_cent` · appelants : `Jourcent:858`, `JournauxA:795`,
  `JournauxM:346` · tests : T03, T10 · sources : [Ccompta.class:416](../../../../.src/Reports/Ccompta.class#L416), [Jourcent.class:858](../../../../.src/Compta/Impressions/Jourcent.class#L858)
