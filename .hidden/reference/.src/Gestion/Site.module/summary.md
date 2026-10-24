# Site — Synthèse

> Source : `.src/Gestion/Site.module` · Synthèse des autres documents.

## Rôle

Module vestige de l'ancienne passerelle « site » (boutique en ligne) : déclare une seconde
connexion `ServeurB` et `connect_site`, qui recopie les paramètres `[dbase]` de `Laurux.conf`
dans cette connexion sans jamais l'ouvrir.

## Points clés

- **Code mort** : aucun appelant de `connect_site` ni lecteur de `ServeurB` (vérifié par grep).
- Homonymie trompeuse : `Fsoc:355-356` utilise le **contrôle** `Site` de `Fsoc.form`, pas ce module.
- Ne gère ni le tunnel SSH ni SQLite (contrairement à `Utils.glb`).

## Dépendances principales

- Utilise : `Start.LocalSettings` (`/dbase/*`), `hexdblKey.crypt`.
- Utilisé par : aucun fichier.

## Risques

- Aucun à l'exécution (pas d'effet observable). Seul risque de la suppression : la résolution du nom
  `Site` dans `Fsoc`, couverte par SITE-T01/T02.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 9 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 1 |
| Complexité max (fonction) | 1 (`connect_site`) |
| Variables globales | 1 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 gbtest (SITE-T01, compilation après suppression) et 1 replay (SITE-T02, champ `Site` de `Fsoc`).

## Rework

1 étape : SITE-001 (suppression du module, code mort). Aucune anomalie.
