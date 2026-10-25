# Csig — Synthèse

> Source : `.src/Reports/Csig.class` · Synthèse des autres documents.

## Rôle

Gabarit PDF (`Inherits PdfWriter`, A4 **paysage**) des **soldes intermédiaires de gestion**,
piloté par `Compta/Impressions/Imp_Sig.module` : trois colonnes Produits / Charges / S.I.G.

## Points clés

- 14 méthodes, dont 4 niveaux morts hérités de `Cbilan` (`Level1L`, `Level1A`, `Level1S`,
  `Level7`) qui portent l'essentiel de la complexité (CC 24 et 25).
- Niveaux vivants : `Level0` (page et titre), `Level3` (en-têtes), `Level1` (ligne produit/charge),
  `Level2` (totaux), `Lines`, `Lines2`, `Lines3` (filets), `BasPage` (290 mm).
- Formatage des montants `Try Format$(Val(x), ",#")` **sans** `Utils.cpoint`.

## Dépendances principales

- Utilise : `PdfWriter`, `User.Name`, `Now` (et `Utils.cpoint` dans le code mort).
- Utilisé par : `Compta/Impressions/Imp_Sig.module` uniquement.

## Risques

- Défauts communs à tous les gabarits, hérités de `PdfWriter` : encodage (€ → ¤, accents perdus,
  PDFWRITER-A01) et largeur de texte fausse qui décale les montants alignés à droite
  (PDFWRITER-A02).
- Un montant décimal au point est imprimé brut (non formaté) : anomalie latente CSIG-A01, à
  confirmer sur données réelles (les montants d'`Imp_Sig` sont en général arrondis à l'unité).
- Rendu dépendant de la locale (`Val` et `",#"` localisés).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 188 |
| Lignes de commentaire | 23 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 72 |
| Complexité max (fonction) | 25 (`Level1S`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests `gbtest` (en-têtes et filets, formatage des montants, multi-pages) et 1 replay des SIG sur
le jeu comptable dérivé ; comparaison `pdftotext` en `fr_FR.UTF-8`.

## Rework

5 étapes (CSIG-001 à 005) : documentation, suppression de 4 niveaux morts (−95 lignes), helper de
formatage, suppression du paramètre `detail` (avec `Imp_Sig`), dérivation de `PdfLaurux`.
1 anomalie latente (A01) soumise à validation.
