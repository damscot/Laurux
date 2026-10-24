# FCalc — Synthèse

> Source : `.src/Utils/FCalc.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Calculette modale ouverte par F5 dans les zones de montant/quantité de 7 écrans (Caisse, Saisecrit,
Tresor, Abont, Facture, TresorFac, Saisiedecons). Évalue la formule avec `Eval()` et renvoie le
résultat formaté dans la variable statique `FCalc.Resultat`.

## Points clés

- Logique de saisie concentrée dans `ManageKeys` (CC 20), pure sur deux chaînes : facile à extraire
  et tester.
- `Resultat` est le canal de retour, au format localisé `0.00000`.
- `GetParent() As Calc` : code mort, seule référence à la classe morte `Calc`.

## Dépendances principales

- Utilisé par 7 écrans, tous avec le même idiome (candidat à une méthode statique commune).
- Utilise `Utils.Observers`, `Utils.cpoint`.

## Risques

- `Resultat` jamais remis à zéro : une fermeture sans export réinjecte l'ancien résultat.
- Erreur d'évaluation → `1` ; virgule décimale probablement non supportée par `Eval`.
- Format dépendant de la locale : les tests doivent fixer `fr_FR.UTF-8`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 124 |
| Lignes de commentaire | 8 |
| Fonctions | 12 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 39 |
| Complexité max (fonction) | 20 (`ManageKeys`) |
| Variables globales | 1 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests (FCALC-T01 à T07) : 5 gb.test (évaluation, erreurs, édition, export, persistance de
`Resultat`) et 2 replays d'intégration (saisie d'écritures, caisse).

## Rework

5 étapes (FCALC-001 à 005) : documentation, code mort (`GetParent`, `Value`), simplification du
clavier, extraction de `ManageKeys`, méthode commune pour les 7 appelants. 2 anomalies
(FCALC-A01, A02).
