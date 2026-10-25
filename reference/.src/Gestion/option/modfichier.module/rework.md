# modfichier — Rework

> Source : `.src/Gestion/option/modfichier.module` · Message de commit (phase 4) : `reference/.src/Gestion/option/modfichier.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 172 |
| Lignes de commentaire | 22 |
| Fonctions | 5 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 71 |
| Complexité max (fonction) | 32 (`fichiercarbu`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 172 | 71 | 32 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MODFICHIER-001 — [documentation] En-tête : modification de schéma hors `LauruxMaj`, liste
  des tables et colonnes créées, absence dans `db_control.csv`, recouvrement avec `Maj369` ;
  suppression de l'en-tête dupliqué · appelants : aucun · tests : aucun · sources : [modfichier.module:fichierboisson](../../../../../.src/Gestion/option/modfichier.module#L10-L99), [modfichier.module:fichiercarbu](../../../../../.src/Gestion/option/modfichier.module#L101-L169)
- [ ] MODFICHIER-002 — [complexité] Requêtes DDL rangées dans des tableaux parcourus par une
  boucle `Try` (même texte, même ordre ; ajout du `&` manquant l. 31, texte SQL identique) (CC 32
  → ≤ 5 visé) · appelants : `Prefs` (inchangé) · tests : T01, T02, T04 · sources : [modfichier.module:fichierboisson](../../../../../.src/Gestion/option/modfichier.module#L10-L99), [modfichier.module:fichiercarbu](../../../../../.src/Gestion/option/modfichier.module#L101-L169), [modfichier.module:31](../../../../../.src/Gestion/option/modfichier.module#L31)
- [ ] MODFICHIER-003 — [séparation traitement/GUI] `commun` : fenêtre d'attente séparée du DDL ;
  `modiffrais` : question isolée de la copie · appelants : aucun · tests : T01-T03 · sources : [modfichier.module:commun](../../../../../.src/Gestion/option/modfichier.module#L171-L194), [modfichier.module:modiffrais](../../../../../.src/Gestion/option/modfichier.module#L196-L216)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.
Toute correction touche le schéma : elle relève d'une future migration `LauruxMaj` (PLAN §0).

- [ ] MODFICHIER-A01 — [anomalie] Modification de schéma hors `LauruxMaj`, non répertoriée dans
  `db_control.csv` ni les bases de référence ; `MODIFY` réduit `Fiches_Ligbl.qte_ligbl` de
  `varchar(12)` à `char(8)` (troncature possible) et change `Fiches_Ligcom.qte` de
  `decimal(9,3)` en `char(9)`, sans traiter `LigblM`/`HistoLigfacM` · tests : T02 · sources : [modfichier.module:143](../../../../../.src/Gestion/option/modfichier.module#L143), [modfichier.module:149-151](../../../../../.src/Gestion/option/modfichier.module#L149-L151)
- [ ] MODFICHIER-A02 — [anomalie] Syntaxe MySQL non traduite (`ADD (col)`, `MODIFY`,
  `COLLATE`) : sous SQLite une partie des colonnes n'est pas créée, sans message (`Try`) ·
  tests : T05 · sources : [modfichier.module:71](../../../../../.src/Gestion/option/modfichier.module#L71), [modfichier.module:138](../../../../../.src/Gestion/option/modfichier.module#L138), [modfichier.module:143](../../../../../.src/Gestion/option/modfichier.module#L143)
- [ ] MODFICHIER-A03 — [anomalie] `modiffrais` écrit `art_trspr` avant sa création (jamais créée
  par `fichiercarbu`) → erreur d'exécution si un article a des frais et que l'utilisateur répond
  OUI ; sans article concerné, `Begin` sans `Commit` · tests : T03 · sources : [modfichier.module:modiffrais](../../../../../.src/Gestion/option/modfichier.module#L196-L216), [modfichier.module:68](../../../../../.src/Gestion/option/modfichier.module#L68)
- [ ] MODFICHIER-A04 — [anomalie, à confirmer] `numadr_ligbl`/`numadr_ligfac` déclarées
  `integer COLLATE utf8mb4_general_ci` : création probablement refusée (erreur masquée), alors
  qu'`ObjFacB.transblfac` les lit en option `P`/`T` (OBJFACB-A16) ; collation `general_ci`
  différente du reste de la base · tests : T02 · sources : [modfichier.module:164-167](../../../../../.src/Gestion/option/modfichier.module#L164-L167), [modfichier.module:154-163](../../../../../.src/Gestion/option/modfichier.module#L154-L163)
