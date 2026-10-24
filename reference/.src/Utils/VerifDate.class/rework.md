# VerifDate — Rework

> Source : `.src/Utils/VerifDate.class` · Message de commit (phase 4) : `reference/.src/Utils/VerifDate.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 117 |
| Lignes de commentaire | 3 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 41 |
| Complexité max (fonction) | 10 (`ClotSuspendu`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 117 | 41 | 10 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VERIFDATE-001 — [documentation] En-tête : rôle, sens des quatre dates de clôture, convention
  « `True` = date refusée », fenêtre de deux mois de `ClotGestion` · appelants : aucun · tests : T01-T09 · sources : [VerifDate.class:_new](../../../../.src/Utils/VerifDate.class#L15-L50)
- [ ] VERIFDATE-002 — [code mort] Supprimer `_call` (aucun appel sans `New`) · appelants : aucun ·
  tests : T01 · sources : [VerifDate.class:_call](../../../../.src/Utils/VerifDate.class#L52-L59)
- [ ] VERIFDATE-003 — [commonalisation] Fusionner `ClotSuspendu`/`ClotAcquite` dans un helper
  privé `ClotCM(nart, droi, suspendu)` et les deux blocs de `_new` dans `DateCloture(suspendu)` ;
  signatures Public conservées · appelants : aucun · tests : T02, T03, T05, T08, T09 · sources : [VerifDate.class:ClotSuspendu](../../../../.src/Utils/VerifDate.class#L97-L120), [VerifDate.class:ClotAcquite](../../../../.src/Utils/VerifDate.class#L122-L145), [VerifDate.class:_new](../../../../.src/Utils/VerifDate.class#L15-L50)
- [ ] VERIFDATE-004 — [séparation traitement/GUI] Prédicats purs privés renvoyant la raison du
  refus ; `Message.Warning` (mêmes textes) conservés dans les fonctions Public · appelants : aucun ·
  tests : T04-T08 · sources : [VerifDate.class:ClotComptable](../../../../.src/Utils/VerifDate.class#L61-L69), [VerifDate.class:ClotGestion](../../../../.src/Utils/VerifDate.class#L71-L86), [VerifDate.class:ClotSuspendu](../../../../.src/Utils/VerifDate.class#L97-L120)
- [ ] VERIFDATE-005 — [réarchitecture] `Fiches_Parametres` → `Cbase.Table("TabParam")`,
  `Fiches_Art` → `Cbase.Table("TabArt")` ; requêtes `Fiches_Art`/`Fiches_regie` déjà paramétrées ·
  appelants : aucun · tests : T01-T03 · sources : [VerifDate.class:21](../../../../.src/Utils/VerifDate.class#L21), [VerifDate.class:103](../../../../.src/Utils/VerifDate.class#L103)
- [ ] VERIFDATE-006 — [réduction de portée] `ClotGestion`, `ClotSuspendu`, `ClotAcquite`,
  `DateSus`, `DateAcq`, `DateGes` → `Private` (couverts par `ClotFac`/`ClotDroi` et les replays) ;
  `DateCom` reste `Public` (`commande1.class:750`) · appelants : aucun · tests : tous · sources : [VerifDate.class:ClotGestion](../../../../.src/Utils/VerifDate.class#L71-L86), [VerifDate.class:ClotSuspendu](../../../../.src/Utils/VerifDate.class#L97-L120), [VerifDate.class:ClotAcquite](../../../../.src/Utils/VerifDate.class#L122-L145), [VerifDate.class:10-13](../../../../.src/Utils/VerifDate.class#L10-L13)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VERIFDATE-A01 — [anomalie] `_new` : pas de test `Available` sur `Fiches_Parametres` ;
  `DateGes` construit par concaténation `"01." & dtepec` (si `dtepec` est vide, `Parse` interprète
  `"01."` comme le 1er du mois courant) · tests : T01 · sources : [VerifDate.class:21-23](../../../../.src/Utils/VerifDate.class#L21-L23)
- [ ] VERIFDATE-A02 — [anomalie] `Facture.class:6511` appelle `VerifDate.ClotDroi` sur
  l'auto-instance : date et paramètres figés au premier appel de la session ; `$vdate` (l. 411)
  semble être l'objet prévu. Correction dans `Facture` (rework minimal) · appelants : `Facture` ·
  tests : T08 · sources : [Facture.class:6511](../../../../.src/Gestion/Facturation/Facture.class#L6511), [Facture.class:411](../../../../.src/Gestion/Facturation/Facture.class#L411)
- [ ] VERIFDATE-A03 — [anomalie] `ClotComptable` refuse aussi la date de clôture elle-même
  (`Avant` non strict) alors que les autres contrôles sont stricts ; à confirmer avec l'utilisateur
  (règle métier) · tests : T06 · sources : [VerifDate.class:63](../../../../.src/Utils/VerifDate.class#L63)
