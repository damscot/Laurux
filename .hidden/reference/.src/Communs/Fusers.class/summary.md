# Fusers — Synthèse

> Source : `.src/Communs/Fusers.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre de gestion des utilisateurs de la **gestion des tâches** (Fmenu `Menu50`) : liste,
création, modification du poste et suppression dans `Fiches_Users` (`nom`, `poste`). Les couples
« nom@poste » sont proposés comme destinataires de tâches dans `Facture`.

## Points clés

- 8 fonctions, toutes `Public`, CC max 4 : fenêtre simple, SQL dans les handlers.
- `Fiches_Users` en dur (pas d'entrée `Cbase`), aucun index unique sur `nom`.
- Mise à jour et suppression par `nom` ; renommage impossible.
- Couleurs lues mais inutilisées, `Utils.Observers` appelé deux fois, bouton d'aide sans action.

## Dépendances principales

- Appelant : `Fmenu.Menu50_Click`.
- Utilise : `Utils.db`, `Utils.FColr`, `Utils.Observers`, `Start.Musique`, `Start.son`.
- Lecteur de la table : `Facture` (l.355) ; création : `LauruxMaj`.

## Risques

- Requête par concaténation dans `Button3_Click` (apostrophe → erreur SQL, injection) (A01).
- Renommage qui duplique, mise à jour de tous les homonymes (A02).
- Suppression de la ligne sélectionnée et non du nom saisi (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 75 |
| Lignes de commentaire | 2 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 15 |
| Complexité max (fonction) | 4 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests `replay` (FUSERS-T01 à T08) comparant le dump de `Fiches_Users` : liste, création,
modification, renommage, suppression (dont sélection différente du nom saisi), apostrophe, champs
vides.

## Rework

4 étapes sans changement de comportement (FUSERS-001 à 004) : documentation, code mort (couleurs),
séparation du SQL et du chargement, réduction de portée. 4 anomalies (FUSERS-A01 à A04) soumises à
validation utilisateur.
