# FRelCompte — Rework

> Source : `.src/Compta/Relances/FRelCompte.class` · Message de commit (phase 4) : `reference/.src/Compta/Relances/FRelCompte.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 365 |
| Lignes de commentaire | 22 |
| Fonctions | 18 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 76 |
| Complexité max (fonction) | 23 (`Releves`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 365 | 76 | 23 | 0 | 18 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FRELCOMPTE-001 — [documentation] En-tête : rôle, table de travail, boutons du groupe `Btn`,
  lien avec `FRelFacture` · appelants : aucun · tests : aucun · sources : [FRelCompte.class:_New](../../../../../.src/Compta/Relances/FRelCompte.class#L37-L70)
- [ ] FRELCOMPTE-002 — [code mort] Supprimer `Compdate` (aucun appelant), `Coulfond` (jamais lu) et
  `Tab3` inutilisé dans `MajTab` · appelants : aucun · tests : T01, T05 · sources :
  [FRelCompte.class:Compdate](../../../../../.src/Compta/Relances/FRelCompte.class#L268-L278), [FRelCompte.class:35](../../../../../.src/Compta/Relances/FRelCompte.class#L35), [FRelCompte.class:39](../../../../../.src/Compta/Relances/FRelCompte.class#L39), [FRelCompte.class:89](../../../../../.src/Compta/Relances/FRelCompte.class#L89)
- [ ] FRELCOMPTE-003 — [réduction de portée] `MajTab`, `Compdate2`, `Releves` → `Private` ·
  appelants : aucun · tests : T01-T05 · sources : [FRelCompte.class:MajTab](../../../../../.src/Compta/Relances/FRelCompte.class#L72-L164), [FRelCompte.class:Compdate2](../../../../../.src/Compta/Relances/FRelCompte.class#L280-L291), [FRelCompte.class:Releves](../../../../../.src/Compta/Relances/FRelCompte.class#L293-L414)
- [ ] FRELCOMPTE-004 — [commonalisation] Base commune avec `FRelFacture` (saisie de période,
  `Btn_Click`, construction de la liste, boucle d'édition), les différences (filtre, table,
  colonnes, `Level1` « 1 »/« 2 », solde en lettres) passées en paramètres · appelants : aucun ·
  tests : T01-T05 et FRELFACTURE-T01-T05 · sources : [FRelCompte.class:MajTab](../../../../../.src/Compta/Relances/FRelCompte.class#L72-L164), [FRelCompte.class:Releves](../../../../../.src/Compta/Relances/FRelCompte.class#L293-L414), [FRelFacture.class:MajTab](../../../../../.src/Compta/Relances/FRelFacture.class#L78-L177), [FRelFacture.class:Releves](../../../../../.src/Compta/Relances/FRelFacture.class#L307-L443)
- [ ] FRELCOMPTE-005 — [commonalisation] En-tête société via le helper commun (LIGCLI-004) ·
  appelants : aucun · tests : T03, T04 · sources : [FRelCompte.class:341-357](../../../../../.src/Compta/Relances/FRelCompte.class#L341-L357)
- [ ] FRELCOMPTE-006 — [complexité] `MajTab` : fiche tiers jointe dans la requête des écritures au
  lieu d'une requête par écriture (SQL modifié, dump identique) · appelants : aucun · tests : T01,
  T02, T06 · sources : [FRelCompte.class:MajTab](../../../../../.src/Compta/Relances/FRelCompte.class#L72-L164)
- [ ] FRELCOMPTE-007 — [séparation traitement/GUI] `ConstruitTable(type, dn0, dn1)` et édition
  sans accès aux contrôles · appelants : aucun · tests : T01-T04 · sources : [FRelCompte.class:MajTab](../../../../../.src/Compta/Relances/FRelCompte.class#L72-L164), [FRelCompte.class:Releves](../../../../../.src/Compta/Relances/FRelCompte.class#L293-L414)
- [ ] FRELCOMPTE-008 — [commonalisation] `Cbase.Table("TabMvt"/"TabCli"/"TabFour"/"TabSoc")` au
  lieu des noms en dur (SQL identique) · appelants : aucun · tests : T01-T03 · sources :
  [FRelCompte.class:88-116](../../../../../.src/Compta/Relances/FRelCompte.class#L88-L116), [FRelCompte.class:334](../../../../../.src/Compta/Relances/FRelCompte.class#L334)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FRELCOMPTE-A01 — [anomalie] Fiche tiers et société lues sans test `Available` (erreur si un
  compte 411/401 n'a pas de fiche) · tests : T06 · sources : [FRelCompte.class:124-128](../../../../../.src/Compta/Relances/FRelCompte.class#L124-L128), [FRelCompte.class:341-342](../../../../../.src/Compta/Relances/FRelCompte.class#L341-L342)
- [ ] FRELCOMPTE-A02 — [anomalie] Contrôle de période fait contre la date de début **initiale**
  (`dte1`), et refuse une période d'un jour (`<=`) · tests : T05 · sources : [FRelCompte.class:64](../../../../../.src/Compta/Relances/FRelCompte.class#L64), [FRelCompte.class:257](../../../../../.src/Compta/Relances/FRelCompte.class#L257)
- [ ] FRELCOMPTE-A03 — [anomalie] Fournisseurs : `INSERT` sans `Try` ni option de relevé, alors
  que les clients sont filtrés par `cli_rlvc` · tests : T02 · sources : [FRelCompte.class:125](../../../../../.src/Compta/Relances/FRelCompte.class#L125), [FRelCompte.class:128](../../../../../.src/Compta/Relances/FRelCompte.class#L128)
