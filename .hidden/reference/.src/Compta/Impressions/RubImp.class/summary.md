# RubImp — Synthèse

> Source : `.src/Compta/Impressions/RubImp.class` · Synthèse des autres documents.

## Rôle

Écran « Impression bilan/SIG/compte de résultat » (Comptabilité > Compte de résultat >
Impression, `Fmenu.Menu124_Click`) : choix de l'édition, de l'exercice (`E1`, `N1`…`N5`) et de la
période. Délègue le bilan à `Imp_Bilan` et les SIG à `Imp_Sig` ; calcule et imprime lui-même le
**compte de résultat** (colonnes N et N-1, `Cresultat`, `~/tmp/Resultat.pdf`).

## Points clés

- `Button2_Click` : 659 lignes, **CC 135**, 10 blocs (initialisation, table de travail, aiguillage,
  centralisation N, centralisation N-1, sous-totaux, totaux produits/charges, résultat, lignes R/G,
  impression).
- Centralisations N et N-1 quasi identiques ; requêtes sans `ORDER BY` dont l'ordre compte.
- Dates d'exercice : 20 lectures brutes de `dteclec*` dans 8 procédures (`Exo`…`Exo5` sont des
  copies), à remplacer par `LDate.Exercice_Cloture`.
- Code mort : `E0_Click`/`Ex1` (contrôle `E0` absent), `Raz` vide.

## Dépendances principales

- Appelé par : `Fmenu` (menu 124).
- Appelle : `Imp_Bilan.Lancement`, `Imp_Sig.Lancement`, `Cresultat`, `Visualiseur.Prog`, `Doc.Open`.
- Tables : `Fiches_Parametres`, `Fiches_Societes`, `Fiches_Rubriques`, `Fiches_RubCompt`,
  `Fiches_Mvt…Mvt5`, `Fiches_Comptes` ; table de travail `centralisation`.

## Risques

- Contrôle des dates saisies faux (A02, à confirmer) ; en-tête N-1 décalé d'un jour (A03).
- Ordre du détail N-1 (A04) ; CSV en double (A05) ; dépendance à l'ordre physique (A06, SQLite).
- Réécriture à haut risque : conserver requêtes et ordre, comparer PDF + CSV + dump.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 983 |
| Lignes de commentaire | 62 |
| Fonctions | 29 |
| Fonctions Public | 29 |
| Complexité cyclomatique totale | 198 |
| Complexité max (fonction) | 135 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests (RUBIMP-T01 à T10) : 9 replays (bénéfice non détaillé, perte détaillée, exercices
antérieurs, aiguillage bilan/SIG, dates proposées, contrôle des dates, quitter, SQLite,
performance) comparant le texte du PDF (`pdftotext`, pied de page normalisé), le CSV et le dump de
`centralisation` ; 1 gbtest sur les bornes d'exercice après commonalisation.

## Rework

10 étapes (RUBIMP-001 à 010) : documentation, code mort, dates d'exercice par `LDate`, helpers
communs avec `Imp_Bilan`/`Imp_Sig`, découpage de `Button2_Click` et fusion des centralisations N/N-1
sans changement SQL, séparation traitement/GUI, réduction de portée, `Cbase`, retour du chemin PDF
par les modules d'édition. 7 anomalies (A01 à A07).
