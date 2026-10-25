# TriEcritures2 — Synthèse

> Source : `.src/Affichages/TriEcritures2.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Copie ancienne (88 % identique) de `TriEcritures` : liste de sélection d'une écriture de
`Fiches_Mvt`, retour par `Comptabilite`. **Classe morte** : jamais appelée dans tout l'historique
git (import initial 2016).

## Points clés

- `jamais_reference` (`deps.py`) confirmé par `grep`, recherche de chaînes et `git log -S`.
- 8 colonnes (sans intitulé du compte), requêtes sans filtres `cloturee`/`pointee`.
- `Debe1`-`Debe4` jamais appelées (comme dans `TriEcritures`).

## Dépendances principales

- Aucune dépendance entrante. Écrirait dans `Comptabilite` ; utilise `Utils` (`Base`, `rs1`,
  `Observers`) et `Cbase`.

## Risques

- Aucun en exécution. Fausse piste de maintenance (écrivain fantôme de `Comptabilite`).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 520 |
| Lignes de commentaire | 2 |
| Fonctions | 59 |
| Fonctions Public | 59 |
| Complexité cyclomatique totale | 176 |
| Complexité max (fonction) | 11 (`Ecrit_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test (TRIECRITURES2-T01) : contrôle d'absence de référence et compilation après suppression.

## Rework

Recommandation : **suppression** du couple `.class`/`.form` (TRIECRITURES2-A01). En cas de refus, 3
étapes (documentation, suppression de `Debe1`-`Debe4`, réduction de portée).
