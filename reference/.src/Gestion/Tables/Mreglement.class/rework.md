# Mreglement — Rework

> Source : `.src/Gestion/Tables/Mreglement.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Mreglement.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 318 |
| Lignes de commentaire | 6 |
| Fonctions | 24 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 77 |
| Complexité max (fonction) | 11 (`bar1_valide`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 318 | 77 | 11 | 0 | 23 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MREGLEMENT-001 — [documentation] En-tête : double rôle (écran + référentiel des modes de
  caisse), signification de `lcr`/`caisse`, cycle de transaction de la barre, appel par
  `Moulinage` · appelants : aucun · tests : aucun · sources : [Mreglement.class:3](../../../../../.src/Gestion/Tables/Mreglement.class#L3), [Mreglement.class:_new](../../../../../.src/Gestion/Tables/Mreglement.class#L15-L49)
- [ ] MREGLEMENT-002 — [réarchitecture] `RegCais`, `CodeCais`, `RegMode2CodeCaisse`,
  `Laision_Reg` (et `CodeCaisse2RegMode` si conservée) en `Static Public` : `Moulinage` ne crée plus
  l'auto-instance cachée (syntaxe d'appel inchangée ; SQL modifié : un `SELECT` de `_new` en moins,
  dump identique) · appelants : `Moulinage` (inchangé) · tests : T01-T03, replays du moulinage ·
  sources : [Mreglement.class:5](../../../../../.src/Gestion/Tables/Mreglement.class#L5), [Mreglement.class:6](../../../../../.src/Gestion/Tables/Mreglement.class#L6), [Mreglement.class:RegMode2CodeCaisse](../../../../../.src/Gestion/Tables/Mreglement.class#L256-L264), [Mreglement.class:Laision_Reg](../../../../../.src/Gestion/Tables/Mreglement.class#L266-L277), [Moulinage.class:2495](../../../../../.src/Caisse/Moulinage.class#L2495)
- [ ] MREGLEMENT-003 — [code mort] Supprimer `CodeCaisse2RegMode` (jamais appelée) ; documenter
  `bar1_recherche` et la branche tag 1 de `recherche_Click` comme inatteignables (handler conservé
  tant que la barre peut afficher la recherche) · appelants : aucun · tests : T02 · sources : [Mreglement.class:CodeCaisse2RegMode](../../../../../.src/Gestion/Tables/Mreglement.class#L243-L254), [Mreglement.class:bar1_recherche](../../../../../.src/Gestion/Tables/Mreglement.class#L307-L329)
- [ ] MREGLEMENT-004 — [séparation traitement/GUI] `ValideReglement(...) As String` (contrôles de
  `bar1_valide` sans accès aux contrôles, message renvoyé à l'appelant qui garde `Message.Error`) ·
  appelants : aucun · tests : T04-T06 · sources : [Mreglement.class:bar1_valide](../../../../../.src/Gestion/Tables/Mreglement.class#L134-L191)
- [ ] MREGLEMENT-005 — [réarchitecture] `Cbase.Table("TabJour")` et `Cbase.Table("TabComptes")`
  dans `affiche`, `jour_LostFocus`, `cptint_LostFocus`, `butjour_Click` (SQL identique) ·
  appelants : aucun · tests : T04-T06 · sources : [Mreglement.class:affiche](../../../../../.src/Gestion/Tables/Mreglement.class#L51-L82), [Mreglement.class:jour_LostFocus](../../../../../.src/Gestion/Tables/Mreglement.class#L207-L223), [Mreglement.class:cptint_LostFocus](../../../../../.src/Gestion/Tables/Mreglement.class#L225-L241), [Mreglement.class:butjour_Click](../../../../../.src/Gestion/Tables/Mreglement.class#L331-L353)
- [ ] MREGLEMENT-006 — [commonalisation] Cycle `Begin`/`Create9`/`Edit`/`Commit`/`Rollback` commun
  avec les écrans à `Barselection` (`Tregie`, `Ttourne`, `Tconsigne`, `Tregion`, `Tchauffeur`) ·
  appelants : aucun · tests : T04-T08 · sources : [Mreglement.class:bar1_creer](../../../../../.src/Gestion/Tables/Mreglement.class#L105-L113), [Mreglement.class:bar1_modif](../../../../../.src/Gestion/Tables/Mreglement.class#L115-L124), [Mreglement.class:bar1_annule](../../../../../.src/Gestion/Tables/Mreglement.class#L126-L132), [Mreglement.class:bar1_suprimer](../../../../../.src/Gestion/Tables/Mreglement.class#L193-L199)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MREGLEMENT-A01 — [anomalie] Transaction ouverte (`Begin`) pendant toute la saisie : la
  fermeture de la fenêtre avant Valider/Annuler laisse la transaction ouverte sur la connexion
  partagée `Utils.db` (écritures ultérieures de la session dans cette transaction, à confirmer) ·
  tests : T04-T09 · sources : [Mreglement.class:110](../../../../../.src/Gestion/Tables/Mreglement.class#L110), [Mreglement.class:118](../../../../../.src/Gestion/Tables/Mreglement.class#L118), [Mreglement.class:196](../../../../../.src/Gestion/Tables/Mreglement.class#L196)
- [ ] MREGLEMENT-A02 — [anomalie] `bar1_modif` sans ligne sélectionnée sort sans `Edit` alors que
  la barre passe en mode validation : Valider utilise un `$res` nul ou celui d'une opération
  précédente · tests : T09 · sources : [Mreglement.class:117](../../../../../.src/Gestion/Tables/Mreglement.class#L117), [Mreglement.class:182](../../../../../.src/Gestion/Tables/Mreglement.class#L182)
- [ ] MREGLEMENT-A03 — [anomalie] Suppression sans contrôle d'usage (clients `cli_reg`, factures,
  échéances) · tests : T08 · sources : [Mreglement.class:197](../../../../../.src/Gestion/Tables/Mreglement.class#L197)
- [ ] MREGLEMENT-A04 — [anomalie] `butjour_Click` sans test `Available` (erreur sans journal
  `TR`) ; `affiche` indexe `RegCais` sans contrôle de bornes ; `recherche_Click` boucle sans fin de
  résultat · tests : T05 · sources : [Mreglement.class:347](../../../../../.src/Gestion/Tables/Mreglement.class#L347), [Mreglement.class:65](../../../../../.src/Gestion/Tables/Mreglement.class#L65), [Mreglement.class:360](../../../../../.src/Gestion/Tables/Mreglement.class#L360)
