# RazClientd — Rework

> Source : `.src/Archivages/RazClientd.class` · Message de commit (phase 4) : `reference/.src/Archivages/RazClientd.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 27 |
| Lignes de commentaire | 6 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 8 |
| Complexité max (fonction) | 6 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 27 | 8 | 6 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RAZCLIENTD-001 — [documentation] En-tête en français : rôle, table `Fiches_Clid` plus
  alimentée (TriclientsD mort), borne `<` stricte, sauvegarde partagée avec `RazDevis` ·
  appelants : aucun · tests : aucun · sources : [RazClientd.class:Button1_Click](../../../../.src/Archivages/RazClientd.class#L16-L44)
- [ ] RAZCLIENTD-002 — [code mort] Supprimer les commentaires de l'ancienne renumérotation de
  `lind` · appelants : aucun · tests : T01 · sources : [RazClientd.class:34-37](../../../../.src/Archivages/RazClientd.class#L34-L37)
- [ ] RAZCLIENTD-003 — [séparation traitement/GUI] Fonction privée `Purge(sDateLimite) As Integer`
  appelée par `Button1_Click` (SQL identique) · appelants : aucun · tests : T01-T03 · sources : [RazClientd.class:Button1_Click](../../../../.src/Archivages/RazClientd.class#L16-L44)
- [ ] RAZCLIENTD-004 — [commonalisation] Sauvegarde par `Utils.DumpBase` (SAUVESAUTO-003), même
  fichier `EffaceD.sql`, et squelette commun `Epuration` (RAZRLVB-006) · prérequis :
  SAUVESAUTO-003, RAZRLVB-006 · appelants : aucun · tests : T01-T04 · sources : [RazClientd.class:26](../../../../.src/Archivages/RazClientd.class#L26), [RazClientd.class:Button1_Click](../../../../.src/Archivages/RazClientd.class#L16-L44)
- [ ] RAZCLIENTD-005 — [complexité] Un seul `DELETE … WHERE ddate < &1` précédé d'un
  `SELECT COUNT(*)` (SQL modifié, dump identique) · appelants : aucun · tests : T01, T03 · sources : [RazClientd.class:27-32](../../../../.src/Archivages/RazClientd.class#L27-L32)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RAZCLIENTD-A01 — [anomalie] Écran sans objet : `Fiches_Clid` n'est plus alimentée par aucun
  code (seul lecteur : `TriclientsD`, mort, TRICLIENTSD-A01). Proposition : supprimer le couple
  `RazClientd.class` + `RazClientd.form` et l'entrée `Menu296` de `Fmenu` (modifie `Fmenu.form`),
  en même temps que TRICLIENTSD-A01 · tests : T03 · sources : [RazClientd.class:Button1_Click](../../../../.src/Archivages/RazClientd.class#L16-L44), [Fmenu.class:Menu296_Click](../../../../.src/Communs/Fmenu.class#L2296-L2300)
- [ ] RAZCLIENTD-A02 — [anomalie] Sauvegarde non fiable : même fichier `~/Sauve/<Base>EffaceD.sql`
  que `RazDevis` (écrasement mutuel) et libellé de l'écran faux (`Laurux_EffaceCd.sql`) ; code retour
  de `mysqldump` ignoré, mot de passe en clair dans la ligne de commande. Correction : fichier
  `EffaceCd.sql` (cohérent avec le libellé), arrêt si le dump échoue · tests : T04 · sources : [RazClientd.class:26](../../../../.src/Archivages/RazClientd.class#L26)
- [ ] RAZCLIENTD-A03 — [anomalie, à confirmer] SQLite : `ddate < 'AAAAMMJJ'` (affinité NUMERIC)
  ne sélectionne pas les dates stockées en texte → purge sans effet · tests : T05 · sources : [RazClientd.class:27](../../../../.src/Archivages/RazClientd.class#L27)
