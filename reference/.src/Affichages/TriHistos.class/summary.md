# TriHistos — Synthèse

> Source : `.src/Affichages/TriHistos.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Historique des **ventes** ou des **achats** d'un article sur 1 à 5 ans, ouvert depuis la fiche
article (`Articles`). En ventes, construit la table de travail `Fiches_Stat` (BL en cours, factures
archivées, sorties exceptionnelles) puis l'affiche ; en achats, lit les réceptions et entrées
exceptionnelles. Un clic ouvre le détail du document dans un panneau intégré.

## Points clés

- `DROP`/`CREATE TABLE Fiches_Stat` à chaque ouverture en ventes (table permanente partagée).
- Requêtes N+1 (une lecture d'en-tête par ligne de document).
- Détail de document dupliqué avec `AFacture` et `ACom`.
- 8 handlers d'en-tête quasi identiques ; nombreuses variables mortes.
- Pas de `Utils.Observers(Me)` ; `Colrcp2`/`Colrcp3` sans `_Click` (`replay_missing`).

## Dépendances principales

- Appelant unique : `Articles.Btn_click` (`Articles.class:1450`, `1456`).
- Tables : `Fiches_Ligbl`, `Fiches_Bl`, `Fiches_HistoLigfac`, `Fiches_HistoFac`, `Fiches_Mvtexp`,
  `Fiches_Ligrecpt`, `Fiches_Four`, `Fiches_Cli`, `Fiches_Art`, `Fiches_Stat` (travail).
- Utilise `Utils` (`db`, `CDec`, `Cdate_Aff`, `cpoint`), `Cbase`, `Start.Caisse`.

## Risques

- **A01** : `Four = Four` → historique des achats incomplet (référence fournisseur ignorée).
- **A02** : fournisseur supprimé → erreur à l'affichage.
- **A04** : `Fiches_Stat` partagée entre postes (collision).
- A03 (dates compactes sous SQLite, à confirmer), A05 (quantité non formatée dans le détail).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 601 |
| Lignes de commentaire | 24 |
| Fonctions | 26 |
| Fonctions Public | 26 |
| Complexité cyclomatique totale | 147 |
| Complexité max (fonction) | 29 (`DocVentes`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests : 5 `replay` depuis `Articles` (ventes, période et tri, détail vente, achats, détail achat et
fournisseur supprimé), conditionnés à l'instrumentation de l'écran, et 1 `gbtest` sur
`ConstruireStatVentes` (MySQL et SQLite). Horloge fixée (faketime) ; jeu dérivé `histo_article`.

## Rework

7 étapes (TRIHISTOS-001 à 007) : documentation, code mort, aide de tri, suppression des requêtes N+1
(dump identique à vérifier), réduction de portée de 7 fonctions, détail de document commun avec
`AFacture`/`ACom` (`DetailDocument`), séparation de la construction de `Fiches_Stat`. 5 anomalies.
