# Cbalances — Synthèse

> Source : `.src/Reports/Cbalances.class` · Synthèse des autres documents.

## Rôle

Gabarit PDF (`Inherits PdfWriter`) des **balances comptables** (avec ou sans cumul hors période)
et de l'**état de TVA**. Mise en page uniquement : l'appelant gère `PosY`, les sauts de page et la
sortie.

## Points clés

- 22 méthodes : communes (`Entete`, `BasPage`, `Level0`), balance (`Level1`…`Level4`,
  `Level1a`…`Level4a`), TVA (`Level0T`…`Level5T`).
- Petit calcul de solde débit − crédit (`Val(Utils.cpoint(…))`) dans `Level2a`, `Level3a`,
  `Level4a`.
- Code mort : `Level2s`, `Level2sbis` (ceux de `Ccompta` sont distincts), `_free`.
- Complexité superflue : `Level5T` (deux branches identiques, paramètres `totd`/`totc` ignorés),
  `Level3` (deux lignes écrasées).
- `Entete`, `BasPage`, `_new` identiques à d'autres gabarits ; `Level0` = `CLcr.Level0`.

## Dépendances principales

- Utilise : `PdfWriter`, `Start.R/G/B`, `Utils.cpoint`, `User.Name`, `Now`.
- Utilisé par : `Compta/Impressions/BalanceM.module`, `Compta/Impressions/FTVA.class`.

## Risques

- Défauts communs à tous les gabarits, hérités de `PdfWriter` : encodage (€ → ¤, accents perdus,
  PDFWRITER-A01) et largeur de texte fausse qui décale les montants alignés à droite
  (PDFWRITER-A02).
- Faibles : rendu pur. Les montants arrivent déjà formatés de `BalanceM`/`FTVA` ; un changement de
  format côté appelant se voit directement dans le PDF.
- Une fusion avec les niveaux voisins de `Ccompta` changerait des largeurs de colonnes : à éviter
  sans comparaison raster.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 263 |
| Lignes de commentaire | 26 |
| Fonctions | 22 |
| Fonctions Public | 22 |
| Complexité cyclomatique totale | 44 |
| Complexité max (fonction) | 5 (`Level2a`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `gbtest` (balance avec et sans cumul hors période, TVA, multi-pages) et 2 replays
(balance générale, état de TVA) sur le jeu comptable dérivé ; comparaison `pdftotext` avec date et
utilisateur normalisés.

## Rework

6 étapes (CBALANCES-001 à 006) : documentation, suppression du code mort et des lignes superflues,
extraction du calcul de solde, dérivation de `PdfLaurux`, suppression des paramètres inutilisés de
`Level5T` (appelant `FTVA`). Aucune anomalie.
