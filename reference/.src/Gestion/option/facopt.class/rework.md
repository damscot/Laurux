# facopt — Rework

> Source : `.src/Gestion/option/facopt.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/facopt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 875 |
| Lignes de commentaire | 28 |
| Fonctions | 48 |
| Fonctions Public | 26 |
| Complexité cyclomatique totale | 173 |
| Complexité max (fonction) | 19 (`grpnb_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 875 | 173 | 19 | 0 | 26 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FACOPT-001 — [documentation] En-tête : rôle (onglets consignes/régie de `Facture`),
  contrôles créés par code, conventions de `Fiches_ligcons` (`type B/F`, `numlig = num & ligne`,
  `D` = déconsigne), événement `recalcul` · appelants : aucun · tests : aucun · sources : [facopt.class:_new](../../../../../.src/Gestion/option/facopt.class#L63-L259)
- [ ] FACOPT-002 — [code mort] Supprimer `majdroit` (jamais appelée, inexécutable), les
  propriétés `regie`, `consigne`, `artcons`, `texttotcons`, `texttotdeco`, `texttotdr`,
  `texttotss`, `tvadroit`, `textmondr`, `textmonss`, `lignedroit` (aucun lecteur, seulement du
  code commenté dans `Facture`), les privés `$calcool`, `$bcreer`, `$bartcons`, la branche
  « Zone numérique » inatteignable de `grpnb_KeyPress` et les locales inutilisées · appelants :
  `Facture` (lignes commentées 2561-2562 à retirer ou laisser) · tests : T01-T08 · sources : [facopt.class:majdroit](../../../../../.src/Gestion/option/facopt.class#L563-L583), [facopt.class:regie_Read](../../../../../.src/Gestion/option/facopt.class#L955-L963), [facopt.class:lignedroit_Read](../../../../../.src/Gestion/option/facopt.class#L1068-L1072), [facopt.class:301-306](../../../../../.src/Gestion/option/facopt.class#L301-L306)
- [ ] FACOPT-003 — [réduction de portée] `mabsaisie` → `Private` (appels internes seulement) ·
  appelants : aucun · tests : T02, T04 · sources : [facopt.class:mabsaisie](../../../../../.src/Gestion/option/facopt.class#L940-L953)
- [ ] FACOPT-004 — [commonalisation] `CreeLigneCons(num, numlig, code, nb, prixActif) As Float`
  pour les trois blocs de `valide` et les trois de `majlig` (mêmes requêtes, même ordre) ·
  appelants : aucun · tests : T01, T02 · sources : [facopt.class:valide](../../../../../.src/Gestion/option/facopt.class#L810-L872), [facopt.class:majlig](../../../../../.src/Gestion/option/facopt.class#L637-L700)
- [ ] FACOPT-005 — [complexité] `_new` : helpers `CreeGrille` et `CreeZoneConsigne` (trois zones
  identiques) ; noms de groupes et ordre de création inchangés · appelants : `Facture`
  (inchangé) · tests : T01-T08 · sources : [facopt.class:_new](../../../../../.src/Gestion/option/facopt.class#L63-L259)
- [ ] FACOPT-006 — [commonalisation] `RemplitGrille(grid, result) As Float` pour `affcons` et
  `affdecons` ; puis `LitConsigne(code)` partagé avec `artopt` (ARTOPT-005), SQL identique ·
  appelants : aucun · tests : T01, T02, T07 · sources : [facopt.class:affcons](../../../../../.src/Gestion/option/facopt.class#L585-L606), [facopt.class:affdecons](../../../../../.src/Gestion/option/facopt.class#L608-L628), [facopt.class:ajoutcons](../../../../../.src/Gestion/option/facopt.class#L792-L807), [facopt.class:verifcons](../../../../../.src/Gestion/option/facopt.class#L385-L411)
- [ ] FACOPT-007 — [séparation traitement/GUI] `affdroit` → `DroitsDuBl(num)` sans contrôle +
  remplissage de grille ; `AjouteDeconsigne`/`SupprimeDeconsigne` pour `valide`,
  `gridcons_MouseUp`, `gridsaisie_*` · appelants : aucun · tests : T02-T04, T07 · sources : [facopt.class:affdroit](../../../../../.src/Gestion/option/facopt.class#L480-L561), [facopt.class:gridcons_MouseUp](../../../../../.src/Gestion/option/facopt.class#L767-L791), [facopt.class:gridsaisie_Activate](../../../../../.src/Gestion/option/facopt.class#L890-L921)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FACOPT-A01 — [anomalie] `gridcons_MouseUp`, `gridsaisie_Activate`, `gridsaisie_KeyPress`
  ne testent pas `$bimp` (ni `$snumbl` pour `MouseUp`) : déconsignes créées, modifiées ou
  supprimées sur une facture déjà imprimée, alors que `valide` et `majlig` le refusent · tests :
  T03, T04 · sources : [facopt.class:gridcons_MouseUp](../../../../../.src/Gestion/option/facopt.class#L767-L791), [facopt.class:gridsaisie_Activate](../../../../../.src/Gestion/option/facopt.class#L890-L921), [facopt.class:gridsaisie_KeyPress](../../../../../.src/Gestion/option/facopt.class#L923-L938)
- [ ] FACOPT-A02 — [anomalie] `gridcons_MouseUp` déconsigne toute la plage entre la première et
  la dernière ligne sélectionnées (lignes non sélectionnées comprises) ; `envaleur` non renseigné ;
  clic sans sélection → erreur d'indice probable (à confirmer) · tests : T03 · sources : [facopt.class:773-786](../../../../../.src/Gestion/option/facopt.class#L773-L786)
- [ ] FACOPT-A03 — [anomalie, à confirmer] `gridsaisie_Activate` supprime la déconsigne dès son
  rappel dans la zone de saisie : abandonner la modification la perd · tests : T04 · sources : [facopt.class:919](../../../../../.src/Gestion/option/facopt.class#L919)
- [ ] FACOPT-A04 — [anomalie] `affdroit` : colonne « Libelle » vide pour une facture non éditée
  (`Calculdroit.lib_Read` renvoie `$slib`, vide quand `_new` sort tôt : cause probable, un article
  avec `art_dra = ''` passe le filtre `art_dra IS NOT NULL` de la requête l. 520-531 ; voir
  CALCULDROIT-A02, à confirmer en replay) ; TVA des droits
  calculée différemment selon la branche (`Round` par ligne × taux, ou `drt.tva`) · tests : T07 ·
  sources : [facopt.class:531](../../../../../.src/Gestion/option/facopt.class#L531), [facopt.class:514](../../../../../.src/Gestion/option/facopt.class#L514), [facopt.class:543](../../../../../.src/Gestion/option/facopt.class#L543)
- [ ] FACOPT-A05 — [anomalie] Quantité non numérique ou décimale : aucun message (bulle
  inatteignable), la zone passe à la suivante et la ligne est ignorée à la validation · tests :
  T08 · sources : [facopt.class:grpnb_KeyPress](../../../../../.src/Gestion/option/facopt.class#L274-L318), [facopt.class:verifnb](../../../../../.src/Gestion/option/facopt.class#L874-L887)
