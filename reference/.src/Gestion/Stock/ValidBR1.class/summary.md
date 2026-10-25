# ValidBR1 — Synthèse

> Source : `.src/Gestion/Stock/ValidBR1.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Validation des réceptions » (Gestion › Stock et `commande1`) : sélection de fournisseurs
et de bons de réception, validation seule (`validee = 2`) ou avec écriture comptable d'achat
(`validee = 1`, `EcrAuto`, journal `jrnal5`), édition des écritures et scan GED de la facture.
Remplace `ValidBR` depuis 2022.

## Points clés

- Deux `TriGen` (fournisseurs, BR) ; sélection gérée par `$selfo`/`$listbr`.
- `ValideSaisie` (CC 15) : met à jour la BR et construit l'écriture (achat par famille, TVA,
  consignes) via `VarEcr` et `ajouligne`.
- `Ecritures` est appelée par `commande1` sur l'auto-instance (formulaire jamais affiché).
- **Module complexe** : scénarios de test à valider par l'utilisateur avant la phase 2.

## Dépendances principales

- Appelé par `Fmenu.Menu232_Click`, `commande1` (`ShowModal`, `Ecritures`) ; ouvre `commande1`
  (dépendance circulaire).
- `TriGen`, `EcrAuto`, `VarEcr`, `LVar`, `LGed`, `Consigne`/`LPrix`/`LTaxe`, `ProgBar`,
  `Visualiseur`.

## Risques

- TVA liée à LTAXE-A01/LPRIX-A01 (correction conjointe obligatoire, A01).
- Montants HT/TTC inversés en GED (A02) ; double validation possible (A03) ; tags par SQL
  concaténé (A04) ; auto-instance cachée pour `Ecritures` (A05).
- Écran non instrumenté pour le rejeu (A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 459 |
| Lignes de commentaire | 4 |
| Fonctions | 19 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 85 |
| Complexité max (fonction) | 15 (`ValideSaisie`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests `replay` (VALIDBR1-T01 à T10, liste à valider) : validation seule et comptable,
désélection, filtres, double validation, consignes, compte inconnu, GED, appel depuis
`commande1`, ouverture d'une réception.

## Rework

7 étapes (VALIDBR1-001 à 007) : documentation, code mort, séparation du calcul de l'écriture,
helper commun `valide`/`Ecritures`, `Cbase.Table`, commonalisations `LVar` et `LGed`.
6 anomalies (A01 à A06) soumises à validation.
