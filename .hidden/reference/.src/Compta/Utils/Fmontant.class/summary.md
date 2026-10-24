# Fmontant — Synthèse

> Source : `.src/Compta/Utils/Fmontant.class` · Synthèse des autres documents.

## Rôle

Écran « Recherche d'une somme » : recherche d'écritures de l'exercice en cours par montant, par
libellé ou par numéro de document, filtrée par type de compte ; ouverture de l'écriture trouvée
dans `Saisecrit` ou `Tresor` pour modification, puis recalcul des soldes.

## Points clés

- `Button2_Click` (CC 41) mélange contrôles de saisie, construction du filtre et requête.
- Requêtes sur `Fiches_Mvt LEFT JOIN Fiches_Comptes`, valeurs **concaténées** dans `LIKE`.
- Ouvert depuis `Fmenu` (« Recherche d'un montant ») et `SaiReg` (bouton `somme`).
- Après modification, `Csolde.Recalc_solde()` recalcule tous les comptes.

## Dépendances principales

- Utilise : `Utils` (`db`, `PointBase`, `Cdate_Aff`, `SetEditColor`, `Observers`), `Csolde`,
  `Saisecrit`, `Tresor`, `Doc` ; tables `Fiches_Mvt`, `Fiches_Comptes` en dur.
- Utilisé par : `Fmenu.Menu40_Click`, `SaiReg.somme_Click`.

## Risques

- Injection / erreur SQL sur apostrophe (A01).
- Filtre « compte collectif » incohérent selon le type de compte (A02).
- Contrôle de clôture possiblement fait sur la mauvaise ligne (`Item` au lieu de `Current`, A04).
- Résultat périmé réaffiché après une saisie refusée (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 168 |
| Lignes de commentaire | 42 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 58 |
| Complexité max (fonction) | 41 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `replay` (FMONTANT-T01 à T06) : recherches par montant, libellé, document et combinées,
saisie refusée, clôture, modification (dump). 1 test `gbtest` (T07) sur la fonction de filtre
extraite par FMONTANT-004.

## Rework

5 étapes (FMONTANT-001 à 005) : documentation, code mort, portée d'`affichage`, séparation
traitement/GUI à SQL identique, `Cbase.Table`. 5 anomalies (A01 à A05) soumises à validation.
