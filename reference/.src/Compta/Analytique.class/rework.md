# Analytique — Rework

> Source : `.src/Compta/Analytique.class` · Message de commit (phase 4) : `reference/.src/Compta/Analytique.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 181 |
| Lignes de commentaire | 9 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 33 |
| Complexité max (fonction) | 8 (`Tbrem_Save`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 181 | 33 | 8 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ANALYTIQUE-001 — [documentation] En-tête en français : appelant, paramètres de `_new`
  (dont `sens` = `"T"` pour débit), sources de préremplissage, contrat `Fiches_MvtA` avec
  `Saisecrit` · appelants : aucun · tests : aucun · sources : [Analytique.class:_new](../../../../.src/Compta/Analytique.class#L17-L52)
- [ ] ANALYTIQUE-002 — [commonalisation] `Deb1` : les deux boucles de remplissage identiques →
  helper privé `AjouteLigne(r, ligne)` · appelants : aucun · tests : T01, T02 ·
  sources : [Analytique.class:Deb1](../../../../.src/Compta/Analytique.class#L130-L170)
- [ ] ANALYTIQUE-003 — [réarchitecture] `Deb1` : requête de ventilation par défaut paramétrée
  (`a.compte = &1`, SQL modifié, résultat identique pour un compte numérique) ; `With Utils`
  superflu retiré · appelants : aucun · tests : T01 · sources : [Analytique.class:153](../../../../.src/Compta/Analytique.class#L153)
- [ ] ANALYTIQUE-004 — [complexité] `Tbrem_Save` : totaux cumulés en `Float` puis formatés une
  fois, au lieu de relire et retailler `Label3.Text` à chaque ligne, avec le **même** arrondi
  affiché · appelants : aucun · tests : T03, T08 · sources : [Analytique.class:Tbrem_Save](../../../../.src/Compta/Analytique.class#L84-L128)
- [ ] ANALYTIQUE-005 — [séparation traitement/GUI] Fonctions pures `RepartitionMontant`,
  `RepartitionPourcent`, `TotauxVentilation` ; `EnregistreVentilation(numero, compte, lignes)` pour
  le SQL de `Button2_Click` (SQL identique) · appelants : aucun · tests : T01-T05, T08 ·
  sources : [Analytique.class:Tbrem_Save](../../../../.src/Compta/Analytique.class#L84-L128), [Analytique.class:Button2_Click](../../../../.src/Compta/Analytique.class#L178-L208)
- [ ] ANALYTIQUE-006 — [réduction de portée] `Deb1` → `Private` (`Tbrem_Save` reste `Public` :
  handler) · appelants : aucun · tests : T01, T02 · sources : [Analytique.class:Deb1](../../../../.src/Compta/Analytique.class#L130-L170)
- [ ] ANALYTIQUE-007 — [code mort] Commentaires de colonne « Libellé poste » et requête
  commentée l. 138 · appelants : aucun · tests : T01 · sources : [Analytique.class:36-37](../../../../.src/Compta/Analytique.class#L36-L37), [Analytique.class:138](../../../../.src/Compta/Analytique.class#L138), [Analytique.class:143](../../../../.src/Compta/Analytique.class#L143)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ANALYTIQUE-A01 — [anomalie] Bouton d'aide inopérant à la souris : `Button1` est dans le
  groupe `Btn` et `Btn_Click` est vide (correction : `Btn_Click` appelle `Button1_Click` selon
  `Last.Tag = 5`, sans toucher au `.form`) · tests : T06 · sources : [Analytique.class:Btn_Click](../../../../.src/Compta/Analytique.class#L225-L227), [Analytique.class:Button1_Click](../../../../.src/Compta/Analytique.class#L219-L223)
- [ ] ANALYTIQUE-A02 — [anomalie] `Button2_Click` : suppression de **toutes** les lignes
  `Fiches_MvtA` du numéro d'écriture (autres comptes compris), avant même le contrôle d'équilibre ;
  nombre de postes enregistrés borné par le nombre de lignes existant auparavant
  (`ligne >= nResult.count`) — comportement exact à confirmer par T01/T05 · tests : T01, T04, T05 ·
  sources : [Analytique.class:185-186](../../../../.src/Compta/Analytique.class#L185-L186), [Analytique.class:201](../../../../.src/Compta/Analytique.class#L201)
- [ ] ANALYTIQUE-A03 — [anomalie] `Poste` limité à 20 postes (`New String[20]`) : dépassement
  d'indice à l'ouverture au-delà · tests : T07 · sources : [Analytique.class:15](../../../../.src/Compta/Analytique.class#L15), [Analytique.class:47](../../../../.src/Compta/Analytique.class#L47)
- [ ] ANALYTIQUE-A04 — [anomalie] `Label4` (% restant) n'est pas calculé par `Deb1` : une
  ventilation rechargée ou par défaut non équilibrée est acceptée si l'utilisateur valide sans
  éditer ; comparaison localisée `"0,00 %"` · tests : T01, T02 · sources : [Analytique.class:Deb1](../../../../.src/Compta/Analytique.class#L130-L170), [Analytique.class:187](../../../../.src/Compta/Analytique.class#L187)
- [ ] ANALYTIQUE-A05 — [anomalie] `Deb1`, seconde branche : `Repeat` sans test `Available`
  (erreur si le compte n'a plus de ventilation par défaut entre l'ouverture de `Saisecrit` et
  celle de l'écran) · tests : manuel · sources : [Analytique.class:153-155](../../../../.src/Compta/Analytique.class#L153-L155)
