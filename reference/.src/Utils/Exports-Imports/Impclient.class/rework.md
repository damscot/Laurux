# Impclient — Rework

> Source : `.src/Utils/Exports-Imports/Impclient.class` · Message de commit (phase 4) : `reference/.src/Utils/Exports-Imports/Impclient.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 125 |
| Lignes de commentaire | 24 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 50 |
| Complexité max (fonction) | 40 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 125 | 50 | 40 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IMPCLIENT-001 — [documentation] En-tête en français : format attendu des 28 colonnes, tables
  écrites, règle de numérotation · appelants : aucun · tests : aucun · sources : [Impclient.class:Button2_Click](../../../../../.src/Utils/Exports-Imports/Impclient.class#L54-L152), [Impclient.class:Compteur](../../../../../.src/Utils/Exports-Imports/Impclient.class#L154-L170)
- [ ] IMPCLIENT-002 — [réduction de portée] `Compteur` → `Private` · appelants : aucun · tests : T04 · sources : [Impclient.class:Compteur](../../../../../.src/Utils/Exports-Imports/Impclient.class#L154-L170)
- [ ] IMPCLIENT-003 — [code mort] Supprimer les variables locales inutilisées `Key` et `x` ; typer
  explicitement les déclarations multiples (`Dim tvai, comm, … As String`) · appelants : aucun · tests : T01 · sources : [Impclient.class:65-79](../../../../../.src/Utils/Exports-Imports/Impclient.class#L65-L79)
- [ ] IMPCLIENT-004 — [complexité] Remplacer les 28 `Try x = Lig2[n]` par une boucle sur un tableau
  de champs **en conservant** la reprise des valeurs précédentes · appelants : aucun · tests : T01, T02 · sources : [Impclient.class:105-132](../../../../../.src/Utils/Exports-Imports/Impclient.class#L105-L132)
- [ ] IMPCLIENT-005 — [séparation traitement/GUI] Extraire `Importer(sChemin) As Integer` et
  `CollectifClient() As String` sans accès aux contrôles · appelants : aucun · tests : T01-T06 · sources : [Impclient.class:Button2_Click](../../../../../.src/Utils/Exports-Imports/Impclient.class#L54-L152)
- [ ] IMPCLIENT-006 — [commonalisation] `Svs_Click` et la lecture du fichier via le socle commun
  d'import/export (`ChoisirFichier`, `LireCsv`, `FinTraitement`) · appelants : aucun · tests : T01, T05 · sources : [Impclient.class:Svs_Click](../../../../../.src/Utils/Exports-Imports/Impclient.class#L38-L46), [Impclient.class:99-104](../../../../../.src/Utils/Exports-Imports/Impclient.class#L99-L104)
- [ ] IMPCLIENT-007 — [réarchitecture] Noms de tables via `Cbase.Table(...)` au lieu de
  `Fiches_Cli`/`Fiches_Comptes`/`Fiches_Parametres` en dur · appelants : aucun · tests : T01 · sources : [Impclient.class:81-83](../../../../../.src/Utils/Exports-Imports/Impclient.class#L81-L83)
- [ ] IMPCLIENT-008 — [commonalisation] Logique de `Compteur` dans un helper pur
  `ProchainCodeClient(sDernier) As String` partagé avec `ImpSage.Compteur` (`ImpSage.class:826`) et
  `Facture.class:1841-1847` ; résultat identique (y compris la conversion entière) · appelants :
  `ImpSage`, `Facture` (modification minimale) · tests : T04 + tests ImpSage/Facture concernés · sources : [Impclient.class:Compteur](../../../../../.src/Utils/Exports-Imports/Impclient.class#L154-L170), [ImpSage.class:Compteur](../../../../../.src/Compta/Utils/ImpSage.class#L823-L839), [Facture.class:1841-1847](../../../../../.src/Gestion/Facturation/Facture.class#L1841-L1847)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] IMPCLIENT-A01 — [anomalie] Code client déjà existant (l.133-140) : `Num` n'est pas incrémenté,
  toutes les lignes suivantes sont ignorées sans message · tests : T03 · sources : [Impclient.class:133-140](../../../../../.src/Utils/Exports-Imports/Impclient.class#L133-L140)
- [ ] IMPCLIENT-A02 — [anomalie] Champ absent (l.105-132) : la valeur de la ligne précédente est
  réutilisée · tests : T02 · sources : [Impclient.class:105-132](../../../../../.src/Utils/Exports-Imports/Impclient.class#L105-L132)
- [ ] IMPCLIENT-A03 — [anomalie] Fichier jamais fermé ; aucun contrôle d'existence du compte dans
  `Fiches_Comptes` avant `INSERT` ; pas de transaction (import partiel en cas d'erreur) · tests : T01 · sources : [Impclient.class:99](../../../../../.src/Utils/Exports-Imports/Impclient.class#L99), [Impclient.class:136](../../../../../.src/Utils/Exports-Imports/Impclient.class#L136)
- [ ] IMPCLIENT-A04 — [anomalie] Sans collectif `41*`, `cli_collectif` reçoit le dernier collectif
  lu (l.91-97) · tests : T06 · sources : [Impclient.class:91-97](../../../../../.src/Utils/Exports-Imports/Impclient.class#L91-L97)
