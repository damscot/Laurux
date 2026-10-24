# Expcontact — Rework

> Source : `.src/Utils/Exports-Imports/Expcontact.class` · Message de commit (phase 4) : `reference/.src/Utils/Exports-Imports/Expcontact.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 117 |
| Lignes de commentaire | 4 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 9 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 117 | 14 | 9 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EXPCONTACT-001 — [documentation] En-tête : format vCard produit, chemin de sortie, différences
  clients/fournisseurs · appelants : aucun · tests : aucun · sources : [Expcontact.class:Button1_Click](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L17-L125)
- [ ] EXPCONTACT-002 — [réduction de portée] `Aff_Statut` → `Private` · appelants : aucun · tests : T01 · sources : [Expcontact.class:Aff_Statut](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L127-L136)
- [ ] EXPCONTACT-003 — [commonalisation] Fonction privée `VCard(...) As String` utilisée par les deux
  boucles (sortie octet pour octet identique) · appelants : aucun · tests : T01, T02, T04 · sources : [Expcontact.class:89](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L89), [Expcontact.class:115](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L115)
- [ ] EXPCONTACT-004 — [code mort] Supprimer les variables lues et non exportées (`Pays`, `Fx`,
  `cpt`) et la ligne CSV commentée l.90 · appelants : aucun · tests : T01, T02 · sources : [Expcontact.class:59-60](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L59-L60), [Expcontact.class:65](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L65), [Expcontact.class:90](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L90)
- [ ] EXPCONTACT-005 — [séparation traitement/GUI] `ExporterContacts(bClients As Boolean, sFichier
  As String) As Integer` sans accès aux contrôles ; le handler garde messages et musique · appelants :
  aucun · tests : T01-T03 · sources : [Expcontact.class:Button1_Click](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L17-L125)
- [ ] EXPCONTACT-006 — [réarchitecture] `Cbase.Table` pour `Fiches_Cli`/`Fiches_Four` · tests : T01, T02 · sources : [Expcontact.class:40-44](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L40-L44)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] EXPCONTACT-A01 — [anomalie] Table vide : `Print`/`Close` sur un fichier non ouvert (erreur
  d'exécution) · tests : T03 · sources : [Expcontact.class:47-48](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L47-L48), [Expcontact.class:115](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L115), [Expcontact.class:122](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L122)
- [ ] EXPCONTACT-A02 — [anomalie] Contacts clients : `Teldom` hérité du dernier client, `Poste` et
  `Portable` = `tel` · tests : T01 · sources : [Expcontact.class:99-115](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L99-L115)
- [ ] EXPCONTACT-A03 — [anomalie] Valeurs non échappées selon la RFC vCard ; libellé de statut
  calculé mais jamais exporté (requête `Aff_Statut` inutile) · tests : T04 · sources : [Expcontact.class:89](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L89), [Expcontact.class:68](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L68), [Expcontact.class:Aff_Statut](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L127-L136)
- [ ] EXPCONTACT-A04 — [anomalie] Musique jouée sans tester `Start.Son` ni `Music.Load` · tests : aucun (manuel) · sources : [Expcontact.class:120](../../../../../.src/Utils/Exports-Imports/Expcontact.class#L120)
