# HitCarte — Synthèse

> Source : `.src/Statistiques/HitCarte.class` · Synthèse des autres documents.

## Rôle

Écran modal de paramétrage du hit-parade des cartes de fidélité (menu `Fmenu`). Il cumule, pour la
période saisie, le nombre de tickets (visites) et les points de chaque carte dans la table de
travail `Total`, puis ouvre `VisHitCartes` avec le nombre de cartes (10 à 100) et le tri (points ou
visites).

## Points clés

- Sources : `Fiches_HisEntTickets` (tickets archivés, colonne `carte`) et `Fiches_Carte` (nom).
- Table de travail `Total` (carte, nom, visite, points) recréée à chaque traitement, hors
  `db_control.csv`, nom partagé avec `TBord`, `Stat*` et `Statcai`.
- Deux requêtes par ticket (carte puis `Total`) : coût proportionnel au nombre de tickets.
- Saisie des dates recopiée de `Histovmo` (et des autres écrans de statistiques).

## Dépendances principales

- Appelé par `Fmenu` (ligne 2008) ; ouvre `VisHitCartes` (contrat sur la structure de `Total` et la
  signature de `_New`).
- Utilise `Utils` (dates, couleurs, `Observers`, `db`), `Cbase.Table("TabHEntTck" | "TabCarte")`.
- Lecture de `Fiches_Carte` commune avec `FClientcarte`, `Tricartes`, `Caisse.RecupClientd`,
  `EmailingCarte` (`LitCarte`, FCLIENTCARTE-008).

## Risques

- Table `Total` partagée entre écrans et postes (A01).
- Tickets supprimés comptés (A02) ; tickets du dernier jour exclus (A03).
- Tri « CA » qui classe en réalité par points (A04, à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 159 |
| Lignes de commentaire | 30 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 44 |
| Complexité max (fonction) | 16 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests prévus (HITCARTE-T01 à T07) : 6 replays (défaut, période et borne de fin, tri et nombre,
cartes inconnues et tickets supprimés, aucune donnée, saisie des dates) comparant le dump de `Total`
et les lignes `Exec_SQL`, puis 1 gbtest du calcul après extraction. Jeu commun `statistiques_ventes`.

## Rework

7 étapes (HITCARTE-001 à 007) : documentation, code mort, `LitCarte` commun, séparation calcul/GUI,
requête d'agrégat (SQL modifié, dump identique), saisie de dates commune, réduction de portée de 3
méthodes. 4 anomalies (HITCARTE-A01 à A04).
