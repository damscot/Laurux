# FCollectif — Synthèse

> Source : `.src/Compta/Tables/FCollectif.class` · Synthèse des autres documents.

## Rôle

Écran des comptes collectifs (`Fiches_Comptes` avec `coll = 1`) : création (préfixes 401, 411,
453), modification de l'intitulé, suppression contrôlée.

## Points clés

- Squelette « table code/intitulé » partagé avec FPostes, FLibelle, FJournaux.
- INSERT paramétré, mais UPDATE par concaténation qui remet le solde à zéro.
- Suppression contrôlée sur `Fiches_Mvt` seulement.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.SetEditColor`, `Doc` ; tables `Fiches_Comptes`, `Fiches_Mvt` (en dur).
- Utilisé par : `Fmenu.Menu111_Click`.

## Risques

- A01 : apostrophe → erreur SQL ; A02 : solde remis à zéro à chaque changement d'intitulé.
- A03 : suppression d'un compte non collectif ou mouvementé dans un exercice archivé.
- A04 : message incohérent sur le préfixe 456.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 172 |
| Lignes de commentaire | 25 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 43 |
| Complexité max (fonction) | 10 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 replays (création, préfixe refusé, modification, suppression, compte non collectif) avec diff de
`Fiches_Comptes`.

## Rework

4 étapes (001 à 004) : documentation, `Cbase.Table`, séparation traitement/GUI, réduction de
portée. 4 anomalies (A01 à A04).
