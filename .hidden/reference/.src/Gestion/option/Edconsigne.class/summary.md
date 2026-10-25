# Edconsigne — Synthèse

> Source : `.src/Gestion/option/Edconsigne.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Édition PDF du **suivi des consignes** sur une période : mouvements de `Fiches_ligcons` issus des
réceptions, des BL et des factures, par code de consigne, par client ou par fournisseur, en détail
ou en cumul, avec ou sans valorisation (`Report` gb.report).

## Points clés

- Trois requêtes réunies par `UNION`, 8 paramètres `&1`-`&8` ; signes inversés (consignes /
  déconsignes).
- Boutons de recherche des bornes présents dans le `.form` mais sans gestionnaire.

## Dépendances principales

- Utilise : `Utils.db`, `LDate`, `Chainage`, `Visualiseur`, gb.report.
- Utilisé par : `menuopt`.
- Tables : `Fiches_consigne`, `Fiches_ligcons`, réceptions, BL, factures, clients, fournisseurs.

## Risques

- **Jointure sur `Fiches_ligcons.code`** (identifiant auto-incrémenté) au lieu de `codecons` :
  l'état ne rapproche probablement pas les bons mouvements (à confirmer).
- Jointures sans numéro de ligne : mouvements répétés et sommes multipliées.
- Filtre `type <> 'E'` absent en cumul BL ; pas de tri pour les ruptures.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 244 |
| Lignes de commentaire | 11 |
| Fonctions | 7 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 35 |
| Complexité max (fonction) | 15 (`edition`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests (EDCONSIGNE-T01 à T06) : 5 replays (comparaison du texte du PDF) et 1 `gbtest` du texte SQL.

## Rework

5 étapes (EDCONSIGNE-001 à 005) : documentation, requête isolée, variable morte, `Cbase.Table`,
libellés de tiers communs. 4 anomalies (A01 à A04).
