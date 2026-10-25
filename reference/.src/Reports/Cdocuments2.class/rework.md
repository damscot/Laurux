# Cdocuments2 — Rework

> Source : `.src/Reports/Cdocuments2.class` · Message de commit (phase 4) : `reference/.src/Reports/Cdocuments2.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 926 |
| Lignes de commentaire | 58 |
| Fonctions | 59 |
| Fonctions Public | 59 |
| Complexité cyclomatique totale | 182 |
| Complexité max (fonction) | 31 (`Level10F`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 926 | 182 | 31 | 0 | 59 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CDOCUMENTS2-001 — [code mort] Supprimer la classe `Cdocuments2` (jamais instanciée depuis
  `a2e027f1`, aucun `.form`) : ses 59 méthodes (`EnteteN`, `EnteteP`, `Lines`, `LinesP`,
  `Entete`, `Entete2`, `Logo`, `Logo2`, `Level1`… `Level16F`, `Colonnes`, `Signature`,
  `SignatureD`, `SignatureD2`, `Level1br`… `Level5RL`, `BasPage`, `BasPageP`) ; supprimer dans le
  même commit la déclaration inutilisée `Private pdf2 As Cdocuments2` de `Facture.class:200`
  (seule modification du fichier legacy) · appelants : `Facture` (déclaration seule) · tests : T01, T02 · sources : [Cdocuments2.class:_new](../../../../.src/Reports/Cdocuments2.class#L9-L15), [Cdocuments2.class:Entete](../../../../.src/Reports/Cdocuments2.class#L61-L181), [Cdocuments2.class:Level10F](../../../../.src/Reports/Cdocuments2.class#L747-L824), [Cdocuments2.class:SignatureD2](../../../../.src/Reports/Cdocuments2.class#L976-L987), [Facture.class:200](../../../../.src/Gestion/Facturation/Facture.class#L200)

### Anomalies : changement de comportement, validation utilisateur requise

Aucune : la classe n'est jamais exécutée. Les défauts de la copie de droite d'`Entete`
(`ville` au lieu de `cap` ligne 107, `mail` au lieu de `iban` ligne 176) sont sans effet et
disparaissent avec CDOCUMENTS2-001.
