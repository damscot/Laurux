# SaiReg — Rework

> Source : `.src/Gestion/Facturation/SaiReg.class` · Message de commit (phase 4) : `reference/.src/Gestion/Facturation/SaiReg.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 913 |
| Lignes de commentaire | 19 |
| Fonctions | 52 |
| Fonctions Public | 39 |
| Complexité cyclomatique totale | 207 |
| Complexité max (fonction) | 24 (`affsel`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 913 | 207 | 24 | 0 | 39 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SAIREG-001 — [documentation] En-tête : rôle, modes Saisie/Bordereau/Facture/caisse,
  contrat avec `ObjFacB` (incrustation, `Form_Close`), événement `RegCaisse` · appelants :
  aucun · tests : aucun · sources : [SaiReg.class:_new](../../../../../.src/Gestion/Facturation/SaiReg.class#L31-L122), [SaiReg.class:nreg_LostFocus](../../../../../.src/Gestion/Facturation/SaiReg.class#L145-L240)
- [ ] SAIREG-002 — [code mort] Supprimer `impecr` (jamais appelée), `quite_Click` (aucun
  contrôle `quite`) et les variables locales inutilisées (`str`, `res` de `_new`, `obj` de
  `Form_Close`) · appelants : aucun (vérifié par `grep`) · tests : T01, T10 · sources : [SaiReg.class:impecr](../../../../../.src/Gestion/Facturation/SaiReg.class#L1092-L1105), [SaiReg.class:quite_Click](../../../../../.src/Gestion/Facturation/SaiReg.class#L1135-L1139), [SaiReg.class:34](../../../../../.src/Gestion/Facturation/SaiReg.class#L34), [SaiReg.class:126](../../../../../.src/Gestion/Facturation/SaiReg.class#L126)
- [ ] SAIREG-003 — [réduction de portée] `check_reg`, `selection_choose`, `vldsaisie_Click`,
  `vldbordereau_Click`, `editions_Click`, `editionb_Click` → `Private` ; `Form_Close` reste
  `Public` (`ObjFacB.win_close`) · appelants : aucun · tests : T01-T04, T09 · sources : [SaiReg.class:check_reg](../../../../../.src/Gestion/Facturation/SaiReg.class#L338-L349), [SaiReg.class:selection_choose](../../../../../.src/Gestion/Facturation/SaiReg.class#L496-L532), [SaiReg.class:vldsaisie_Click](../../../../../.src/Gestion/Facturation/SaiReg.class#L949-L998), [SaiReg.class:vldbordereau_Click](../../../../../.src/Gestion/Facturation/SaiReg.class#L1000-L1078), [SaiReg.class:editions_Click](../../../../../.src/Gestion/Facturation/SaiReg.class#L1109-L1120), [SaiReg.class:editionb_Click](../../../../../.src/Gestion/Facturation/SaiReg.class#L1122-L1133)
- [ ] SAIREG-004 — [commonalisation] Impression récapitulative commune
  `ImprimeEcritures(ereg, imp)` pour `vldsaisie_Click` et `vldbordereau_Click` (même séquence
  `Impression`/`FinImp`/`Print`/`Visualiseur.Prog`) · appelants : aucun · tests : T01, T03 ·
  sources : [SaiReg.class:vldsaisie_Click](../../../../../.src/Gestion/Facturation/SaiReg.class#L949-L998), [SaiReg.class:vldbordereau_Click](../../../../../.src/Gestion/Facturation/SaiReg.class#L1000-L1078)
- [ ] SAIREG-005 — [complexité] `nreg_LostFocus` (CC 23) : extraire `ChargeBordereau()` ;
  `affsel` (CC 24) : extraire `AjouteBl()` et `AjouteEcritures()` (SQL et ordre identiques) ·
  appelants : aucun · tests : T03, T06 · sources : [SaiReg.class:nreg_LostFocus](../../../../../.src/Gestion/Facturation/SaiReg.class#L145-L240), [SaiReg.class:affsel](../../../../../.src/Gestion/Facturation/SaiReg.class#L393-L453)
- [ ] SAIREG-006 — [séparation traitement/GUI] `vldsaisie_Click`/`vldbordereau_Click` : boucle
  d'écriture `EcrReg` sans contrôle ni message ; `Facture()` : préparation des tables de travail
  séparée de l'ouverture d'`OptFac` · appelants : aucun · tests : T01, T03, T08 · sources : [SaiReg.class:vldsaisie_Click](../../../../../.src/Gestion/Facturation/SaiReg.class#L949-L998), [SaiReg.class:Facture](../../../../../.src/Gestion/Facturation/SaiReg.class#L897-L946)
- [ ] SAIREG-007 — [commonalisation] Création des tables de travail de fin de mois par le helper
  commun (FACTUREFM-007), structure identique · appelants : aucun · tests : T08, FACTUREFM-T01 ·
  sources : [SaiReg.class:904-924](../../../../../.src/Gestion/Facturation/SaiReg.class#L904-L924)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SAIREG-A01 — [anomalie, latente] `RegCaisse` déclaré à 3 paramètres et levé à 4
  (`var.numdoc` en trop) : tout futur gestionnaire provoquerait « Too many arguments » (vérifié
  sur projet minimal). La valeur `choix` (repli `Mreglement.autre`) est calculée puis ignorée au
  profit de `$resreg!caisse` ; le `Raise` final utilise la dernière écriture de la boucle ·
  tests : aucun observable aujourd'hui · sources : [SaiReg.class:3](../../../../../.src/Gestion/Facturation/SaiReg.class#L3), [SaiReg.class:974-975](../../../../../.src/Gestion/Facturation/SaiReg.class#L974-L975), [SaiReg.class:992](../../../../../.src/Gestion/Facturation/SaiReg.class#L992)
- [ ] SAIREG-A02 — [anomalie] `Facture()` ouvre une transaction (`Utils.db.Begin`) sans
  `Commit` ni `Rollback`, rappelle `res.Update` sur le dernier BL (l. 941), et passe
  `$Vecr.numlot` comme numéro à `OptFac` en fin de mois, où `ObjFac` l'utilise comme **suffixe de
  table** (`Fiches_Bl<numlot>`) s'il n'est pas vide · tests : T08 · sources : [SaiReg.class:928](../../../../../.src/Gestion/Facturation/SaiReg.class#L928), [SaiReg.class:941](../../../../../.src/Gestion/Facturation/SaiReg.class#L941), [SaiReg.class:942](../../../../../.src/Gestion/Facturation/SaiReg.class#L942), [ObjFac.class:181](../../../../../.src/Gestion/Facturation/ObjFac.class#L181)
- [ ] SAIREG-A03 — [anomalie, à confirmer] `vldsaisie_Click` et `vldbordereau_Click` signalent un
  échec d'écriture (`EcrReg.ecriture`) mais remettent l'écran à blanc et `$modif` à faux : les
  règlements non écrits sont perdus sans nouvelle proposition · tests : T01, T03 · sources : [SaiReg.class:970-971](../../../../../.src/Gestion/Facturation/SaiReg.class#L970-L971), [SaiReg.class:1061-1074](../../../../../.src/Gestion/Facturation/SaiReg.class#L1061-L1074)
- [ ] SAIREG-A04 — [anomalie, à confirmer] `nreg_LostFocus` parcourt les autres lignes de
  l'écriture (`rescli1`) sans tester `Available`, et `Listreg_Click` recopie le libellé complet
  « code libellé » dans `nreg` (2 caractères maximum) · tests : T03 · sources : [SaiReg.class:214-220](../../../../../.src/Gestion/Facturation/SaiReg.class#L214-L220), [SaiReg.class:836](../../../../../.src/Gestion/Facturation/SaiReg.class#L836)
- [ ] SAIREG-A05 — [anomalie, à confirmer] Montants de la sélection relus par `Val()` sur le
  texte formaté (`Format(…, "0.00")`, séparateur localisé) dans `selection_choose` et `testtbl`,
  alors que `affsel` utilise `Utils.cpoint` : comparaison et cumul dépendants de la locale ·
  tests : T01 (sous deux locales) · sources : [SaiReg.class:516-517](../../../../../.src/Gestion/Facturation/SaiReg.class#L516-L517), [SaiReg.class:597](../../../../../.src/Gestion/Facturation/SaiReg.class#L597)
