# Creleve — Synthèse

> Source : `.src/Reports/Creleve.class` · Synthèse des autres documents.

## Rôle

Gabarit PDF (`Inherits PdfWriter`, A4 portrait) des **relevés de compte / de factures** et des
**lettres de relance** clients : cadre société avec logo, cadre destinataire, tableau d'écritures,
totaux et texte libre. Aucun accès à la base : les quatre écrans de `Compta/Relances` lui passent
tout en paramètre.

## Points clés

- 16 méthodes : `Entete` (17 paramètres, CC 12, crée la page), `Entete2`, `Logo`, niveaux de
  relevé (`Level1`-`Level4`, `Level9`) et de relance (`Level5`-`Level8`).
- `Creleve.EnteteSociete` **n'existe pas** : c'est la proposition LIGCLI-004. Le bloc de lecture
  société (17 lignes) est recopié dans 6 fichiers (4 relances + `Facturergbl`, `RelvMo` via
  `Cdocuments`), tous avec `WHERE cd_sc = &1` (pas de défaut multi-sociétés dans ces copies).
  Proposition : une lecture commune (Collection) + `Creleve.EnteteSociete(hSoc)`.
- Code mort : `EnteteN`, `_free`, `Coln` ; paramètres ignorés `Pays`, `Col`, `Jour`.
- `Logo` identique à `Clivre.Logo`, voisin de `Cfacture.Logo`.

## Dépendances principales

- Utilise : `PdfWriter`, `Start.R/G/B`, `Start.LocalSettings` (logo), `Start.Societe`.
- Utilisé par : `FEditrel`, `Ligcli`, `FRelCompte`, `FRelFacture` (`Compta/Relances`).

## Risques

- Défauts communs à tous les gabarits, hérités de `PdfWriter` : encodage (€ → ¤, accents perdus,
  PDFWRITER-A01) et largeur de texte fausse qui décale les montants alignés à droite
  (PDFWRITER-A02).
- Texte de relance en `MultiCell` de 294 mm sur une page de 210 mm (CRELEVE-A01, à confirmer).
- Division par zéro hors `Try` pour un logo de moins de 10 pixels de large (CRELEVE-A02, vérifié
  avec gbs3).
- La commonalisation de l'en-tête société touche 4 à 6 fichiers dans un même commit.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 225 |
| Lignes de commentaire | 15 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 35 |
| Complexité max (fonction) | 12 (`Entete`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `gbtest` (en-têtes, logo, relevé multi-pages, lettre de relance) et 2 replays (relevé de
factures, relances) ; comparaison `pdftotext` et rendu raster pour le logo et le texte long.

## Rework

9 étapes (CRELEVE-001 à 009) : documentation, code mort, simplification d'`Entete`, `Logo` en
`Private`, suppression des paramètres inutiles (avec les 4 appelants), helpers de tableau, en-tête
société commun (LIGCLI-004), séparation de la lecture du logo, dérivation de `PdfLaurux`.
2 anomalies (A01 largeur du texte, A02 division par zéro) soumises à validation.
