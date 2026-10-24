# TresorFac — Synthèse

> Source : `.src/Gestion/Reglements/TresorFac.class` · Synthèse des autres documents.

## Rôle

Ancienne variante de l'écran de trésorerie (`Tresor`) pour la saisie des règlements clients :
écriture client + contrepartie de trésorerie + collectif dans `Fiches_Mvt`, validation, lettrage
du lot, mise à jour des soldes.

## Points clés

- **Code mort** : aucun point d'entrée (ni menu, ni `Prgm`, ni `New`) ; en-tête « Tresor.class ».
- 37 fonctions homonymes de `Tresor`, qui en est l'évolution maintenue.
- Recherche de compte cassée (`Comptabilite.Bsel`/`sCmpt` jamais alimentés, `Bsel`/`Bval` absents).
- `Ecrit3` (rappel d'écriture) jamais rempli : `ecritv` n'est pas appelé.
- `Cmpt_KeyPress` (CC 44) et `Ecrit3_Click` (CC 24) concentrent la complexité.

## Dépendances principales

- Utilise : `Utils.db` et utilitaires de date/montant, `TriCpt`, `FCalc`, `Comptabilite`, `Doc` ;
  tables `Fiches_Mvt`, `Fiches_Comptes`, `Fiches_Parametres`, `Fiches_Journaux`.
- Utilisé par : personne.

## Risques

- Aucun en production (inatteignable). Si on le réactivait : erreurs d'indice sur `Ecrit1`
  (TRESORFAC-A03), sélection de compte en erreur (A02), numérotation sans verrou (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1081 |
| Lignes de commentaire | 33 |
| Fonctions | 45 |
| Fonctions Public | 45 |
| Complexité cyclomatique totale | 225 |
| Complexité max (fonction) | 44 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 gbtest de compilation après suppression (T01) ; 1 replay conditionnel (T02, saisie d'un
règlement via un lanceur dédié) si la suppression est refusée.

## Rework

Recommandation : suppression du couple (TRESORFAC-A01, validation utilisateur). À défaut,
4 étapes (TRESORFAC-001 à 004 : documentation, code mort, `Csolde`, portée). 4 anomalies
(A01 à A04).
