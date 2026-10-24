# Facturergbl — Rework

> Source : `.src/Gestion/Facturation/Facturergbl.class` · Message de commit (phase 4) : `reference/.src/Gestion/Facturation/Facturergbl.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1232 |
| Lignes de commentaire | 99 |
| Fonctions | 30 |
| Fonctions Public | 30 |
| Complexité cyclomatique totale | 258 |
| Complexité max (fonction) | 121 (`Button14_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 1232 | 258 | 121 | 0 | 30 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FACTURERGBL-001 — [documentation] En-tête : rôle (regroupement de BL), double usage
  (écran et bibliothèque de `Moulinage`), contrat de `Ent_Bl`, existence d'une chaîne d'édition
  inatteignable · appelants : aucun · tests : aucun · sources : [Facturergbl.class:Ent_Bl](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1238-L1317), [Facturergbl.class:Button9_Click](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1334-L1359)
- [ ] FACTURERGBL-002 — [code mort] Supprimer `Bl_Sup` et `ard` (jamais appelées ; `ard` =
  copie de `ValidBR.ard`) et les variables d'instance mortes indépendantes de la chaîne
  d'édition (`Cclient`, `Ccli`, `dateech2`, `dtex`, `Visudoc`, `Ardi`, `nbdec`…) · appelants :
  aucun · tests : T01-T03 · sources : [Facturergbl.class:Bl_Sup](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1322-L1332), [Facturergbl.class:ard](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1364-L1401), [Facturergbl.class:89-91](../../../../../.src/Gestion/Facturation/Facturergbl.class#L89-L91)
- [ ] FACTURERGBL-003 — [réduction de portée] `recup_bl`, `Quittedate`, `Parametres`, `Selbl`
  → `Private` ; `Ent_Bl` et `Maj_Parametres` restent `Public` (`Moulinage`) · appelants : aucun ·
  tests : T01-T03, T07 · sources : [Facturergbl.class:recup_bl](../../../../../.src/Gestion/Facturation/Facturergbl.class#L164-L242), [Facturergbl.class:Quittedate](../../../../../.src/Gestion/Facturation/Facturergbl.class#L354-L409), [Facturergbl.class:Parametres](../../../../../.src/Gestion/Facturation/Facturergbl.class#L997-L1008), [Facturergbl.class:Selbl](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1219-L1233)
- [ ] FACTURERGBL-004 — [séparation traitement/GUI] `Ent_Bl` : défaut de `Date_Bl` rendu
  explicite par l'appelant écran (`Selbl` passe `LDate(datej.Text).G`, même valeur) ; extraire
  `InsereEntete` et `RecopieLigne` (SQL identique, même ordre) ; `Button9_Click` : extraire
  `RegroupeSelection` · appelants : `Moulinage` (signature inchangée) · tests : T02, T03, T07 ·
  sources : [Facturergbl.class:Ent_Bl](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1238-L1317), [Facturergbl.class:Selbl](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1219-L1233), [Facturergbl.class:Button9_Click](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1334-L1359)
- [ ] FACTURERGBL-005 — [commonalisation] Écran de sélection : base commune avec `Facturefm` et
  `FacturefmA` (FACTUREFM-006) et `Quittedate` partagée avec `FacturefmA` (FACTUREFMA-007) ·
  appelants : aucun · tests : T01, T05 · sources : [Facturergbl.class:_New](../../../../../.src/Gestion/Facturation/Facturergbl.class#L97-L159), [Facturergbl.class:Quittedate](../../../../../.src/Gestion/Facturation/Facturergbl.class#L354-L409)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FACTURERGBL-A01 — [anomalie, décision utilisateur] Chaîne d'édition de facture regroupée
  **inatteignable** (panneau `Edit` invisible, `Bl_Edit` jamais appelée) et défectueuse : appels
  `Cdocuments.Level6F` à 5 arguments pour 6 (erreur d'arité, `frais` manquant), `Totht` écrasé
  par `Maj_Totalisation`, `LOCK TABLES` imbriqués qui libèrent ceux de l'appelant. Choix : supprimer
  `Button14_Click`, `Button16_Click`, `dtef_LostFocus`, `Ventilation`, `Maj_Totalisation`,
  `Calc_tva`, `Bl_Edit`, le `Shell "lpc status"` de `_New` et les variables associées (handlers
  laissés vides, `.form` inchangé), ou réactiver l'édition en corrigeant ces défauts ·
  tests : aucun aujourd'hui · sources : [Facturergbl.class:948](../../../../../.src/Gestion/Facturation/Facturergbl.class#L948), [Facturergbl.class:953](../../../../../.src/Gestion/Facturation/Facturergbl.class#L953), [Facturergbl.class:960](../../../../../.src/Gestion/Facturation/Facturergbl.class#L960), [Facturergbl.class:Button14_Click](../../../../../.src/Gestion/Facturation/Facturergbl.class#L470-L992), [Facturergbl.class:Bl_Edit](../../../../../.src/Gestion/Facturation/Facturergbl.class#L447-L457), [Facturergbl.class:112-116](../../../../../.src/Gestion/Facturation/Facturergbl.class#L112-L116)
- [ ] FACTURERGBL-A02 — [anomalie] Fusion d'articles (`Fus_art`) : marges lues sur l'entête
  `Entbonl!mrgart_ligbl` / `mrgmo_ligbl`, colonnes absentes de `Fiches_Bl` (elles sont dans
  `Fiches_Ligbl`) → erreur dès que deux lignes identiques sont fusionnées depuis l'écran ·
  tests : T04 · sources : [Facturergbl.class:1294-1295](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1294-L1295)
- [ ] FACTURERGBL-A03 — [anomalie] Les `LOCK TABLES` de `Button9_Click` sont remplacés puis
  libérés par ceux de `DocActif.Get_Lock`/`Free_Lock` appelés dans `Ent_Bl` : le regroupement
  (numérotation `dnbon` comprise) n'est plus protégé contre un autre poste · tests : à définir
  (deux connexions) · sources : [Facturergbl.class:1346](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1346), [Facturergbl.class:1267](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1267), [DocActif.class:101](../../../../../.src/Communs/DocActif.class#L101)
- [ ] FACTURERGBL-A04 — [anomalie] Numérotation : en mode « tous les clients », `Selbl`
  incrémente `Nbon` avant le premier regroupement (le numéro `dnbon + 1` est perdu) ; sans client
  sélectionné, `dnbon` est quand même incrémenté sans BL créé · tests : T03, T06 · sources : [Facturergbl.class:1226](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1226), [Facturergbl.class:1349](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1349)
- [ ] FACTURERGBL-A05 — [anomalie, à confirmer] `Ent_Bl` renseigne l'entête du nouveau BL avec
  des membres jamais calculés hors de la chaîne d'édition morte : `htbl = Val(Totht)` (colonne
  `tinyint`), `ech = Cdate_Dbase(dateech)`, `marge_art/marge_mo = mgart/mgmo` (chaînes vides),
  `totalttc = Val(Mttc)` (corrigé ensuite) ; `Coldetail_Keypress` écrit le TTC dans
  `Colbl.Item[3]` (comme FACTUREFMA-A01) · tests : T02, T07, T05 · sources : [Facturergbl.class:1266](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1266), [Facturergbl.class:334](../../../../../.src/Gestion/Facturation/Facturergbl.class#L334)
- [ ] FACTURERGBL-A06 — [anomalie, à confirmer] Seules les lignes `A` et `C` des BL sources sont
  recopiées (`typel_ligbl = 'A' OR 'C'`) avant suppression des BL : lignes de main-d'œuvre `M`,
  deuxièmes lignes `T`, composants `O`, écotaxes `E`/`P` et lignes `R` sont perdues · tests :
  T02 · sources : [Facturergbl.class:1276](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1276), [Facturergbl.class:1308-1309](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1308-L1309)
