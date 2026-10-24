# LDate — Rework

> Source : `.src/Utils/LDate.class` · Message de commit (phase 4) : `reference/.src/Utils/LDate.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 489 |
| Lignes de commentaire | 18 |
| Fonctions | 45 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 119 |
| Complexité max (fonction) | 20 (`DateFilterDB`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 489 | 119 | 20 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LDATE-001 — [documentation] En-tête de classe : tableau des propriétés de format, formats
  acceptés par `Parse`, sémantique de `EDeb`/`EFin`/`EInd` (requête SQL à chaque lecture) ;
  commentaires `'''` sur chaque méthode Public · appelants : aucun · tests : T01-T13 · sources : [LDate.class:_New](../../../../.src/Utils/LDate.class#L43-L68), [LDate.class:Parse](../../../../.src/Utils/LDate.class#L192-L290)
- [ ] LDATE-002 — [code mort] Supprimer les variables locales inutilisées (`cvdate`, `time` dans
  `DateFilterDB` et `Parse`, `edate` dans `Exercice_Index`) et les blocs `With utils` sans effet ·
  appelants : aucun · tests : T10, T11 · sources : [LDate.class:DateFilterDB](../../../../.src/Utils/LDate.class#L79-L185), [LDate.class:Exercice_Index](../../../../.src/Utils/LDate.class#L623-L646)
- [ ] LDATE-003 — [complexité] `DateFilterDB` : helper privé `Joker(txt, n)` et construction unique
  du motif (CC 20 → ≤ 8 visé) · appelants : `Facture`, `ArchivesTck` (inchangés) · tests : T10 · sources : [LDate.class:DateFilterDB](../../../../.src/Utils/LDate.class#L79-L185)
- [ ] LDATE-004 — [complexité] Helper privé `Clotures() As Date[]` partagé par `Exercice_Fin`,
  `Exercice_Index`, `Exercice_Cloture` (une requête par appel, comme aujourd'hui) · appelants :
  aucun · tests : T11, T12, T13 · sources : [LDate.class:Exercice_Fin](../../../../.src/Utils/LDate.class#L594-L621), [LDate.class:Exercice_Index](../../../../.src/Utils/LDate.class#L623-L646), [LDate.class:Exercice_Cloture](../../../../.src/Utils/LDate.class#L648-L672)
- [ ] LDATE-005 — [séparation traitement/GUI] `Parse` : analyse pure qui renvoie `Null` et un code
  d'erreur ; les `Message.Error` (mêmes textes, même ordre) dans un wrapper et dans `_New` ·
  appelants : aucun · tests : T02, T03, T04 · sources : [LDate.class:Parse](../../../../.src/Utils/LDate.class#L192-L290), [LDate.class:_New](../../../../.src/Utils/LDate.class#L43-L68)
- [ ] LDATE-006 — [complexité] `Apres`/`Avant` : comparaison directe `DateDiff(…, gb.Second)` et
  suppression de `prd` et des `Select Case` booléens, sous réserve que T09 reste identique ·
  appelants : ~29 appels (Extrait, VerifDate, Moulinage…) inchangés · tests : T09, VERIFDATE-T* · sources : [LDate.class:Apres](../../../../.src/Utils/LDate.class#L515-L537), [LDate.class:Avant](../../../../.src/Utils/LDate.class#L540-L562), [LDate.class:prd](../../../../.src/Utils/LDate.class#L292-L297)
- [ ] LDATE-007 — [réduction de portée] `Fin_Mois`, `Exercice_Debut`, `Exercice_Fin`,
  `Exercice_Index`, `Periode_Debut`, `Periode_Fin` → `Private` (couverts par les propriétés). **Ne
  pas** réduire `Fin_Jour` (`Histocliart.class:342`) ni `Exercice_Cloture` · appelants : aucun ·
  tests : T08, T11 · sources : [LDate.class:Fin_Mois](../../../../.src/Utils/LDate.class#L564-L573), [LDate.class:Exercice_Debut](../../../../.src/Utils/LDate.class#L587-L591), [LDate.class:Exercice_Fin](../../../../.src/Utils/LDate.class#L594-L621), [LDate.class:Exercice_Index](../../../../.src/Utils/LDate.class#L623-L646), [LDate.class:Periode_Debut](../../../../.src/Utils/LDate.class#L674-L678), [LDate.class:Periode_Fin](../../../../.src/Utils/LDate.class#L681-L685)
- [ ] LDATE-008 — [commonalisation] `Exercice_Cloture(i)` devient l'API unique de lecture des
  bornes d'exercice ; la bascule des ~30 fichiers qui lisent `dteclec*` à la main se fait dans
  leurs propres reworks (liste dans architecture.md) · appelants : aucun dans ce fichier · tests : T13 · sources : [LDate.class:Exercice_Cloture](../../../../.src/Utils/LDate.class#L648-L672)
- [ ] LDATE-009 — [commonalisation] Préparer la bascule des `Utils.Cdate_Dbase`, `Cdate_Aff`,
  `Cdate2_Dbase`, `Calc_mois`, `lastday` vers `LDate` : documenter dans `Utils.module` l'équivalent
  `LDate` de chaque helper (la bascule effective est un rework d'`Utils`) · appelants : aucun ·
  tests : T05, T08 · sources : [LDate.class:Fin_Mois](../../../../.src/Utils/LDate.class#L564-L573), [Utils.module:Cdate_Dbase](../../../../.src/Utils/Utils.module#L316-L324), [Utils.module:Cdate_Aff](../../../../.src/Utils/Utils.module#L400-L407), [Utils.module:Calc_mois](../../../../.src/Utils/Utils.module#L508-L534), [Utils.module:lastday](../../../../.src/Utils/Utils.module#L1248-L1260)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LDATE-A01 — [anomalie] `Parse` traite toute chaîne de 14 caractères comme
  `yyyymmddHHMMSS` : `"12/03/24 10:30"` provoque « Erreur grave » et une date `Null` · tests : T04 · sources : [LDate.class:209-210](../../../../.src/Utils/LDate.class#L209-L210)
- [ ] LDATE-A02 — [anomalie] `Exercice_Debut` (`EDeb`) suppose un exercice de 12 mois (fin − 1 an) ;
  faux pour un premier exercice ou un exercice de durée différente (`EcrM` utilise
  `dteclec(n+1) + 1 jour`) · appelants : ExportA47, Pointage, Lettrage, Stockmvt, Edconsigne,
  Histocliart, LauruxMaj · tests : T12 · sources : [LDate.class:589](../../../../.src/Utils/LDate.class#L589)
- [ ] LDATE-A03 — [anomalie] `Exercice_Fin` au-delà de `dteclec` : année de la date + jour/mois de
  clôture, ce qui donne une fin d'exercice antérieure à la date pour un exercice décalé · tests : T12 · sources : [LDate.class:614-615](../../../../.src/Utils/LDate.class#L614-L615)
- [ ] LDATE-A04 — [anomalie] `MonStr` : noms de mois incohérents (`fevrier` sans accent ; `jun`,
  `jui`, `aou`… abrégés au lieu de `juin`, `juillet`, `août`) ; impact sur les libellés
  automatiques `$moistr` (`LVar`) · tests : T07, LVAR-T03 · sources : [LDate.class:475](../../../../.src/Utils/LDate.class#L475)
- [ ] LDATE-A05 — [anomalie] `_New` : branche `Param.Count = 0` toujours vraie (à confirmer) ;
  `LDate("2024", 3, 1)` ignore le mois et le jour fournis · tests : T01 · sources : [LDate.class:51](../../../../.src/Utils/LDate.class#L51)
- [ ] LDATE-A06 — [anomalie] `L_Write`/`D_Write`/`LT_Write`/`DT_Write` : un échec d'analyse met la
  date à `Null` (valeur précédente perdue) sans événement ; `_New` affiche deux messages pour une
  même erreur · tests : T04, T06 · sources : [LDate.class:L_Write](../../../../.src/Utils/LDate.class#L315-L322), [LDate.class:53-55](../../../../.src/Utils/LDate.class#L53-L55)
- [ ] LDATE-A07 — [anomalie] `Parse` des formats `a.m`/`m.a` utilise `Day(Now)` : date invalide
  (donc `Null`) les 29, 30, 31 selon le mois saisi · tests : T04 · sources : [LDate.class:261-264](../../../../.src/Utils/LDate.class#L261-L264)
- [ ] LDATE-A08 — [anomalie] `Exercice_*` : pas de test `rResult.Available` (table
  `Fiches_Parametres` vide → erreur) · tests : manuel · sources : [LDate.class:600](../../../../.src/Utils/LDate.class#L600)
