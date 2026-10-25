# Cstocks — Rework

> Source : `.src/Reports/Cstocks.class` · Message de commit (phase 4) : `reference/.src/Reports/Cstocks.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 241 |
| Lignes de commentaire | 22 |
| Fonctions | 24 |
| Fonctions Public | 24 |
| Complexité cyclomatique totale | 24 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 241 | 24 | 1 | 0 | 24 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CSTOCKS-001 — [documentation] En-tête de classe en français : rôle (squelette des éditions
  d'inventaire et de dépôts), table « édition → en-tête / lignes / total → écrans », contrat
  (valeurs formatées, pagination par l'appelant, `BasPage` explicite) ; `'''` par méthode ·
  appelants : aucun · tests : T01-T05 · sources : [Cstocks.class:_new](../../../../.src/Reports/Cstocks.class#L8-L14), [Cstocks.class:Entete](../../../../.src/Reports/Cstocks.class#L20-L28), [Cstocks.class:BasPage](../../../../.src/Reports/Cstocks.class#L41-L48)
- [ ] CSTOCKS-002 — [code mort] Supprimer `_free` (vide) · appelants : aucun · tests : T01 · sources : [Cstocks.class:_free](../../../../.src/Reports/Cstocks.class#L16-L18)
- [ ] CSTOCKS-003 — [commonalisation] Hériter de la base `PdfLaurux` (CARTICLES-004) : `Entete` →
  `TitrePage` + `CouleurTheme` (même position des opérateurs de couleur dans le flux), `BasPage`
  → `PiedDePage(190)`, `Lines` → `Trait(y, 2, 208)` ; noms publics conservés · appelants : aucun ·
  tests : T01-T05, T07 · sources : [Cstocks.class:Entete](../../../../.src/Reports/Cstocks.class#L20-L28), [Cstocks.class:BasPage](../../../../.src/Reports/Cstocks.class#L41-L48), [Cstocks.class:Lines](../../../../.src/Reports/Cstocks.class#L51-L57)
- [ ] CSTOCKS-004 — [commonalisation] En-têtes et lignes (`Level1*`, `Level2*`, `Entetefam`) via
  `EnteteColonnes` / `LigneColonnes` (CARTICLES-005) ; flux identique · appelants : aucun · tests :
  T01-T04 · sources : [Cstocks.class:Level1](../../../../.src/Reports/Cstocks.class#L60-L74), [Cstocks.class:Level2G](../../../../.src/Reports/Cstocks.class#L110-L123), [Cstocks.class:Level2E](../../../../.src/Reports/Cstocks.class#L224-L239), [Cstocks.class:Level3D](../../../../.src/Reports/Cstocks.class#L288-L302), [Cstocks.class:Level2M](../../../../.src/Reports/Cstocks.class#L339-L352)
- [ ] CSTOCKS-005 — [commonalisation] Helper `TotalPaPmp(…)` pour `Level3`, `Level3NS`, `Level3E`
  (même schéma à des abscisses, tailles et libellés près), réutilisable par `level3fam` et
  `Carticles.Level5` ; flux identique · appelants : aucun · tests : T01, T03 · sources : [Cstocks.class:Level3](../../../../.src/Reports/Cstocks.class#L126-L141), [Cstocks.class:Level3NS](../../../../.src/Reports/Cstocks.class#L187-L202), [Cstocks.class:Level3E](../../../../.src/Reports/Cstocks.class#L242-L257), [Cstocks.class:level3fam](../../../../.src/Reports/Cstocks.class#L143-L154)
- [ ] CSTOCKS-006 — [commonalisation] Squelette d'édition paginée : `DebutEdition(sTitre,
  iEntete)` et `SautDePageSi(PosY, iSeuil, iReprise, Optional bPied = True) As Integer`
  (énumération des en-têtes, pas d'`Object.Call`) ; chaque écran garde son seuil, sa reprise et
  l'absence de `BasPage` d'`Edsdepots` (entrées) ; PDF identique · appelants : `Ecarts`,
  `EcartsT`, `Ednsaisis`, `EdnsaisisT`, `Edinv`, `Geninv`, `GeninvT`, `ImpDepots`, `Edsdepots`
  (`Edinv1`, `EdinvT` : après décision EDINV1-A01/EDINVT-A01) · tests : T06, T07 · sources : [Ecarts.class:116](../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class#L116), [Edinv.class:119](../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class#L119), [Geninv.class:214](../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L214), [ImpDepots.class:144](../../../../.src/Gestion/Depots/ImpDepots.class#L144), [Edsdepots.class:226](../../../../.src/Gestion/Depots/Edsdepots.class#L226)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CSTOCKS-A01 — [anomalie] (cosmétique) `level3fam` imprime la cellule « Total famille … » sur
  175 mm à partir de x = 2 puis recouvre sa partie droite (163 à 177 mm) par les cellules de
  valeurs ; un libellé de famille long est masqué. Correction : largeur 161 mm · tests : T01,
  EDINV-T01 · sources : [Cstocks.class:149](../../../../.src/Reports/Cstocks.class#L149), [Cstocks.class:150](../../../../.src/Reports/Cstocks.class#L150)
