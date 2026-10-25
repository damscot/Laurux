# EdClient — Rework

> Source : `.src/Gestion/Impressions/EdClient.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/EdClient.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 338 |
| Lignes de commentaire | 18 |
| Fonctions | 17 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 78 |
| Complexité max (fonction) | 15 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 338 | 78 | 15 | 0 | 17 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDCLIENT-001 — [documentation] Corriger l'en-tête (`EdCli.class`), documenter les filtres,
  la variable `Org`, `Colcli_Click` à garder `Public` (rejeu dynamique) · appelants : aucun ·
  tests : aucun · sources : [EdClient.class:4](../../../../../.src/Gestion/Impressions/EdClient.class#L4), [EdClient.class:Colcli_Click](../../../../../.src/Gestion/Impressions/EdClient.class#L295-L341)
- [ ] EDCLIENT-002 — [code mort] Supprimer le `Case 1` inatteignable de `Btn_Click`, `dte`,
  `Nbpage`, `Shell "cd …"`, la ligne commentée · appelants : aucun · tests : T01-T06 · sources : [EdClient.class:215](../../../../../.src/Gestion/Impressions/EdClient.class#L215), [EdClient.class:363](../../../../../.src/Gestion/Impressions/EdClient.class#L363), [EdClient.class:366](../../../../../.src/Gestion/Impressions/EdClient.class#L366)
- [ ] EDCLIENT-003 — [réduction de portée] `Aff_Clients`, `Aff_Statuts`, `Aff_Types`,
  `Button2_Click` → `Private` (appels internes seulement ; `Button2` groupé dans `Btn`) ·
  appelants : aucun · tests : T01, T05 · sources : [EdClient.class:Aff_Clients](../../../../../.src/Gestion/Impressions/EdClient.class#L45-L80), [EdClient.class:Aff_Statuts](../../../../../.src/Gestion/Impressions/EdClient.class#L97-L131), [EdClient.class:Aff_Types](../../../../../.src/Gestion/Impressions/EdClient.class#L148-L183), [EdClient.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdClient.class#L343-L428)
- [ ] EDCLIENT-004 — [complexité] Fusion des trois `Aff_*` en `AfficheListe(sSql, sCode,
  sLibelle, iLargeur, hBouton)` (requêtes et affichage identiques ; `Cbase.Table("TabTypec")`, SQL
  identique) · appelants : aucun · tests : T05 · sources : [EdClient.class:Aff_Clients](../../../../../.src/Gestion/Impressions/EdClient.class#L45-L80), [EdClient.class:Aff_Statuts](../../../../../.src/Gestion/Impressions/EdClient.class#L97-L131), [EdClient.class:Aff_Types](../../../../../.src/Gestion/Impressions/EdClient.class#L148-L183)
- [ ] EDCLIENT-005 — [séparation traitement/GUI] `FiltreClients(…) As String` pure (texte SQL
  identique, A01/A02 comprises) et `ListeClients` ; le handler imprime · appelants : aucun · tests :
  T01-T04 · sources : [EdClient.class:384](../../../../../.src/Gestion/Impressions/EdClient.class#L384), [EdClient.class:389](../../../../../.src/Gestion/Impressions/EdClient.class#L389)
- [ ] EDCLIENT-006 — [commonalisation] Socle « plage de codes + listes » commun avec `EdFam`,
  `EdFour`, `EdDocs` (même commit qu'EDFAM-005) · appelants : aucun · tests : T01-T06 · sources : [EdClient.class:Aff_Clients](../../../../../.src/Gestion/Impressions/EdClient.class#L45-L80), [EdDocs.class:Aff_Clients](../../../../../.src/Gestion/Impressions/EdDocs.class#L276-L311)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDCLIENT-A01 — [anomalie] `req = " AND cli_reg = &7"` (au lieu de `&=`) : le choix d'un mode
  de règlement annule les filtres de codes, statuts et types · tests : T03 · sources : [EdClient.class:387](../../../../../.src/Gestion/Impressions/EdClient.class#L387)
- [ ] EDCLIENT-A02 — [anomalie] Tous les filtres vides → `SELECT … WHERE  ORDER BY …` (erreur SQL
  affichée par `DB_Connection`, aucun PDF) ; correction : `WHERE 1 = 1` ou absence de `WHERE` ·
  tests : T04 · sources : [EdClient.class:388](../../../../../.src/Gestion/Impressions/EdClient.class#L388), [EdClient.class:389](../../../../../.src/Gestion/Impressions/EdClient.class#L389)
- [ ] EDCLIENT-A03 — [anomalie] Saut de page : le titre des pages suivantes omet le mode de
  règlement affiché sur la première · tests : T06 · sources : [EdClient.class:374](../../../../../.src/Gestion/Impressions/EdClient.class#L374), [EdClient.class:411](../../../../../.src/Gestion/Impressions/EdClient.class#L411)
