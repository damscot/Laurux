# Suivi — Synthèse

> Source : `.src/Gestion/Suivi.class` · Synthèse des autres documents.

## Rôle

Fenêtre modale de **suivi d'affaire** : saisie du prévu (devis) et du réalisé (facture) en heures
de main-d'œuvre, achats et ventes ; calcul des marges et des écarts ; enregistrement dans
`Fiches_Suivis`.

## Points clés

- Ouverte par F12 depuis `Facture` (3 appels identiques) et `Archives` (consultation).
- Taux et prix de revient MO lus dans `Fiches_Txtmo` pour `/Soc<XX>/CodeMO`.
- Calculs mêlés aux contrôles : fonctions « prévu » et « réalisé » dupliquées (`Calc_*`/`Calc_*2`).
- `Calc_Emarge` reconstruit un signe par branches et préfixe `"-"`.

## Dépendances principales

- Utilise : `Utils` (cpoint, dates, formatage, couleurs), `Cbase.Table` (`TabTxmo`, `TabSuivis`),
  `Start.LocalSettings`, `Doc`.
- Utilisé par : `Facture` (l. 3331, 5664, 7865), `Archives` (l. 1435).

## Risques

- A01 : prix de revient MO nul → suivi existant non chargé, risque d'écrasement.
- A02 : écarts MO et articles de signes opposés, total incohérent.
- A03 : enregistrement par `numdev` seul (collision entre clients).
- A04 : enregistrement possible en consultation d'archive.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 292 |
| Lignes de commentaire | 30 |
| Fonctions | 31 |
| Fonctions Public | 31 |
| Complexité cyclomatique totale | 95 |
| Complexité max (fonction) | 14 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 replays (SUIVI-T01 à T03, T05 à T08 : création, réalisé, archives, prix de revient nul,
suppression, n° partagé, code MO absent) et 1 gbtest (T04, calculs purs après séparation).

## Rework

7 étapes (SUIVI-001 à 007) : documentation, éditabilité, fusion des calculs prévu/réalisé,
simplification des écarts, séparation traitement/GUI, filtre de saisie commun, portée.
4 anomalies (SUIVI-A01 à A04).
