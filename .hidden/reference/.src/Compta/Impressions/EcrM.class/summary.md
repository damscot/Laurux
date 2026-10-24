# EcrM — Synthèse

> Source : `.src/Compta/Impressions/EcrM.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Écritures modifiées/supprimées » (menu Compta) : impression, entre deux dates d'un
exercice (en cours, N-1 … N-5), des lignes des tables d'historique `Fiches_MvtM*`, filtrées
(toutes / modifiées / supprimées) et triées (date ou numéro), dans `~/tmp/Journaux.pdf`
(`Ccompta`).

## Points clés

- Copie partielle de `Journaux.class` : en-tête, `Createtable`, `donnees*`, cumuls et sélection
  d'exercice hérités ; beaucoup de code mort (table `centralisation` recréée sans usage, cumuls
  jamais imprimés, `Tab0`).
- Sélection d'exercice factorisée dans `exercice(ind)` : modèle pour un helper commun aux éditions
  (Journaux, Balance, Editcompte la recopient six fois).
- `DteN0`/`Dten1` sont dans le groupe `Cmpt` : les fonctions `dteN*_GotFocus/LostFocus` ne
  s'exécutent que par appel explicite.
- Une requête `Fiches_Comptes` par ligne imprimée.

## Dépendances principales

- Appelé par `Fmenu.Menu323_Click` uniquement.
- Utilise `Utils.db`, `Utils.Cdate*`, `Utils.Calc_mois`, `LDate`, `Ccompta`, `Visualiseur`, `Doc`,
  et (par erreur) l'auto-instance du formulaire `Journaux`.
- Tables lues : `Fiches_MvtM` … `Fiches_MvtM5`, `Fiches_Comptes`, `Fiches_Parametres`,
  `Fiches_Societes` ; DDL : `centralisation`.

## Risques

- Date de fin jamais validée ni normalisée (handler `dteN1_LostFocus` inactif, A01).
- `Journaux.Mouse` au lieu de `Me.Mouse` : formulaire `Journaux` caché instancié (A02).
- Titre de page faux après saut de page, numérotation commençant à 0, lignes à `datem` nul
  (A03-A05).
- PDF au même nom que l'édition des journaux (A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 485 |
| Lignes de commentaire | 33 |
| Fonctions | 35 |
| Fonctions Public | 34 |
| Complexité cyclomatique totale | 105 |
| Complexité max (fonction) | 34 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

13 tests (ECRM-T01 à T13) : 11 replays (ouverture, exercices, impressions comparées après
`pdftotext` et normalisation de la date et de l'utilisateur, filtres, multipage, compte absent,
sélection vide, saisie des dates, `datem` nul, édition provisoire, formulaire `Journaux`) et 2
`gbtest` sur les fonctions extraites (`Bornes_Exercice`, `Date_Hors_Periode`).

## Rework

10 étapes (ECRM-001 à 010) : documentation, code mort (dont `Createtable`), suppression des alias
`Exo*`, `Cbase.Table` pour `Fiches_MvtM*`, fusion de `Compdate*`, découpage de `Button1_Click`,
séparation calcul/affichage, réduction de portée, socle commun des éditions. 6 anomalies
(ECRM-A01 à A06).
