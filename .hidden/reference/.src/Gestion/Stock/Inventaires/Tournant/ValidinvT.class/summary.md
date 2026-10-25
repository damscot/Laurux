# ValidinvT — Synthèse

> Source : `.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Validation de l'inventaire tournant : met `art_qte` au comptage (ou à 0 pour les non comptés,
selon l'option), enregistre chaque écart dans `Fiches_Mvtexp`, historise les lignes comptées dans
`Fiches_HisInvT` (nouveau `inv_num`) et supprime `Fiches_InvT`. Sauvegarde `mysqldump` préalable.

## Points clés

- Logique différente de `Validinv` (41 % de lignes communes) : pas de stock de départ ni de
  `dteinv`, mais mouvement exceptionnel + historique, combinés par `Cstock.Calc_stock`.
- Cohérent avec le tableau des sources de `Stockmvt` (STOCKMVT-A05).
- Lectures inutiles (`Fiches_Parametres`, `Fiches_Art` par ligne) ; pas de transaction.

## Dépendances principales

- `Utils.db`, `Utils.Observers` ; appelé par `Fmenu.Menu100_Click`.
- Tables : `Fiches_InvT`, `Fiches_Art`, `Fiches_Mvtexp`, `Fiches_HisInvT`.
- Consommateurs : `Cstock`, `Stockmvt`, `Changefam`.

## Risques

- **Sortie fictive pour les non comptés conservés** (A02, grave) ; double comptage possible (A03) ;
  sauvegarde de la base `Laurux` en dur (A01) ; validation partielle (A04) ; dépôts (A07).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 122 |
| Lignes de commentaire | 28 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 26 |
| Complexité max (fonction) | 23 (`Button2_click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

13 scénarios `replay` (VALIDINVT-T01 à T13). **Liste à valider par l'utilisateur avant la
phase 2** (module complexe).

## Rework

6 étapes (VALIDINVT-001 à 006) : documentation, code mort et lectures inutiles, complexité,
séparation traitement/GUI, `Cbase.Table`, sauvegarde et module communs. 7 anomalies
(VALIDINVT-A01 à A07).
