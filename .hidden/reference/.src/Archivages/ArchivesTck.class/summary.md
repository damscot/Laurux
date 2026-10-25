# ArchivesTck — Synthèse

> Source : `.src/Archivages/ArchivesTck.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Tickets archivés » (`Fmenu.Menu218`) : liste paginée, triable et filtrable des tickets de
caisse moulinés (`Fiches_HisEntTickets`), détail des lignes (`Fiches_HisLigTickets`) et réimpression
A4 en PDF (`Htickets`).

## Points clés

- Zones d'en-tête à triple rôle : prise de focus = tri, frappe = filtre `LIKE`, double-clic =
  inversion ; requêtes construites par concaténation.
- Réimpression (`Button4_Click`, CC 46) avec cumul de TVA dans la table permanente `Tottva`,
  partagée avec la caisse.
- Code mort confirmé : `cpoint` (copie de `Utils.cpoint`) et `Refresh` (masque `Control.Refresh`,
  jamais appelée) ; traces `Print`.
- Instrumenté (`Utils.Observers`) ; `Coltk_Click` rejoué par `Object.Call` (reste `Public`) ; `Detk`
  sans handler de clic.

## Dépendances principales

- Appelé par `Fmenu.Menu218_Click` ; données produites par `Moulinage`, purgées par `RazHistoTk` ;
  utilise `Htickets`, `Visualiseur`, `LDate.DateFilterDB`, `Utils.cpoint`.

## Risques

- TVA par taux fausse sur les tickets réimprimés multi-taux (A01, A02, A03).
- Interférence avec la caisse via `Tottva` (A04).
- « Caisse n° » tiré du numéro de ticket (A05, à confirmer) ; filtre non paramétré (A06) ; bouton
  d'aide inerte (A07) ; numéros en doublon (A08).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 557 |
| Lignes de commentaire | 4 |
| Fonctions | 42 |
| Fonctions Public | 42 |
| Complexité cyclomatique totale | 157 |
| Complexité max (fonction) | 46 (`Button4_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests `replay` (ARCHIVESTCK-T01 à T10) : ouverture, tri/filtre, filtre date, pagination, détail,
réimpression mono et multi-taux (PDF + `Tottva`), totaux `BC`/`BH` et ticket supprimé, guillemet,
doublon. Jeu `tickets_archives` partagé avec `RazHistoTk`.

## Rework

8 étapes (ARCHIVESTCK-001 à 008) : documentation, code mort (2), réduction de portée de 10
fonctions, factorisation des handlers d'en-tête, séparation SQL/GUI, découpage de `Button4_Click`,
`PaginationListe`. 8 anomalies (A01 à A08).
