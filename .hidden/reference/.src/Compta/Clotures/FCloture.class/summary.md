# FCloture — Synthèse

> Source : `.src/Compta/Clotures/FCloture.class` · Synthèse des autres documents.

## Rôle

Écran de clôture mensuelle : vérifie qu'aucune écriture du mois n'est provisoire, contrôle la
clé SHA-1 de chaque écriture validée, pose `cloturee`, `dteval` et le numéro définitif
`numerodef`, puis avance `Fiches_Parametres.dtepc` et `numecriture2`.

## Points clés

- Tout le traitement est dans `Button1_Click` (CC 17) ; tables en dur (`Fiches_Mvt`,
  `Fiches_Parametres`).
- Vérification d'intégrité par `Sha1Calc.CalcSha1_Verify` avant chaque mise à jour.
- Une requête `UPDATE` par écriture, sans transaction.
- Dates manipulées par découpage de chaîne alors que `LDate` fournit période et fin de mois.
- Ouvert en modal par `Fmenu.Menu46_Click` après contrôle du tunnel de réplication.

## Dépendances principales

- Utilise : `Utils` (db, dates, tunnel), `Sha1Calc`, `ProgBar`, `Start`, `Doc`.
- Utilisé par : `Fmenu` (1 appel).

## Risques

- **Interruption** (bouton Arrêter ou clé invalide) : clôture partielle ; après Arrêter, la
  période est malgré tout marquée clôturée (`dtepc` avancé).
- Aucun contrôle de fin d'exercice (`dteclec` lu, non utilisé).
- Table des paramètres vide → `Quit` de l'application.
- `dteval` dépend de la date du jour : les replays doivent figer l'horloge.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 116 |
| Lignes de commentaire | 25 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 25 |
| Complexité max (fonction) | 17 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 replays (FCLOTURE-T01 à T07 : nominal, provisoires, SHA-1 altérée, décembre, interruption,
mois vide, hors exercice) et 1 gbtest (T08) sur le calcul de période après séparation. Liste à
valider par l'utilisateur (module complexe).

## Rework

7 étapes (FCLOTURE-001 à 007) : documentation, code mort, dates via `LDate`, `Cbase.Table`,
séparation traitement/GUI, simplification des conditions, réduction de portée. 3 anomalies
(FCLOTURE-A01 à A03).
