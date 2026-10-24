# FComptes — Synthèse

> Source : `.src/Compta/Tables/FComptes.class` · Synthèse des autres documents.

## Rôle

Écran du plan comptable (`Fiches_Comptes`) : grille de recherche, fiche du compte (type, collectif,
options, TVA ventes/achats), sous-comptes de ventilation et répartition analytique par postes.

## Points clés

- Plus gros fichier du lot (1 202 lignes) ; `Button2_Click` CC 48.
- Règles métier dans les handlers : type forcé selon la tranche du numéro, refus pour C/F/collectifs,
  contrôle des mouvements sur `Mvt…Mvt5` et `MvtM…MvtM5` avant suppression.
- Drapeau `Enr` partagé entre contrôles TVA, ventilation, collectif et autorisation d'enregistrement.
- Grille virtuelle déléguée au module `Ccomptes`.
- Ouvert en modal (auto-instance) par Saisecrit, Tresor, Parametre pour créer un compte.

## Dépendances principales

- Utilise : `Ccomptes`, `Utils` (`db`, `ObsGotf`, `Obstch`, `convBool`, `PointBase`), `Cbase`,
  `TriCpt`, `Start.LocalSettings` (option analytique), `Doc`.
- Utilisé par : `Fmenu`, `Saisecrit`, `Tresor`, `Parametre` (affichage seulement) ; `TriCpt`
  écrit `Bsel`/`Bval`.

## Risques

- A01 : question de suppression à chaque touche (sous-comptes, postes).
- A02 : fermeture bloquée après vidage de la répartition analytique.
- A03 : suppression de la ligne de grille et non du compte affiché, contrôles incomplets.
- A04 : enregistrement dépendant d'un drapeau partagé ; A05 à A07 : défauts mineurs de saisie.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 919 |
| Lignes de commentaire | 53 |
| Fonctions | 60 |
| Fonctions Public | 60 |
| Complexité cyclomatique totale | 271 |
| Complexité max (fonction) | 48 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 replays (création et types forcés, refus, TVA, drapeau `Enr`, suppression, sous-comptes,
analytique, recherche, ouverture depuis la saisie) et 2 gbtest sur les fonctions extraites.

## Rework

10 étapes (001 à 010) : documentation, code mort, `Cbase.Table`, factorisation TVA et recherche,
`CompteMouvemente`, séparation de `Button2_Click` et de `Quitter_Postes`, requête paramétrée,
réduction de portée. 7 anomalies (A01 à A07).
