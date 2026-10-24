# Facturergbl — Synthèse

> Source : `.src/Gestion/Facturation/Facturergbl.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de regroupement de BL : liste les clients ayant plusieurs BL non facturés et fusionne leurs
BL en un nouveau BL numéroté depuis `dnbon`. Sert aussi de bibliothèque à `Moulinage`, qui
instancie le formulaire pour appeler `Ent_Bl` et `Maj_Parametres`.

## Points clés

- `Ent_Bl` (regroupement) et `Maj_Parametres` sont les seules fonctions utilisées de
  l'extérieur (`Moulinage`).
- Une chaîne d'édition de facture regroupée (`Button14_Click`, CC 121, ≈ 700 lignes avec ses
  fonctions) est inatteignable : panneau `Edit` invisible, `Bl_Edit` jamais appelée.
- L'erreur d'arité `Cdocuments.Level6F` (5 arguments pour 6, l. 948/953/960) est dans ce code
  inatteignable.
- `_New` exécute `lpc status` (y compris depuis `Moulinage`) pour une liste d'imprimantes morte.

## Dépendances principales

- Utilisé par : `Fmenu.Menu306`, `Moulinage`.
- Utilise : `DocActif` (verrous), `AFacture`, `Doc`, `Fiches_Bl`, `Fiches_Ligbl`, `Fiches_Cli`,
  `Fiches_Parametres`, tables de travail `Facturefm`, `Bl`, `Totalisation` ; `Cdocuments`,
  `Impression` et ≈ 15 tables dans la chaîne morte.

## Risques

- Fusion d'articles : colonne de marge lue sur l'entête → erreur (A02).
- Verrous `LOCK TABLES` annulés par ceux de `DocActif` (A03) ; numéros de BL perdus (A04).
- Entête du BL regroupé alimenté par des membres vides (A05) ; lignes autres que `A`/`C`
  perdues au regroupement (A06, à confirmer).
- Décision à prendre sur la chaîne d'édition morte (A01).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1232 |
| Lignes de commentaire | 99 |
| Fonctions | 30 |
| Fonctions Public | 30 |
| Complexité cyclomatique totale | 258 |
| Complexité max (fonction) | 121 (`Button14_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `replay` (FACTURERGBL-T01 à T07) : sélection, regroupement d'un client / de tous,
fusion d'articles, retraits, absence de sélection, `Ent_Bl` depuis la caisse (partagé avec
`Moulinage`). La chaîne d'édition n'est pas testable depuis l'interface.

## Rework

5 étapes (FACTURERGBL-001 à 005) : documentation, code mort (`Bl_Sup`, `ard`, variables),
réduction de portée de 4 fonctions, séparation de `Ent_Bl`/`Button9_Click`, base commune avec
`Facturefm`/`FacturefmA`. 6 anomalies (A01 à A06), dont la décision sur la chaîne d'édition morte.
