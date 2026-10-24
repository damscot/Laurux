# ConsultArt — Synthèse

> Source : `.src/Gestion/Tables/ConsultArt.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Consultation des articles » en lecture seule (ouvert par `Fmenu`, non modal) : grille
filtrable et triable des articles, recherche incrémentale par frappe dans les en-têtes, coloration
selon l'état de stock, fiche résumée de l'article cliqué (prix, TVA, écotaxe, stock, quantité en
commande fournisseur, remises quantitatives), recherche par code-barre.

## Points clés

- 983 lignes, 49 fonctions toutes `Public`, CC max 37 (`Colarts_Data`).
- Copie ancienne et simplifiée d'`Articles` (14 fonctions homonymes, en-tête « Articles.class »).
- Requêtes de liste construites par concaténation (`Deb2`/`Deb3`/`Deb4`, quasi identiques) et
  affichées via `Utils.Base` / `Utils.rs1`.
- Aucune écriture en base ; tables de la fiche en dur.
- Code mort : `Ref`, `art_man`, `Decimal`, `FamMan` ; 6 variables écrites jamais lues.

## Dépendances principales

- Utilise : `Utils` (`Base`, `rs1`, `FColr`, `Observers`, `Find_cbarre`, `CDec`…), `Cbase`,
  `CPrix.CTva`, `Start.LocalSettings` (couleurs `/Coul/*`).
- Utilisé par : `Fmenu` (seul appelant).

## Risques

- **CONSULTART-A01** : recherche concaténée (un `"` casse la requête, jokers interprétés).
- **A02** : recherche par code-barre qui cumule la quantité en commande de l'article précédent.
- **A03** : colonne famille vide en tri descendant des suspendus.
- **A04** : message « famille inexistante » quand c'est le code TVA qui manque.
- **A05** : grille dépendante du résultat global `Utils.rs1`, partagé avec les autres écrans.
- Coloration dépendante de l'ordre d'appel de l'événement `Data` (à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 771 |
| Lignes de commentaire | 42 |
| Fonctions | 49 |
| Fonctions Public | 49 |
| Complexité cyclomatique totale | 200 |
| Complexité max (fonction) | 37 (`Colarts_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests prévus : 6 `replay` (ouverture, filtres et tris, fiche résumée, code-barre, recherche par
frappe, grille et état global) comparant le texte SQL du log et l'affichage (dump inchangé), et
1 `gbtest` sur la fonction pure de construction de la requête (CONSULTART-T07).

## Rework

9 étapes sans changement de comportement (CONSULTART-001 à 009) : documentation, code mort,
`Cbase.Table`, fusion des trois requêtes de liste (texte SQL identique), couleurs lues une fois,
requête en double de `Rb_Click`, helpers d'en-tête, grille de remises commune avec `Articles`,
réduction de portée. 5 anomalies (A01 à A05) soumises à validation.
