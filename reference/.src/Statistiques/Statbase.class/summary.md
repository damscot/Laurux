# Statbase — Synthèse

> Source : `.src/Statistiques/Statbase.class` · Synthèse des autres documents.

## Rôle

Écran « Statistiques utilisation base Laurux » : dix compteurs (`SELECT Count(*)`) sur les
principales tables (articles, MO, clients, fournisseurs, produits composés, factures archivées,
tickets, écritures, BL et devis en cours). Ce n'est **pas** une classe de base : aucune classe
n'en hérite.

## Points clés

- 50 lignes, deux fonctions ; lecture seule ; SQL paramétré et `Cbase.Table` partout.
- Deux couleurs lues sans usage.
- Dix blocs copiés (factorisables en boucle).

## Dépendances principales

- Ouvert par `Fmenu.Menu250_Click` (modal).
- `Cbase.Table` (9 clés), `Utils.db`, `Utils.Observers`.

## Risques

- **A01** : le compteur « tickets archivés » compte les tickets en cours.
- **A02** : les factures d'entretien ne sont pas comptées (à confirmer).
- Risque de régression faible.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 32 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 2 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests : 3 `replay` (base de référence, jeu de ventes, SQLite), 1 `gbtest` après séparation.

## Rework

4 étapes (STATBASE-001 à 004) : documentation, code mort, séparation `Compteurs()`, boucle sur
une table de correspondance. 2 anomalies (A01, A02).
