# Saisecrit — Synthèse

> Source : `.src/Compta/Saisecrit.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de saisie des écritures comptables des journaux d'achat, de vente et d'OD (les journaux de
trésorerie relèvent de `Tresor`, son quasi-clone). Il gère la saisie ligne à ligne, la TVA et la
ventilation automatiques, l'analytique, les masques d'abonnement, la validation (soldes des comptes
et des collectifs), le rappel et la suppression d'écritures, et l'attachement GED.
Ouvert depuis `Fmenu` (nouvelle écriture) et depuis `Extrait`, `Ecritures`, `Fmontant` (rappel).

## Points clés

- Fichier legacy : 3148 lignes, 102 fonctions, CC totale 654 ; `Cmpt_KeyPress` CC 72,
  `Button4_Click` CC 48.
- Les lignes saisies sont écrites aussitôt dans `Fiches_Mvt` en **provisoire** ; la validation
  efface puis réécrit l'écriture (`DelMvt2` + `Enrg_Ecr`) et met à jour les soldes de
  `Fiches_Comptes` en lecture-modification-écriture.
- Le `ColumnView` `Ecrit1` est le modèle de l'écriture (colonnes cachées 7 à 10).
- Contrôles regroupés (`Cmpt`, `Btn`) : une vingtaine de fonctions nommées comme des handlers
  (`Montant_GotFocus`, `Button4_Click`…) ne sont jamais levées par Gambas et servent de méthodes ;
  `numcompte_LostFocus` et `Dateech_DblClick` ne sont appelées par personne.
- 48 variables d'instance servent d'état partagé (drapeaux `LF`, `B`, `Modif`, `nvlle`…), dont
  8 inutiles (6 écrites sans jamais être lues, 1 jamais renseignée, 1 masquée).
- Tables en dur : `Fiches_MvtM`, `Fiches_Echeances`, `Fiches_Mvt` (`Sha1Calc`, `Ecr2`) ; `Fiches_Mvt1-5`
  ne sont jamais touchées.

## Dépendances principales

- Utilise : `Utils` (`db`, `cpoint`, dates, `Calcech`, `Observers`), `Cbase`, `LDate`, `LPrix`,
  `LVar`, `LGed`, `Sha1Calc`, `TextReg`, `TriCpt`, `TriEcritures`, `Comptabilite`, `Extrait`,
  `Analytique`, `Abont`, `FCalc`, `FComptes`/`FClient`/`FFournisseur`, `Doc`.
- Utilisé par : `Fmenu`, `Extrait`, `Ecritures`, `Fmontant` (constructeur uniquement).
- Handlers appelés dynamiquement par `ReplayObserver` : `Jour_Click`, `Vtl_Click`, `Libview_Click`,
  `Colabt_Click`, `Choix1_Click`.

## Risques

- Numérotation sans verrou (SAISECRIT-A01) et validation sans transaction, soldes calculés côté
  application (A02).
- SQL construit par concaténation de saisies (`LIKE` sur le compte, journal, `tag_def` sans quotes)
  (A03).
- Ergonomie : raccourcis du montant actifs seulement dans le champ échéance (A06), sélecteur de date
  jamais affiché (A04), question ignorée sur un numéro de document en double (A07).
- Table de travail `Ecrs` partagée entre postes et verrouillée de façon douteuse (A05).
- Constructeur appelé avec trois arguments par trois écrans (A09, à confirmer).
- Toute modification de l'ordre des effets de focus (`LF`, `B`) peut casser la saisie : rework
  limité aux extractions et au code mort.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 2528 |
| Lignes de commentaire | 210 |
| Fonctions | 102 |
| Fonctions Public | 101 |
| Complexité cyclomatique totale | 654 |
| Complexité max (fonction) | 72 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

17 tests prévus (SAISECRIT-T01 à T17) : 16 scénarios `replay` (achat, vente, OD et collectifs,
reprise d'une écriture provisoire, rappel d'une écriture validée, suppression, lignes, dates et
numérotation, masques d'abonnement, refus, raccourcis, analytique, GED, largeurs de colonnes,
SQLite, concurrence indicative) comparant le dump des tables comptables, et 1 `gbtest` sur les
fonctions pures extraites. Module complexe : liste des scénarios à valider par l'utilisateur avant
la phase 2.

## Rework

15 étapes sans changement de comportement (SAISECRIT-001 à 015) : documentation, suppression de
6 fonctions et 8 variables mortes, `Cbase.Table` pour les tables en dur, helper `LVar` commun,
extractions pures (`MontantTva`, `ControleDate`, `MontantsGed`, `ValideLigne`), chargement de la grille
factorisé, deux requêtes répétées réduites (SQL modifié, dump identique), largeurs de colonnes
communes, 36 fonctions passées `Private`, découpage de `Cmpt_KeyPress`, mise en commun avec
`Tresor` en phase 3. 9 anomalies (SAISECRIT-A01 à A09) soumises à validation utilisateur.
