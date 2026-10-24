# Echeances — Rework

> Source : `.src/Compta/Echeances.class` · Message de commit (phase 4) : `reference/.src/Compta/Echeances.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 220 |
| Lignes de commentaire | 68 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 57 |
| Complexité max (fonction) | 18 (`ech_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 220 | 57 | 18 | 0 | 16 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ECHEANCES-001 — [documentation] En-tête de classe en français : rôle (paramétrage de
  `Fiches_Echeances`), signification de `duree`/`jours`/`finmois`, lien avec `Utils.Calcech` ;
  commentaires `'''` sur les méthodes non-handlers · appelants : aucun · tests : T01-T08 · sources : [Echeances.class:_New](../../../../.src/Compta/Echeances.class#L32-L47), [Echeances.class:Button5_Click](../../../../.src/Compta/Echeances.class#L316-L333)
- [ ] ECHEANCES-002 — [code mort] Supprimer la fin sans effet de `Button5_Click` (calcul de
  `ye`/`mo`/`da` et `Try dateech = Date(dateech, …)` qui échoue toujours), les variables membres
  `ye`/`mo`/`da`, la branche `Case 6` d'`ech_KeyPress` (aucun tag 6) et la branche `Else` vide de
  `Button1_Click` · appelants : aucun · tests : T04, T05, T06 · sources : [Echeances.class:324-327](../../../../.src/Compta/Echeances.class#L324-L327), [Echeances.class:168-170](../../../../.src/Compta/Echeances.class#L168-L170), [Echeances.class:263-264](../../../../.src/Compta/Echeances.class#L263-L264)
- [ ] ECHEANCES-003 — [commonalisation] Remplacer `"Fiches_Echeances"` par `Cbase.Table("TabEch")`
  (4 occurrences, sans changement SQL) et retirer les `With Utils` à un seul appel · appelants :
  aucun · tests : T01-T04, T07 · sources : [Echeances.class:Form_Open](../../../../.src/Compta/Echeances.class#L52-L69), [Echeances.class:echman](../../../../.src/Compta/Echeances.class#L224-L239), [Echeances.class:Button1_Click](../../../../.src/Compta/Echeances.class#L244-L267), [Echeances.class:Button2_Click](../../../../.src/Compta/Echeances.class#L272-L295)
- [ ] ECHEANCES-004 — [séparation traitement/GUI] Extraire `Lit_Echeances()`, `Lit_Echeance(code)`,
  `Enregistre(code, libelle, duree, jours, finmois)` et `Supprime(code)` en `Private`, sans accès
  aux contrôles ; mêmes requêtes, même ordre · appelants : aucun · tests : T01-T04, T07 · sources : [Echeances.class:Form_Open](../../../../.src/Compta/Echeances.class#L52-L69), [Echeances.class:echman](../../../../.src/Compta/Echeances.class#L224-L239), [Echeances.class:Button1_Click](../../../../.src/Compta/Echeances.class#L244-L267), [Echeances.class:Button2_Click](../../../../.src/Compta/Echeances.class#L272-L295)
- [ ] ECHEANCES-005 — [commonalisation] Normalisation de date avec sentinelle `"00.00.0:00"` vers
  un helper commun partagé avec `Tresor.QuitteDate` (créé dans le rework de `Tresor` ou d'`Utils`)
  · appelants : aucun · tests : T05, T08 · sources : [Echeances.class:Quittedate](../../../../.src/Compta/Echeances.class#L300-L311), [Tresor.class:1292-1296](../../../../.src/Compta/Tresor.class#L1292-L1296)
- [ ] ECHEANCES-006 — [réduction de portée] `Maj_Zones`, `CleanChamps`, `Refresh`, `echman`,
  `Quittedate` → `Private` (aucun appelant externe ; couverture par replay) · appelants : aucun ·
  tests : T01-T08 · sources : [Echeances.class:Maj_Zones](../../../../.src/Compta/Echeances.class#L74-L86), [Echeances.class:CleanChamps](../../../../.src/Compta/Echeances.class#L91-L99), [Echeances.class:Refresh](../../../../.src/Compta/Echeances.class#L104-L109), [Echeances.class:echman](../../../../.src/Compta/Echeances.class#L224-L239), [Echeances.class:Quittedate](../../../../.src/Compta/Echeances.class#L300-L311)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ECHEANCES-A01 — [anomalie] Suppression d'une échéance sans contrôle d'usage par
  `Fiches_Cli`/`Fiches_Four` (les fiches gardent un code orphelin ; à confirmer côté métier) ·
  tests : T04 · sources : [Echeances.class:Button1_Click](../../../../.src/Compta/Echeances.class#L244-L267)
- [ ] ECHEANCES-A02 — [anomalie] `Button2_Click` vide les champs après une modification mais pas
  après une création (comportement incohérent) · tests : T02, T03 · sources : [Echeances.class:283-288](../../../../.src/Compta/Echeances.class#L283-L288)
- [ ] ECHEANCES-A03 — [anomalie] Message erroné « Veuillez saisir une date » pour un nombre de jours
  manquant (tag 4) · tests : T06 · sources : [Echeances.class:159-160](../../../../.src/Compta/Echeances.class#L159-L160)
- [ ] ECHEANCES-A04 — [anomalie] `Finm` relu sans conversion dans `echman` (`Finm.Value =
  rResult!finmois`) alors que `Maj_Zones` utilise `Utils.convBool` ; valeur Boolean stockée par
  `Subst` à vérifier (à confirmer) · tests : T02, T07 · sources : [Echeances.class:236](../../../../.src/Compta/Echeances.class#L236), [Echeances.class:82](../../../../.src/Compta/Echeances.class#L82)
