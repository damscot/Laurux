# Portable — Synthèse

> Source : `.src/Gestion/Lcr/Portables/Portable.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Import du fichier `~/Portable/inventaire.txt` produit par un **terminal portable de saisie
d'inventaire** (lecteur de codes-barres) vers la table de travail `Etiquettes` (code article,
nombre d'étiquettes), avec rapport des rejets `~/tmp/ImpT.txt` et compteur global `cpt2`. Aucun lien
avec les LCR malgré son emplacement.

## Points clés

- Une fonction `Import(Org)` : seul `Org = "Etiq"` fait un traitement ; `"Casier"` (`Majcasier`) ne
  fait que vider le rapport.
- Globale `cpt2` jamais remise à zéro.
- Code-barres résolu par `Utils.Find_cbarre` ; table de travail `Etiquettes` en dur.
- Lecture de `inventaire.txt` dupliquée dans 5 autres écrans.

## Dépendances principales

- Appelé par `Etigond`, `Etiqart`, `Etiqcasier` (étiquettes) et `Majcasier`.
- Utilise `Utils.Find_cbarre`, `Utils.cpoint`, `Utils.db`, `Cbase.Table("TabArt")`.

## Risques

- Rapport d'erreurs ouvert à tort (A01), étiquettes imprimées pour un mauvais article (A02),
  absence de message si le fichier manque (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 69 |
| Lignes de commentaire | 5 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 18 |
| Complexité max (fonction) | 18 (`Import`) |
| Variables globales | 1 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `gbtest` (PORTABLE-T01 à T05) avec `HOME` temporaire et base de test : import nominal,
rejets, cumul de `cpt2`, fichiers absents, `Org = "Casier"`.

## Rework

4 étapes (PORTABLE-001 à 004) : documentation, simplification, séparation du message d'erreur,
lecture commune de `inventaire.txt` pour 6 écrans. 3 anomalies (PORTABLE-A01 à A03).
