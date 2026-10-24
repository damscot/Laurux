# Comptabilite — Synthèse

> Source : `.src/Compta/Utils/Comptabilite.module` · Synthèse des autres documents.

## Rôle

Module de 6 variables globales servant d'échange entre la liste de sélection d'écritures
`TriEcritures` et les écrans `Saisecrit` et `Tresor` (écriture choisie : `Bsel`, `snum`, `libelle`,
`journal`).

## Points clés

- Aucune fonction ; ce n'est **pas** un fichier mort (5 fichiers l'utilisent).
- `sdesg` n'est utilisée que dans du code commenté (code mort).
- `sCmpt` n'est jamais renseignée (toujours `""`), lue seulement par `TresorFac`.
- Deux utilisateurs, `TriEcritures2` et `TresorFac`, semblent eux-mêmes morts.

## Dépendances principales

- Écrit par : `TriEcritures`, `TriEcritures2`, `Saisecrit`, `Tresor`.
- Lu par : `Saisecrit`, `Tresor`, `TresorFac`.

## Risques

- État global persistant : une valeur périmée peut être relue (cas de `TresorFac`, A01).
- Protocole différent de celui de `TriCpt` (`Object.SetProperty` sur l'appelant).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 6 |
| Lignes de commentaire | 1 |
| Fonctions | 0 |
| Fonctions Public | 0 |
| Complexité cyclomatique totale | 0 |
| Complexité max (fonction) | 0 |
| Variables globales | 6 |
| Variables Public | 6 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `replay` (COMPTABILITE-T01, T02) : sélection d'une écriture depuis `Saisecrit` et depuis
`Tresor`.

## Rework

2 étapes (COMPTABILITE-001, 002) : documentation du protocole, suppression de `sdesg`.
1 anomalie (A01, défaut de `TresorFac` à traiter dans son lot). La suppression du module au profit
de propriétés de `TriEcritures` est une réarchitecture proposée dans architecture.md.
