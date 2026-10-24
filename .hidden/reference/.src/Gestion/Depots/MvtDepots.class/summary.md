# MvtDepots — Synthèse

> Source : `.src/Gestion/Depots/MvtDepots.class` · Synthèse des autres documents.

## Rôle

Transfert de stock entre dépôts, ligne à ligne : mise à jour du stock de la fiche article (dépôt
`01`), des stocks de dépôts (`Fiches_StkDepots`) et de l'historique (`Fiches_Sdepots`).

## Points clés

- Mises à jour de stock sous `LOCK TABLES` successifs, dans des fonctions qui lisent les contrôles.
- Drapeau `b` à double sens (échec de recherche / ligne à valider).
- 205 lignes communes avec Sdepots ; liste des dépôts dupliquée avec ImpDepots.
- Code mort : `Button2_Click` (vide, sans bouton).

## Dépendances principales

- Utilise : `Utils.db`, classe `DB` (`db.Exec`), `TriArticles`, `Utils.Cdec`, `Utils.cpoint`, `Cbase`.
- Utilisé par : `Fmenu` (`Show`) ; tables relues par `Cstock`, `Edsdepots`, `Articles`, `Facture`,
  `Caisse`.
- `Coldep_Click`, `Coldepa_Click` rejoués par `ReplayObserver` : restent `Public`.

## Risques

- **A01 (grave)** : le stock du dépôt de départ est supprimé à chaque transfert.
- A02 : libellé d'arrivée faux ; A03 : recherches par code-barres inatteignables ; A04 : article
  introuvable transféré ; A05 : `db.Exec` hors `Utils.db`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 409 |
| Lignes de commentaire | 23 |
| Fonctions | 26 |
| Fonctions Public | 26 |
| Complexité cyclomatique totale | 103 |
| Complexité max (fonction) | 11 (`Dep_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 replays (magasin → dépôt, dépôt → magasin, libellé d'arrivée, article introuvable, code-barres,
cumul) avec diff de `Fiches_Art`, `Fiches_StkDepots`, `Fiches_Sdepots`. Liste à valider par
l'utilisateur (module de stock).

## Rework

5 étapes (001 à 005) : documentation, code mort, séparation du transfert, module `Depot` commun,
réduction de portée. 5 anomalies (A01 à A05).
