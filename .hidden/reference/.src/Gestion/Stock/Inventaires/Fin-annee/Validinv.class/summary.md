# Validinv — Synthèse

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Validation de l'inventaire de fin d'exercice : sauvegarde `mysqldump`, puis réécrit pour chaque
ligne de `Fiches_Inv` le stock (`art_qte`) **et le stock de départ** (`art_stkdep`) selon le
comptage et l'option des non saisis, fixe `Fiches_Parametres.dteinv`, vide l'historique tournant.
Bouton « Compta matière » (option boissons) : stock de départ par régie dans `Fiches_ligregie`.

## Points clés

- Seul écran de la chaîne fin d'exercice qui modifie le stock ; cohérent avec le tableau des
  sources de mouvements de `Stockmvt` (STOCKMVT-A05) : stock de départ + `dteinv`.
- 72 lignes de correction des mouvements commentées : logique réduite à `qtest = qtec`.
- Recalcul `Cstock.Calc_stock("", "")` sans effet (CSTOCK-A01).
- `Fiches_Inv` ni supprimée ni marquée validée ; `Fiches_StkDepots`/`Fiches_Sdepots` non traités.

## Dépendances principales

- `Utils.db`, `Cstock` (→ `Calcstock`), `Calculdroit`, `LDate`, `Utils.Option`.
- Appelé par `Fmenu.Menu84_Click`.
- Tables : `Fiches_Inv`, `Fiches_Art`, `Fiches_Parametres`, `Fiches_HisInvT`, `Fiches_regie`,
  `Fiches_ligregie`.

## Risques

- Validation partielle sans transaction (A04), revalidation (A05), SQLite (A06), stock par dépôt
  (A07), dates de comptage/validation (A08), sauvegarde non sûre (A03), compta matière (A09).
- À reworker avec `Cstock`/`Calcstock` (même commit).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 158 |
| Lignes de commentaire | 103 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 32 |
| Complexité max (fonction) | 20 (`Button2_click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

16 scénarios `replay` (VALIDINV-T01 à T16) : trois cas de mise à jour, comptage nul, refus,
absence, mouvements et dates, historique tournant, revalidation, article supprimé, SQLite, dépôts,
compta matière, sauvegarde. **Liste à valider par l'utilisateur avant la phase 2**.

## Rework

8 étapes (VALIDINV-001 à 008) : documentation, code mort (dont 72 lignes commentées), `SELECT`
inutile, décision unique, séparation traitement/GUI, `Utils.DumpBase`, `Cbase.Table`, module
`Inventaire`. 9 anomalies (VALIDINV-A01 à A09).
