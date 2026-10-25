# fourconsdroi — Synthèse

> Source : `.src/Gestion/option/fourconsdroi.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ébauche de gestion des consignes et droits d'accise d'une réception fournisseur, remplacée par
`Consigne`, `calculdroit1` et `Achat`. **Jamais instanciée** : tout le fichier est du code mort.

## Points clés

- Pas de `.form` : la suppression du fichier est un rework [code mort].
- Structure publique `consigne` homonyme (à la casse près) de la classe `Consigne` : source de faux
  positifs de `deps.py`.
- Défauts latents (variable `cdt` non affectée, `DELETE` hors transaction) sans effet puisque le code
  n'est jamais exécuté.

## Dépendances principales

- Utilise : `calculdroit`, `Utils.db`, `Utils.totobs` ; tables `Fiches_ligcons`, `Fiches_consigne`,
  `Fiches_ligregie`, `Fiches_Art`.
- Utilisé par : aucun fichier.

## Risques

- Aucun à l'exécution ; brouille l'analyse des dépendances de `Consigne`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 213 |
| Lignes de commentaire | 2 |
| Fonctions | 17 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 49 |
| Complexité max (fonction) | 8 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests (FOURCONSDROI-T01, T02) : absence de référence et compilation, non-régression de la
réception boissons.

## Rework

1 étape (FOURCONSDROI-001) : suppression du fichier. Aucune anomalie.
