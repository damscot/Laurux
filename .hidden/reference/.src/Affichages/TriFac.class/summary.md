# TriFac — Synthèse

> Source : `.src/Affichages/TriFac.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Liste modale des **factures archivées** (`Fiches_HistoFac`) ouverte par `Facture.Creation(True)`
pour créer un avoir à partir d'une facture existante. L'utilisateur trie et filtre par les en-têtes
(`TextBox`), pagine, puis clique une facture : `Variables.Bsel` et `Variables.numeroFac` sont
renseignés et `Facture` charge la facture (`EntFac`).

## Points clés

- Grille `ColFac` en mode données (`ColFac_Data`, CC 19) alimentée par `Utils.Base2` → `Utils.rs2`.
- Quatre requêtes `Deb2`/`Deb2b`/`Deb3`/`Deb3b` construites par concaténation (filtre `LIKE`,
  colonne de tri, `LIMIT`) ; tri numérique `abs(lpad(…))` quand `Dat = 0`.
- 18 handlers d'en-tête quasi identiques (6 colonnes × clic, double-clic, frappe).
- Pagination manuelle (boutons, molette, flèches), dupliquée dans au moins 7 écrans.
- Pas de `Utils.Observers(Me)` : écran non journalisé, non rejouable en l'état.

## Dépendances principales

- Appelant unique : `Facture.Creation` (`Facture.class:12098`).
- Utilise : `Utils` (`Base2`, `rs2`, `Fcolr`, `cpoint`), `Variables` (`Bsel`, `numeroFac`), `Cbase`,
  `Start.LocalSettings` (couleurs).
- Forte parenté avec `TriFac2` (374 lignes communes sur 409).

## Risques

- **A01** : le double-clic n'inverse pas l'ordre et la pagination après double-clic change de
  filtre et d'ordre.
- **A04** : `Variables.Bsel` jamais remis à `False` à l'ouverture : fermer sans choisir recharge la
  facture choisie précédemment.
- **A03** : filtre concaténé dans le SQL (erreur sur `"`/`\`).
- A02 (état de tri incohérent), A05 (prénom d'une autre ligne, à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 409 |
| Lignes de commentaire | 1 |
| Fonctions | 35 |
| Fonctions Public | 35 |
| Complexité cyclomatique totale | 127 |
| Complexité max (fonction) | 19 (`ColFac_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests : 4 `replay` depuis `Facture` (sélection pour avoir, tri/filtre, double-clic et pagination,
fermeture sans choix) et 1 `gbtest` sur la future fonction `RequeteFactures`. Les replays exigent
d'instrumenter l'écran (`Utils.Observers`) dans les deux clones : décision de phase 2. Jeu de données
dérivé `factures_base` (≥ 3 pages de factures).

## Rework

9 étapes (TRIFAC-001 à 009) : documentation, code mort, factorisation des requêtes et des handlers
d'en-tête, couleurs calculées une fois, réduction de portée de 8 fonctions, `PaginationListe`, socle
commun avec `TriFac2` (`RequeteFactures`), séparation du SQL. 5 anomalies (A01 à A05) soumises à
validation utilisateur.
