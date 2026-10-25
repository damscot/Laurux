# Traites — Rework

> Source : `.src/Gestion/Impressions/Traites.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/Traites.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 132 |
| Lignes de commentaire | 5 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 13 |
| Complexité max (fonction) | 8 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 132 | 13 | 8 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRAITES-001 — [documentation] En-tête : rôle, origine de `Fiches_Traites` (`EcrAuto`),
  différence option LCR active/inactive, lien avec `Lcr.Imp_Traites` · appelants : aucun · tests :
  aucun · sources : [Traites.class:Form_Open](../../../../../.src/Gestion/Impressions/Traites.class#L6-L17), [Traites.class:Button1_Click](../../../../../.src/Gestion/Impressions/Traites.class#L25-L103)
- [ ] TRAITES-002 — [code mort] Supprimer `Level1`, `Level2` (jamais appelées), `Coulfond`,
  `Shell "cd …"`, la réaffectation de `Traite`, le `With Utils` et les `LOCK TABLES` commentés ·
  appelants : aucun · tests : T01-T05 · sources : [Traites.class:Level1](../../../../../.src/Gestion/Impressions/Traites.class#L106-L131), [Traites.class:Level2](../../../../../.src/Gestion/Impressions/Traites.class#L134-L154), [Traites.class:10](../../../../../.src/Gestion/Impressions/Traites.class#L10), [Traites.class:43](../../../../../.src/Gestion/Impressions/Traites.class#L43), [Traites.class:84](../../../../../.src/Gestion/Impressions/Traites.class#L84)
- [ ] TRAITES-003 — [commonalisation] Procédure commune d'impression du listing des traites avec
  `Lcr.Imp_Traites` (chemin du PDF et formateur de date en paramètres, sortie identique pour
  chacun) · appelants : `Lcr` (même commit) · tests : T01, T05, tests de `Lcr` · sources : [Traites.class:Button1_Click](../../../../../.src/Gestion/Impressions/Traites.class#L25-L103), [Lcr.class:Imp_Traites](../../../../../.src/Gestion/Lcr/Lcr.class#L522-L591)
- [ ] TRAITES-004 — [séparation traitement/GUI] Extraire `ImprimeTraites(sFichier) As Boolean` et
  `PurgeTraites()` ; le handler garde `Message.Warning` et `Visualiseur.Prog` · appelants : aucun ·
  tests : T01-T04 · sources : [Traites.class:Button1_Click](../../../../../.src/Gestion/Impressions/Traites.class#L25-L103)
- [ ] TRAITES-005 — [complexité] Une jointure `Fiches_Traites LEFT JOIN <TabCli>` à la place des
  N+1 requêtes, bloc vide conservé pour les traites sans client (SQL modifié, dump identique, texte
  PDF identique) · appelants : aucun · tests : T01, T05 · sources : [Traites.class:48](../../../../../.src/Gestion/Impressions/Traites.class#L48), [Traites.class:57](../../../../../.src/Gestion/Impressions/Traites.class#L57)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRAITES-A01 — [anomalie] Purge par `DROP TABLE` + `Try CREATE TABLE` codé en dur : la table
  recréée perd la colonne `imp` et change le type de `acceptee`/`ecartee` (écart `db_control.csv`,
  signalé par `DB_Sanity`) ; un `CREATE` en échec laisse la base sans `Fiches_Traites`
  (`EcrAuto` en erreur). Correction : `DELETE FROM Fiches_Traites` (aussi valable sous SQLite,
  contrairement au `TRUNCATE` de `Lcr`) · tests : T02 · sources : [Traites.class:83](../../../../../.src/Gestion/Impressions/Traites.class#L83), [Traites.class:85](../../../../../.src/Gestion/Impressions/Traites.class#L85), [Lcr.class:583](../../../../../.src/Gestion/Lcr/Lcr.class#L583)
- [ ] TRAITES-A02 — [anomalie] Texte d'accueil « listing des traites pour le mois en cours » alors
  que toutes les traites de la table sont imprimées · tests : T01 · sources : [Traites.class:12](../../../../../.src/Gestion/Impressions/Traites.class#L12)
