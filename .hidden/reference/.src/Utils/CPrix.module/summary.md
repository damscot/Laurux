# CPrix — Synthèse

> Source : `.src/Utils/CPrix.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Helpers de prix historiques : remise en cascade sur un prix d'achat (`Cascade`) et taux de TVA de
vente d'un code (`CTva`).

## Points clés

- `Cascade` : 15 appels (`Impart`, `MajTarifM`, `Articles`), calcul sur chaînes avec `Val` localisé.
- `CTva` : 5 appels (`Facture`, `MajTarifM`, `Articles`, `ConsultArt`), SQL paramétré sur
  `Fiches_Tvaav`.
- Recouvre partiellement `LPrix`/`LTaxe`.

## Dépendances principales

- `Utils.db`, `Utils.cpoint`, `Cbase`.

## Risques

- Dépendance à la locale (`Val`, conversion implicite Float → String).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 15 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 3 (`Cascade`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `gbtest` (CPRIX-T01, T02), sous deux locales et sur `Laurux01.sql`.

## Rework

2 étapes (CPRIX-001, 002) : documentation et explicitation des conversions. Aucune anomalie.
