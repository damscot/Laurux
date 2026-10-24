# Echeancier — Synthèse

> Source : `.src/Compta/Impressions/Echeancier.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Echéanciers » (menu Compta) : impression des factures clients (411) ou fournisseurs (401)
validées, non lettrées, hors trésorerie et hors collectif, dont l'échéance tombe dans une période,
avec les règlements de chaque lot ; tri par échéance ou par compte, filtre optionnel par mode de
règlement client. PDF `~/tmp/Echeancier.pdf` (`Ccompta`).

## Points clés

- `Dten1` (« Du ») est la borne basse, `Dten0` (« Jusqu'au ») la borne haute ; défauts = clôtures
  N-1 et N.
- Trois variantes de requête sur `Fiches_Mvt` (dont une aux noms de tables en dur), puis une
  requête de règlements par ligne.
- Signes produits par concaténation `"-" & montant`.
- Six méthodes `Draw` héritées, jamais appelées (code mort).

## Dépendances principales

- Appelé par `Fmenu.Menu303_Click` (`ShowModal`).
- Utilise `Utils.db`, `Utils.Cdate_*`, `Cbase.Table`, `Ccompta`, `Visualiseur`, `Doc`.
- Tables lues : `Fiches_Mvt`, `Fiches_Comptes`, `Fiches_Cli`, `Fiches_Reglements`,
  `Fiches_Parametres`, `Fiches_Societes`.

## Risques

- Règlement négatif : `"--x"` probable erreur de conversion ; règlements de sens inverse imprimés
  mais non totalisés (A01).
- En-tête sans période (A02) ; filtre de mode ignoré sans avertissement (A03).
- Débordement de page possible dans la boucle des règlements (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 386 |
| Lignes de commentaire | 46 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 67 |
| Complexité max (fonction) | 28 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests (ECHEANCIER-T01 à T10) : 9 replays (ouverture, clients/fournisseurs, tris, filtre de
mode, multipage, règlement négatif, saisie des dates, SQLite), PDF comparé après `pdftotext` et
normalisation de la date et de l'utilisateur ; 1 `gbtest` sur `Montant_Signe` après extraction.

## Rework

8 étapes (ECHEANCIER-001 à 008) : documentation, suppression des méthodes `Draw` mortes et des
variables inutiles, factorisation des sauts de page et de la requête (`Cbase.Table`), signe par
négation là où il est sûr, réduction de portée, séparation calcul/affichage, socle commun des
éditions. 5 anomalies (ECHEANCIER-A01 à A05).
