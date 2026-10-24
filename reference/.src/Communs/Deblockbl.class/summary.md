# Deblockbl — Synthèse

> Source : `.src/Communs/Deblockbl.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de maintenance lancé par `Prgm` (`Deblockbl`) pour supprimer le verrou d'un document saisi
par son numéro.

## Points clés

- Vérifie l'existence du numéro dans `Fiches_Bl`, puis supprime dans `Fiches_Docactif`.
- Tables en dur, sans `Cbase.Table`.
- La gestion normale des verrous est dans `DocActif`.

## Dépendances principales

- Appelé par `Prgm`. Utilise `Utils.db`. Tables `Fiches_Bl`, `Fiches_Docactif`.

## Risques

- **Non fonctionnel** : la colonne `numerobl` n'existe pas dans `Fiches_Docactif` ; aucun verrou ne
  peut être supprimé (A01).
- Ne reconnaît que les documents de `Fiches_Bl` et annonce un succès sans vérifier (A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 21 |
| Lignes de commentaire | 1 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 3 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests `replay` (DEBLOCKBL-T01 à T03) : numéro inconnu, numéro verrouillé (anomalie figée),
champ vide.

## Rework

3 étapes (DEBLOCKBL-001 à 003) : documentation, `Cbase.Table`, séparation traitement/GUI.
2 anomalies (DEBLOCKBL-A01, A02).
