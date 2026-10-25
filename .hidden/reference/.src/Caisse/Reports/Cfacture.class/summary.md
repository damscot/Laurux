# Cfacture — Synthèse

> Source : `.src/Caisse/Reports/Cfacture.class` · Synthèse des autres documents.

## Rôle

Gabarit PDF (`Inherits PdfWriter`) des éditions de la caisse : ticket « Défaut A4/80 mm » et
facture de caisse (`Caisse`), livre de caisse (`Moulinage.Livre_caisse`). La classe ne fournit que
des primitives de mise en page (en-têtes, lignes de tableau, traits, logo, pied de page) ; le
contenu vient des appelants. Aucun accès à la base.

## Points clés

- Mise à l'échelle par format (`a3`, `80mm`, `a4`, `a5`, `letter`, `legal`) via trois rapports
  calculés dans `_new`.
- Le choix A4/autre se fait par un paramètre `Ba4` **ou** par la lecture de `Caisse.Ba4`, qui
  porte sur l'auto-instance du formulaire `Caisse` (toujours `False`) : tickets et factures A4
  imprimés avec les polices et troncatures 80 mm (anomalie A01).
- `Logo2` est la version utilisée du logo ; `Logo` (ancienne version) et `Level1T` sont du code
  mort, confirmé par `grep`.
- Branches identiques (`Typel = "TA"`, `If Caisse.Ba4` de `Level2F`/`Level4`), paramètre `Bold`
  d'`Entete` ignoré.
- `Fiches_Societes` n'est pas lu ici : l'en-tête société est préparé par `Caisse`.

## Dépendances principales

- Parent : `PdfWriter` (lot Reports).
- Utilisé par : `Caisse` (`Defaut_Tk`, `Defaut_Facture`), `Moulinage` (`Livre_caisse`).
- Utilise : `Start.R/G/B`, `Start.LocalSettings` (`/Soc<XX>/caisse/logo`, `ilogo`),
  `Caisse.Ba4` (dépendance circulaire cachée).

## Risques

- A01 : rendu A4 dégradé et création cachée de l'auto-instance `Caisse` (y compris depuis le
  livre de caisse).
- A03 : un logo absent ou au mauvais format interrompt l'impression du ticket.
- A02 : message d'erreur cassé pour un format non géré (branche inatteignable aujourd'hui).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 267 |
| Lignes de commentaire | 15 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 59 |
| Complexité max (fonction) | 8 (`Level1`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests prévus : 7 `gbtest` (formats, ticket A4/80 mm, facture, livre de caisse, couplage
`Caisse.Ba4`, logo) comparant des PDF normalisés produits dans le clone non modifié, et 2 `replay`
(impression du ticket en caisse, livre de caisse), soumis à validation car liés au module Caisse.

## Rework

4 étapes sans changement de comportement (CFACTURE-001 à 004) : documentation, suppression de
`Logo`/`Level1T`/`_free`, fusion des branches identiques, helpers de police et de trait.
3 anomalies (CFACTURE-A01 à A03) soumises à validation utilisateur.
