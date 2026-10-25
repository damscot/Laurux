# Cdocuments3 — Synthèse

> Source : `.src/Reports/Cdocuments3.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Gabarit PDF du **bon de préparation de commande** (A4 portrait, `Inherits PdfWriter`) : en-tête,
cadres client et livraison, colonnes, lignes d'articles avec cases « Reçue »/« Reliquat »,
commentaires, pied d'expédition et pied de page.

## Points clés

- Appelant unique : `EdPrep` (second PDF de l'écran, imprimé directement).
- 14 méthodes `Public`, sans SQL ni réglage ; `Entete` est la seule qui crée une page.
- Pas une variante de `Cdocuments` (ratio 0,08) malgré le nom ; `_new` et `BasPage` sont
  identiques à ceux de `Cdocuments`.
- Code mort : `Lines`, `Level3`, variable `Coln`.
- Arguments `Cell` atypiques (bordure `""`/`" "`, alignement `" L "`) sans effet sur le rendu.

## Dépendances principales

- Hérite de `PdfWriter` ; lit `Start.R/G/B/R2/G2/B2`, `User.Name`, `Now`.
- Utilisé par `EdPrep` (`EdPrep.class:184-305`).

## Risques

- **CDOCUMENTS3-A01** (à confirmer) : le saut de page dans les commentaires d'`EdPrep` (ligne
  267) n'appelle pas `Entete` : en-tête et lignes réimprimés par-dessus la page courante.
- PDFWRITER-A01/A02 (encodage, largeur de texte) touchent aussi ce gabarit.
- Impression directe du PDF : les tests doivent rediriger la sortie vers un fichier.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 159 |
| Lignes de commentaire | 9 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 17 |
| Complexité max (fonction) | 2 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests (CDOCUMENTS3-T01 à T03) : un `gbtest` du gabarit complet, deux `replay` d'`EdPrep`
(bons multi-pages, saut de page dans les commentaires), comparaison `pdftotext` (+ `-bbox`,
`pdfinfo`), valeurs produites dans le clone non modifié.

## Rework

5 étapes (CDOCUMENTS3-001 à 005) : documentation, suppression de `Lines`/`Level3`/`Coln`,
héritage du socle PDF commun (avec `Cdocuments`), méthode `EntetePage` pour `EdPrep`,
simplification d'`adresse`/`adresse2`. 1 anomalie (A01).
