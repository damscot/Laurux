# DataButtonList — Synthèse

> Source : `.src/Utils/DataButtonList.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Composant générique « bouton bascule + liste déroulante liée à une table » (auteur Fabien Bodard),
**jamais utilisé** dans Laurux : code mort.

## Points clés

- Aucun appelant, aucun `.form` (vérifié par `grep -rni`).
- Lit la base par `DB.Find` (connexion courante gb.db), hors `Utils.db`.
- Défaut latent : `Tag_Write` remplace le bouton par la valeur du tag.

## Dépendances principales

- `Start.LocalSettings` (`/Soc<XX>/Coul_fen`), `DB.Find`.

## Risques

- Aucun à l'exécution.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 247 |
| Lignes de commentaire | 44 |
| Fonctions | 37 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 71 |
| Complexité max (fonction) | 13 (`LoadValues`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 contrôle de build (DATABUTTONLIST-T01).

## Rework

1 étape : suppression du fichier (DATABUTTONLIST-001). Aucune anomalie retenue.
