# Listecom — Synthèse

> Source : `.src/Gestion/Stock/Listecom.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre de consultation de l'historique d'achats d'un client : lignes d'articles et de
main-d'œuvre de ses factures et BL (en cours et « entretien »). Deux modes : un article donné
(Ctrl+A dans `Facture`) ou les 10 dernières dates d'achat en colonnes (Ctrl+H dans `Facture`,
bouton 24 dans `FClient`).

## Points clés

- Tout est fait dans le constructeur `_new` (CC 14) : lecture des dates, puis une requête `UNION`
  de 4 sous-requêtes par date, et remplissage de `GridView1`.
- Lecture seule, tables en dur (pas de `Cbase.Table`), quantités et montants texte convertis par
  `REPLACE(…, ',', '.')`.
- `Form_Close` fait `Me.Delete` ; écran instrumenté (`Utils.Observers`).

## Dépendances principales

- Utilisé par `Facture` (3 ouvertures) et `FClient` (`Button24_Click`).
- Utilise `Utils.db`, `Utils.Observers` ; tables `Fiches_HistoFac[M]`, `Fiches_HistoLigfac[M]`,
  `Fiches_Bl[M]`, `Fiches_Ligbl[M]`, `Fiches_Art`, `Fiches_Mo`.

## Risques

- Date sans ligne `A`/`M` en mode client : parcours au-delà du résultat (A01, à confirmer).
- SQLite : `UNION(SELECT …)` probablement refusé (A03).
- Achats présents seulement dans les tables entretien jamais listés (A04).
- Littéraux adjacents sans `&` ligne 106 (à vérifier avec `gbc3`).
- `GridView1` sans `GridView1_Click` : pas de clic dans les scénarios de rejeu.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 162 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 22 |
| Complexité max (fonction) | 14 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `replay` (LISTECOM-T01 à T05) : mode client, mode article, date sans ligne, client sans
historique, base SQLite. Le contenu de la grille fait foi, la base doit rester inchangée.

## Rework

5 étapes (LISTECOM-001 à 005) : documentation, découpage du constructeur, génération commune des
deux requêtes `UNION`, `Cbase.Table`, séparation SQL/grille. 4 anomalies (A01 à A04) soumises à
validation.
