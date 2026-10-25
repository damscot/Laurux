# Cbordereaux — Synthèse

> Source : `.src/Reports/Cbordereaux.class` · Synthèse des autres documents.

## Rôle

Gabarit PDF (`Inherits PdfWriter`) des **bordereaux de remise** (caisse, chèques) et de la
**liste des paiements clients**. Rendu pur ; le contenu (dont l'en-tête société) est composé par
les appelants.

## Points clés

- 16 méthodes, toutes utilisées par `Caisse/Bordereaux`, `Compta/Impressions/BordereauxC` ou
  `Gestion/Impressions/Edpaiement`.
- `Footer` surcharge le crochet `PdfWriter.Footer` (non appelé automatiquement) : seul
  `Edpaiement` l'appelle ; les bordereaux n'ont pas de pied de page.
- Doublons : `Footer` = pied de page standard, `EnteteP` = titre standard, `Entete` = `AddPage`,
  `_new` = 11 autres gabarits.

## Dépendances principales

- Utilise : `PdfWriter`, `Start.R/G/B`, `User.Name`, `Now`.
- Utilisé par : `Caisse/Bordereaux`, `Compta/Impressions/BordereauxC`, `Gestion/Impressions/Edpaiement`.

## Risques

- Logo absent ou de type non géré : erreur non interceptée (CBORDEREAUX-A01, à confirmer).
- Réactiver l'appel automatique de `Footer` dans `PdfWriter` changerait les trois documents.
- Encodage (€, accents) et alignement à droite des montants : défauts communs à tous les gabarits,
  documentés dans PDFWRITER-A01 et PDFWRITER-A02.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 97 |
| Lignes de commentaire | 12 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 16 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `gbtest` (bordereau de caisse, de chèques, paiements multi-pages, logo invalide) et 2
replays (`BordereauxC`, `Edpaiement`) ; normalisation par `check_output.py`.

## Rework

4 étapes (CBORDEREAUX-001 à 004) : documentation, code mort (`_free`, `PosY` d'`EnteteP` avec
`Edpaiement`), helper de ligne, dérivation de `PdfLaurux`. 1 anomalie (A01 logo) soumise à
validation.
