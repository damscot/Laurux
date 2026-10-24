# Sha1Calc — Synthèse

> Source : `.src/Utils/Sha1Calc.module` · Synthèse des autres documents.

## Rôle

Calcul et vérification des clés de contrôle chaînées (SHA1 encodé en Base64, colonne `control`)
garantissant l'inaltérabilité des écritures comptables (`Fiches_Mvt*`, avec historique des
modifications dans `Fiches_MvtM*`) et des tickets de caisse (`Fiches_EntTicketz`).

## Points clés

- `CalcSha1` (CC 15) : clé de l'écriture précédente (ou de sa première version modifiée, ou d'une
  écriture supprimée), plus les deux dernières clés de modification de l'écriture courante, plus les
  champs de chaque ligne.
- `CalcSha1_all` recalcule toute une table (migrations, clôture annuelle, programme `CalcSha1`).
- `CalcSha1_Verify` sert au contrôle d'anomalies et à la clôture.
- `CalcSha1T` chaîne les tickets au ticket précédent (table courante puis historique).
- La liste des champs hachés est un contrat persistant : ne jamais la modifier.

## Dépendances principales

- Utilise : `Utils.db`, `ProgBar`.
- Utilisé par : environ 20 fichiers de comptabilité et de caisse (`Moulinage`, `Tresor`, `Saisecrit`,
  `EcrAuto`, `impfec`, `Anomalies`, `FCloture`, `FClotureAn`, `LauruxMaj`, `Caisse`…).

## Risques

- Une modification involontaire de la concaténation invalide toutes les clés existantes, sans erreur
  visible avant le contrôle d'anomalies.
- Clés dépendantes de la conversion texte des types du pilote (A01) ; `control` NULL accepté (A02).
- Coût : 4 à 5 requêtes par écriture, par ligne en vérification.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 115 |
| Lignes de commentaire | 15 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 31 |
| Complexité max (fonction) | 15 (`CalcSha1`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests prévus (SHA1CALC-T01 à T09) : 8 `gbtest` (recalcul complet, écriture isolée, chaînage avec
modifications et suppressions, vérification, moteurs MySQL/SQLite, tickets, tables d'exercices,
performance) et 1 `replay` (édition des anomalies). Clés attendues produites par le clone de référence.

## Rework

5 étapes sans changement de comportement (SHA1CALC-001 à 005) : documentation, code mort, découpage
de `CalcSha1`, séparation de la barre de progression, simplification de `CalcSha1T`.
2 anomalies (SHA1CALC-A01, A02).
