# Epurmvtexp — Synthèse

> Source : `.src/Gestion/Stock/Epurmvtexp.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Épuration des régularisations » (Gestion › Stock) : supprime les mouvements de stock
exceptionnels (`Fiches_Mvtexp`, saisis par `Mvtex`) jusqu'à une date de fin proposée à partir de
la date de clôture de `Fiches_Parametres`.

## Points clés

- `Form_Open` propose `date1` (mois suivant `dteclec1`) et `date2` (`dteclec`) ; seule `date2`
  sert au traitement.
- `Button1_Click` lit toute la table et supprime ligne à ligne, sans transaction.
- Les handlers de contrôle des dates ne sont jamais levés (contrôles du groupe `Cmpt`).

## Dépendances principales

- Appelé par `Fmenu.Menu229_Click` uniquement.
- `Utils.db`, `Utils.Cdate_*`, `Utils.Observers`, `Doc.Open`, `Start.Son/Musique`.
- `Fiches_Mvtexp` est lue par `Cstock` (recalcul de `art_qte`), `Stockmvt`, `TriHistos`,
  `Edregul`, `ValidinvT`.

## Risques

- **CRITIQUE (A01)** : `DELETE … WHERE mind` sans paramètre vide **toute** la table dès qu'un
  mouvement est antérieur à la date : perte de l'historique et stock recalculé faux.
- Dates non contrôlées (A02) ; date de début ignorée (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 109 |
| Lignes de commentaire | 28 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 21 |
| Complexité max (fonction) | 7 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `replay` (EPURMVTEXP-T01 à T05) sur le dump de `Fiches_Mvtexp` : purge nominale (A01
figée), rien à purger, abandon, dates proposées, date invalide.

## Rework

5 étapes (EPURMVTEXP-001 à 005) : documentation, code mort (handlers inactifs, membres inutiles),
fonction `Purge` isolée, `Aff_date` en `Private`, `Cbase.Table`. 3 anomalies (A01 critique, A02,
A03) soumises à validation.
