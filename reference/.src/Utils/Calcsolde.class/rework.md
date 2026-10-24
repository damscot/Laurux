# Calcsolde — Rework

> Source : `.src/Utils/Calcsolde.class` · Message de commit (phase 4) : `reference/.src/Utils/Calcsolde.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 70 |
| Lignes de commentaire | 31 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 20 |
| Complexité max (fonction) | 8 (`Calcul`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 70 | 20 | 8 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CALCSOLDE-001 — [documentation] En-tête : définition de `solde` et `soldep`, rôle de `jdr`,
  appel statique depuis `Pointage` · appelants : aucun · tests : aucun · sources : [Calcsolde.class:Calcul](../../../../.src/Utils/Calcsolde.class#L97-L129)
- [ ] CALCSOLDE-002 — [code mort] Supprimer le paramètre `depart`/`$depart` de `_new` (aucun
  appelant ne le passe) et le `If IsNull(compt) Then Continue` (`compte_cc` NOT NULL) ;
  variables inutilisées `i` (`Button2_Click`) et `rrResult` (`Calcul`) · appelants : aucun · tests : T01-T06 · sources : [Calcsolde.class:_new](../../../../.src/Utils/Calcsolde.class#L29-L36), [Calcsolde.class:85](../../../../.src/Utils/Calcsolde.class#L85), [Calcsolde.class:Button2_Click](../../../../.src/Utils/Calcsolde.class#L68-L94)
- [ ] CALCSOLDE-003 — [séparation traitement/GUI] Extraire `RecalculeTout()` de `Button2_Click`
  (souris, message et fermeture restent dans le handler) · tests : T06 · sources : [Calcsolde.class:Button2_Click](../../../../.src/Utils/Calcsolde.class#L68-L94)
- [ ] CALCSOLDE-004 — [réarchitecture] `Calcul` en `Static Public` (n'utilise aucune donnée
  d'instance) pour éviter l'instanciation du formulaire par `Pointage` ; appel inchangé
  (`Calcsolde.Calcul(…)`) · appelants : `Pointage` (syntaxe identique) · tests : T01-T05, T07 · sources : [Calcsolde.class:Calcul](../../../../.src/Utils/Calcsolde.class#L97-L129), [Pointage.class:728](../../../../.src/Compta/Pointage.class#L728)
- [ ] CALCSOLDE-005 — [réarchitecture] `Cbase.Table("TabMvt")`, `Cbase.Table("TabComptes")`,
  `Cbase.Table("TabParam")` (mêmes noms physiques) · tests : T01-T07 · sources : [Calcsolde.class:Calcul](../../../../.src/Utils/Calcsolde.class#L97-L129), [Calcsolde.class:Button2_Click](../../../../.src/Utils/Calcsolde.class#L68-L94)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CALCSOLDE-A01 — [anomalie] `Pointage.class:728` appelle `Calcul(cpt, True)` sans le journal
  d'à-nouveaux : `soldep` n'est jamais recalculé après la suppression d'un relevé · tests : T04, T07 · sources : [Pointage.class:728](../../../../.src/Compta/Pointage.class#L728), [Calcsolde.class:116](../../../../.src/Utils/Calcsolde.class#L116)
- [ ] CALCSOLDE-A02 — [anomalie] `soldep` non remis à jour quand le compte n'a plus d'écriture
  validée (`solde` Null) · tests : T03 · sources : [Calcsolde.class:111-112](../../../../.src/Utils/Calcsolde.class#L111-L112)
