# LVar — Synthèse

> Source : `.src/Utils/LVar.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Moteur de libellés et numéros automatiques : construit un contexte de variables (`$annee`,
`$mois`, `$moistr`, champs d'un `Result`, variables de l'appelant) et évalue avec `Eval` une
expression paramétrée en base (par ex. `Fiches_Comptes.libel_def`). Affiche les variables
disponibles dans l'infobulle du contrôle de saisie.

## Points clés

- Petite classe (4 méthodes Public, toutes utilisées).
- Utilisée en comptabilité (`Saisecrit`, `Tresor`, `EcrAuto`) et en réception (`ValidBR`,
  `ValidBR1`).
- Le contexte est la collection de l'appelant, partagée par référence.
- `Eval` sur une expression lue en base : puissance et risque du paramétrage.

## Dépendances principales

- Utilise : `LDate` (composants de date).
- Utilisé par : 5 fichiers, séquence d'appel répétée une douzaine de fois.

## Risques

- Libellés dépendants de `LDate.MonStr` et `Year2`, eux-mêmes porteurs d'anomalies (LDATE-A04,
  LVAR-A02).
- Infobulle d'origine perdue (LVAR-A01).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 61 |
| Lignes de commentaire | 3 |
| Fonctions | 5 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 15 |
| Complexité max (fonction) | 5 (`Evaluate`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests (LVAR-T01 à T06) : 5 `gbtest` (évaluation, `ParseResult` avec base, `AddDate`, priorité
des sources, infobulle) et 1 `replay` (libellé automatique dans `Saisecrit`).

## Rework

4 étapes (LVAR-001 à 004) : documentation, nettoyage, construction de l'infobulle, helper commun
pour la séquence d'appel. 3 anomalies (LVAR-A01 à A03).
