# Trifam — Synthèse

> Source : `.src/Utils/Trifam.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Construit l'arbre des familles d'articles à partir des préfixes de `code_fam` et des points de
rupture `ipr` de la société ; chaque nœud porte clé, libellé, liens de parenté et sous-totaux
cumulatifs utilisés par les éditions d'inventaire.

## Points clés

- Construction récursive dans le constructeur, 2 requêtes par nœud.
- `enfant` désigne le dernier fils ; le parcours se fait par `For Each` + récursion sur
  `precedant` (idiome dupliqué dans les 5 appelants).
- Écrire `soustotpa`/`soustotpmp` **ajoute** au cumul et propage à la racine.
- Paramétrage absent → `Message.Error` puis `Quit`.

## Dépendances principales

- Utilisé par `Edart4`, `Edinv`, `Edinv1`, `Stockmvt`, `Histocliart`.
- Utilise `Fiches_Fam`, `Start.LocalSettings` (`ipr`), même paramètre que `textfamille`.

## Risques

- Codes de famille contenant des caractères triés après `z` possiblement exclus.
- Arrêt de l'application si `ipr` manque.
- Coût en requêtes sur un grand nombre de familles.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 131 |
| Lignes de commentaire | 5 |
| Fonctions | 15 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 18 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests (TRIFAM-T01 à T08) : 6 gb.test (arbres à 2 et 3 niveaux, liens, sous-totaux, codes limites,
performance) et 2 replays (paramétrage absent, édition d'inventaire).

## Rework

5 étapes (TRIFAM-001 à 005) : documentation, code mort, factorisation de la création des fils,
lecture commune d'`ipr` avec `textfamille`, méthode de parcours commune aux 5 appelants.
3 anomalies (TRIFAM-A01 à A03).
