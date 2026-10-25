# Chistoriques — Rework

> Source : `.src/Reports/Chistoriques.class` · Message de commit (phase 4) : `reference/.src/Reports/Chistoriques.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 291 |
| Lignes de commentaire | 37 |
| Fonctions | 33 |
| Fonctions Public | 33 |
| Complexité cyclomatique totale | 33 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 291 | 33 | 1 | 0 | 33 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CHISTORIQUES-001 — [documentation] En-tête de classe en français : rôle, table « suffixe →
  édition → appelant », sens réel de `Level0F` (bandeau de période de toutes les statistiques),
  contrat des paramètres (valeurs déjà formatées, sauf `level2FO`) ; commentaires `'''` sur les
  méthodes publiques · appelants : aucun · tests : T01-T05 · sources : [Chistoriques.class:_new](../../../../.src/Reports/Chistoriques.class#L9-L16), [Chistoriques.class:Level0F](../../../../.src/Reports/Chistoriques.class#L108-L114), [Chistoriques.class:level2FO](../../../../.src/Reports/Chistoriques.class#L397-L407)
- [ ] CHISTORIQUES-002 — [code mort] Supprimer les méthodes sans appelant `Level1bis`, `Level2bis`,
  `Level1F`, `level2F`, `Level4F`, `Level5F`, `Level5AC` (vérifié par `grep`, homonymes d'autres
  classes exclus) et les membres `R`/`G`/`B` (variables locales suffisent) · appelants : aucun ·
  tests : T01-T05 · sources : [Chistoriques.class:Level1bis](../../../../.src/Reports/Chistoriques.class#L63-L75), [Chistoriques.class:Level2bis](../../../../.src/Reports/Chistoriques.class#L92-L104), [Chistoriques.class:Level1F](../../../../.src/Reports/Chistoriques.class#L117-L129), [Chistoriques.class:level2F](../../../../.src/Reports/Chistoriques.class#L132-L144), [Chistoriques.class:Level4F](../../../../.src/Reports/Chistoriques.class#L147-L155), [Chistoriques.class:Level5F](../../../../.src/Reports/Chistoriques.class#L158-L166), [Chistoriques.class:Level5AC](../../../../.src/Reports/Chistoriques.class#L216-L223)
- [ ] CHISTORIQUES-003 — [commonalisation] Hériter de la base `PdfLaurux` (CARTICLES-004) :
  `_new` → `CouleurTheme`, `Entete` → `TitrePage` (taille 12), `Footer` → `PiedDePage(190)`,
  `Lines` → `Trait` ; noms publics conservés, flux PDF identique · appelants : aucun (API
  inchangée) · tests : T01, T06 · sources : [Chistoriques.class:_new](../../../../.src/Reports/Chistoriques.class#L9-L16), [Chistoriques.class:Entete](../../../../.src/Reports/Chistoriques.class#L19-L26), [Chistoriques.class:Footer](../../../../.src/Reports/Chistoriques.class#L29-L35), [Chistoriques.class:Lines](../../../../.src/Reports/Chistoriques.class#L38-L44)
- [ ] CHISTORIQUES-004 — [commonalisation] En-têtes, lignes et totaux via `EnteteColonnes` /
  `LigneColonnes` (CARTICLES-005) ; les totaux `Level5C`/`Level5P`/`Level5A` gardent leur espace
  final et `Level5FO` son alignement centré (paramètres) ; flux identique · appelants : aucun ·
  tests : T02-T05 · sources : [Chistoriques.class:Level1C](../../../../.src/Reports/Chistoriques.class#L169-L181), [Chistoriques.class:level2C](../../../../.src/Reports/Chistoriques.class#L264-L276), [Chistoriques.class:Level5C](../../../../.src/Reports/Chistoriques.class#L292-L302), [Chistoriques.class:Level1P](../../../../.src/Reports/Chistoriques.class#L328-L340), [Chistoriques.class:Level5FO](../../../../.src/Reports/Chistoriques.class#L421-L429)
- [ ] CHISTORIQUES-005 — [séparation traitement/GUI] `level2FO` : extraire le formatage
  `Format$(Val(x), "0.00")` dans une fonction pure `Montant2Dec(x) As String` (même comportement,
  erreur comprise), testable en gb.test · appelants : aucun · tests : T05 · sources : [Chistoriques.class:level2FO](../../../../.src/Reports/Chistoriques.class#L397-L407)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CHISTORIQUES-A01 — [anomalie] `level2FO` fait `Format$(Val(x), "0.00")` : une valeur vide ou
  non numérique lève « Type mismatch » (vérifié avec `gbx3`). `VisStatFour` laisse la colonne %
  vide quand le CA de la période est nul (`Try` sur la division) → l'impression du CA
  fournisseurs s'arrête dès qu'un fournisseur n'a vendu qu'en N-1 (à confirmer par T07).
  Correction proposée : imprimer la valeur brute (ou « 0,00 ») si `Val` renvoie `Null` · tests :
  T05, T07, VISSTATFOUR-T03 · sources : [Chistoriques.class:403](../../../../.src/Reports/Chistoriques.class#L403), [Chistoriques.class:405](../../../../.src/Reports/Chistoriques.class#L405), [VisStatFour.class:98](../../../../.src/Statistiques/VisStatFour.class#L98), [VisStatFour.class:182](../../../../.src/Statistiques/VisStatFour.class#L182)
- [ ] CHISTORIQUES-A02 — [anomalie] (renvoi) `level2P` imprime tels quels les `Float` que lui
  passe `VisStatClimo` (« 12.5 » au lieu de « 12,50 ») ; la correction se fait dans l'appelant
  (VISSTATCLIMO-A01), le gabarit restant inchangé · tests : T04, VISSTATCLIMO-T03 · sources : [Chistoriques.class:level2P](../../../../.src/Reports/Chistoriques.class#L343-L355), [VisStatClimo.class:221](../../../../.src/Statistiques/VisStatClimo.class#L221)
