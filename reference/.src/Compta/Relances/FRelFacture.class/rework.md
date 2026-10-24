# FRelFacture — Rework

> Source : `.src/Compta/Relances/FRelFacture.class` · Message de commit (phase 4) : `reference/.src/Compta/Relances/FRelFacture.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 425 |
| Lignes de commentaire | 23 |
| Fonctions | 19 |
| Fonctions Public | 19 |
| Complexité cyclomatique totale | 89 |
| Complexité max (fonction) | 24 (`Releves`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 425 | 89 | 24 | 0 | 19 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FRELFACTURE-001 — [documentation] En-tête : différences avec `FRelCompte` (filtre VE/AC,
  table, solde en lettres) · appelants : aucun · tests : aucun · sources : [FRelFacture.class:_New](../../../../../.src/Compta/Relances/FRelFacture.class#L39-L76)
- [ ] FRELFACTURE-002 — [code mort] Supprimer `Solde` (appel commenté), `Compdate`, `Afflog`,
  `Coulfond` · appelants : aucun · tests : T03, T05 · sources : [FRelFacture.class:Solde](../../../../../.src/Compta/Relances/FRelFacture.class#L445-L480),
  [FRelFacture.class:Compdate](../../../../../.src/Compta/Relances/FRelFacture.class#L282-L292), [FRelFacture.class:340](../../../../../.src/Compta/Relances/FRelFacture.class#L340), [FRelFacture.class:37](../../../../../.src/Compta/Relances/FRelFacture.class#L37)
- [ ] FRELFACTURE-003 — [réduction de portée] `MajTab`, `Compdate2`, `Releves` → `Private` ·
  appelants : aucun · tests : T01-T05 · sources : [FRelFacture.class:MajTab](../../../../../.src/Compta/Relances/FRelFacture.class#L78-L177), [FRelFacture.class:Compdate2](../../../../../.src/Compta/Relances/FRelFacture.class#L294-L305), [FRelFacture.class:Releves](../../../../../.src/Compta/Relances/FRelFacture.class#L307-L443)
- [ ] FRELFACTURE-004 — [commonalisation] Base commune avec `FRelCompte` (voir FRELCOMPTE-004) ·
  appelants : aucun · tests : T01-T05 et FRELCOMPTE-T01-T05 · sources : [FRelFacture.class:MajTab](../../../../../.src/Compta/Relances/FRelFacture.class#L78-L177), [FRelFacture.class:Releves](../../../../../.src/Compta/Relances/FRelFacture.class#L307-L443)
- [ ] FRELFACTURE-005 — [complexité] `MajTab` : journal et fiche tiers joints dans la requête
  principale au lieu de deux requêtes par écriture (SQL modifié, dump identique) · appelants :
  aucun · tests : T01, T02 · sources : [FRelFacture.class:MajTab](../../../../../.src/Compta/Relances/FRelFacture.class#L78-L177)
- [ ] FRELFACTURE-006 — [commonalisation] En-tête société commun (LIGCLI-004) et
  `Cbase.Table("TabParam"/"TabMvt"/"TabJour"/"TabCli"/"TabFour"/"TabSoc")` (SQL identique) ·
  appelants : aucun · tests : T01-T04 · sources : [FRelFacture.class:72](../../../../../.src/Compta/Relances/FRelFacture.class#L72), [FRelFacture.class:95-123](../../../../../.src/Compta/Relances/FRelFacture.class#L95-L123), [FRelFacture.class:358](../../../../../.src/Compta/Relances/FRelFacture.class#L358)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FRELFACTURE-A01 — [anomalie] Date de ligne du relevé construite par `CStr` + découpage : jour
  décalé (UTC) et année remplacée par l'heure (`06.03.0:00`) ; corriger par `Format$(…,
  "dd.mm.yyyy")` comme `FRelCompte` · tests : T03, T06 · sources : [FRelFacture.class:393-394](../../../../../.src/Compta/Relances/FRelFacture.class#L393-L394), [FRelCompte.class:378](../../../../../.src/Compta/Relances/FRelCompte.class#L378)
- [ ] FRELFACTURE-A02 — [anomalie] Clé `(compte, numdoc, numero)` : écritures client en double
  ignorées (`Try`), fournisseur en double → erreur ; journal et fiche tiers lus sans `Available` ·
  tests : T01, T02 · sources : [FRelFacture.class:131-140](../../../../../.src/Compta/Relances/FRelFacture.class#L131-L140)
- [ ] FRELFACTURE-A03 — [anomalie] Devise par défaut « Euro » (singulier) alors que
  `FEditrel`/`FPrepRel2` utilisent « Euros » ; à harmoniser avec `Numtostring.Convertir` · tests :
  T03 · sources : [FRelFacture.class:74](../../../../../.src/Compta/Relances/FRelFacture.class#L74)
