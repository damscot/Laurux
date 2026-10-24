# Ecritures — Synthèse

> Source : `.src/Compta/Utils/Ecritures.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Consultation descendante des écritures en trois niveaux (soldes des comptes par type → extrait de
compte → détail d'une écriture avec clés d'intégrité) et accès à la modification d'une écriture non
clôturée par `Saisecrit` ou `Tresor`.

## Points clés

- Quatre handlers de type de compte copiés-collés ; SQL avec constante concaténée.
- Affiche la clé `control` mémorisée et la clé recalculée par `Sha1Calc` (sans mise à jour).
- Code mort : `type_compte`, `QuitteEcritjl`, lecture du collectif sur le mauvais `Result`.

## Dépendances principales

- Utilise : `Utils.db`, `Sha1Calc`, `Saisecrit`, `Tresor`, `Doc`.
- Tables : `Fiches_Comptes`, `Fiches_Mvt`.
- Utilisé par : `Fmenu.Menu10_Click`.

## Risques

- État de navigation dispersé dans 17 variables privées ; `type` incohérent (ECRITURES-A01).
- Clôture et trésorerie déduites de la dernière ligne de l'écriture (A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 374 |
| Lignes de commentaire | 29 |
| Fonctions | 18 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 66 |
| Complexité max (fonction) | 18 (`Necrit_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `replay` (ECRITURES-T01 à T07) : trois niveaux, clés d'intégrité, modification via
`Saisecrit` et `Tresor`, écriture clôturée, retour arrière.

## Rework

7 étapes : documentation, factorisation des handlers de type, code mort, réduction de portée de
`type_Click`, séparation traitement/GUI, `Cbase.Table`, simplification de `Necrit_Click`.
2 anomalies (ECRITURES-A01, A02).
