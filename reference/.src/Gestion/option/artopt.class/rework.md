# artopt — Rework

> Source : `.src/Gestion/option/artopt.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/artopt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 472 |
| Lignes de commentaire | 13 |
| Fonctions | 30 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 110 |
| Complexité max (fonction) | 15 (`affiche`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 472 | 110 | 15 | 0 | 17 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ARTOPT-001 — [documentation] En-tête : onglet d'options de la fiche article, contrôles de
  l'appelant modifiés (`Frais`, `Prvt`) et détruits à la fermeture, événement `recalculpx` ·
  appelants : aucun · tests : aucun · sources : [artopt.class:_new](../../../../../.src/Gestion/option/artopt.class#L23-L127), [artopt.class:form_Close](../../../../../.src/Gestion/option/artopt.class#L129-L136)
- [ ] ARTOPT-002 — [code mort] Supprimer la propriété `creer` (et `$bcreer`), `$snbdec`, les
  locales inutilisées et la seconde affectation de `Textcdr` dans `affiche` · appelants : aucun
  (vérifié par `grep`) · tests : T01, T03 · sources : [artopt.class:creer_Write](../../../../../.src/Gestion/option/artopt.class#L599-L608), [artopt.class:creer_Read](../../../../../.src/Gestion/option/artopt.class#L593-L597), [artopt.class:12](../../../../../.src/Gestion/option/artopt.class#L12), [artopt.class:411](../../../../../.src/Gestion/option/artopt.class#L411)
- [ ] ARTOPT-003 — [complexité] `_new` : table `[contrôle, décimales]` pour les réglages
  `TextReg` (même ordre) · appelants : `Articles`, `commande1` (inchangés) · tests : T01-T04 ·
  sources : [artopt.class:_new](../../../../../.src/Gestion/option/artopt.class#L23-L127)
- [ ] ARTOPT-004 — [commonalisation] `AfficheConsigne(res)` pour `grcode_lostfocus`,
  `Listcons_Activate` et les trois blocs de consignes d'`affiche` · appelants : aucun · tests :
  T01, T02 · sources : [artopt.class:grcode_lostfocus](../../../../../.src/Gestion/option/artopt.class#L243-L271), [artopt.class:Listcons_Activate](../../../../../.src/Gestion/option/artopt.class#L273-L297), [artopt.class:affiche](../../../../../.src/Gestion/option/artopt.class#L362-L427)
- [ ] ARTOPT-005 — [commonalisation] `LitConsigne(code)` partagé avec `facopt` (FACOPT-006), SQL
  identique · appelants : aucun · tests : T01, T02, FACOPT-T01 · sources : [artopt.class:grcode_lostfocus](../../../../../.src/Gestion/option/artopt.class#L243-L271), [facopt.class:verifcons](../../../../../.src/Gestion/option/facopt.class#L385-L411)
- [ ] ARTOPT-006 — [séparation traitement/GUI] `PrixRevient(...) As Float` pur pour
  `calculpxrev`, `EnregistreOptions` sans contrôle pour `enregiste` · appelants : aucun ·
  tests : T02, T03 · sources : [artopt.class:calculpxrev](../../../../../.src/Gestion/option/artopt.class#L299-L314), [artopt.class:enregiste](../../../../../.src/Gestion/option/artopt.class#L512-L552)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ARTOPT-A01 — [anomalie] `enregiste` sort sans `Commit` ni `Rollback` si l'article est
  introuvable après `Begin` (transaction laissée ouverte) · tests : T03 · sources : [artopt.class:516-518](../../../../../.src/Gestion/option/artopt.class#L516-L518)
- [ ] ARTOPT-A02 — [anomalie, à confirmer] `form_Close` détruit des contrôles qui appartiennent à
  l'appelant (`Frais`, `PaUA`, `Prvt`, `TxTva`) · tests : T01 · sources : [artopt.class:form_Close](../../../../../.src/Gestion/option/artopt.class#L129-L136)
