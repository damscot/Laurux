# Cetiquettes — Synthèse

> Source : `.src/Reports/Cetiquettes.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Gabarit PDF (`Inherits PdfWriter`) des étiquettes : chaque méthode imprime un élément
d'étiquette (texte, prix, code-barres EAN13, cadre) à une position absolue, avec un facteur
d'échelle `fontratio`. Utilisé par les 7 écrans d'étiquettes (articles, gondole, casiers,
promotions, réception, tarifs carburant, clients) et par les fiches client et fournisseur.

## Points clés

- 29 méthodes `Public`, toutes appelées ; complexité maximale 3 (`Barcode`).
- 14 méthodes de texte suivent le même schéma (police, taille × `fontratio`, cellule de 30 mm) ;
  `Code` ≡ `Intitule` et `Codec` ≡ `IntituleA`.
- Pas d'en-tête ni de pied de page ; le placement (`pos_Etiq`, 6 variantes) est dans les écrans.
- Formats de page A4 ou Dymo (`dymog`, `dymoc`) choisis au `New`.

## Dépendances principales

- Hérite de [PdfWriter](../PdfWriter.class/summary.md) (`EAN13`, `Rect`) ; `Start.R/G/B`,
  `Utils.cpoint`.
- Appelants : `Etiqart`, `Etigond`, `Etiqcasier`, `EtiqPromo`, `EtiqRecpt`, `Etiqfbtarif`,
  `Eticli`, `FClient`, `FFournisseur`.

## Risques

- **CETIQUETTES-A01** : dimensions du code-barres lues en chaîne (locale française obligatoire),
  hauteur tronquée à l'entier.
- `PdfWriter.EAN13` n'imprime rien hors 13 caractères et dessine les barres plusieurs fois
  (PDFWRITER-A06) ; prix soumis aux défauts d'encodage et d'alignement (PDFWRITER-A01, A02).
- Le socle `PlancheEtiquettes` (ETIQART-010) s'appuiera sur ce gabarit : garder ses noms publics.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 185 |
| Lignes de commentaire | 5 |
| Fonctions | 29 |
| Fonctions Public | 29 |
| Complexité cyclomatique totale | 33 |
| Complexité max (fonction) | 3 (`Barcode`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests : 5 `gbtest` par famille de méthodes (textes, textes composés, prix, code-barres,
cadres et formats) avec comparaison du flux PDF non compressé, 1 `replay` qui reprend les
scénarios des 9 écrans appelants.

## Rework

5 étapes (CETIQUETTES-001 à 005) : documentation, helpers `Texte` et `LibellePrix`, base commune
`PdfLaurux` (couleur, `NewPage`), extraction des calculs de `Barcode`. 1 anomalie (A01).
