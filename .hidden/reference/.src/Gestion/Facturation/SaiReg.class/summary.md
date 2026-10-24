# SaiReg — Synthèse

> Source : `.src/Gestion/Facturation/SaiReg.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de saisie des règlements clients/fournisseurs : choix du mode de règlement et du tiers,
sélection des pièces à lettrer (écritures, factures, BL), constitution d'un bordereau, validation
comptable par `EcrReg`, éditions par `EdReg`. Il sert aussi, incrusté par `ObjFacB.editef`, à
saisir le règlement d'une facture (mode caisse) et, en mode « Facture », à facturer des BL cochés
via les tables de travail de fin de mois et `OptFac`.

## Points clés

- 56 fonctions ; `nreg_LostFocus` (CC 23) et `affsel` (CC 24) sont les plus complexes.
- Deux modes de validation : Saisie (règlement par règlement) et Bordereau (reprise des
  écritures en attente du compte interne, validation groupée à une date).
- `Listreg` est une `ListView` : ses clics ne sont pas rejoués (REPLAYOBSERVER-A06).
- Événement `RegCaisse` déclaré à 3 paramètres, levé à 4, sans gestionnaire.

## Dépendances principales

- Utilisé par : `Fmenu` (3 points d'entrée), `ObjFacB` (incrustation, `Form_Close`).
- Utilise : `VarEcr`, `Listextcpt`, `EcrReg`/`EcrAuto`, `EdReg`, `VerifDate`, `TriCpt`, `OptFac`,
  `Fiches_Reglements`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Comptes`, `Fiches_Bl[M]`,
  `Fiches_HistoFac[M]`, `Fiches_Cli`, tables de travail `Facturefm`/`Bl`.

## Risques

- Écritures comptables : module complexe, scénarios à valider avant la phase 2.
- Mode « Facture » : transaction jamais validée, `numlot` utilisé comme suffixe de table (A02).
- Échec d'écriture suivi d'une remise à blanc (A03, à confirmer) ; lectures sans `Available`
  (A04) ; montants relus selon la locale (A05) ; arité de `RegCaisse` (A01, latente).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 913 |
| Lignes de commentaire | 19 |
| Fonctions | 52 |
| Fonctions Public | 39 |
| Complexité cyclomatique totale | 207 |
| Complexité max (fonction) | 24 (`affsel`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

11 tests `replay` (SAIREG-T01 à T11) : saisie avec lettrage, modification/suppression,
bordereau, éditions, décaissement, filtres, ouverture de documents, mode « Facture », mode
caisse, fermeture, période close. Comparaison du dump (écritures, lettrage, soldes) et des PDF.

## Rework

7 étapes (SAIREG-001 à 007) : documentation, code mort (`impecr`, `quite_Click`), réduction de
portée de 6 fonctions, impression commune, découpage de `nreg_LostFocus`/`affsel`, séparation
écriture/messages, helper des tables de travail. 5 anomalies (A01 à A05) soumises à validation.
