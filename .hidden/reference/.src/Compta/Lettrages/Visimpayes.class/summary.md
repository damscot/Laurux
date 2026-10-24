# Visimpayes — Synthèse

> Source : `.src/Compta/Lettrages/Visimpayes.class` · Synthèse des autres documents.

## Rôle

Ancien écran de visualisation des impayés clients (comptes `411…` non lettrés de `Fiches_Mvt`),
avec détail par client et retrait d'une écriture par lettrage forcé.

## Points clés

- **Aucun point d'entrée** dans l'application : couple `.class` + `.form` mort.
- Détruit et recrée les tables de travail `Facturefm` et `Detail` à chaque ouverture.
- En-tête et titre copiés de la facturation de fin de mois.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.Coulfd`, `Utils.Cdate_Aff`, `Doc` ; tables `Fiches_Mvt`,
  `Fiches_Cli`, `Fiches_Parametres`, `Facturefm`, `Detail`.
- Utilisé par : personne.

## Risques

- A02 : si l'écran était réactivé, il casserait `Facturefm` utilisée par `FacturefmA`/`ObjFacB`.
- A03 : lettrage forcé de toutes les lignes d'une écriture, sans SHA1.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 157 |
| Lignes de commentaire | 29 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 18 |
| Complexité max (fonction) | 7 (`recup_bl`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 gbtest conditionnel (instanciation directe), utile seulement si le fichier est conservé.

## Rework

1 étape de documentation. 3 anomalies, dont la suppression du couple mort (A01).
