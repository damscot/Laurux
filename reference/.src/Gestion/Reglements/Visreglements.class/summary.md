# Visreglements — Synthèse

> Source : `.src/Gestion/Reglements/Visreglements.class` · Synthèse des autres documents.

## Rôle

Ancien écran de visualisation des règlements clients (comptes `411…` passés dans les journaux de
caisse/banque), avec détail par client et suppression d'un règlement.

## Points clés

- **Aucun point d'entrée** (ni menu, ni `Prgm`, ni `New`) : couple `.class` + `.form` mort.
- Quasi-clone de `Visimpayes` (Compta/Lettrages), lui aussi mort.
- Détruit et recrée à chaque ouverture les tables de travail `Facturefm` et `Detail`.
- `Calc_solde` duplique `Csolde.Solde_caisse` (et `TresorFac.Calc_solde`).

## Dépendances principales

- Utilise : `Utils.db`, `Cbase.Table` (`TabMvt`, `TabComptes`), `Utils.Cdate_Aff`,
  `Utils.PointBase`, `Doc` ; tables `Fiches_Mvt`, `Fiches_Cli`, `Fiches_Parametres`,
  `Fiches_Comptes`, `Facturefm`, `Detail`.
- Utilisé par : personne.

## Risques

- A01 : suppression du couple mort (déroge à « `.form` intouchable », validation requise).
- A02 : `Coldetail.Item[7]` hors des 7 colonnes.
- A03 : suppression d'une ligne d'écriture sans contrepartie ni contrôle de clôture.
- A04 : collision de la table de travail `Facturefm` avec la facturation de fin de mois.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 191 |
| Lignes de commentaire | 29 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 24 |
| Complexité max (fonction) | 8 (`recup_bl`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 gbtest de compilation après suppression (T01), 3 replays (T02 à T04, avec lanceur dédié faute de
menu) et 1 gbtest SQL (T05, `Calc_solde`). T02 à T05 ne servent que si la suppression est refusée.

## Rework

6 étapes conditionnelles (VISREGLEMENTS-001 à 006, si A01 est refusée) : documentation, code mort,
boucle d'UPDATE, délégation à `Csolde`, séparation, portée. 4 anomalies (A01 à A04).
