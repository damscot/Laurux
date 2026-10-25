# Consigne — Rework

> Source : `.src/Gestion/option/Consigne.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/Consigne.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 61 |
| Lignes de commentaire | 1 |
| Fonctions | 6 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 12 |
| Complexité max (fonction) | 3 (`recuppalette`) |
| Variables globales | 0 |
| Variables Public | 5 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 61 | 12 | 3 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CONSIGNE-001 — [documentation] En-tête de classe en français : rôle (consignes d'emballages,
  option boissons), chaîne d'héritage `LPrix` → `calculdroit1` → `Consigne`, répartition des 13
  arguments du constructeur, clé `bloc`/`numlig`, accès par `Sailig.AutresObj` dans `Achat` ;
  commentaires `'''` sur les méthodes Public · appelants : aucun · tests : T01-T05 · sources : [Consigne.class:_new](../../../../../.src/Gestion/option/Consigne.class#L13-L21), [Consigne.class:consigne_Read](../../../../../.src/Gestion/option/Consigne.class#L81-L88)
- [ ] CONSIGNE-002 — [code mort] Supprimer `LecCons` (privée, jamais appelée, corps vide) ·
  appelants : aucun · tests : T01-T05 · sources : [Consigne.class:LecCons](../../../../../.src/Gestion/option/Consigne.class#L23-L28)
- [ ] CONSIGNE-003 — [complexité] `consigne_montant` : paramètre `&1` passé à `Exec` au lieu de
  `Utils.db.Subst` + concaténation (SQL émis identique) · appelants : `Achat` (inchangé) · tests :
  T01, T02, T06 · sources : [Consigne.class:consigne_montant](../../../../../.src/Gestion/option/Consigne.class#L30-L45)
- [ ] CONSIGNE-004 — [commonalisation] `recuppalette`/`recupcol` → helper privé
  `RecupNb(type, block, nlge) As Integer` ; signatures Public et affectation de `nbpal`/`nbcol`
  (faite par chaque méthode Public) conservées · appelants : `ValidBR1` (inchangé) · tests : T03, T06 · sources : [Consigne.class:recuppalette](../../../../../.src/Gestion/option/Consigne.class#L47-L62), [Consigne.class:recupcol](../../../../../.src/Gestion/option/Consigne.class#L64-L79)
- [ ] CONSIGNE-005 — [complexité] `consigne_Read` : boucle sur les trois couples (code, nombre) au
  lieu de trois expressions chaînées (SQL identique, même ordre) · appelants : `ValidBR1` ·
  tests : T04, T06 · sources : [Consigne.class:consigne_Read](../../../../../.src/Gestion/option/Consigne.class#L81-L88)
- [ ] CONSIGNE-006 — [commonalisation] Fonction `Static Public PrixUnitaire(code) As Float` (lecture
  de `Fiches_consigne.prix`, 0 si absent) utilisée par `consigne_montant` et proposée à
  `Saisiedecons.majcons` (rework SAISIEDECONS-006, même commit si retenu) · appelants :
  `Saisiedecons` · tests : T01, SAISIEDECONS-T07 · sources : [Consigne.class:consigne_montant](../../../../../.src/Gestion/option/Consigne.class#L30-L45), [Saisiedecons.class:majcons](../../../../../.src/Gestion/option/Saisiedecons.class#L555-L578)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CONSIGNE-A01 — [anomalie, à confirmer] `consigne_montant(code, qte As Integer)` : la quantité
  `Float` transmise par `Achat.EnrConsigne` (`nb As Float`) et par `consigne_Read` (`Me.Qte`) est
  convertie en entier : une quantité fractionnaire de bouteilles fausse le montant consigné ·
  tests : T02 · sources : [Consigne.class:30](../../../../../.src/Gestion/option/Consigne.class#L30), [Consigne.class:85](../../../../../.src/Gestion/option/Consigne.class#L85), [Achat.class:994](../../../../../.src/Gestion/Entrées/Achat.class#L994)
- [ ] CONSIGNE-A02 — [anomalie] Héritage de CALCULDROIT1-A01 : avec l'option `B` seule, `opt` vaut
  `True` ; `Consigne` reste calculée mais `code` renvoie `Null`, donc `Achat.EnrRec` n'écrit pas la
  ligne de régie (`Fiches_ligregie`) des articles consignés · tests : T05, T06 · sources : [calculdroit1.class:33](../../../../../.src/Gestion/option/calculdroit1.class#L33), [Achat.class:958](../../../../../.src/Gestion/Entrées/Achat.class#L958)
