# Edcom — Synthèse

> Source : `.src/Gestion/Impressions/Edcom.class` · Synthèse des autres documents.

## Rôle

Écran de **réimpression d'une commande fournisseur** (`~/tmp/Commande.pdf`, `Cdocuments`) choisie
dans la liste des commandes `Fiches_Entcom` ou saisie par son numéro.

## Points clés

- Cinq routines `Draw` mortes (`Level1`…`Level4`, `Level3bis`) ; `deps.py` n'en voit qu'une.
- Fichier `Edcom.kdf` ouvert et jamais fermé ; `Piece`, `Logo`, `Cfac` calculés sans usage.
- En-tête société recopié (candidat `Creleve.EnteteSociete`).
- Ni copie dans `~/Impressions`, ni GED (contrairement à `commande1`).

## Dépendances principales

- Appelé par `Fmenu` (`Menu92`). Utilise `Cdocuments`, `Visualiseur`.
- Lit `Fiches_Entcom`, `Fiches_Ligcom`, `Fiches_Four`, `Fiches_Societes`.

## Risques

- EDCOM-A01 : seule la sélection à la souris fonctionne (Entrée ou saisie → rien).
- EDCOM-A02 : la date imprimée est celle de la dernière commande listée.
- EDCOM-A03 : erreur si une commande n'a plus de fournisseur.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 279 |
| Lignes de commentaire | 45 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 49 |
| Complexité max (fonction) | 23 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `replay` (EDCOM-T01 à T06) : choix souris/clavier/saisie, réimpression, saut de page,
fournisseur absent.

## Rework

6 étapes (EDCOM-001 à 006) : documentation, deux lots de code mort, séparation et `Cbase`, en-tête
société commun, découpage de `Button2_Click`. 4 anomalies (EDCOM-A01 à A04).
