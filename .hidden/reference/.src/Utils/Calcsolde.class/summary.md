# Calcsolde — Synthèse

> Source : `.src/Utils/Calcsolde.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Recalcul des soldes du plan comptable (`Fiches_Comptes.solde`) à partir des écritures validées de
`Fiches_Mvt`, et du solde pointé (`soldep`) des comptes de trésorerie (écritures pointées + report
à nouveau clôturé).

## Points clés

- `Calcul(compte, Treso, jan)` : 1 à 2 `SELECT` + 1 à 2 `UPDATE` par compte, valeurs formatées par
  `LPrix(...).D`.
- Ouvert par le menu, après l'import FEC et par `Prgm` ; `Calcul` appelé en statique par `Pointage`
  (instanciation cachée du formulaire).
- Paramètre `depart` du constructeur jamais utilisé.

## Dépendances principales

- Appelants : `Fmenu`, `impfec`, `Prgm` (non détectés par `deps.py`), `Pointage`.
- Utilise `LPrix`, `Utils.db`, tables `Fiches_Mvt`, `Fiches_Comptes`, `Fiches_Parametres` (en dur).

## Risques

- **`Pointage` ne recalcule jamais le solde pointé** (journal d'à-nouveaux non transmis).
- `soldep` obsolète pour un compte sans écriture validée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 70 |
| Lignes de commentaire | 31 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 20 |
| Complexité max (fonction) | 8 (`Calcul`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests (CALCSOLDE-T01 à T07) : 5 gb.test de `Calcul` (compte général, trésorerie, sans écriture,
appel style Pointage, arrondi) et 2 replays (recalcul global, suppression de relevé).

## Rework

5 étapes (CALCSOLDE-001 à 005) : documentation, code mort, extraction de la boucle, `Calcul`
statique, `Cbase.Table`. 2 anomalies (CALCSOLDE-A01, A02).
