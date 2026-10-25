# TBord — Rework

> Source : `.src/Statistiques/TBord.class` · Message de commit (phase 4) : `reference/.src/Statistiques/TBord.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 339 |
| Lignes de commentaire | 1 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 67 |
| Complexité max (fonction) | 49 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 339 | 67 | 49 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TBORD-001 — [documentation] En-tête de classe en français : rôle, liste des indicateurs et de
  leurs sources, période glissante, table de travail `Total` (structure, durée de vie, nom partagé) ;
  commentaires sur `Traitement` et `Draw_Chart` · appelants : aucun · tests : aucun · sources : [TBord.class:_new](../../../../.src/Statistiques/TBord.class#L12-L26), [TBord.class:Traitement](../../../../.src/Statistiques/TBord.class#L28-L251)
- [ ] TBORD-002 — [code mort] Supprimer la requête `TabParam` inutilisée de `_new`, la condition
  toujours vraie de la ligne 71 et sa branche `Else`, les variables `colors`, `sumdata`, `Tab`… non
  lues et le cumul de `margepart`/`margepmo` jamais affiché ; **SQL modifié (un SELECT en moins), dump
  identique** · appelants : aucun · tests : T01, T05 · sources : [TBord.class:17](../../../../.src/Statistiques/TBord.class#L17), [TBord.class:71](../../../../.src/Statistiques/TBord.class#L71), [TBord.class:Draw_Chart](../../../../.src/Statistiques/TBord.class#L278-L359)
- [ ] TBORD-003 — [commonalisation] Noms de tables via `Cbase.Table("TabHisFac")`, `("TabHisFacm")`,
  `("TabBl")`, `("TabBlM")` (texte SQL identique) · appelants : aucun · tests : T01, T02 · sources : [TBord.class:51](../../../../.src/Statistiques/TBord.class#L51), [TBord.class:53](../../../../.src/Statistiques/TBord.class#L53)
- [ ] TBORD-004 — [complexité] Cumul mensuel dupliqué (factures, BL) → helper privé
  `CumuleMois(Dte, Brut, Remise, Total, MargeArt, MargeMo, bTry)` (`SELECT` du mois puis `UPdate` ou
  `INSERT`, mêmes requêtes dans le même ordre ; `bTry` garde les divisions non protégées du bloc BL)
  (CC 49 → ≤ 20 visé) · appelants : aucun · tests : T01-T03, T06 · sources : [TBord.class:Traitement](../../../../.src/Statistiques/TBord.class#L28-L251)
- [ ] TBORD-005 — [séparation traitement/GUI] Extraire de `Traitement` `RemplitTotal(dte1, dte2,
  bMateriel)`, `LitAgregats() As Float[]` et `DocsEnCours() As Collection` (sans accès aux contrôles) ;
  `Traitement` ne garde que `Me.Mouse`, `Draw_Chart` et l'écriture des libellés (mêmes formats) ·
  appelants : aucun · tests : T01-T07 · sources : [TBord.class:Traitement](../../../../.src/Statistiques/TBord.class#L28-L251), [TBord.class:Aff_Mois](../../../../.src/Statistiques/TBord.class#L253-L276)
- [ ] TBORD-006 — [complexité] `Aff_Mois` : 5 `If` → `Select Case` (comportement identique) ·
  appelants : aucun · tests : T04 · sources : [TBord.class:Aff_Mois](../../../../.src/Statistiques/TBord.class#L253-L276)
- [ ] TBORD-007 — [commonalisation] Histogramme sur `DrawingArea` : helper commun
  `Histogramme(drw, valeurs, libelles, echelle)` partagé avec `VisHitCartes.Draw_Chart` (emplacement
  décidé en phase 3), chaque écran gardant son échelle ; rendu identique vérifié visuellement ·
  appelants : `VisHitCartes` (même commit que VISHITCARTES-005) · tests : T01, VISHITCARTES-T01 ·
  sources : [TBord.class:Draw_Chart](../../../../.src/Statistiques/TBord.class#L278-L359), [VisHitCartes.class:Draw_Chart](../../../../.src/Statistiques/VisHitCartes.class#L109-L176)
- [ ] TBORD-008 — [réduction de portée] `Traitement`, `Aff_Mois`, `Draw_Chart` → `Private` (aucun
  appelant externe, vérifié par `grep`) · appelants : aucun · tests : T01 · sources : [TBord.class:Traitement](../../../../.src/Statistiques/TBord.class#L28-L251), [TBord.class:Aff_Mois](../../../../.src/Statistiques/TBord.class#L253-L276), [TBord.class:Draw_Chart](../../../../.src/Statistiques/TBord.class#L278-L359)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TBORD-A01 — [anomalie] Documents en cours : à chaque changement de `type`, le premier document
  du nouveau type est compté (`Inc n`) mais son `totalht` n'est pas ajouté au montant ; tous les
  montants sauf ceux du premier type (ordre alphabétique) sont sous-évalués · tests : T04, T07 · sources : [TBord.class:236](../../../../.src/Statistiques/TBord.class#L236), [TBord.class:237](../../../../.src/Statistiques/TBord.class#L237)
- [ ] TBORD-A02 — [anomalie] SQLite : `MONTH(&1)` avec un paramètre `Date` substitué avant la
  traduction ; si la valeur contient l'heure (`:`), la regex de `DB_Connection.Exec` ne la traduit pas
  et la requête échoue (« no such function: MONTH ») — à confirmer · tests : T08 · sources : [TBord.class:103](../../../../.src/Statistiques/TBord.class#L103), [TBord.class:117](../../../../.src/Statistiques/TBord.class#L117), [DB_Connection.class:362](../../../../.src/Utils/DB_Connection.class#L362)
- [ ] TBORD-A03 — [anomalie] Table de travail `Total` détruite et recréée sous un nom partagé avec
  `HitCarte`, `StatClimo`, `StatComm`, `StatComArt`, `StatFour`, `StatTypCli` et `Statcai` (structures
  différentes) : deux écrans ou deux postes simultanés se corrompent (même défaut que STATCAI-A04, à
  corriger ensemble, création unique par `StatCommun.TotalCree` ; change le dump) · tests : T01 · sources : [TBord.class:59](../../../../.src/Statistiques/TBord.class#L59), [TBord.class:60](../../../../.src/Statistiques/TBord.class#L60), [HitCarte.class:174](../../../../.src/Statistiques/HitCarte.class#L174)
- [ ] TBORD-A04 — [anomalie] Histogramme : les barres sont remplies dans l'ordre de lecture de `Total`
  (sans `ORDER BY`), alors que les libellés de mois partent du mois de `dte1` ; un mois sans vente
  décale toutes les barres suivantes, et sous SQLite l'ordre d'insertion (factures puis BL) peut
  différer de l'ordre chronologique · tests : T03 · sources : [TBord.class:203](../../../../.src/Statistiques/TBord.class#L203), [TBord.class:Draw_Chart](../../../../.src/Statistiques/TBord.class#L278-L359)
- [ ] TBORD-A05 — [anomalie] Divisions non protégées : taux de marge du bloc BL (`Total = 0`), taux
  globaux et panier moyen (`Totca = 0` ou `nb = 0`) lèvent une erreur Gambas à l'ouverture · tests :
  T06 · sources : [TBord.class:168](../../../../.src/Statistiques/TBord.class#L168), [TBord.class:172](../../../../.src/Statistiques/TBord.class#L172), [TBord.class:224](../../../../.src/Statistiques/TBord.class#L224), [TBord.class:229](../../../../.src/Statistiques/TBord.class#L229)
- [ ] TBORD-A06 — [anomalie] Indicateurs incohérents (à confirmer avec l'utilisateur) : « Total CA »
  et les taux de marge portent sur le CA **brut** (avant remises) alors que l'histogramme montre le
  net ; échelle divisée par 100 000 si `/Soc<XX>/Prxdec` ; la borne `datefac <= aaaammjj` exclut les
  documents du jour qui ont une heure · tests : T01, T07 · sources : [TBord.class:217](../../../../.src/Statistiques/TBord.class#L217), [TBord.class:224](../../../../.src/Statistiques/TBord.class#L224), [TBord.class:313](../../../../.src/Statistiques/TBord.class#L313), [TBord.class:73](../../../../.src/Statistiques/TBord.class#L73)
