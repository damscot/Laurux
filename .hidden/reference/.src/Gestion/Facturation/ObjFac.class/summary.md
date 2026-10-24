# ObjFac — Synthèse

> Source : `.src/Gestion/Facturation/ObjFac.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Objet métier « document de vente à éditer » : charge un BL, une facture, une facture archivée ou
les BL de fin de mois d'un client, calcule totaux, TVA par taux, écotaxes, frais de gestion,
prépare les lignes imprimables (`ligne`), les écritures de vente (`ecrit`) et le texte de
règlement, porte ≈ 40 options d'édition lues dans `Start.LocalSettings`, archive le PDF en GED
et passe l'écriture comptable (`EcrAuto`).

## Points clés

- Jamais instancié directement : classe parente d'`ObjFacB` (lot Gestion/option), qui redéfinit
  `calcul` et `verifdat` en appelant `Super.` ; `Create Static` sert à l'énumération des types.
- ≈ 70 membres `Public` : la plupart sont lus par `ObjFacB`, `Editfac`, `EditfacB`, `OptFac`,
  `Moulinage` via des variables typées `ObjFacB` (invisibles pour `deps.py`).
- `calcul` (CC 45) concentre la logique ; tables en dur, `Cbase` presque absent.
- En fin de mois, `num` est le **suffixe de table** (`""`/`"M"`) et les BL viennent de la table de
  travail `Bl`.

## Dépendances principales

- Utilisé par : `ObjFacB` (héritage), et par son énumération : `Facture`, `OptFac`, `SaiReg`,
  `Facturefm`, `FacturefmA`, `Archives`, `Moulinage`, `ClotureF`, `Stockmvt`, `Caleditcmat`,
  `Editfac`.
- Utilise : `EcrAuto`, `VarEcr`, `VerifDate`, `LGed`, `LDate`, `LPrix`, `Numtostring`, `Utils`,
  ≈ 20 tables `Fiches_*` et la table de travail `Bl`.

## Risques

- Écotaxe TTC toujours nulle (A01) ; remises cumulées entre clients en fin de mois (A02) ; TVA des
  frais de gestion pour un client exonéré (A03, à confirmer).
- Option SMS lue sur la mauvaise clé (A04) ; SQL concaténé pour les tags GED (A05).
- Tables `M` (entretien) ignorées par `ecriturecompt`/`verifdat` (A06, à confirmer) ;
  `mult` avec `"O"` (A07) ; lectures sans `Available` (A08).
- Réduction de portée risquée : vérifier chaque membre contre `ObjFacB` (accès hérités).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 893 |
| Lignes de commentaire | 38 |
| Fonctions | 26 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 181 |
| Complexité max (fonction) | 45 (`calcul`) |
| Variables globales | 0 |
| Variables Public | 85 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

16 tests (OBJFAC-T01 à T16) : 13 `gbtest` sur base Docker avec le jeu `facturation_base`
(options, recherche du document, fiche client, calcul par type de document et de ligne, frais,
avoir, archive, fin de mois, écotaxes, cumul de remises, écriture comptable, origines,
performance) et 2 `replay` (GED, contrôles de dates). Module complexe : liste à valider avant la
phase 2.

## Rework

11 étapes (OBJFAC-001 à 011) : documentation, code mort (1 fonction, 14 variables), réduction de
portée de 8 membres, découpage de `calcul` et de `_new`, `Cbase.Table`, archivage GED via
`LGed.Archive` (après LGED-007), séparation des messages, nettoyage de types. 8 anomalies (A01 à
A08) soumises à validation.
