# Impclient — Synthèse

> Source : `.src/Utils/Exports-Imports/Impclient.class` · Synthèse des autres documents.

## Rôle

Fenêtre d'import de clients depuis un fichier `;` de 28 colonnes : création de la fiche client
(`Fiches_Cli`), du compte auxiliaire (`Fiches_Comptes`), du mail (`Mails_Cli`) et mise à jour du
dernier numéro client (`Fiches_Parametres.dnc`).

## Points clés

- Tout le traitement est dans le handler `Button2_Click` (GUI + SQL mêlés).
- Numérotation `411001…411999 → 4111000… → 41110000…` dans `Compteur`.
- Collectif client : premier compte collectif commençant par `41`.
- Tables en dur, sauf `Mails_Cli` ; pas de transaction.

## Dépendances principales

- Ouverte par `Fmenu.Menu152_Click` et `Prgm` (non détecté par deps.py).
- Utilise `Utils.db`, `Utils.Observers`, `Cbase.Table`, `Start.Son`/`Musique`.

## Risques

- Un code déjà existant bloque silencieusement tout le reste de l'import.
- Les lignes incomplètes héritent des valeurs de la ligne précédente.
- Fichier jamais fermé ; import partiel possible en cas d'erreur SQL.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 125 |
| Lignes de commentaire | 24 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 50 |
| Complexité max (fonction) | 40 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 replays (IMPCLIENT-T01 à T06) : import nominal, lignes courtes, code existant, bornes du
compteur, fichier absent, collectif absent. Comparaison par diff des 4 tables écrites.

## Rework

7 étapes sans changement de comportement (documentation, portée de `Compteur`, réduction de
complexité, séparation traitement/GUI, socle commun d'import/export, `Cbase.Table`) et
4 anomalies (A01 à A04) soumises à validation.
