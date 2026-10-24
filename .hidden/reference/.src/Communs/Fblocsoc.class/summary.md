# Fblocsoc — Synthèse

> Source : `.src/Communs/Fblocsoc.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Petit écran lancé par `Prgm` (`Blocsoc`) pour bloquer l'accès à la table des sociétés de la société
courante : case `Blocsoc` et mot de passe chiffré `BlocsocMdp` dans `Laurux.conf`.

## Points clés

- Enregistrement systématique à la fermeture (`Form_Close`).
- Le blocage masque `Fmenu.Menu26` (« Sociétés ») et désactive des champs de `LauruxConf`.
- Avertissement « case cochée sans mot de passe » dupliqué.

## Dépendances principales

- Appelé par `Prgm`. Utilise `Start.LocalSettings`, `hexdblKey`. Clé lue par `Fmenu` et `LauruxConf`.

## Risques

- Mot de passe **jamais vérifié** (A01) ; écrasé à chaque réouverture (A02) ; blocage enregistré
  même sans mot de passe (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 18 |
| Lignes de commentaire | 1 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 10 |
| Complexité max (fonction) | 4 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `replay` (FBLOCSOC-T01 à T04) : blocage avec et sans mot de passe, réouverture, effet sur
le menu principal.

## Rework

2 étapes (FBLOCSOC-001, 002) : documentation et factorisation. 3 anomalies (FBLOCSOC-A01 à A03).
