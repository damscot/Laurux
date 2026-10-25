# Archives — Synthèse

> Source : `.src/Archivages/Archives.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Factures archivées » (`Fmenu.Menu72`, étiquette `lblArch`) : liste paginée, triable et
filtrable des factures émises (`Fiches_HistoFac`, et factures entretien `Fiches_HistoFacM` avec
l'option matériel), recherche dans les lignes (commentaire, code, libellé), détail d'une facture,
réimpression / envoi par `OptFac` → `ObjFacB` (mode `ObjFac.archive`) et suivi client (F12).

## Points clés

- 1 495 lignes, 70 fonctions toutes `Public`, CC max 35 (`Recup_ligbl`).
- 24 variantes de requêtes de liste construites par concaténation (`Deb2`/`Deb2b`/`Deb3`/`Deb3b`).
- Recherche dans les lignes par la table de travail `Blcom`, tantôt permanente, tantôt temporaire.
- Beaucoup d'état hérité inutile : 21 membres jamais utilisés, 18 écrits sans être relus, lectures
  SQL sans usage (devise, consignes/régie, `Utils.orientation`).
- Code mort confirmé : `Maj_Zones`, `Refresh` (masque `Control.Refresh`, jamais appelée).
- Instrumenté ; `Colbl_click` rejoué par `Object.Call` (reste `Public`) ; `Coldetail` sans handler
  de clic.

## Dépendances principales

- Appelé par `Fmenu` (2 points d'entrée, `ShowModal`) ; utilise `OptFac`/`ObjFacB`, `Suivi`,
  `Utils.Base`/`Utils.rs1`, `Variables.bRemise`, `Start.LocalSettings` ; données purgées par
  `RazHistoFac`.

## Risques

- `Blcom` partagée entre postes ou en échec au 2e appel (A01) ; pagination après filtre date (A02)
  et navigation suivante/précédente à bornes fixes (A03) ; filtre incohérent en mode « Toutes »
  (A04) ; client supprimé (A05) ; filtres non paramétrés (A06) ; ouverture impossible sous SQLite
  (A07, via DB_CONNECTION-A03) ; bouton d'aide inerte (A08) ; détail (A09) et choix du critère de
  recherche (A10) à confirmer.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1202 |
| Lignes de commentaire | 63 |
| Fonctions | 70 |
| Fonctions Public | 70 |
| Complexité cyclomatique totale | 307 |
| Complexité max (fonction) | 35 (`Recup_ligbl`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

15 tests `replay` (ARCHIVES-T01 à T15) : ouverture, modes, tri/filtre, filtre date, pagination,
détail normal et entretien, navigation, recherche dans les lignes, réimpression, suivi, client
supprimé, guillemet, SQLite, largeurs de colonnes. Jeu `factures_archives` partagé avec
`RazHistoFac`.

## Rework

12 étapes (ARCHIVES-001 à 012) : documentation, code mort (3), réduction de portée de 15 fonctions,
requêtes pures, découpage de `Recup_ligbl`, couleurs, largeurs de colonnes (`Utils.LitLargeurs`),
`PaginationListe`, factorisation des recherches, comptage SQL. 10 anomalies (A01 à A10).
