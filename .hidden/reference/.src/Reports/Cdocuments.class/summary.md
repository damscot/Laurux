# Cdocuments — Synthèse

> Source : `.src/Reports/Cdocuments.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Bibliothèque de gabarits PDF (`Inherits PdfWriter`) pour les documents commerciaux et quelques
listes : en-tête société/destinataire au format lettre, commande fournisseur, relevé de
prestations, bon de réception, listes de documents et de familles, historique des ventes,
ancienne facture PDF. Aucune requête SQL : l'appelant fournit des chaînes déjà formatées et gère
la position verticale (`PosY`) et les sauts de page.

## Points clés

- 72 méthodes, toutes `Public`, nommées par famille (`Level<n>`, `…R`, `…F`, `…br`, `…D`,
  `…FAM`, `…RL`) ; une famille par document appelant.
- **23 méthodes sans appelant** (variantes devis, atelier, conditionnement, coupon…) et une
  famille facture (`Level1F`…`Level13F`, `Colonnes`) appelée seulement par le code
  **inatteignable** de `Facturergbl` (FACTURERGBL-A01). Les factures/BL/devis sont édités depuis
  2019 par le report `Editfac`.
- `Entete` : **19 paramètres positionnels obligatoires** (2 inutilisés), CC 23 ; les trois
  appelants reconstruisent chacun le même bloc société depuis `Fiches_Societes`.
- Branches mortes : `Variables.EnvoiMail`, `TypeL`, `Qte`, `bImpref` ne sont jamais affectées.
- `Cdocuments2` (copie paysage en double exemplaire) n'est plus instanciée ; `Cdocuments3`
  partage `_new` et `BasPage` à l'identique.

## Dépendances principales

- Hérite de `PdfWriter` (`Cell`, `MultiCell`, `Image`, `EAN13`, saut de page automatique à
  295 mm en portrait).
- Utilisé (code atteignable) par `Edcom`, `RelvMo`, `Edbr`, `EdDocs`, `EdPrep`, `EdFam`,
  `RelMoprod` ; `Facturergbl` (inatteignable) ; `FacturefmA` (déclaration seule).
- Lit `Start.R/G/B/R2/G2/B2`, `Start.LocalSettings["/Soc<XX>/…"]` (logos, `AutoEnt`,
  `Franchise`, `Taxe`, `Devis2`) et `Variables.*`.

## Risques

- **CDOCUMENTS-A01** : `RelvMo:427` appelle `Entete` avec 18 arguments pour 19 → « Not enough
  arguments » au saut de page, aucun relevé PDF pour un client de plus d'une page
  (= RELVMO-A01) ; `Facturergbl:948/953/960` appellent `Level6F` avec 5 arguments pour 6 (code
  inatteignable).
- **CDOCUMENTS-A02** : logo de moins de 10 pixels de large → « Division by zero » non intercepté.
- Défauts d'appelants relevés au passage : `RelvMo` omet la première ligne d'adresse du client
  dans `Entete2` ; `Edcom` imprime le téléphone du fournisseur dans l'en-tête société.
- Défauts de `PdfWriter` communs à tous les gabarits : encodage (€ rendu « ¤ », accents,
  PDFWRITER-A01) et largeur de texte fausse (alignements à droite/centrés décalés, PDFWRITER-A02).
- `pdf.Footer()` appelé par `RelvMo`/`RelMoprod` est sans effet (non surchargé ici).
- Les seuils de saut de page sont propres à chaque appelant (180 à 283 mm) : toute modification
  de géométrie se vérifie sur des documents multi-pages.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 986 |
| Lignes de commentaire | 76 |
| Fonctions | 72 |
| Fonctions Public | 72 |
| Complexité cyclomatique totale | 212 |
| Complexité max (fonction) | 23 (`Entete`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

12 tests prévus (CDOCUMENTS-T01 à T12) : 5 `gbtest` (en-tête société, logos, arité, matrice des
régimes de TVA, gabarits élémentaires) et 7 `replay` par les écrans appelants (`Edcom`, `RelvMo`,
`Edbr`, `EdDocs`, `EdPrep`, `EdFam`, `RelMoprod`), dont 4 multi-pages. Comparaison du texte
extrait par `pdftotext` (et `pdfimages`/`-bbox`), valeurs produites dans le clone non modifié,
date et utilisateur figés.

## Rework

12 étapes (CDOCUMENTS-001 à 012) : documentation, suppression de ~300 lignes mortes puis de la
famille facture après FACTURERGBL-A01, réduction de portée (`Logo`, `Logo3`, `Colonnes`), socle
PDF commun `PdfLaurux` avec `Cdocuments3`/`Creleve`/…, **objet `LEnteteSoc`** remplaçant les 19
paramètres d'`Entete` (adaptateur puis migration des appelants), simplification d'`Entete` et
`Level2F`, helpers de lignes, paramètres inutilisés, `SansTva()`. 2 anomalies (A01, A02).
