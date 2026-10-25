# Cresultat — Synthèse

> Source : `.src/Reports/Cresultat.class` · Synthèse des autres documents.

## Rôle

Gabarit PDF (`Inherits PdfWriter`, A4 portrait) du **compte de résultat**, piloté par
`Compta/Impressions/RubImp.class` (`~/tmp/Resultat.pdf`) : rubriques, comptes et montants des
exercices N et N-1.

## Points clés

- 8 méthodes, toutes appelées : `Level0` (page et titre, sans bandeau), `Level3` (en-têtes),
  `Level1` (rubrique), `Level7` (synthèse), `Level2` (compte), `BasPage`.
- Formatage `Try Format$(Val(x), ",#")` sans `Utils.cpoint` dans `Level1`/`Level7` ; `Level2`
  imprime les montants tels quels.
- Le paramètre `p5` est imprimé deux fois par `Level1` mais n'est jamais affecté par `RubImp`
  (toujours vide).

## Dépendances principales

- Utilise : `PdfWriter`, `Start.R/G/B`, `User.Name`, `Now`.
- Utilisé par : `Compta/Impressions/RubImp.class` uniquement.

## Risques

- Défauts communs à tous les gabarits, hérités de `PdfWriter` : encodage (€ → ¤, accents perdus,
  PDFWRITER-A01) et largeur de texte fausse qui décale les montants alignés à droite
  (PDFWRITER-A02).
- Montant décimal au point imprimé brut (anomalie latente CRESULTAT-A01, même défaut que
  CSIG-A01).
- Rendu dépendant de la locale.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 66 |
| Lignes de commentaire | 5 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 12 |
| Complexité max (fonction) | 3 (`Level1`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `gbtest` (niveaux et formatage, multi-pages) et 1 replay du compte de résultat sur le jeu
comptable dérivé ; comparaison `pdftotext` en `fr_FR.UTF-8`.

## Rework

4 étapes (CRESULTAT-001 à 004) : documentation, helper de formatage, suppression des paramètres
inutiles (`detail`, `p5`, avec `RubImp`) et de `_free`, dérivation de `PdfLaurux`. 1 anomalie
latente (A01) soumise à validation.
