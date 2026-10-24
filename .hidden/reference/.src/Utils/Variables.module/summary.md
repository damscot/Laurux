# Variables — Synthèse

> Source : `.src/Utils/Variables.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Module sans fonction déclarant 41 variables globales : des réglages de la société figés au premier
accès (`Sprix`, `Sexport`, `SMaj*`, `Schmprix`, `son`) et des « boîtes aux lettres » par lesquelles
les dialogues de recherche (`TriFac`, `Tricp`, `TriEqu`…) renvoient leur sélection à l'écran appelant
(`Facture`, `FClientcarte`, `CoefTypeC`…).

## Points clés

- 14 variables jamais utilisées, 4 écrites jamais lues, 4 lues jamais écrites (branches mortes de
  `Cdocuments`).
- Échanges réellement actifs : `Bsel`, `numeroFac`, `$Codearticle`, `codepostal`,
  `Bureaudistributeur`, `bRemise`, `ArtCode`/`ArtHt`/…, `sTexte`.
- `Facture` est le principal consommateur ; `TriEqu` le principal écrivain.
- Réglages lus une seule fois : risque de valeurs périmées après changement de société.

## Dépendances principales

- Utilise : `Start.LocalSettings`, `Start.Societe` (initialisation).
- Écrit par une quinzaine d'écrans, lu par une vingtaine (carte complète dans architecture.md).

## Risques

- La suppression de variables touche les écrans écrivains : à faire avec les replays correspondants.
- Transformer les échanges en propriétés de fenêtres change l'API de ~15 écrans : hors périmètre,
  à planifier en phase 3.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 42 |
| Lignes de commentaire | 1 |
| Fonctions | 0 |
| Fonctions Public | 0 |
| Complexité cyclomatique totale | 0 |
| Complexité max (fonction) | 0 |
| Variables globales | 40 |
| Variables Public | 40 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests (VARIABLES-T01 à T07) : un `gbtest` sur l'initialisation depuis `Laurux.conf`, six `replay`
couvrant chaque échange entre écrans (`Tricp`, `TriFac`, `TriEqu` → `Facture` ; `Articles` →
`CoefTypeC` ; `bRemise` → impression ; `sTexte` → courriel).

## Rework

5 étapes (VARIABLES-001 à 005) : suppression des variables mortes en trois temps, documentation
des échanges, remplacement de `Variables.Musique` par `Start.Musique`. 2 anomalies (VARIABLES-A01,
A02) : réglages figés au premier accès et branches inatteignables de `Cdocuments`.
