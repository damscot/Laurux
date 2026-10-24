# Epurjdv — Rework

> Source : `.src/Compta/Utils/Epurjdv.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/Epurjdv.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 172 |
| Lignes de commentaire | 23 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 29 |
| Complexité max (fonction) | 18 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 172 | 29 | 18 | 0 | 7 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EPURJDV-001 — [documentation] En-tête : fenêtre **non appelée** (aucun menu), traitement
  destructeur (rotation `Fiches_Mvt*`), renvoi vers EPURJDV-A01 · appelants : aucun · tests : aucun · sources : [Epurjdv.class:Button1_Click](../../../../../.src/Compta/Utils/Epurjdv.class#L96-L206)
- [ ] EPURJDV-002 — [réduction de portée] `Aff_date`, `Sauve` → `Private` (à n'exécuter que si
  EPURJDV-A01 est refusée) · appelants : aucun · tests : T01, T02 · sources : [Epurjdv.class:Aff_date](../../../../../.src/Compta/Utils/Epurjdv.class#L76-L88), [Epurjdv.class:Sauve](../../../../../.src/Compta/Utils/Epurjdv.class#L208-L220)
- [ ] EPURJDV-003 — [commonalisation] `Sauve` → `Utils.DumpBase` (SAUVESAUTO-003) avec une commande
  identique (base `Laurux` en dur conservée) ; à n'exécuter que si EPURJDV-A01 est refusée ·
  appelants : aucun · tests : T02 · sources : [Epurjdv.class:Sauve](../../../../../.src/Compta/Utils/Epurjdv.class#L208-L220), [SauvesAuto.module:19](../../../../../.src/Communs/SauvesAuto.module#L19)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EPURJDV-A01 — [anomalie] Supprimer le couple `Epurjdv.class` + `Epurjdv.form` : aucun appelant
  (vérifié par `grep`), traitement obsolète et dangereux (voir A02-A04) ; la page d'aide
  « Epurationjdv » devient orpheline · tests : aucun (gbc3 + grep) · sources : [Epurjdv.class:_New](../../../../../.src/Compta/Utils/Epurjdv.class#L38-L45), [Epurjdv.class:Button1_Click](../../../../../.src/Compta/Utils/Epurjdv.class#L96-L206)
- [ ] EPURJDV-A02 — [anomalie] `CREATE TABLE Fiches_Mvt` hors `LauruxMaj`, non conforme à
  `db_control.csv` (pas de colonnes `export`/`control`, `dte date` au lieu de `datetime`,
  `intitule Char(30)` au lieu de `varchar(40)`, index absents) ; `ALTER TABLE … RENAME` sans `TO`
  (échec SQLite) · tests : T02 · sources : [Epurjdv.class:138-170](../../../../../.src/Compta/Utils/Epurjdv.class#L138-L170)
- [ ] EPURJDV-A03 — [anomalie] Recopie : seules les lignes 411 sont reprises (écritures
  déséquilibrées), `numerodef = " "` dans une colonne entière, le dernier numéro n'est jamais
  supprimé de `Fiches_Mvt1`, rien n'est recopié si la case n'est pas cochée · tests : T02 · sources : [Epurjdv.class:171-188](../../../../../.src/Compta/Utils/Epurjdv.class#L171-L188)
- [ ] EPURJDV-A04 — [anomalie] `Sauve` : base `Laurux` en dur (et non `Utils.db.Name`), port et
  tunnel SSH ignorés, mot de passe visible dans `ps`, résultat non vérifié · tests : T02 · sources : [Epurjdv.class:215](../../../../../.src/Compta/Utils/Epurjdv.class#L215)
- [ ] EPURJDV-A05 — [anomalie] `Form_Open` : `SELECT` sans test `Available`, test du mois courant
  sur `dtepp` alors que la valeur lue est `dtepec`, année préfixée « 20 » en dur · tests : T01 · sources : [Epurjdv.class:54](../../../../../.src/Compta/Utils/Epurjdv.class#L54), [Epurjdv.class:64](../../../../../.src/Compta/Utils/Epurjdv.class#L64), [Epurjdv.class:67-70](../../../../../.src/Compta/Utils/Epurjdv.class#L67-L70)
