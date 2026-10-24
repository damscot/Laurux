# Impcpostaux — Synthèse

> Source : `.src/Utils/Exports-Imports/Impcpostaux.class` · Synthèse des autres documents.

## Rôle

Import des couples ville / code postal dans `Fiches_Cpostaux` depuis un fichier `ville;cp`, avec
complément à 5 chiffres et sans doublon.

## Points clés

- Découpage manuel par `InStr` des deux premiers champs.
- Une requête d'existence par ligne avant l'insertion.

## Dépendances principales

- `Fmenu.Menu284_Click`, `Prgm` (non vus par deps.py) ; `Utils.db`, `Cbase.Table("TabCpostaux")`.
- Duplique `Enrgcp.Ecp` (même SELECT + INSERT).

## Risques

- Lignes mal formées insérées avec des valeurs incohérentes ; fichier non fermé.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 54 |
| Lignes de commentaire | 1 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 10 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 replays (IMPCPOSTAUX-T01 à T04), diff de `Fiches_Cpostaux`.

## Rework

6 étapes (documentation, découpage, séparation traitement/GUI, socle commun, réutilisation de
`Enrgcp.Ecp`, code mort) et 3 anomalies (A01 à A03).
