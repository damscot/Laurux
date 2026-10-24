# Ligext — Synthèse

> Source : `.src/Compta/Relances/Ligext.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ligne graphique (formulaire embarqué) d'extrait de compte dans l'écran de préparation des relances
`FEditrel`. Sa case à cocher inscrit ou retire l'écriture de la table de travail `Fiches_relances`.

## Points clés

- Créée par `Ligcli.visext`, une instance par écriture de l'extrait (`Listextcpt`).
- `CheckBox1_Click` : `Create9` + recopie des champs, ou `DELETE … WHERE lind`.
- Propriété `selection` pilotée par `FEditrel.CheckBox2_Click` (via `Variant`).

## Dépendances principales

- Utilise : `Utils.db` (`Exec`, `Create9`, transactions), table `Fiches_relances`.
- Utilisée par : `Ligcli` (création), `FEditrel` (propriété `selection`).

## Risques

- Les données réinsérées diffèrent de la génération initiale (`intitule`, `niveau`) : LIGEXT-A02.
- Transaction laissée ouverte en cas d'erreur (LIGEXT-A01).
- Comportement de `selection_Write` dépendant de l'événement `Click` sur affectation (à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 61 |
| Lignes de commentaire | 7 |
| Fonctions | 4 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 3 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests `replay` (LIGEXT-T01 à T03) via `FEditrel` ; comparaison du dump de `Fiches_relances`.

## Rework

3 étapes (documentation, code mort de `selection_Write`, séparation traitement/GUI) ;
2 anomalies (LIGEXT-A01, A02).
