# Cecrit — Synthèse

> Source : `.src/Compta/Cecrit.module` · Synthèse des autres documents.

## Rôle

Module d'affichage d'une liste d'écritures dans une `GridView` (cellule, largeurs de colonnes,
8 variantes de requête selon validée/provisoire, trésorerie et sens du tri). **Module mort** :
aucun appelant dans le projet.

## Points clés

- 10 fonctions `Public`, toutes sans appelant (vérifié par `grep`).
- Les homonymes `Tris2`/`Debn1…4` de `TriEcritures2`, `Eticli`, `Emailing`, `EmailingCarte`
  sont des méthodes locales sans lien avec ce module.
- SQL entièrement concaténé, valeurs saisies comprises ; dépend du résultat global `Utils.rs1`.

## Dépendances principales

- Utilise : `Utils.Base`, `Utils.rs1`.
- Utilisé par : personne.

## Risques

- Aucun risque fonctionnel (code non exécuté). Seul risque de la suppression : confusion avec les
  homonymes locaux, couverte par un replay de `TriEcritures2`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 71 |
| Lignes de commentaire | 1 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 17 |
| Complexité max (fonction) | 8 (`Ecrit_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test `replay` (CECRIT-T01) : non-régression de `TriEcritures2` après suppression, plus
`gbc3 -agt`.

## Rework

1 étape (CECRIT-001) : suppression du module. Aucune anomalie.
