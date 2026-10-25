# Caleditcmat — Synthèse

> Source : `.src/Gestion/option/Caleditcmat.class` · Synthèse des autres documents.

## Rôle

Écran de contrôle, d'édition et de **clôture mensuelle de la comptabilité matières** des alcools
(option boissons), pour le régime acquitté ou suspendu : volumes effectif et d'alcool pur,
droits d'accises, sécurité sociale. Ouvert en modal par `menuopt.cmat_click`. Lance aussi le
détail des mouvements, les éditions de stock (`EditStkDepart`) et la consultation (`Visucmat`).

## Points clés

- **Module complexe** : la clôture écrit dans `Fiches_ligregie` (`cloture=True` des mouvements du
  mois, lignes `M` de stock au 1er du mois suivant). Pas d'écriture comptable `Fiches_Mvt*`.
  Scénarios de test à faire valider par l'utilisateur.
- `Edit` (CC 35) calcule la collection de `Declaration` par régie et l'imprime par `Ecomptamat`
  (suspendu) ou `Einvmat` (acquitté) ; `ddcl` sert de variable de travail aux reports.
- Contrôles : BL non facturés, lignes de régie manquantes (avec recalcul complet des BL par
  `ObjFacB`, sans limite de date), inventaire, mois précédent clôturé.
- Concerne la comptabilité **matières**, pas les tables `*M` du matériel.
- Pas d'`Utils.Observers(Me)`.

## Dépendances principales

- Utilise : `ObjFacB`/`ObjFac`, `Calculdroit`, `Ecomptamat`, `Einvmat`, `EditStkDepart`,
  `Visucmat`, `ProgBar`, `LDate`, `Visualiseur` ; tables `Fiches_ligregie`, `Fiches_regie`,
  `Fiches_Bl`, `Fiches_Ligbl`, `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_Art`.
- Utilisé par : `menuopt` ; `ddcl` lu/écrit par `Ecomptamat` et `Einvmat` (circulaire).

## Risques

- Clôture non atomique (A04) et impossible sous SQLite (A06).
- Date invalide : curseur d'attente bloqué (A01) et édition de la période précédente (A02).
- Réédition : plage de vignettes fausse (A05).
- Montants dépendants de `Calculdroit` et d'`ObjFacB` : tout rework de ces classes impose de
  repasser les tests de ce module.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 765 |
| Lignes de commentaire | 38 |
| Fonctions | 22 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 121 |
| Complexité max (fonction) | 35 (`Edit`) |
| Variables globales | 0 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

13 replays et 1 gbtest (CALEDITCMAT-T01 à T14) : contrôles, éditions provisoires des deux
régimes, clôture nominale et refusée, réédition, modes de calcul et d'arrondi, détail, éditions
de stock, cas d'erreur. Liste à valider par l'utilisateur (module complexe).

## Rework

9 étapes (CALEDITCMAT-001 à 009) : documentation, découpage d'`Edit`, cœur de calcul sans GUI,
contrôles et clôture séparés, suppression de `ddcl`, fabrique de `ReportLabel` commune, code
mort, découpage de `detail_Click`, `RegieSuspendue` commun. 9 anomalies (A01 à A09).
