# Plancomptable — Synthèse

> Source : `.src/Compta/Impressions/Plancomptable.class` · Synthèse des autres documents.

## Rôle

Écran « Impression du plan comptable » : liste en PDF (`Ccompta`, `~/tmp/Plan.pdf`) des comptes
d'un type (Clients, Fournisseurs, Gestion, Bilan) dans une plage de numéros, avec sélection des
bornes par `TriCpt`.

## Points clés

- Requête et mise en page PDF dans `Button2_Click`, appelé par le handler de groupe `Btn_Click`.
- `Bsel`/`Bval` publiques, écrites dynamiquement par `TriCpt` (faux positif de portée).
- Plages et types codés dans quatre handlers presque identiques.
- Variables mortes et `Shell "cd"` sans effet.

## Dépendances principales

- Utilise : `Ccompta`, `TriCpt`, `Visualiseur`, `Utils` (observateurs, `db`), `Start.Societe` ;
  tables `Fiches_Societes`, `Fiches_Comptes` en dur.
- Utilisé par : `Fmenu.Menu70_Click`.

## Risques

- Faibles (lecture seule). F2 remplit probablement le mauvais champ (A01).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 155 |
| Lignes de commentaire | 22 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 42 |
| Complexité max (fonction) | 8 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `replay` (PLANCOMPTABLE-T01 à T04) comparant le texte du PDF : impression par type,
plage personnalisée ou vide, sélection par `TriCpt`, suppression du PDF à la fermeture.

## Rework

4 étapes (PLANCOMPTABLE-001 à 004) : documentation, code mort, helpers de type et de sélection,
séparation requête/impression. 2 anomalies (A01, A02) soumises à validation.
