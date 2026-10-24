# FPostes — Synthèse

> Source : `.src/Compta/Tables/FPostes.class` · Synthèse des autres documents.

## Rôle

Écran de la table des postes analytiques (`Fiches_Postes`), utilisés par la répartition analytique
des comptes et les écritures analytiques.

## Points clés

- Copie de FCollectif (en-tête erroné), SQL paramétré via `Cbase.Table("TabPostes")`.
- Pas de contrôle d'usage à la suppression ; pas d'unicité du code.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.SetEditColor`, `Cbase`, `Doc`.
- Utilisé par : `Fmenu.Menu294_Click` ; table lue par `FComptes`, `Analytique`, `JournauxA`.

## Risques

- A01 : suppression d'un poste utilisé ; A02 : code trop long, doublons.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 117 |
| Lignes de commentaire | 12 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 35 |
| Complexité max (fonction) | 7 (`Col_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 replays (création, modification, suppression, code long) avec diff de `Fiches_Postes` et
`Fiches_Analytiques`.

## Rework

3 étapes (001 à 003) : documentation, séparation, portée. 2 anomalies.
