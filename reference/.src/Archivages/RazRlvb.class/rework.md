# RazRlvb — Rework

> Source : `.src/Archivages/RazRlvb.class` · Message de commit (phase 4) : `reference/.src/Archivages/RazRlvb.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 29 |
| Lignes de commentaire | 2 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 29 | 8 | 6 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RAZRLVB-001 — [documentation] En-tête en français : rôle (purge de `Fiches_Rappro` avant la
  date choisie, borne `<` stricte), tables liées non purgées (`Fiches_Mvt*.nrlv`), sauvegarde
  préalable, défaut A01 · appelants : aucun · tests : aucun · sources : [RazRlvb.class:Button1_Click](../../../../.src/Archivages/RazRlvb.class#L16-L41)
- [ ] RAZRLVB-002 — [code mort] Supprimer la variable locale `PB As ProgBar`, jamais utilisée ·
  appelants : aucun · tests : T01 · sources : [RazRlvb.class:18](../../../../.src/Archivages/RazRlvb.class#L18)
- [ ] RAZRLVB-003 — [réarchitecture] `Cbase.Table("TabRappro")` à la place de `"Fiches_Rappro"` en
  dur (nom physique identique, SQL identique) · appelants : aucun · tests : T01, T03 · sources : [RazRlvb.class:22](../../../../.src/Archivages/RazRlvb.class#L22)
- [ ] RAZRLVB-004 — [commonalisation] Sauvegarde par `Utils.DumpBase` (SAUVESAUTO-003) avec les
  options `--lock-tables=0 --add-drop-table` et le même fichier `~/Sauve/<Base>EffaceR.sql` ·
  prérequis : SAUVESAUTO-003 · appelants : aucun · tests : T04 · sources : [RazRlvb.class:28](../../../../.src/Archivages/RazRlvb.class#L28)
- [ ] RAZRLVB-005 — [séparation traitement/GUI] Fonction privée `Purge(sDateLimite) As Integer`
  (lecture + suppressions, sans contrôle) appelée par `Button1_Click` ; position actuelle de l'appel
  conservée (hors du `If`, A01 inchangée) · appelants : aucun · tests : T01-T03 · sources : [RazRlvb.class:Button1_Click](../../../../.src/Archivages/RazRlvb.class#L16-L41)
- [ ] RAZRLVB-006 — [commonalisation] Module d'aide `Epuration` (`Confirme`, `Sauvegarde`, `Fin`)
  partagé par les six `Raz*` du lot, messages identiques · appelants : aucun · tests : T01-T04 et
  les tests des cinq autres `Raz*` · sources : [RazRlvb.class:Button1_Click](../../../../.src/Archivages/RazRlvb.class#L16-L41), [RazHistoTk.class:Button1_Click](../../../../.src/Archivages/RazHistoTk.class#L16-L45)
- [ ] RAZRLVB-007 — [complexité] Un seul `DELETE … WHERE date_releve < &1` précédé d'un
  `SELECT COUNT(*)` au lieu de la boucle ligne à ligne (SQL modifié, dump identique) · appelants :
  aucun · tests : T01, T03 · sources : [RazRlvb.class:30-35](../../../../.src/Archivages/RazRlvb.class#L30-L35)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RAZRLVB-A01 — [anomalie] **CRITIQUE** : la purge est exécutée **même si l'utilisateur répond
  « Non »** (le `Endif` l. 29 ne couvre que la sauvegarde) ; dans ce cas, aucune sauvegarde n'est
  faite. Correction : inclure la lecture et les `DELETE` dans le `If` (même famille que
  EPURMVTEXP-A01, EDREGUL-A01) · tests : T02 · sources : [RazRlvb.class:25-36](../../../../.src/Archivages/RazRlvb.class#L25-L36)
- [ ] RAZRLVB-A02 — [anomalie] Sauvegarde non fiable : code retour de `mysqldump` ignoré (purge
  poursuivie si le dump échoue : SQLite, port non standard ou tunnel SSH, à confirmer), mot de
  passe en clair dans la ligne de commande (`ps`) et non protégé pour le shell, fichier écrasé à
  chaque purge. Correction : arrêt si le dump échoue, horodatage du fichier, `--defaults-extra-file` ·
  tests : T04 · sources : [RazRlvb.class:28](../../../../.src/Archivages/RazRlvb.class#L28)
- [ ] RAZRLVB-A03 — [anomalie, à confirmer] SQLite : `date_releve < 'AAAAMMJJ'` compare une date
  stockée en texte à un entier (affinité NUMERIC) → aucune ligne sélectionnée, purge sans effet.
  Correction : paramètre `Date` (ou format `AAAA-MM-JJ`) · tests : T06 · sources : [RazRlvb.class:30](../../../../.src/Archivages/RazRlvb.class#L30)
- [ ] RAZRLVB-A04 — [anomalie, à confirmer] Purge sans garde-fou ni transaction : date du jour
  proposée par défaut, tous les relevés d'un compte peuvent être supprimés (le pointage perd alors
  son relevé précédent et son solde de départ) et `Fiches_Mvt*.nrlv` garde des numéros de relevés
  supprimés. Correction proposée : conserver le dernier relevé de chaque compte, transaction ·
  tests : T05 · sources : [RazRlvb.class:30-35](../../../../.src/Archivages/RazRlvb.class#L30-L35), [Pointage.class:383](../../../../.src/Compta/Pointage.class#L383)
