# Edart4 — Rework

> Source : `.src/Gestion/Impressions/Edart4.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/Edart4.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 392 |
| Lignes de commentaire | 6 |
| Fonctions | 20 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 66 |
| Complexité max (fonction) | 19 (`Butimp_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 392 | 66 | 19 | 0 | 14 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDART4-001 — [documentation] En-tête en français (remplace `EdArt2`, gb.report, rôle de
  `TarArt`, options) et commentaires sur `Butimp_Click`, `entete`, `ligne` · appelants : aucun ·
  tests : aucun · sources : [Edart4.class:_new](../../../../../.src/Gestion/Impressions/Edart4.class#L15-L43), [Edart4.class:Butimp_Click](../../../../../.src/Gestion/Impressions/Edart4.class#L106-L168)
- [ ] EDART4-002 — [code mort] Variables `res`, `cle`, `nego` de `Butimp_Click`
  ; commentaire `vb.Border` · appelants : aucun · tests : T01 · sources : [Edart4.class:Butimp_Click](../../../../../.src/Gestion/Impressions/Edart4.class#L106-L168), [Edart4.class:entete](../../../../../.src/Gestion/Impressions/Edart4.class#L342-L401)
- [ ] EDART4-003 — [complexité] Renommer la procédure privée `TriArticles` (homonyme de la classe
  `TriArticles`) en `AjouteFamilles` · appelants : aucun · tests : T01, T06 · sources : [Edart4.class:TriArticles](../../../../../.src/Gestion/Impressions/Edart4.class#L45-L61)
- [ ] EDART4-004 — [complexité] Helper privé `Cellule(hb, texte, align, largeur, bordure)` pour les
  blocs `ReportLabel` répétés de `tetedecolone` et `ligne` (rendu identique) · appelants : aucun ·
  tests : T01, T04, T05 · sources : [Edart4.class:tetedecolone](../../../../../.src/Gestion/Impressions/Edart4.class#L171-L240), [Edart4.class:ligne](../../../../../.src/Gestion/Impressions/Edart4.class#L242-L318)
- [ ] EDART4-005 — [séparation traitement/GUI] Extraire de `Butimp_Click` la requête
  `ArticlesFamille(…) As Result` et le calcul `PrixLigne(…) As Float[]` (HT, droits, TVA, TTC) ;
  `Butclig_Click` : lecture du client séparée de l'affichage · appelants : aucun · tests : T01, T02,
  T05 · sources : [Edart4.class:Butimp_Click](../../../../../.src/Gestion/Impressions/Edart4.class#L106-L168), [Edart4.class:Butclig_Click](../../../../../.src/Gestion/Impressions/Edart4.class#L87-L102)
- [ ] EDART4-006 — [commonalisation] Lecture de la société via un helper commun
  (`Utils.LitSociete`, en lien avec `Creleve.EnteteSociete` de LIGCLI-004) en gardant la requête
  actuelle sans filtre tant qu'EDART4-A04 n'est pas tranchée · appelants : aucun · tests : T01 ·
  sources : [Edart4.class:entete](../../../../../.src/Gestion/Impressions/Edart4.class#L342-L401)
- [ ] EDART4-007 — [commonalisation] Liste des types client partagée avec `EdArt3` (EDART3-007) ;
  parcours de l'arbre via `Trifam.Parcours()` si la proposition Trifam est retenue · appelants :
  aucun · tests : T03, T06 · sources : [Edart4.class:Buttypc_Click](../../../../../.src/Gestion/Impressions/Edart4.class#L403-L424), [Edart4.class:TriArticles](../../../../../.src/Gestion/Impressions/Edart4.class#L45-L61)
- [ ] EDART4-008 — [complexité] Conserver les 5 observateurs dans `Private $obs As Observer[]` au
  lieu d'une variable locale réaffectée (à faire seulement si le replay confirme un comportement
  identique) · appelants : aucun · tests : T07 · sources : [Edart4.class:_new](../../../../../.src/Gestion/Impressions/Edart4.class#L15-L43)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDART4-A01 — [anomalie] `saisie_keypress` fait `Stop Event` pour toute touche : la saisie
  clavier dans `Textyp`, `Four`, `Four2`, `Art`, `Art2` est probablement impossible (à confirmer en
  replay) · tests : T07 · sources : [Edart4.class:491](../../../../../.src/Gestion/Impressions/Edart4.class#L491)
- [ ] EDART4-A02 — [anomalie] Requête d'articles sans `ORDER BY` : ordre des articles non garanti
  dans le tarif · tests : T01 · sources : [Edart4.class:131](../../../../../.src/Gestion/Impressions/Edart4.class#L131)
- [ ] EDART4-A03 — [anomalie] `Textyp` désactivé après choix d'un client et jamais réactivé ;
  `$rescli` lu sans test `Available` · tests : T08 · sources : [Edart4.class:96](../../../../../.src/Gestion/Impressions/Edart4.class#L96), [Edart4.class:98](../../../../../.src/Gestion/Impressions/Edart4.class#L98)
- [ ] EDART4-A04 — [anomalie] En-tête société lu sans filtre `cd_sc = Start.Societe` (1ʳᵉ ligne de
  `Fiches_Societes`) · tests : T01 · sources : [Edart4.class:365](../../../../../.src/Gestion/Impressions/Edart4.class#L365)
- [ ] EDART4-A05 — [anomalie] `Image.Load` sans `Try` (photo d'article, logo) : une image absente
  interrompt l'édition ; chemin de photo sans préfixe `/Soc<XX>/Photart`, contrairement à
  `EdArt1`/`EdArt3` (à confirmer) · tests : T04 · sources : [Edart4.class:306](../../../../../.src/Gestion/Impressions/Edart4.class#L306), [Edart4.class:394](../../../../../.src/Gestion/Impressions/Edart4.class#L394)
- [ ] EDART4-A06 — [anomalie] Une fenêtre `TarArt` cachée créée par article et jamais détruite
  (voir TARART-A04, à traiter ensemble) ; `Bsel` jamais remis à faux avant `TriCpt`/`TriArticles` ·
  tests : T01, T06 · sources : [Edart4.class:141](../../../../../.src/Gestion/Impressions/Edart4.class#L141), [Edart4.class:ToggleButton5_Click](../../../../../.src/Gestion/Impressions/Edart4.class#L63-L73)
