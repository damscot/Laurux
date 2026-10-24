# Listextcpt — Rework

> Source : `.src/Compta/Utils/Listextcpt.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/Listextcpt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 297 |
| Lignes de commentaire | 10 |
| Fonctions | 15 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 76 |
| Complexité max (fonction) | 28 (`_new`) |
| Variables globales | 0 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 297 | 76 | 28 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LISTEXTCPT-001 — [documentation] En-tête de classe en français : rôle, structure `$brn`
  (ordre ancien → courant), contrat textuel de `requete` (`Pointage`), modes `ltr` ; commentaires
  `'''` sur chaque méthode Public · appelants : aucun · tests : T01 · sources : [Listextcpt.class:_new](../../../../../.src/Compta/Utils/Listextcpt.class#L36-L134), [Listextcpt.class:_call](../../../../../.src/Compta/Utils/Listextcpt.class#L27-L34)
- [ ] LISTEXTCPT-002 — [code mort] Supprimer `litpointee` (aucun appelant), la variable `dtes` de
  `letcpt` et le bloc `With Utils` de `Controle` · appelants : aucun · tests : T06, T08, T10 · sources : [Listextcpt.class:litpointee](../../../../../.src/Compta/Utils/Listextcpt.class#L348-L371), [Listextcpt.class:letcpt](../../../../../.src/Compta/Utils/Listextcpt.class#L188-L208), [Listextcpt.class:Controle](../../../../../.src/Compta/Utils/Listextcpt.class#L240-L266)
- [ ] LISTEXTCPT-003 — [complexité] `_new` : extraire `ChargeBornes()`, `FiltreLettrage(ltr)` et
  `ConstruitRequete(…)` (CC 28 → ≤ 10 visé), texte SQL identique à l'octet (sans changement SQL) ·
  appelants : aucun (signature inchangée) · tests : T01, T02, T03, T04 · sources : [Listextcpt.class:_new](../../../../../.src/Compta/Utils/Listextcpt.class#L36-L134)
- [ ] LISTEXTCPT-004 — [commonalisation] Helper privé `UnionExercices(sColonnes, sFiltre)` pour
  `ctrl`, `rechechelot`, `rechedoc` et `totalpointe` (même texte SQL, sans changement SQL) ;
  `ctrl` n'utilise plus `i` non initialisé · appelants : aucun · tests : T08, T09, T10 · sources : [Listextcpt.class:ctrl](../../../../../.src/Compta/Utils/Listextcpt.class#L220-L238), [Listextcpt.class:rechechelot](../../../../../.src/Compta/Utils/Listextcpt.class#L268-L285), [Listextcpt.class:rechedoc](../../../../../.src/Compta/Utils/Listextcpt.class#L287-L305), [Listextcpt.class:totalpointe](../../../../../.src/Compta/Utils/Listextcpt.class#L308-L328)
- [ ] LISTEXTCPT-005 — [complexité] `cherche` : comparaison des dates par `LDate` au lieu de
  chaînes `yyyymmdd`, résultat identique · appelants : aucun · tests : T05, T06 · sources : [Listextcpt.class:cherche](../../../../../.src/Compta/Utils/Listextcpt.class#L162-L186)
- [ ] LISTEXTCPT-006 — [séparation traitement/GUI] `enregistrepointage` : `Application.Busy`
  déplacé dans `Pointage` (autour des deux appels) · appelants : `Pointage.class:664`, `699` ·
  tests : T10, replay Pointage · sources : [Listextcpt.class:enregistrepointage](../../../../../.src/Compta/Utils/Listextcpt.class#L330-L346), [Pointage.class:664](../../../../../.src/Compta/Pointage.class#L664), [Pointage.class:699](../../../../../.src/Compta/Pointage.class#L699)
- [ ] LISTEXTCPT-007 — [commonalisation] Lecture des dates de clôture par
  `LDate.Exercice_Cloture(i)` (LDATE-008) en conservant l'heure 00:00 de `dtesup` · appelants :
  aucun · tests : T01, T04 · sources : [Listextcpt.class:_new](../../../../../.src/Compta/Utils/Listextcpt.class#L36-L134), [LDate.class:Exercice_Cloture](../../../../../.src/Utils/LDate.class#L648-L672)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LISTEXTCPT-A01 — [anomalie] Calcul de `der` : `$dtes` comparée deux fois à `dteinf`
  (`dtesup` probablement voulu) ; `der` reste l'exercice en cours, requêtes `UNION` inutiles et
  condition `i = der` de la ligne 96 faussée · tests : T01, T04 · sources : [Listextcpt.class:82](../../../../../.src/Compta/Utils/Listextcpt.class#L82)
- [ ] LISTEXTCPT-A02 — [anomalie] Ligne « Report a nouveau » : colonnes `numero`/`intitule`
  inversées par rapport à `champ` (UNION positionnel) → `intitule = 0`, `numero = ' '` · tests :
  T03 · sources : [Listextcpt.class:107](../../../../../.src/Compta/Utils/Listextcpt.class#L107)
- [ ] LISTEXTCPT-A03 — [anomalie] Alias `$dtei = $brn[0].dteinf` puis `$dtei.L = dtei` : la borne
  de l'exercice le plus ancien est modifiée, ce qui élargit `ctrl`, `rechechelot`, `rechedoc`,
  `totalpointe` (à confirmer) ; copier l'objet (`New LDate`) · tests : T04 · sources : [Listextcpt.class:76](../../../../../.src/Compta/Utils/Listextcpt.class#L76), [Listextcpt.class:87](../../../../../.src/Compta/Utils/Listextcpt.class#L87)
- [ ] LISTEXTCPT-A04 — [anomalie] `enregistrepointage` et `letgroupe` mettent à jour toutes les
  tables d'exercice sans borne de date : un même `numero`/`numlot` réutilisé dans un autre
  exercice du même compte est aussi modifié (à confirmer selon la renumérotation à la clôture) ·
  tests : T07, T10 · sources : [Listextcpt.class:enregistrepointage](../../../../../.src/Compta/Utils/Listextcpt.class#L330-L346), [Listextcpt.class:letgroupe](../../../../../.src/Compta/Utils/Listextcpt.class#L210-L218)
- [ ] LISTEXTCPT-A05 — [anomalie] `cherche` sans lecture préalable de `resext`, ou sur un
  extrait vide : erreur d'exécution ; `litleres` renvoie `Null` implicitement · tests : T05, T11 · sources : [Listextcpt.class:cherche](../../../../../.src/Compta/Utils/Listextcpt.class#L162-L186), [Listextcpt.class:litleres](../../../../../.src/Compta/Utils/Listextcpt.class#L149-L160)
- [ ] LISTEXTCPT-A06 — [anomalie] SQLite : `UNION (SELECT …)` entre parenthèses (exercices
  suivants) n'est pas accepté par SQLite (à confirmer) ; extrait sur deux exercices en échec ·
  tests : T12 · sources : [Listextcpt.class:127](../../../../../.src/Compta/Utils/Listextcpt.class#L127)
- [ ] LISTEXTCPT-A07 — [anomalie, sécurité] `totalpointe`/`enregistrepointage` concatènent la
  liste `selected` dans `IN (…)` et `rechedoc` concatène l'opérateur `egal` ; valeurs internes
  aujourd'hui (numéros de la grille), à paramétrer · tests : T09, T10 · sources : [Listextcpt.class:totalpointe](../../../../../.src/Compta/Utils/Listextcpt.class#L308-L328), [Listextcpt.class:enregistrepointage](../../../../../.src/Compta/Utils/Listextcpt.class#L330-L346), [Listextcpt.class:rechedoc](../../../../../.src/Compta/Utils/Listextcpt.class#L287-L305)
