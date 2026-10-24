# FacturefmA — Rework

> Source : `.src/Gestion/Facturation/FacturefmA.class` · Message de commit (phase 4) : `reference/.src/Gestion/Facturation/FacturefmA.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 517 |
| Lignes de commentaire | 34 |
| Fonctions | 26 |
| Fonctions Public | 26 |
| Complexité cyclomatique totale | 109 |
| Complexité max (fonction) | 41 (`recup_bl`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 517 | 109 | 41 | 0 | 26 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FACTUREFMA-001 — [documentation] En-tête : rôle (abonnements, BL `A`), règle de
  périodicité (`cli_aban`, `cli_datab`, `dtefac`), structure des tables de travail et appel
  d'`OptFac` en mode fin de mois · appelants : aucun · tests : aucun · sources : [FacturefmA.class:recup_bl](../../../../../.src/Gestion/Facturation/FacturefmA.class#L164-L301), [FacturefmA.class:Button14_Click](../../../../../.src/Gestion/Facturation/FacturefmA.class#L636-L644)
- [ ] FACTUREFMA-002 — [code mort] Supprimer `EnvoiFTP` (jamais appelée) et les variables qui ne
  servent qu'à elle (`ty`, `hnew`, `mail2`, `$rs_soc`, `$cli_nom`, `$cli_pnm`, `scode`,
  `numeroFac`, `Mttc`) ; les handlers vides de `FtpClient1` restent · appelants : aucun · tests :
  T01, T06 · sources : [FacturefmA.class:EnvoiFTP](../../../../../.src/Gestion/Facturation/FacturefmA.class#L545-L571), [FacturefmA.class:90-106](../../../../../.src/Gestion/Facturation/FacturefmA.class#L90-L106)
- [ ] FACTUREFMA-003 — [code mort] Supprimer les ≈ 55 autres variables d'instance mortes, la
  lecture de la devise et `Coulfond` dans `_New`, les calculs inutilisés de `Quittedate` (`dtex`,
  `dte`, `dte2`, `ye`, `numecr`) et le test `IsNull(dtefac)` inatteignable (l. 260) · appelants :
  aucun · tests : T01-T06 · sources : [FacturefmA.class:27-89](../../../../../.src/Gestion/Facturation/FacturefmA.class#L27-L89), [FacturefmA.class:Quittedate](../../../../../.src/Gestion/Facturation/FacturefmA.class#L401-L452), [FacturefmA.class:260](../../../../../.src/Gestion/Facturation/FacturefmA.class#L260)
- [ ] FACTUREFMA-004 — [réduction de portée] `recup_bl`, `Quittedate` → `Private` ; `Cclient`
  supprimée ; `Bsel`/`Bval` et tous les handlers restent `Public` · appelants : aucun · tests :
  T01-T05 · sources : [FacturefmA.class:recup_bl](../../../../../.src/Gestion/Facturation/FacturefmA.class#L164-L301), [FacturefmA.class:Quittedate](../../../../../.src/Gestion/Facturation/FacturefmA.class#L401-L452)
- [ ] FACTUREFMA-005 — [complexité] `recup_bl` (CC 41) : table `[libellé, mois]` et fonction
  privée `EstFacturable(…)` à la place des 5 branches `Case`, à **comportement identique**
  (formules actuelles conservées, défauts compris) · appelants : aucun · tests : T01-T03, T08 ·
  sources : [FacturefmA.class:recup_bl](../../../../../.src/Gestion/Facturation/FacturefmA.class#L164-L301)
- [ ] FACTUREFMA-006 — [séparation traitement/GUI] Sélection, règle de périodicité et
  alimentation des tables de travail dans des fonctions sans contrôle (SQL identique) ; le
  handler garde l'affichage et l'avertissement · appelants : aucun · tests : T01-T05 · sources : [FacturefmA.class:recup_bl](../../../../../.src/Gestion/Facturation/FacturefmA.class#L164-L301)
- [ ] FACTUREFMA-007 — [commonalisation] `Quittedate` partagée avec `Facturergbl` (identiques) ;
  base commune des écrans de fin de mois (voir FACTUREFM-006) · appelants : aucun · tests : T01,
  FACTURERGBL-T01 · sources : [FacturefmA.class:Quittedate](../../../../../.src/Gestion/Facturation/FacturefmA.class#L401-L452), [Facturergbl.class:Quittedate](../../../../../.src/Gestion/Facturation/Facturergbl.class#L354-L409)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FACTUREFMA-A01 — [anomalie] `Coldetail_Keypress` écrit le TTC de chaque BL dans
  `Colbl.Item[3]` (Ville du client) au lieu de `Coldetail.Item[3]` ; même défaut dans
  `Facturergbl` · tests : T05 · sources : [FacturefmA.class:381](../../../../../.src/Gestion/Facturation/FacturefmA.class#L381), [Facturergbl.class:334](../../../../../.src/Gestion/Facturation/Facturergbl.class#L334)
- [ ] FACTUREFMA-A02 — [anomalie, à confirmer] `dtefac` (datetime) est converti implicitement en
  « mm/jj/aaaa hh:nn:ss » en temps universel : `Left$(…, 2)` peut donner le mois précédent pour
  une facture du 1er à 00:00, et `Right$(…, 4)` (cas annuel) contient l'heure, pas l'année :
  l'abonnement annuel n'est pas sélectionné comme prévu · tests : T03, T08 · sources : [FacturefmA.class:210](../../../../../.src/Gestion/Facturation/FacturefmA.class#L210), [FacturefmA.class:252-253](../../../../../.src/Gestion/Facturation/FacturefmA.class#L252-L253)
- [ ] FACTUREFMA-A03 — [anomalie] Mois de référence négatif corrigé par `12 - n` au lieu de
  `12 + n` pour les périodicités bimensuelle, trimestrielle et semestrielle (janvier bimensuel →
  13 au lieu de 11) : clients non facturés ou facturés à tort en début d'année · tests : T02 ·
  sources : [FacturefmA.class:227](../../../../../.src/Gestion/Facturation/FacturefmA.class#L227), [FacturefmA.class:235](../../../../../.src/Gestion/Facturation/FacturefmA.class#L235), [FacturefmA.class:243](../../../../../.src/Gestion/Facturation/FacturefmA.class#L243)
- [ ] FACTUREFMA-A04 — [anomalie] La table de travail `Bl` est créée sans colonne `nom` :
  `ObjFac.calcul` (fin de mois) filtre sur `nom` pour un client divers → erreur SQL à l'édition ·
  tests : T07 · sources : [FacturefmA.class:192-198](../../../../../.src/Gestion/Facturation/FacturefmA.class#L192-L198), [ObjFac.class:481](../../../../../.src/Gestion/Facturation/ObjFac.class#L481)
- [ ] FACTUREFMA-A05 — [anomalie, à confirmer] `Button14_Click` édite avec la date `datej`
  (date de sélection) et non la date `Dtef` saisie dans le panneau d'édition, et en mode
  `ObjFac.finmois` plutôt que `ObjFac.abonnement` ; la sélection utilise `Now` et non `datej`
  (`dtefac <= aujourd'hui`) · tests : T06, T01 · sources : [FacturefmA.class:640](../../../../../.src/Gestion/Facturation/FacturefmA.class#L640), [FacturefmA.class:199](../../../../../.src/Gestion/Facturation/FacturefmA.class#L199)
