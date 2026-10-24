# TypeClient — Synthèse

> Source : `.src/Compta/Utils/TypeClient.class` · Synthèse des autres documents.

## Rôle

Contrôle graphique exporté (`Inherits TreeView`) listant les types de clients (`Fiches_Typec`) ;
sa propriété `where` renvoie le filtre SQL `cli_typec IN(…)` de la sélection. Utilisé par les
écrans Balance, comptes non justifiés et non lettrés.

## Points clés

- Chargement SQL dans le constructeur du contrôle (base connectée requise).
- `where` construit le filtre avec `Utils.db.Subst` (valeurs quotées).
- Classe courte (2 fonctions, CC 6).

## Dépendances principales

- Utilise : `Utils.db` ; table `Fiches_Typec` en dur.
- Utilisé par : `Balance`, `EdNjustifiees`, `EdNlettrees` (contrôle `TypeClient1` des `.form`),
  `BalanceM.Imprime`.

## Risques

- Faibles. La sélection dans ce contrôle n'est probablement pas rejouée par `ReplayObserver`
  (classe `TypeClient` non reconnue), à traiter avant les replays des écrans hôtes.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 24 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 6 |
| Complexité max (fonction) | 3 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `gbtest` (chargement, propriété `where`) et 1 `replay` (Balance filtrée)
(TYPECLIENT-T01 à T03).

## Rework

3 étapes (TYPECLIENT-001 à 003) : documentation, `Cbase.Table`, fonction pure `WhereTypes`.
Aucune anomalie.
