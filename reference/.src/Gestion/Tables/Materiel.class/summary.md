# Materiel — Synthèse

> Source : `.src/Gestion/Tables/Materiel.class` · Synthèse des autres documents.

## Rôle

Fiche des **matériels suivis par numéro de série** (`Fiches_Materiels`, clé `(mat_serie,
mat_code)`) : exemplaires d'articles `art_mat`, avec prix, marque, type, client, garantie,
réception et vente. Elle affiche aussi l'historique des ventes, des **interventions** (bons et
factures d'entretien `Fiches_BlM`/`Fiches_HistoFacM`, rattachés au matériel par `numserie` +
`codep`, commentaire `Fiches_HisentMat`) et des achats. Ouverte en modal depuis le menu Gestion et
depuis la fiche article (liste filtrée sur le produit).

## Points clés

- Fichier legacy (2 632 lignes, 107 fonctions toutes `Public`, CC max 24 `Histo_Ventes`) : rework
  minimal et ciblé.
- Les matériels sont créés à la réception (`Achat`) et vendus par la facturation (`Facture`,
  `ObjFacB`) ; cet écran ne modifie que `Fiches_Materiels`.
- Aucun `Cbase.Table` : 19 tables en dur ; SQL de la grille par concaténation de la saisie.
- Chaîne de calcul des prix (PA, frais, coefficient, taux de marque, HT/TTC, arrondi « au 5 » par
  chaîne, marge) mêlée aux contrôles ; arrondi identique à `Movr.arrondi`.
- Code mort important : 9 handlers sans contrôle (`Ta_*`, `Cof_*`, `TTc_*`), 4 fonctions jamais
  appelées, 11 membres jamais lus, observateurs `OBS` sans handler.

## Dépendances principales

- Utilise : `Utils` (`db`, `rs1`, formats de dates et de prix, observateurs), `TriArticles`,
  `TriCpt`, `DocActif.Is_Lock`, `LDate`, `Doc.Open`, `Start.Epuises`/`Stockes`.
- Appelée par `Fmenu` et `Articles` ; `Bsel`/`Bval` écrits par `TriArticles`/`TriCpt`
  (`Object.SetProperty`).
- Tables lues : articles, familles, TVA, comptes, fournisseurs, clients, marques, BL et factures
  (normaux et `*M`), réceptions ; écrite : `Fiches_Materiels`.

## Risques

- **Ouvrir/enregistrer une fiche corrompt** `mat_cequ`, `mat_prvt` et `mat_pmp` (A01).
- Drapeau `B2` jamais remis à zéro après Enregistrer (A02, à confirmer) ; collision du groupe et
  de l'en-tête `Rcpt` (A03) ; tri de `Deb` (A04) ; SQL concaténé (A05).
- Historiques incomplets (A06) et erreurs non interceptées (A07) ; date de fin de garantie perdue
  (A08) ; sélection client annulée réappliquée (A09) ; verrou de réception (A10) ; suppression peu
  contrôlée (A11) ; matériel divers en double ignoré (A12).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 2054 |
| Lignes de commentaire | 174 |
| Fonctions | 107 |
| Fonctions Public | 107 |
| Complexité cyclomatique totale | 444 |
| Complexité max (fonction) | 24 (`Histo_Ventes`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

12 tests prévus : 11 replays (création, ouvrir/enregistrer, chaîne de prix et arrondis,
contrôles, suppression, historiques ventes/interventions et achats, tri/filtre, garantie,
ouverture depuis la fiche article, sélection client) sur un jeu dérivé (`Laurux01.sql` ne contient
aucun matériel), et 1 `gbtest` des calculs de prix et de l'arrondi après séparation.

## Rework

10 étapes sans changement de comportement (MATERIEL-001 à 010) : documentation, code mort
(handlers, fonctions, membres), `Cbase.Table`, factorisation des chargements de grille et des
en-têtes, découpage de `Histo_Ventes`/`Maj_Zones`/`EnrgMat`, calculs de prix purs, `ArrondiPrix`
commune avec `Movr`, extraction SQL, réduction de portée de 35 fonctions. 12 anomalies
(MATERIEL-A01 à A12) soumises à validation.
