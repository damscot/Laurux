# Geninv — Synthèse

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Génération de l'inventaire de fin d'exercice : recrée la table de travail `Fiches_Inv` avec tous
les articles stockés (stock théorique `art_qte`, comptage à 0, n° de ligne séquentiel) selon deux
critères de tri, puis imprime la feuille de comptage (`~/tmp/Inventaire.pdf`, `Cstocks`).
Premier maillon de la chaîne fin d'exercice (`SaisieInv` → `Ecarts`/`Ednsaisis`/`Edinv` →
`Validinv`).

## Points clés

- `gen_Inv` : `DROP` + `CREATE TABLE` à l'exécution (table hors `db_control.csv`), 6 `SELECT`
  qui ne diffèrent que par l'`ORDER BY`, un `INSERT` par article.
- Première génération : passe par le `Catch` (le `SELECT` sur la table absente échoue).
- Impression sans `ORDER BY` : ordre lexicographique de `inv_nlig char(9)` sur MySQL (à confirmer).
- Variante tournante `GeninvT` : 77 % des lignes de `Geninv` s'y retrouvent.
- Le document architecture.md porte la **mesure de duplication de tout le module inventaire** et
  la proposition de **socle commun `Inventaire`** paramétré `"F"`/`"T"`.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.Cdate_Dbase`, `Cstocks`, `Visualiseur`, `Doc`, `TextReg`, `LDate`.
- Utilisé par : `Fmenu.Menu81_Click`.
- Tables : `Fiches_Inv` (créée), `Fiches_Art` (lecture).

## Risques

- Flux par exception (GENINV-A03), statut « validé » jamais écrit (GENINV-A02), ordre
  d'impression (GENINV-A01), message trompeur si article supprimé (GENINV-A04).
- Stock théorique tronqué à 2 décimales par le DDL (schéma, information seulement).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 203 |
| Lignes de commentaire | 22 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 36 |
| Complexité max (fonction) | 13 (`gen_Inv`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

16 scénarios `replay` (GENINV-T01 à T16) : 6 combinaisons de tri, régénération acceptée/refusée,
première génération, base vide, stocks limites, date, impression (texte PDF), erreurs,
pagination, SQLite. **Liste à valider par l'utilisateur avant la phase 2** (module complexe).

## Rework

8 étapes (GENINV-001 à 008) : documentation, code mort, `DROP` redondant, requête unique,
séparation traitement/GUI, **création du module commun `Inventaire`**, `Cbase.Table`, réduction de
portée de `gen_Inv`. 4 anomalies (GENINV-A01 à A04).
