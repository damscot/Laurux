# Changefam — Synthèse

> Source : `.src/Utils/Changefam.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran (menu Gestion) de changement de **famille** et éventuellement de **code** d'articles, avec
propagation dans les historiques. Quatre modes : un article, une liste d'articles (table temporaire
`CFamille`), une famille entière, un fichier CSV `code;famille;nouveau_code`.

## Points clés

- `Modifart` est le cœur métier : 8 `UPDATE` (famille) ou 37 `UPDATE` (famille + code) sur 29 tables,
  noms en dur sans `Cbase.Table`.
- Verrouillage par `LOCK TABLES` sur 29 tables, sans transaction ni `Catch`.
- Fortement mixte : les traitements lisent directement les contrôles du formulaire.
- Clone élargi de `Changefour` (247 lignes de code identiques ; formulaire d'import CSV dynamique
  copié à l'identique).
- Code mort : `verifart`, variable `b` de `Cmpt_KeyPress`, `SELECT` inutilisé d'`AjoutArt`.

## Dépendances principales

- Appelé uniquement par `Fmenu` (`Changefam.ShowModal`).
- Utilise `TriArticles` (sélection, retour par `Object.SetProperty` sur `Bsel`/`Bval`),
  `textfamille` (4 contrôles de saisie de famille), `LGed.Articles`, `Utils.Find_cbarre`.

## Risques

- **Import par fichier quasi inopérant** : test du nouveau code sur la famille et condition
  inversée, plus `SELECT` sur une table non verrouillée (erreur MySQL).
- **Verrou dépendant de `Rupture`/`RuptureC`** : sur une base où l'édition des ruptures n'a jamais
  tourné, tous les traitements échouent sous MariaDB.
- Pas de contrôle d'unicité du nouveau code : erreur de clé primaire en plein traitement, tables
  laissées verrouillées.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 548 |
| Lignes de commentaire | 63 |
| Fonctions | 28 |
| Fonctions Public | 28 |
| Complexité cyclomatique totale | 106 |
| Complexité max (fonction) | 14 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

12 tests prévus (CHANGEFAM-T01 à T12) : 11 replays sur MariaDB (un article, liste, famille entière,
import CSV, doublons, base sans tables de rupture, code-barres, sélections) avec dump des 29 tables
et diff du log `Exec_SQL`, plus un test gb.test de `Modifart` après séparation traitement/GUI.

## Rework

9 étapes sans changement de comportement (CHANGEFAM-001 à 009) : documentation, code mort, boucle
sur tables pour `Modifart`, factorisation des contrôles de famille, commonalisation avec
`Changefour`, séparation traitement/GUI, `Cbase.Table`, réduction de portée de 14 membres.
6 anomalies (CHANGEFAM-A01 à A06) soumises à validation utilisateur.
