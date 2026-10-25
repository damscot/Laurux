# Edinv — Synthèse

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Édition PDF de l'inventaire valorisé (PA et PMP) par famille, avec sous-totaux et total, pour
l'inventaire de fin d'exercice (`New Edinv("F")`) ou tournant (`New Edinv("T")`).

## Points clés

- Seul écran déjà paramétré par le type d'inventaire : il a rendu `Edinv1` et `EdinvT` morts et
  sert de modèle au module commun `Inventaire`.
- Parcours récursif de l'arbre `Trifam` (CC 15) ; sous-totaux cumulés par les propriétés de
  `Trifam`.
- Trace de débogage `Print` ; articles hors arbre de familles exclus.

## Dépendances principales

- `Trifam` (exige `/SocXX/ipr`, sinon `Quit`), `Cstocks`, `Utils`, `Visualiseur`.
- Appelé par `Fmenu` (menus 85 et 99). Tables : `Fiches_Inv`/`Fiches_InvT`, `Fiches_Art`,
  `Fiches_Fam` (lecture).

## Risques

- Valorisation incomplète (A01), `Show` après `Close` (A02), en-têtes incohérents (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 135 |
| Lignes de commentaire | 27 |
| Fonctions | 6 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 29 |
| Complexité max (fonction) | 15 (`TriArticles`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 scénarios `replay` (EDINV-T01 à T07), texte du PDF ; paramétrage `ipr` obligatoire.

## Rework

5 étapes (EDINV-001 à 005). 3 anomalies (EDINV-A01 à A03).
