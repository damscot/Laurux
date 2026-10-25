# EdRup — Synthèse

> Source : `.src/Gestion/Impressions/EdRup.class` · Synthèse des autres documents.

## Rôle

Écran d'impression des **produits à commander** (ruptures) (`Fmenu.Menu253_Click`). Appelle
`Crupt.Rupture`, qui recrée les tables de travail `Rupture`/`RuptureC`, puis imprime
`~/tmp/Pcommande.pdf` (`Carticles`) : ruptures, détail des commandes clients, ventes en caisse.

## Points clés

- Seul appelant de `Crupt` ; tables `Rupture`/`RuptureC` hors `db_control.csv`, aussi modifiées
  par `Changefam`.
- `Button2_Click` : CC 73, 325 lignes, 3 sections, pas de `Catch`.
- Options `CheckBox1`/`CheckBox2` mémorisées dans `/Soc<XX>/Edrupt/*`.

## Dépendances principales

- `Crupt`, `Carticles` (`Level13*`, `Level14*`), `TriCpt`, `TriArticles`, `LDate`, `Utils`, `Cbase`.
- Tables : `Rupture`, `RuptureC`, `Fiches_Art`, `Fiches_Four`, `Fiches_HisLigTickets`,
  `Fiches_HisEntTickets`, `Fiches_Cli`.

## Risques

- Section ventes probablement en erreur SQL (colonne `date` ambiguë).
- `UPdate RuptureC` sans effet ; contrôle fournisseur inopérant.
- Collision multi-poste sur les tables de travail.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 503 |
| Lignes de commentaire | 46 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 122 |
| Complexité max (fonction) | 73 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 `replay` (EDRUP-T01 à T09) avec comparaison du PDF, des `Exec_SQL` et du contenu de
`Rupture`/`RuptureC`, et 1 `gbtest` (T10) sur la quantité à commander. Module à scénarios à faire
valider (chaîne `EdRup` + `Crupt`).

## Rework

7 étapes (EDRUP-001 à 007) : documentation, code mort, découpage de `Button2_Click`, constantes de
tables communes avec `Crupt`/`Changefam`, extraction du calcul de quantité, socle `EdSelection`,
réduction de portée. 6 anomalies (EDRUP-A01 à A06).
