# TriBl — Synthèse

> Source : `.src/Affichages/TriBl.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ancien écran de la caisse servant à rattacher des BL non facturés d'un client au ticket en cours
(écriture immédiate de `Fiches_Bl.numtick`). **Classe morte** depuis le commit `7101bb39` (2022) qui
l'a remplacée par `TriFacture`.

## Points clés

- Aucun appelant (`jamais_reference` de `deps.py`, confirmé par `grep` et `git log -S "New TriBl"`) ;
  les `Tribl` de `Facture.class` sont une variable homonyme.
- SQL legacy par concaténation dans `Deb3`/`Deb4` (ligne 199 et 209) : `cdclibl = " & Clicode`,
  `numtick = " & Ntk` (sans guillemets), motif `LIKE`, `LIMIT` ; les autres requêtes sont paramétrées.
- 177 lignes communes avec `Tricartes` (ratio 0,61) ; `ClavInput`/`ClavInput2` jamais appelées.

## Dépendances principales

- Aucune dépendance entrante. Utilise `Utils` (`Base2`, `rs2`, `Obstch`, `Observers`…), `Cbase`,
  `Start.LocalSettings`.

## Risques

- Aucun en exécution (code inatteignable). Risque de maintenance : défauts latents (A02) qui
  réapparaîtraient si la classe était réutilisée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 255 |
| Lignes de commentaire | 11 |
| Fonctions | 32 |
| Fonctions Public | 32 |
| Complexité cyclomatique totale | 98 |
| Complexité max (fonction) | 14 (`Select_Bl`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test (TRIBL-T01) : contrôle d'absence de référence et compilation après suppression. Pas de replay
possible.

## Rework

Recommandation : **suppression** du couple `.class`/`.form` (TRIBL-A01, validation utilisateur). En
cas de refus, 4 étapes (TRIBL-001 à 004 : documentation, code mort, portée, pagination commune) et
l'anomalie latente A02 (SQL concaténé).
