# ticpe — Synthèse

> Source : `.src/Gestion/option/ticpe.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ébauche d'objet de règle TICPE (catégories « GNR détaxé » agricole / « Carburant », table
`Art_Tipp`) pour l'option carburants : fabrique `ticpe(client)` sur un code client ou un `Result`.

## Points clés

- Aucun appelant ; `Parametre` code la liste des catégories en dur (l'appel `ticpe(Null)` échoue,
  probablement parce que `_new` exige un argument).
- Propriétés `date`, `NumAgri`, `NumCarb`, `region` jamais alimentées.
- `Valide` : requête invalide (`&1` sans argument), jamais appelée.

## Dépendances principales

- Utilise : `Utils.db` ; tables `Fiches_Cli`, `Art_Tipp`, `Fiches_Art`.
- Utilisé par : aucun fichier.

## Risques

- Règle métier non implémentée ; décision utilisateur requise (achever ou supprimer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 40 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 5 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 `gbtest` (TICPE-T01 à T03) : construction, fabrique, propriétés.

## Rework

2 étapes (TICPE-001, 002) : documentation, suppression de `Valide` et `$val`. 1 anomalie
(A01 : achever ou supprimer l'ébauche).
