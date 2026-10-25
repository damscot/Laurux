# RelvMo — Rework

> Source : `.src/Statistiques/RelvMo.class` · Message de commit (phase 4) : `reference/.src/Statistiques/RelvMo.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 382 |
| Lignes de commentaire | 26 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 97 |
| Complexité max (fonction) | 37 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 382 | 97 | 37 | 0 | 16 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RELVMO-001 — [documentation] En-tête en français : rôle, sources (BL facturés, historiques
  factures et matériel), table de travail `Fiches_Stat` (structure, collision), sélection `RB1`/`RB2` ·
  appelants : aucun · tests : aucun · sources : [RelvMo.class:_New](../../../../.src/Statistiques/RelvMo.class#L36-L63), [RelvMo.class:Button1_Click](../../../../.src/Statistiques/RelvMo.class#L197-L308)
- [ ] RELVMO-002 — [code mort] Supprimer `dte`, `dte1`, `dte2`, la variable `Logo` lue sans être
  transmise, le `Shell "cd …"` et `RlCli.Current.Delete` (liste vidée juste après) ; vider le
  commentaire de `Button7_Click` (handler conservé) · appelants : aucun · tests : T01, T04, T05 · sources : [RelvMo.class:Ex1](../../../../.src/Statistiques/RelvMo.class#L76-L92), [RelvMo.class:Button2_Click](../../../../.src/Statistiques/RelvMo.class#L329-L451), [RelvMo.class:190](../../../../.src/Statistiques/RelvMo.class#L190)
- [ ] RELVMO-003 — [complexité] `RlCli_Activate` : un seul `DELETE … WHERE codecli = &1 and code = &2`
  au lieu du `SELECT` et de la boucle ; **SQL modifié, dump identique** · appelants : aucun · tests :
  T04 · sources : [RelvMo.class:RlCli_Activate](../../../../.src/Statistiques/RelvMo.class#L174-L195)
- [ ] RELVMO-004 — [complexité] Factoriser les trois blocs de `Button1_Click` (BL, factures,
  factures matériel) dans un helper privé `CumuleMo(…)` paramétré par tables et colonnes, en gardant
  les différences actuelles (montant non cumulé, `qte = "1"` du bloc factures) (CC 37 → ≤ 15 visé) ·
  appelants : aucun · tests : T01, T02 · sources : [RelvMo.class:Button1_Click](../../../../.src/Statistiques/RelvMo.class#L197-L308)
- [ ] RELVMO-005 — [séparation traitement/GUI] Extraire `RemplitReleve(d0, d1)` (DROP/CREATE et
  remplissage de `Fiches_Stat`) ; le handler garde la validation des dates, les messages, le curseur
  et `MajTab` · appelants : aucun · tests : T01-T03, T08 · sources : [RelvMo.class:Button1_Click](../../../../.src/Statistiques/RelvMo.class#L197-L308)
- [ ] RELVMO-006 — [séparation traitement/GUI] `Button2_Click` : extraire `MentionsSociete() As
  Collection` (lecture `Fiches_Societes` et composition des mentions), à mutualiser en phase 3 avec
  les autres relevés · appelants : aucun · tests : T05 · sources : [RelvMo.class:Button2_Click](../../../../.src/Statistiques/RelvMo.class#L329-L451)
- [ ] RELVMO-007 — [commonalisation] Dates : `dteN0_LostFocus`/`dteN1_LostFocus` →
  `StatCommun.DateSaisie` (HITCARTE-006) ; `Ex1` → `PeriodeParDefaut()` partagé avec `RelMoprod.Ex1` ;
  `Fiches_Parametres` via `Cbase.Table("TabParam")` · appelants : aucun · tests : T02, T03 · sources : [RelvMo.class:Ex1](../../../../.src/Statistiques/RelvMo.class#L76-L92), [RelvMo.class:dteN0_LostFocus](../../../../.src/Statistiques/RelvMo.class#L129-L142), [RelvMo.class:dteN1_LostFocus](../../../../.src/Statistiques/RelvMo.class#L150-L163), [RelMoprod.class:Ex1](../../../../.src/Statistiques/RelMoprod.class#L72-L88)
- [ ] RELVMO-008 — [réduction de portée] `Ex1`, `MajTab`, `dteN0_GotFocus`, `dteN0_LostFocus`,
  `dteN1_GotFocus`, `dteN1_LostFocus` → `Private` (aucun appelant externe ; noms de handlers non
  levés car les zones sont dans le groupe `Cmpt`) · appelants : aucun · tests : T01, T03 · sources : [RelvMo.class:Ex1](../../../../.src/Statistiques/RelvMo.class#L76-L92), [RelvMo.class:MajTab](../../../../.src/Statistiques/RelvMo.class#L310-L327), [RelvMo.class:dteN0_GotFocus](../../../../.src/Statistiques/RelvMo.class#L122-L127), [RelvMo.class:dteN1_LostFocus](../../../../.src/Statistiques/RelvMo.class#L150-L163)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RELVMO-A01 — [anomalie] Saut de page de l'impression : `pdf.Entete` appelé avec 18 arguments
  pour 19 paramètres obligatoires (`Libre` absent) → erreur « Not enough arguments », aucun PDF dès
  qu'un client dépasse une page (corriger en passant `Libre` comme ligne 411) · tests : T06 · sources : [RelvMo.class:427](../../../../.src/Statistiques/RelvMo.class#L427), [RelvMo.class:411](../../../../.src/Statistiques/RelvMo.class#L411), [Cdocuments.class:Entete](../../../../.src/Reports/Cdocuments.class#L96-L196)
- [ ] RELVMO-A02 — [anomalie] Montant TTC non cumulé : l'`Update` de `Fiches_Stat` n'écrit que `qte`
  (le montant calculé ligne 276 est ignoré) ; la colonne affiche le montant de la première ligne
  trouvée pour le couple (MO, client) · tests : T01 · sources : [RelvMo.class:233](../../../../.src/Statistiques/RelvMo.class#L233), [RelvMo.class:254](../../../../.src/Statistiques/RelvMo.class#L254), [RelvMo.class:276](../../../../.src/Statistiques/RelvMo.class#L276)
- [ ] RELVMO-A03 — [anomalie] Table de travail `Fiches_Stat` détruite et recréée avec trois structures
  différentes (`RelvMo`, `RelMoprod`, `TriHistos`) et partagée entre postes : exécutions simultanées
  incohérentes (changement du dump si renommage) · tests : T01 · sources : [RelvMo.class:210](../../../../.src/Statistiques/RelvMo.class#L210), [RelMoprod.class:171](../../../../.src/Statistiques/RelMoprod.class#L171), [TriHistos.class:48](../../../../.src/Affichages/TriHistos.class#L48)
- [ ] RELVMO-A04 — [anomalie] Si `Val` échoue (quantité vide), `qte` garde la valeur de l'itération
  précédente (le `If Not Error` ne teste que le montant) ; les lignes MO des documents matériel non
  historisés (`Fiches_LigblM`) sont ignorées alors que les factures matériel historisées sont lues ·
  tests : T01 · sources : [RelvMo.class:235](../../../../.src/Statistiques/RelvMo.class#L235), [RelvMo.class:224](../../../../.src/Statistiques/RelvMo.class#L224)
- [ ] RELVMO-A05 — [anomalie] (relevée au lot Reports, voir CDOCUMENTS) l. 412 et 428 :
  `pdf.Entete2(rs2, adr22, ville2, pays, "", "", False)` omet `adr21` alors que la signature est
  `Entete2(rs2, adr1, adr2, ville, Pays, Col, entete)` : la 1re ligne d'adresse du client manque, la
  2e prend sa place, la ville passe en 2e ligne et le pays en ville · tests : T01 · sources : [RelvMo.class:412](../../../../.src/Statistiques/RelvMo.class#L412), [RelvMo.class:428](../../../../.src/Statistiques/RelvMo.class#L428), [Cdocuments.class:Entete2](../../../../.src/Reports/Cdocuments.class#L199-L229)
- [ ] RELVMO-A06 — [anomalie, sans effet visible] l. 440 : `pdf.Footer()` est sans effet
  (`Cdocuments` ne surcharge pas `Footer`, `PdfWriter.Footer` est vide) : le pied de page attendu
  n'est jamais imprimé · tests : T01 · sources : [RelvMo.class:440](../../../../.src/Statistiques/RelvMo.class#L440)
