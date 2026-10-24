# Verbal — Synthèse

> Source : `.src/Compta/Utils/Verbal.class` · Synthèse des autres documents.

## Rôle

Écran « Vérification des balances » (Comptabilité > Outils, `Fmenu.Menu132_Click`) : sur une
période de l'exercice courant, cumule débits, crédits et soldes des écritures validées par
catégorie de comptes (collectifs clients/fournisseurs, balances clients, fournisseurs, gestion,
bilan, générale) et signale un solde général non nul.

## Points clés

- Cumuls faits dans le texte des champs (`Format$ "0.00"` à chaque écriture) : arrondi à chaque pas,
  dépendance à la locale.
- Une requête `Fiches_Mvt` par compte (N+1).
- Dates d'exercice lues à la main dans `Fiches_Parametres` (`dteclec`, `dteclec1`), comparaisons
  par recomposition `yyyymmdd`.
- `date1` est du code mort ; le bouton d'aide est sans effet.

## Dépendances principales

- Appelé par : `Fmenu` (menu 132), en modal.
- Utilise : `Utils.db`, `Utils.cpoint`, fonctions de dates d'`Utils`, `LDate`, `Syntheses.Message`.
- Tables : `Fiches_Parametres`, `Fiches_Comptes`, `Fiches_Mvt` (lecture seule).

## Risques

- Alerte de déséquilibre peu visible (fond rouge + son), sensible à la locale (A02).
- Période d'un exercice antérieur : résultats nuls silencieux (A03).
- Contrôles de dates permissifs (A04) ; bouton d'aide inactif (A01).
- Réécriture du calcul : l'arrondi intermédiaire doit être reproduit à l'identique.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 314 |
| Lignes de commentaire | 52 |
| Fonctions | 12 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 57 |
| Complexité max (fonction) | 19 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests (VERBAL-T01 à T07) : 6 replays (dates à l'ouverture avec horloge fixée, balance équilibrée
et déséquilibrée, contrôles de dates, exercice antérieur, performance) sur un jeu dérivé
d'écritures, 1 gbtest sur `CalculeBalances` après extraction.

## Rework

7 étapes (VERBAL-001 à 007) : documentation, code mort, réduction de portée, tableau de champs,
extraction du calcul, suppression du N+1, dates d'exercice par `LDate` et tables par `Cbase`.
4 anomalies (A01 à A04).
