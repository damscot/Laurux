# Carticles — Rework

> Source : `.src/Reports/Carticles.class` · Message de commit (phase 4) : `reference/.src/Reports/Carticles.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 370 |
| Lignes de commentaire | 27 |
| Fonctions | 36 |
| Fonctions Public | 36 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 2 (`Photo`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 370 | 37 | 2 | 0 | 36 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CARTICLES-001 — [documentation] En-tête de classe en français : rôle (gabarit PDF des
  éditions d'articles et de stock), tableau « édition appelante → en-tête / lignes / total »,
  contrat (valeurs déjà formatées, pagination à la charge de l'appelant, `Footer` appelé
  explicitement) ; commentaire `'''` par méthode publique · appelants : aucun · tests : T01-T07 · sources : [Carticles.class:_new](../../../../.src/Reports/Carticles.class#L9-L16), [Carticles.class:Entete](../../../../.src/Reports/Carticles.class#L22-L29), [Carticles.class:Footer](../../../../.src/Reports/Carticles.class#L32-L38)
- [ ] CARTICLES-002 — [code mort] Supprimer `_free` (vide) et les méthodes sans appelant
  `Level3bis`, `EnteteTC`, `Level2TC`, `Level3TC` (vérifié par `grep`, aucune chaîne dynamique) ;
  remplacer les membres `R`/`G`/`B` par `SetFillColor(Start.R, Start.G, Start.B)` · appelants :
  aucun · tests : T01-T06 · sources : [Carticles.class:_free](../../../../.src/Reports/Carticles.class#L18-L20), [Carticles.class:Level3bis](../../../../.src/Reports/Carticles.class#L78-L93), [Carticles.class:EnteteTC](../../../../.src/Reports/Carticles.class#L108-L115), [Carticles.class:Level2TC](../../../../.src/Reports/Carticles.class#L118-L130), [Carticles.class:Level3TC](../../../../.src/Reports/Carticles.class#L133-L147), [Carticles.class:_new](../../../../.src/Reports/Carticles.class#L9-L16)
- [ ] CARTICLES-003 — [code mort] **Après validation d'EDART2-A01** (suppression d'`EdArt2`) :
  supprimer `Level8`, `Level8bis`, `Level9`, `Level9bis` et `Ligne2`, sans autre appelant ·
  appelants : `EdArt2` (supprimé) · tests : T07 (retiré) · sources : [Carticles.class:Level8](../../../../.src/Reports/Carticles.class#L248-L262), [Carticles.class:Level8bis](../../../../.src/Reports/Carticles.class#L265-L277), [Carticles.class:Level9](../../../../.src/Reports/Carticles.class#L280-L292), [Carticles.class:Level9bis](../../../../.src/Reports/Carticles.class#L295-L306), [Carticles.class:Ligne2](../../../../.src/Reports/Carticles.class#L441-L445), [EdArt2.class:Button2_Click](../../../../.src/Gestion/Impressions/EdArt2.class#L544-L651)
- [ ] CARTICLES-004 — [commonalisation] Compléter la base commune `PdfLaurux` (`Inherits PdfWriter`,
  créée par PDFWRITER-011) avec les éléments de gabarit `CouleurTheme()`, `PiedDePage(largeur, dy)`, `TitrePage(titre, x, largeur,
  style, taille)`, `Trait(y, x1, x2)` ; `Carticles` passe à `Inherits PdfLaurux`, `Entete`,
  `Footer`, `Ligne`, `Ligne2` délèguent (noms publics conservés). Flux PDF identique ; les autres
  gabarits suivent (CHISTORIQUES-003, CSTOCKS-003, CCLIENTS-003, CMAT-003, CETIQUETTES-004 et les
  gabarits comptables) · appelants : aucun (API inchangée) · tests : T01-T08 · sources : [Carticles.class:_new](../../../../.src/Reports/Carticles.class#L9-L16), [Carticles.class:Entete](../../../../.src/Reports/Carticles.class#L22-L29), [Carticles.class:Footer](../../../../.src/Reports/Carticles.class#L32-L38), [Carticles.class:Ligne](../../../../.src/Reports/Carticles.class#L435-L439), [Carticles.class:Ligne2](../../../../.src/Reports/Carticles.class#L441-L445)
- [ ] CARTICLES-005 — [commonalisation] Helpers `EnteteColonnes(x, y, taille, largeurs,
  libelles)` et `LigneColonnes(x, y, h, taille, largeurs, valeurs, alignements)` dans
  `PdfLaurux` ; les 22 `LevelN` vivants (hors `Level6bis`, voir A01, et hors `Level5`/`Level10`)
  deviennent un appel chacun, même suite de `Cell` (flux identique) · appelants : aucun · tests :
  T01-T05, T07 · sources : [Carticles.class:Level1](../../../../.src/Reports/Carticles.class#L41-L56), [Carticles.class:Level3](../../../../.src/Reports/Carticles.class#L59-L76), [Carticles.class:Level7](../../../../.src/Reports/Carticles.class#L215-L229), [Carticles.class:Level6](../../../../.src/Reports/Carticles.class#L179-L195), [Carticles.class:Level13V](../../../../.src/Reports/Carticles.class#L378-L391), [Carticles.class:Level14V](../../../../.src/Reports/Carticles.class#L412-L427), [Carticles.class:Level2MO](../../../../.src/Reports/Carticles.class#L466-L483)
- [ ] CARTICLES-006 — [commonalisation] `Static Public Function FormatAligne(valeur, nbdec) As
  String` dans `PdfLaurux` (idiome « espace si 2 décimales », environ 15 copies) ; les appelants
  remplacent leurs copies dans le même commit ou dans leurs propres cases (EDART1-007) ·
  appelants : `EdArt1`, `EdArt3`, `EdStk`, `EdRup`, `EdMat`, `ImpDepots` · tests : T09, T08 · sources : [EdArt1.class:618](../../../../.src/Gestion/Impressions/EdArt1.class#L618), [EdStk.class:Button2_Click](../../../../.src/Gestion/Impressions/EdStk.class#L463-L586), [ImpDepots.class:Button2_Click](../../../../.src/Gestion/Depots/ImpDepots.class#L99-L171)
- [ ] CARTICLES-007 — [commonalisation] `EnteteTarif(sTitre, bPhoto, bMarge)` dans `Carticles`
  (`Entete` + `Level7`/`Level7bis`/`Level7M`), écrit 2 fois dans `EdArt1` et 2 fois dans `EdArt3`
  (voir EDART1-006) · appelants : `EdArt1`, `EdArt3` · tests : T02, T03, T08 · sources : [Carticles.class:Level7](../../../../.src/Reports/Carticles.class#L215-L229), [Carticles.class:Level7bis](../../../../.src/Reports/Carticles.class#L232-L245), [Carticles.class:Level7M](../../../../.src/Reports/Carticles.class#L505-L519), [EdArt1.class:Button2_Click](../../../../.src/Gestion/Impressions/EdArt1.class#L553-L696), [EdArt3.class:Button2_Click](../../../../.src/Gestion/Impressions/EdArt3.class#L626-L763)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CARTICLES-A01 — [anomalie] `Level6bis` choisit la police « Hel8vetica » : `PdfWriter.SetFont`
  lève « Undefined font: hel8vetica » (vérifié avec `gbx3`) → le tarif interne en mode photo
  s'arrête sur une erreur non interceptée au premier article (`EdArt3`, case `Phot` visible ;
  `EdArt1`, case invisible). Correction : « Helvetica » · tests : T03, EDART3-T03 · sources : [Carticles.class:202](../../../../.src/Reports/Carticles.class#L202), [EdArt3.class:715](../../../../.src/Gestion/Impressions/EdArt3.class#L715), [EdArt3.class:727](../../../../.src/Gestion/Impressions/EdArt3.class#L727), [EdArt1.class:648](../../../../.src/Gestion/Impressions/EdArt1.class#L648)
- [ ] CARTICLES-A02 — [anomalie] `Entete` place le titre à x = 40 avec une largeur de 206 mm (cadre
  jusqu'à 246 mm sur une page de 210 mm, texte décalé à droite) depuis `77efe343` (2017, ajout
  d'`EnteteTC` à x = 2, probable inversion) ; touche les 8 éditions. Correction : x = 2 comme
  les autres gabarits (à confirmer visuellement) · tests : T01, T08 · sources : [Carticles.class:25](../../../../.src/Reports/Carticles.class#L25), [Carticles.class:EnteteTC](../../../../.src/Reports/Carticles.class#L108-L115)
- [ ] CARTICLES-A03 — [anomalie] (cosmétique) `Level5` imprime les valeurs à x = 138, décalées de
  2 mm sous les en-têtes « Total PA »/« Total PMP » (x = 140), et l'en-tête « Total Stock » n'a pas
  de valeur · tests : T01 · sources : [Carticles.class:Level5](../../../../.src/Reports/Carticles.class#L165-L176)
