# Facturefm — Rework

> Source : `.src/Gestion/Facturation/Facturefm.class` · Message de commit (phase 4) : `reference/.src/Gestion/Facturation/Facturefm.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 629 |
| Lignes de commentaire | 41 |
| Fonctions | 30 |
| Fonctions Public | 29 |
| Complexité cyclomatique totale | 139 |
| Complexité max (fonction) | 29 (`recup_bl`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 629 | 139 | 29 | 0 | 29 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FACTUREFM-001 — [documentation] En-tête : rôle, structure des tables de travail
  `Facturefm`/`Bl` et contrat avec `ObjFac`/`ObjFacB` (colonnes lues), sens de `$sreq` ·
  appelants : aucun · tests : aucun · sources : [Facturefm.class:recup_bl](../../../../../.src/Gestion/Facturation/Facturefm.class#L228-L370), [Facturefm.class:requete](../../../../../.src/Gestion/Facturation/Facturefm.class#L567-L611)
- [ ] FACTUREFM-002 — [code mort] Supprimer les ≈ 60 variables d'instance mortes (liste dans
  architecture.md), l'initialiseur `Prxdec`, la lecture de la devise dans `_New`, `Coulfond`,
  `Cclient`, et le corps de `Form_Close` (`$process` jamais vrai, `Filename` jamais affecté ; le
  handler reste, vide) · appelants : aucun (vérifié par `grep`) · tests : T01, T10 · sources : [Facturefm.class:27-118](../../../../../.src/Gestion/Facturation/Facturefm.class#L27-L118), [Facturefm.class:Form_Close](../../../../../.src/Gestion/Facturation/Facturefm.class#L214-L224), [Facturefm.class:131-136](../../../../../.src/Gestion/Facturation/Facturefm.class#L131-L136)
- [ ] FACTUREFM-003 — [réduction de portée] `recup_bl`, `supclient`, `affclient`, `Quittedate`,
  `requete` → `Private` ; `Bsel`/`Bval` restent `Public` (`TriCpt`) · appelants : aucun · tests :
  T01-T08 · sources : [Facturefm.class:recup_bl](../../../../../.src/Gestion/Facturation/Facturefm.class#L228-L370), [Facturefm.class:supclient](../../../../../.src/Gestion/Facturation/Facturefm.class#L428-L442), [Facturefm.class:affclient](../../../../../.src/Gestion/Facturation/Facturefm.class#L444-L467), [Facturefm.class:Quittedate](../../../../../.src/Gestion/Facturation/Facturefm.class#L532-L543), [Facturefm.class:requete](../../../../../.src/Gestion/Facturation/Facturefm.class#L567-L611)
- [ ] FACTUREFM-004 — [complexité] Constantes privées pour les noms des tables de travail
  (`Tab3`/`Tab4` locaux répétés, `"Facturefm"` en dur dans `affclient`) ; suppression des
  arguments inutiles passés à `Exec` dans `Colbl_Click` (SQL identique) · appelants : aucun ·
  tests : T01, T08 · sources : [Facturefm.class:Colbl_Click](../../../../../.src/Gestion/Facturation/Facturefm.class#L384-L417), [Facturefm.class:affclient](../../../../../.src/Gestion/Facturation/Facturefm.class#L444-L467), [Facturefm.class:supclient](../../../../../.src/Gestion/Facturation/Facturefm.class#L428-L442)
- [ ] FACTUREFM-005 — [séparation traitement/GUI] `recup_bl` : extraire `CreeTablesTravail()`,
  `SelectionBl() As Result` et le cumul par client dans des fonctions sans contrôle (SQL
  identique, même ordre) ; `requete` : construction de `$sreq` à partir de paramètres · appelants :
  aucun · tests : T01-T07, T09 · sources : [Facturefm.class:recup_bl](../../../../../.src/Gestion/Facturation/Facturefm.class#L228-L370), [Facturefm.class:requete](../../../../../.src/Gestion/Facturation/Facturefm.class#L567-L611)
- [ ] FACTUREFM-006 — [commonalisation] Base commune avec `FacturefmA` et `Facturergbl`
  (colonnes de `Colbl`/`Coldetail`, `Radiobutton*_Click`, `codeclient_KeyPress`,
  `Togglebutton1_Click`, retraits) en conservant les handlers dans chaque classe · appelants :
  aucun · tests : T01-T08, FACTUREFMA-T01-T05, FACTURERGBL-T01-T04 · sources : [Facturefm.class:_New](../../../../../.src/Gestion/Facturation/Facturefm.class#L123-L212), [FacturefmA.class:_New](../../../../../.src/Gestion/Facturation/FacturefmA.class#L111-L159), [Facturergbl.class:_New](../../../../../.src/Gestion/Facturation/Facturergbl.class#L97-L159)
- [ ] FACTUREFM-007 — [commonalisation] Helper unique de création des tables de travail de fin de
  mois (structure de cette classe, attendue par `ObjFac`), partagé avec `SaiReg.Facture` (même
  structure) · appelants : `SaiReg` · tests : T01, SAIREG-T08 · sources : [Facturefm.class:245-265](../../../../../.src/Gestion/Facturation/Facturefm.class#L245-L265), [SaiReg.class:904-924](../../../../../.src/Gestion/Facturation/SaiReg.class#L904-L924)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FACTUREFM-A01 — [anomalie] `requete` signale une période incohérente avec la périodicité
  (`Message.Error`) mais le traitement continue : `recup_bl` sélectionne quand même les BL ·
  tests : T02 · sources : [Facturefm.class:582-596](../../../../../.src/Gestion/Facturation/Facturefm.class#L582-L596), [Facturefm.class:559-560](../../../../../.src/Gestion/Facturation/Facturefm.class#L559-L560)
- [ ] FACTUREFM-A02 — [anomalie] Tables de travail globales `Facturefm` et `Bl` détruites et
  recréées sans identifiant de poste ni de session, et partagées avec `FacturefmA`, `Facturergbl`,
  `SaiReg`, `Visimpayes`, `Visreglements` sous d'autres structures : deux postes (ou deux écrans)
  s'écrasent mutuellement la sélection (voir VISIMPAYES-A02) · tests : T01, T10 · sources : [Facturefm.class:245-265](../../../../../.src/Gestion/Facturation/Facturefm.class#L245-L265), [FacturefmA.class:182-198](../../../../../.src/Gestion/Facturation/FacturefmA.class#L182-L198), [Visimpayes.class:101-110](../../../../../.src/Compta/Lettrages/Visimpayes.class#L101-L110)
- [ ] FACTUREFM-A03 — [anomalie, à confirmer] En mode « un client », la requête ignore les
  filtres de `$sreq` (périodicité `cli_regr`, période `BETWEEN`, tournée, type, commercial) et
  n'exclut les documents imprimés (`imp = 1`) que pour le type `F` : sélection différente du mode
  « tous » pour un même client · tests : T03 · sources : [Facturefm.class:269](../../../../../.src/Gestion/Facturation/Facturefm.class#L269), [Facturefm.class:271](../../../../../.src/Gestion/Facturation/Facturefm.class#L271)
