# FRelFacture — Rework

> Source : `.src/Compta/Relances/FRelFacture.class` · Message de commit (phase 4) : `.hidden/reference/.src/Compta/Relances/FRelFacture.class/rework.md <REWORK_ID>`

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
  table, solde en lettres) · appelants : aucun · tests : aucun · sources : [FRelFacture.class:_New](../../../../../../.src/Compta/Relances/FRelFacture.class#L39-L76)
- [ ] FRELFACTURE-002 — [code mort] Supprimer `Solde` (appel commenté), `Compdate`, `Afflog`,
  `Coulfond` · appelants : aucun · tests : T03, T05 · sources : [FRelFacture.class:Solde](../../../../../../.src/Compta/Relances/FRelFacture.class#L445-L480),
  [FRelFacture.class:Compdate](../../../../../../.src/Compta/Relances/FRelFacture.class#L282-L292), [FRelFacture.class:340](../../../../../../.src/Compta/Relances/FRelFacture.class#L340), [FRelFacture.class:37](../../../../../../.src/Compta/Relances/FRelFacture.class#L37)
- [ ] FRELFACTURE-003 — [réduction de portée] `MajTab`, `Compdate2`, `Releves` → `Private` ·
  appelants : aucun · tests : T01-T05 · sources : [FRelFacture.class:MajTab](../../../../../../.src/Compta/Relances/FRelFacture.class#L78-L177), [FRelFacture.class:Compdate2](../../../../../../.src/Compta/Relances/FRelFacture.class#L294-L305), [FRelFacture.class:Releves](../../../../../../.src/Compta/Relances/FRelFacture.class#L307-L443)
- [ ] FRELFACTURE-004 — [commonalisation] Base commune avec `FRelCompte` (voir FRELCOMPTE-004) ·
  appelants : aucun · tests : T01-T05 et FRELCOMPTE-T01-T05 · sources : [FRelFacture.class:MajTab](../../../../../../.src/Compta/Relances/FRelFacture.class#L78-L177), [FRelFacture.class:Releves](../../../../../../.src/Compta/Relances/FRelFacture.class#L307-L443)
- [ ] FRELFACTURE-005 — [complexité] `MajTab` : journal et fiche tiers joints dans la requête
  principale au lieu de deux requêtes par écriture (SQL modifié, dump identique) · appelants :
  aucun · tests : T01, T02 · sources : [FRelFacture.class:MajTab](../../../../../../.src/Compta/Relances/FRelFacture.class#L78-L177)
- [ ] FRELFACTURE-006 — [commonalisation] En-tête société commun (LIGCLI-004) et
  `Cbase.Table("TabParam"/"TabMvt"/"TabJour"/"TabCli"/"TabFour"/"TabSoc")` (SQL identique) ·
  appelants : aucun · tests : T01-T04 · sources : [FRelFacture.class:72](../../../../../../.src/Compta/Relances/FRelFacture.class#L72), [FRelFacture.class:95-123](../../../../../../.src/Compta/Relances/FRelFacture.class#L95-L123), [FRelFacture.class:358](../../../../../../.src/Compta/Relances/FRelFacture.class#L358)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FRELFACTURE-A01 — [anomalie] (confirmée phase 2, vague 4 : dates de ligne du PDF `02.06.0:00` (jour décalé, heure au lieu de l'année), figées par T03 et le gb.test T06) Date de ligne du relevé construite par `CStr` + découpage : jour
  décalé (UTC) et année remplacée par l'heure (`06.03.0:00`) ; corriger par `Format$(…,
  "dd.mm.yyyy")` comme `FRelCompte` · tests : T03, T06 · sources : [FRelFacture.class:393-394](../../../../../../.src/Compta/Relances/FRelFacture.class#L393-L394), [FRelCompte.class:378](../../../../../../.src/Compta/Relances/FRelCompte.class#L378)
- [ ] FRELFACTURE-A02 — [anomalie] Clé `(compte, numdoc, numero)` : écritures client en double
  ignorées (`Try`), fournisseur en double → erreur ; journal et fiche tiers lus sans `Available` ·
  tests : T01, T02 · sources : [FRelFacture.class:131-140](../../../../../../.src/Compta/Relances/FRelFacture.class#L131-L140)
- [ ] FRELFACTURE-A03 — [anomalie] Devise par défaut « Euro » (singulier) alors que
  `FEditrel`/`FPrepRel2` utilisent « Euros » ; à harmoniser avec `Numtostring.Convertir` · tests :
  T03 · sources : [FRelFacture.class:74](../../../../../../.src/Compta/Relances/FRelFacture.class#L74)
- [ ] FRELFACTURE-A04 — [anomalie] Contrôle de période identique à FRELCOMPTE-A02 (comparaison à la date de début **initiale** `dte1`, `<=`) : période inversée acceptée sans avertissement (phase 2, vague 4, 2026-11-13) · tests : T05 · sources : [FRelFacture.class:68](../../../../../../.src/Compta/Relances/FRelFacture.class#L68), [FRelFacture.class:271](../../../../../../.src/Compta/Relances/FRelFacture.class#L271)
- [ ] FRELFACTURE-A05 — [anomalie, à confirmer] Relevé de factures : les écritures lettrées sont exclues (`lettree = 0`) alors que `FRelCompte` les inclut : relevé 411002 à 980 (facture lettrée F104 absente) contre 1010 dans `FRelCompte` (intention à confirmer) (phase 2, vague 4, 2026-11-13) · tests : T03 · sources : [FRelFacture.class:127](../../../../../../.src/Compta/Relances/FRelFacture.class#L127), [FRelCompte.class:120](../../../../../../.src/Compta/Relances/FRelCompte.class#L120)
- [ ] FRELFACTURE-A06 — [anomalie] `Releves` : la variable `Pays` est déclarée mais jamais affectée : le pays du tiers (Belgique) n'est pas imprimé, contrairement à `FRelCompte` (phase 2, vague 4, 2026-11-13) · tests : T03 · sources : [FRelFacture.class:318](../../../../../../.src/Compta/Relances/FRelFacture.class#L318), [FRelFacture.class:387-388](../../../../../../.src/Compta/Relances/FRelFacture.class#L387-L388), [FRelCompte.class:370-371](../../../../../../.src/Compta/Relances/FRelCompte.class#L370-L371)
