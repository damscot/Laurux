# RazInvT — Synthèse

> Source : `.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Suppression de l'inventaire tournant en cours (`DROP TABLE IF EXISTS Fiches_InvT`) après
confirmation. Ouvert par `Fmenu.Menu233_Click`.

## Points clés

- Copie de `RazInv` (85 % de lignes communes) ; seule la table change.
- L'historique `Fiches_HisInvT` n'est pas touché ; après `ValidinvT`, la table n'existe déjà plus.

## Dépendances principales

- `Utils.db.Exec`, `Cbase.Table("TabInvT")`, `Utils.Observers` ; appelé par `Fmenu`.

## Risques

- Message de succès même en cas d'échec du `DROP` (RAZINVT-A01).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 13 |
| Lignes de commentaire | 1 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 3 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 `replay` (RAZINVT-T01 à T03) : confirmée, refusée, table absente.

## Rework

3 étapes (documentation, extraction du `DROP`, socle commun `Inventaire`) ; 1 anomalie.
