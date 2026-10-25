# Saisiedecons — Rework

> Source : `.src/Gestion/option/Saisiedecons.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/Saisiedecons.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 497 |
| Lignes de commentaire | 11 |
| Fonctions | 34 |
| Fonctions Public | 27 |
| Complexité cyclomatique totale | 117 |
| Complexité max (fonction) | 9 (`saisie_keypress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 497 | 117 | 9 | 0 | 27 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SAISIEDECONS-001 — [documentation] En-tête : règle de déconsignation (lignes `numlig = 'D'`,
  montants négatifs, déduction du HT et du TTC de la réception), clé `bloc`, listes flottantes
  créées par code · appelants : aucun · tests : T01-T06 · sources : [Saisiedecons.class:_new](../../../../../.src/Gestion/option/Saisiedecons.class#L18-L72), [Saisiedecons.class:majcons](../../../../../.src/Gestion/option/Saisiedecons.class#L555-L578)
- [ ] SAISIEDECONS-002 — [séparation traitement/GUI] `selectionbr` : fonctions privées
  `TotauxReception`, `TotalConsignes`, `CumulAccise` sans contrôles (SQL identique) · appelants :
  aucun · tests : T01, T05 · sources : [Saisiedecons.class:selectionbr](../../../../../.src/Gestion/option/Saisiedecons.class#L260-L292)
- [ ] SAISIEDECONS-003 — [séparation traitement/GUI] `majcons` : calcul `nb`/`montant` dans une
  fonction privée pure ; écriture du `Result` inchangée · appelants : aucun · tests : T02, T03,
  T07 · sources : [Saisiedecons.class:majcons](../../../../../.src/Gestion/option/Saisiedecons.class#L555-L578)
- [ ] SAISIEDECONS-004 — [commonalisation] Helper privé `FenetreListe(...)` pour la fenêtre +
  grille flottante de `Butbl_Click` et `consigne_click` (noms d'événements `rechbl`/`rechcons`
  conservés) · appelants : aucun · tests : T01, T02 · sources : [Saisiedecons.class:Butbl_Click](../../../../../.src/Gestion/option/Saisiedecons.class#L183-L237), [Saisiedecons.class:consigne_click](../../../../../.src/Gestion/option/Saisiedecons.class#L413-L449)
- [ ] SAISIEDECONS-005 — [complexité] `Relire()` pour les 4 lectures des déconsignations
  (SQL identique) · appelants : aucun · tests : T02-T04 · sources : [Saisiedecons.class:selectionbr](../../../../../.src/Gestion/option/Saisiedecons.class#L260-L292), [Saisiedecons.class:GridView1_KeyPress](../../../../../.src/Gestion/option/Saisiedecons.class#L334-L347), [Saisiedecons.class:Butval_Click](../../../../../.src/Gestion/option/Saisiedecons.class#L510-L547)
- [ ] SAISIEDECONS-006 — [commonalisation] Prix de consigne par `Consigne.PrixUnitaire` (voir
  CONSIGNE-006, même commit ; comportement identique tant que la consigne existe — sinon voir A04) ·
  appelants : aucun · tests : T02, T07 · sources : [Saisiedecons.class:majcons](../../../../../.src/Gestion/option/Saisiedecons.class#L555-L578), [Consigne.class:consigne_montant](../../../../../.src/Gestion/option/Consigne.class#L30-L45)
- [ ] SAISIEDECONS-007 — [code mort] Variables locales `res` inutilisées (`saisie_keypress`,
  `Textfour_LostFocus`, `Butart_Click`) ;
  documenter la branche `nfour`/`$fen` de `_new`/`Butenr_Click` comme inatteignable (aucun appelant
  ne passe d'argument) · appelants : aucun · tests : T01-T04 · sources : [Saisiedecons.class:saisie_keypress](../../../../../.src/Gestion/option/Saisiedecons.class#L114-L136), [Saisiedecons.class:Textfour_LostFocus](../../../../../.src/Gestion/option/Saisiedecons.class#L138-L148), [Saisiedecons.class:Butenr_Click](../../../../../.src/Gestion/option/Saisiedecons.class#L605-L623)
- [ ] SAISIEDECONS-008 — [réarchitecture] `Cbase.Table` pour `Fiches_Four`, `Fiches_Entrecpt`,
  `Fiches_Ligrecpt`, `Fiches_Art` (SQL identique) · appelants : aucun · tests : T01, T02 · sources : [Saisiedecons.class:selectionbr](../../../../../.src/Gestion/option/Saisiedecons.class#L260-L292), [Saisiedecons.class:lirefour](../../../../../.src/Gestion/option/Saisiedecons.class#L349-L357), [Saisiedecons.class:Butbl_Click](../../../../../.src/Gestion/option/Saisiedecons.class#L183-L237)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SAISIEDECONS-A01 — [anomalie] Suppression d'une déconsignation (Suppr) : la ligne est effacée
  mais les totaux HT/TTC affichés et `Fiches_Entrecpt.montant/mttc` restent diminués (réception
  sous-évaluée) · tests : T04 · sources : [Saisiedecons.class:GridView1_KeyPress](../../../../../.src/Gestion/option/Saisiedecons.class#L334-L347)
- [ ] SAISIEDECONS-A02 — [anomalie] `selectionbr` recumule l'accise dans `Labelacc` sans remise à
  zéro à chaque nouvel appel · tests : T05 · sources : [Saisiedecons.class:282](../../../../../.src/Gestion/option/Saisiedecons.class#L282)
- [ ] SAISIEDECONS-A03 — [anomalie, à confirmer] `lirefour` cherche `fo_code = Val(Textfour.Text)` :
  codes fournisseurs alphanumériques jamais trouvés (code vidé) ; `Butval_Click` met à jour
  `Fiches_Entrecpt` sans la date (`ddate`) alors que la sélection en tient compte · tests : T01,
  T02 · sources : [Saisiedecons.class:353](../../../../../.src/Gestion/option/Saisiedecons.class#L353), [Saisiedecons.class:539](../../../../../.src/Gestion/option/Saisiedecons.class#L539)
- [ ] SAISIEDECONS-A04 — [anomalie] `majcons` lit `resc!prix` sans test `Available` (code de
  consigne inconnu → erreur dans la transaction ouverte) ; `GridView1_Data` divise par `nb`
  (nul possible) · tests : T02 · sources : [Saisiedecons.class:571](../../../../../.src/Gestion/option/Saisiedecons.class#L571), [Saisiedecons.class:299](../../../../../.src/Gestion/option/Saisiedecons.class#L299)
- [ ] SAISIEDECONS-A05 — [anomalie] `Bsel` non remis à `False` avant `TriCpt`/`TriArticles` : une
  recherche annulée réutilise la sélection précédente · tests : T01 · sources : [Saisiedecons.class:Butfour_Click](../../../../../.src/Gestion/option/Saisiedecons.class#L166-L181), [Saisiedecons.class:Butart_Click](../../../../../.src/Gestion/option/Saisiedecons.class#L360-L378)
