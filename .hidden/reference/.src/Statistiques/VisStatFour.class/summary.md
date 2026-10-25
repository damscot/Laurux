# VisStatFour — Synthèse

> Source : `.src/Statistiques/VisStatFour.class` · Synthèse des autres documents.

## Rôle

Visualisation et impression du CA fournisseurs (achats) calculé par `StatFour` : grille `Liste`
(code, nom, montant N, N-1, % N/N-1) et PDF `~/tmp/Statfour.pdf`.

## Points clés

- Lecture seule de `Total` ; tris par RadioButton (`Click`).
- **Non rejouable** : pas d'`Utils.Observers`.
- Code mort important : 5 méthodes `Level*` (ancienne impression `Draw`), boucle `Totl`,
  variables.
- % calculé sur la base N (différent de `VisStatTypCli`).

## Dépendances principales

- Ouvert par `StatFour.Traitement` ; `Chistoriques` (`Level1FO`, `level2FO`, `Level4FO`,
  `Level5FO`), `Visualiseur`, `Utils`.

## Risques

- **A01** : formule du % incohérente avec `VisStatTypCli`.
- **A02** : titre « CA clients » sur les pages suivantes du PDF.
- **A03** : pas de journalisation/rejeu.
- Données N-1 multipliées en amont (STATFOUR-A01).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 213 |
| Lignes de commentaire | 26 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 29 |
| Complexité max (fonction) | 8 (`Affichage`) |
| Variables globales | 0 |
| Variables Public | 6 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests : 3 scénarios (manuels tant que A03 n'est pas validée, `replay` ensuite) et 1 `gbtest`
sur la fonction extraite (prioritaire).

## Rework

5 étapes (VISSTATFOUR-001 à 005) : en-tête, code mort (`Level0`…`Level5`), portée, socle
`VisStat*`, séparation. 3 anomalies (A01 à A03).
