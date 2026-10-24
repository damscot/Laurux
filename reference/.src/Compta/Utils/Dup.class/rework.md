# Dup — Rework

> Source : `.src/Compta/Utils/Dup.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/Dup.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 230 |
| Lignes de commentaire | 25 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 89 |
| Complexité max (fonction) | 82 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 230 | 89 | 82 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] DUP-001 — [documentation] En-tête en français : tables copiées par option, remises à zéro,
  limitation MySQL, conséquences d'une copie partielle · appelants : aucun · tests : T02-T04 · sources : [Dup.class:Button1_Click](../../../../../.src/Compta/Utils/Dup.class#L64-L296)
- [ ] DUP-002 — [complexité] Helper privé `CopieTableSoc(sTable, bExisting)` (DROP + message +
  CREATE … SELECT) et liste de tables par case à cocher ; même SQL, même ordre (sans changement
  SQL) ; CC 82 → ≤ 15 visé · appelants : aucun · tests : T02-T05 · sources : [Dup.class:Button1_Click](../../../../../.src/Compta/Utils/Dup.class#L64-L296)
- [ ] DUP-003 — [commonalisation] Test d'existence de la base cible par `Utils.BasesLaurux`
  (LAURUXCONF-005) au lieu de la boucle sur `Utils.db.Databases` · appelants : aucun · tests :
  T02, T03 · sources : [Dup.class:82](../../../../../.src/Compta/Utils/Dup.class#L82), [LauruxConf.class:_new](../../../../../.src/Communs/LauruxConf.class#L39-L173)
- [ ] DUP-004 — [séparation traitement/GUI] Séquence SQL dans `Private Sub Duplique(…)` paramétrée
  par booléens (sans accès aux contrôles) ; le handler garde confirmations, curseur et message final ·
  appelants : aucun · tests : T02-T05 · sources : [Dup.class:Button1_Click](../../../../../.src/Compta/Utils/Dup.class#L64-L296)
- [ ] DUP-005 — [code mort] Supprimer `Shell "cd " & User.Home` (sans effet) et l'argument superflu
  de la remise à zéro des soldes · appelants : aucun · tests : T01, T03 · sources : [Dup.class:37](../../../../../.src/Compta/Utils/Dup.class#L37), [Dup.class:149](../../../../../.src/Compta/Utils/Dup.class#L149)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] DUP-A01 — [anomalie] `CREATE TABLE … SELECT` perd clés primaires, index, `AUTO_INCREMENT` et
  valeurs par défaut des 20 tables copiées : la base cible diverge de `db_control.csv` ; utiliser
  `CREATE TABLE … LIKE` + `INSERT … SELECT` · tests : T02, T03 · sources : [Dup.class:97](../../../../../.src/Compta/Utils/Dup.class#L97), [Dup.class:Button1_Click](../../../../../.src/Compta/Utils/Dup.class#L64-L296)
- [ ] DUP-A02 — [anomalie, sécurité] Liste des bases par `Shell mysql -p<mot de passe>` (visible
  dans `ps`, port et tunnel SSH ignorés, fichier `~/bases.txt` laissé) ; à remplacer par
  `Utils.BasesLaurux` · tests : T01 · sources : [Dup.class:38](../../../../../.src/Compta/Utils/Dup.class#L38), [Dup.class:_New](../../../../../.src/Compta/Utils/Dup.class#L28-L50)
- [ ] DUP-A03 — [anomalie] `set sql_mode = no_auto_value_on_zero` remplace le `sql_mode` de la
  session courante sans le restaurer (effet sur toute la suite de la session, à confirmer) ·
  tests : T06 · sources : [Dup.class:78](../../../../../.src/Compta/Utils/Dup.class#L78)
- [ ] DUP-A04 — [anomalie] Écran accessible en mode SQLite alors qu'il repose sur `mysql` et sur
  des requêtes inter-bases : erreur attendue ; masquer le menu ou refuser avec un message · tests :
  manuel · sources : [Dup.class:_New](../../../../../.src/Compta/Utils/Dup.class#L28-L50), [Fmenu.class:1399](../../../../../.src/Communs/Fmenu.class#L1399)
