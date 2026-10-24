# Expcontact — Synthèse

> Source : `.src/Utils/Exports-Imports/Expcontact.class` · Synthèse des autres documents.

## Rôle

Export des clients (avec leurs contacts `Fiches_ContactC`) ou des fournisseurs au format vCard 3.0
dans `~/Contacts.vcf`.

## Points clés

- Tout le traitement dans `Button1_Click` ; deux lignes `Print` de vCard quasi identiques.
- `Aff_Statut` exécute une requête par client pour un libellé jamais exporté.
- Chemin de sortie fixe, aucun échappement vCard.

## Dépendances principales

- Ouverte par `Fmenu.Menu283_Click` et `Prgm` (non vu par deps.py).
- Tables : `Fiches_Cli`, `Fiches_Four` (en dur), `Fiches_ContactC`, `Fiches_Statut` (`Cbase.Table`).

## Risques

- Erreur d'exécution si la table exportée est vide (fichier non ouvert).
- Téléphone domicile des contacts faux (valeur du dernier client).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 117 |
| Lignes de commentaire | 4 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 9 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 replays (EXPCONTACT-T01 à T04) comparant le fichier `.vcf` produit.

## Rework

6 étapes (documentation, portée, factorisation de la vCard, code mort, séparation traitement/GUI,
`Cbase.Table`) et 4 anomalies (A01 à A04).
