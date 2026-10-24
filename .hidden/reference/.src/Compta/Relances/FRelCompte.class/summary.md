# FRelCompte — Synthèse

> Source : `.src/Compta/Relances/FRelCompte.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Édition des relevés de compte clients (411) ou fournisseurs (401) sur une période : table de
travail `Fiches_Relcomptes`, liste des comptes avec totaux, PDF `~/tmp/RelCompte.pdf` pour tous les
comptes ou une sélection.

## Points clés

- Table de travail recréée à chaque rafraîchissement (`MajTab`, appelée par chaque bouton radio et
  après chaque édition).
- Clients filtrés par `cli_rlvc` ; fournisseurs tous inclus.
- Jumeau à 90 % de `FRelFacture`.

## Dépendances principales

- Utilise : `Utils.db`, `Creleve`, `Visualiseur`, `Doc`, `Utils.Cdate_*`.
- Tables : `Fiches_Mvt`, `Fiches_Cli`, `Fiches_Four`, `Fiches_Societes`, `Fiches_Relcomptes`.
- Utilisé par : `Fmenu.Menu30_Click`.

## Risques

- Erreur si un compte n'a pas de fiche tiers (FRELCOMPTE-A01).
- Contrôle de période faux (A02) ; traitement asymétrique clients/fournisseurs (A03).
- Une requête par écriture (N+1) sur de longues périodes.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 365 |
| Lignes de commentaire | 22 |
| Fonctions | 18 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 76 |
| Complexité max (fonction) | 23 (`Releves`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `replay` (FRELCOMPTE-T01 à T06) : listes clients/fournisseurs, éditions (toutes, sélection),
contrôle de période, compte sans fiche.

## Rework

8 étapes : documentation, code mort (`Compdate`, `Coulfond`), réduction de portée, base commune
avec `FRelFacture`, en-tête société commun, suppression du N+1, séparation traitement/GUI,
`Cbase.Table`. 3 anomalies (FRELCOMPTE-A01 à A03).
