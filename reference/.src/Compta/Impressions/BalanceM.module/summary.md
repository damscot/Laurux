# BalanceM — Synthèse

> Source : `.src/Compta/Impressions/BalanceM.module` · Synthèse des autres documents.

## Rôle

Module d'**impression PDF des balances** (`~/tmp/Balance.pdf`), appelé par `Balance.Button1_Click`.
Il lit les comptes et leurs écritures, cumule période / hors période / classe / balance, et pilote
le rendu de `Cbalances` (`Inherits PdfWriter`).

## Points clés

- Une seule fonction utile, `Imprime` (CC 30, 207 LOC) ; état dans 43 variables `Private` de module.
- Requête d'écritures émise deux fois par compte (l. 102 et 106).
- Test `rrResult.count` au lieu de `rResult.count` : branche des comptes sans écriture inatteignable.
- En-tête de page répété 4 fois (`Imprime`, `Bas_page`, `Classe`, `Classe2`) ; `Classe2` est mort.
- Couplages GUI : `Balance.Mouse` (auto-instance), contrôle `TypeClient` passé en paramètre,
  `Message`, `Visualiseur.Prog`.

## Dépendances principales

- Appelant unique : `Balance.Button1_Click` (dépendance circulaire avec `Balance`).
- Utilise `Cbalances` (partagée avec `FTVA`), `Utils` (dates, `db`), `Cbase`, `TypeClient`,
  `Visualiseur`.
- Tables (lecture) : `Fiches_Comptes`, `Fiches_Societes`, `Fiches_Cli`, `Fiches_Mvt*` (paramètre).

## Risques

- **BALANCEM-A02** : les cumuls « hors période » incluent les écritures **postérieures** à la date de
  fin : le solde imprimé n'est pas un solde à date.
- **BALANCEM-A03** : rupture de classe en bas de page → page sans pied de page.
- État de module non remis à zéro après une erreur (A04).
- Aucun test existant.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 355 |
| Lignes de commentaire | 13 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 44 |
| Complexité max (fonction) | 30 (`Imprime`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests `replay` (BALANCEM-T01 à T10) lancés depuis l'écran `Balance` : balances client avec et sans
cumuls, générale avec ruptures de classe, saut de page, comptes non mouvementés, filtre par type de
client, exercice archivé, aucun compte, impressions successives, soldes nuls. Comparaison du texte
PDF (`pdftotext`) normalisé (date d'édition, utilisateur).

## Rework

8 étapes (BALANCEM-001 à 008) : documentation, code mort (`Classe2`, branche inatteignable, variables),
requête dupliquée supprimée (SQL modifié, dump identique), helper d'en-tête, découpage d'`Imprime`,
réduction de portée, filtre client en chaîne et curseur géré par l'écran (avec BALANCE-008),
`Cbase.Table("TabCli")`. 4 anomalies (BALANCEM-A01 à A04).
