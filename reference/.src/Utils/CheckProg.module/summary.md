# CheckProg — Synthèse

> Source : `.src/Utils/CheckProg.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Teste la présence d'un programme dans le `PATH` via `which`.

## Points clés

- Une fonction, un seul appelant (`Editeur.Prog_Email`), lui-même jamais appelé : module mort de fait.
- Fichier temporaire `~/temp_prog`, nom de programme non échappé.

## Dépendances principales

- `Editeur.module` ; programme `which`.

## Risques

- Aucun en pratique (code inatteignable).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 13 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 2 |
| Complexité max (fonction) | 2 (`Chk`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test `gbtest` (CHECKPROG-T01).

## Rework

3 étapes (CHECKPROG-001 à 003) : documentation, suppression du fichier temporaire, suppression du
module si `Editeur.Prog_Email` est supprimé. Aucune anomalie.
