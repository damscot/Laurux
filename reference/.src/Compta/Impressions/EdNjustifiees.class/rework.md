# EdNjustifiees — Rework

> Source : `.src/Compta/Impressions/EdNjustifiees.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/EdNjustifiees.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 249 |
| Lignes de commentaire | 58 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 47 |
| Complexité max (fonction) | 16 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 249 | 47 | 16 | 0 | 14 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDNJUSTIFIEES-001 — [documentation] En-tête en français (définition d'un compte « non
  justifié », périmètre `Fiches_Mvt` seul, contrat `Bsel`/`Bval` avec `TriCpt`) ; commentaires
  `'''` · appelants : aucun · tests : aucun · sources : [EdNjustifiees.class:20-26](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L20-L26), [EdNjustifiees.class:Button1_Click](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L235-L359)
- [ ] EDNJUSTIFIEES-002 — [code mort] Supprimer `Tab1` (`Ctrln`), `Tab`, `req`, `Coulfond` et
  `Utils.Coulfd`, les cumuls `totdeb`/`totcred`/`totsld` jamais imprimés, `p` et le `Shell "cd"` ·
  appelants : aucun · tests : T01, T07 · sources : [EdNjustifiees.class:248-253](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L248-L253), [EdNjustifiees.class:269](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L269), [EdNjustifiees.class:302-304](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L302-L304)
- [ ] EDNJUSTIFIEES-003 — [complexité] Helper `SautPage()` pour les quatre blocs `PosY >= 280` ;
  une seule requête de comptes (jointure et `TypeClient1.where` conditionnels, `Fiches_Societes` et
  `Fiches_Cli` par `Cbase.Table`) · appelants : aucun · tests : T01-T03, T07 · sources : [EdNjustifiees.class:251](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L251), [EdNjustifiees.class:266-270](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L266-L270), [EdNjustifiees.class:Button1_Click](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L235-L359)
- [ ] EDNJUSTIFIEES-004 — [réduction de portée] `Raz`, `Button3_Click` (aucun contrôle `Button3`)
  → `Private` ; `Bsel`/`Bval` restent `Public` · appelants : aucun · tests : T01 · sources : [EdNjustifiees.class:Raz](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L160-L170), [EdNjustifiees.class:Button3_Click](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L364-L368)
- [ ] EDNJUSTIFIEES-005 — [séparation traitement/GUI] `Compte_Non_Justifie(sCompte,
  fSoldeMemorise)` : requête, somme et comparaison formatée sans contrôle ; `Button1_Click` ne fait
  que le rendu · appelants : aucun · tests : T01, T06, T08 · sources : [EdNjustifiees.class:276-286](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L276-L286)
- [ ] EDNJUSTIFIEES-006 — [commonalisation] (transverse) Socle commun des éditions (EDITCOMPTE-006)
  et sélection de plage de comptes partagée avec `EdNlettrees` (EDNLETTREES-007) · appelants :
  aucun · tests : T01-T03, EDNLETTREES-T02-T04 · sources : [EdNjustifiees.class:Bclient_Click](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L175-L184), [EdNjustifiees.class:ToggleButton1_Click](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L203-L214), [EdNlettrees.class:Bclient_Click](../../../../../.src/Compta/Impressions/EdNlettrees.class#L263-L272)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDNJUSTIFIEES-A01 — [anomalie] F2 dans `Cpt`/`Cpt2` ne fait rien : `Cmpt_KeyPress` teste
  les tags 3/4 (copiés d'`EdNlettrees`) alors que les champs portent les tags 1/2 · tests : T05 ·
  sources : [EdNjustifiees.class:95-105](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L95-L105)
- [ ] EDNJUSTIFIEES-A02 — [anomalie] Seule `Fiches_Mvt` est lue alors que le solde mémorisé peut
  inclure des reports ; un compte en écart est imprimé sans total (seul le solde mémorisé de
  l'en-tête de compte permet la comparaison) ; PDF au même nom que l'édition des non lettrées ;
  PDF vide sans message si tout est justifié · tests : T01, T04 · sources : [EdNjustifiees.class:254](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L254), [EdNjustifiees.class:276](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L276), [EdNjustifiees.class:295](../../../../../.src/Compta/Impressions/EdNjustifiees.class#L295)
