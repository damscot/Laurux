# Fprepdus — Rework

> Source : `.src/Communs/Fprepdus.class` · Message de commit (phase 4) : `reference/.src/Communs/Fprepdus.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 72 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 20 |
| Complexité max (fonction) | 8 (`TraitementC`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 72 | 20 | 8 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FPREPDUS-001 — [documentation] En-tête en français : rôle, ouverture depuis `lblClm3`,
  règles de calcul (soldes positifs clients, négatifs fournisseurs), devise · appelants : aucun ·
  tests : aucun · sources : [Fprepdus.class:_new](../../../../.src/Communs/Fprepdus.class#L6-L23)
- [ ] FPREPDUS-002 — [code mort] Supprimer le reformatage inutilisé de `Dte` (l.17) et le test
  `If rResult.Available` redondant dans les boucles · appelants : aucun · tests : T01 à T04 · sources : [Fprepdus.class:17](../../../../.src/Communs/Fprepdus.class#L17), [Fprepdus.class:TraitementC](../../../../.src/Communs/Fprepdus.class#L31-L59), [Fprepdus.class:TraitementF](../../../../.src/Communs/Fprepdus.class#L61-L89)
- [ ] FPREPDUS-003 — [commonalisation] `SyntheseDus(sType, iSigne) As Float[]` (pure, SQL +
  calcul, même requête et même ordre de sommation) utilisée par `TraitementC`/`TraitementF`,
  qui ne gardent que l'affichage (textes et mutation de `Devises` inchangés) · appelants : aucun ·
  tests : T01 à T05 · sources : [Fprepdus.class:TraitementC](../../../../.src/Communs/Fprepdus.class#L31-L59), [Fprepdus.class:TraitementF](../../../../.src/Communs/Fprepdus.class#L61-L89)
- [ ] FPREPDUS-004 — [documentation] `Fiches_Comptes` en dur → `Cbase.Table("TabComptes")` (SQL
  identique) · appelants : aucun · tests : T01 · sources : [Fprepdus.class:38](../../../../.src/Communs/Fprepdus.class#L38), [Fprepdus.class:68](../../../../.src/Communs/Fprepdus.class#L68)
- [ ] FPREPDUS-005 — [réduction de portée] `TraitementC`, `TraitementF` → `Private` (aucun
  appelant externe ; couverts par replay et par `SyntheseDus`) · appelants : aucun · tests : T01, T05 · sources : [Fprepdus.class:TraitementC](../../../../.src/Communs/Fprepdus.class#L31-L59), [Fprepdus.class:TraitementF](../../../../.src/Communs/Fprepdus.class#L61-L89)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FPREPDUS-A01 — [anomalie] `TraitementF` affiche un total fournisseurs **négatif** et le test
  de pluriel `Tot > 0` n'est jamais vrai ; « 1 fournisseurs » au singulier. Proposition : afficher
  la valeur absolue et accorder les libellés · tests : T02 · sources : [Fprepdus.class:80](../../../../.src/Communs/Fprepdus.class#L80), [Fprepdus.class:81](../../../../.src/Communs/Fprepdus.class#L81)
- [ ] FPREPDUS-A02 — [anomalie] Pluriel de devise construit en ajoutant « s » (« EURs ») et
  mutation du membre `Devises` partagée entre les deux calculs ; devise vide si `Fiches_Parametres`
  n'a pas de ligne · tests : T04 · sources : [Fprepdus.class:50](../../../../.src/Communs/Fprepdus.class#L50), [Fprepdus.class:_new](../../../../.src/Communs/Fprepdus.class#L6-L23)
