# Monip — Synthèse

> Source : `.src/Utils/Monip.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Affiche dans une petite fenêtre l'adresse IP publique (`curl ifconfig.me`) et le nom d'hôte ;
appelé par le menu principal (`Fmenu`).

## Points clés

- Une fonction mixte (shell + construction de fenêtre).
- Fichier intermédiaire `monip` écrit dans le répertoire courant mais lu dans `$HOME`.
- `Shell "cd"` sans effet.

## Dépendances principales

- `Fmenu` (appelant unique) ; `curl`, `ifconfig.me`.

## Risques

- Faibles : fonction isolée, informative.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 30 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 3 |
| Complexité max (fonction) | 3 (`Monip`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `replay` (MONIP-T01, T02) avec un `curl` factice.

## Rework

3 étapes (MONIP-001 à 003) : documentation, nettoyage, séparation de la lecture de l'IP. 1 anomalie
(MONIP-A01) : chemin du fichier intermédiaire.
