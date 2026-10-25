# EdPrep — Synthèse

> Source : `.src/Gestion/Impressions/EdPrep.class` · Synthèse des autres documents.

## Rôle

Écran de **préparation des livraisons** : liste des commandes clients en cours
(`~/tmp/ListeDocs.pdf`), bons de préparation par commande imprimés directement
(`~/tmp/Liste2Docs.pdf`, `Impression.Facture`) et export CSV d'expédition (véhicules, reliquats).

## Points clés

- `Button1_Click` (CC 43, 264 lignes) : deux éditions complètes dans un handler.
- Cascade d'adresses de livraison `Fiches_AdrlivC` → `Fiches_AdrlivBL`, recopiée deux fois.
- Données véhicule relues dans un commentaire `XX` par découpage de texte.
- `Frmt`, `Coulfond`, `TypeD` morts ; ≈ 118 lignes communes avec `EdDocs`.

## Dépendances principales

- Appelé par `Fmenu` (`Menu325`). Utilise `Cdocuments`, `Cdocuments3`, `Impression.Facture`,
  `Editeur.Prog_Editeur`, `Visualiseur`.
- Lit `Fiches_Bl`, `Fiches_Cli`, `Fiches_Ligbl`, `Fiches_Art`, `Fiches_Four`, adresses de livraison.

## Risques

- **EDPREP-A01** : ville/code postal de facturation imprimés dans l'adresse de livraison des bons.
- EDPREP-A02 : en-têtes de pages suivantes incohérents ; A03 : fichier CSV non fermé.
- Impression papier directe : tests à neutraliser par `/CmdImp`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 350 |
| Lignes de commentaire | 25 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 70 |
| Complexité max (fonction) | 43 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `replay` (EDPREP-T01 à T07) : avec et sans détail, adresse de livraison (A01 figée), tris,
sauts de page (A02), export expédition, absence de commande.

## Rework

7 étapes (EDPREP-001 à 007) : documentation, code mort, portée, découpage, SQL simplifié et `Cbase`,
séparation, liste commune avec `EdDocs`. 3 anomalies (EDPREP-A01 à A03).
