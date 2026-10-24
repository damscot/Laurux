# Rubresult — Synthèse

> Source : `.src/Compta/Utils/Rubresult.class` · Synthèse des autres documents.

## Rôle

Écran de saisie des **rubriques** des éditions comptables (`Fiches_Rubriques` : numéro, intitulé,
type, détail, produit/charge) et d'**import du paramétrage** complet (rubriques et plages de
comptes) depuis `Bcr.txt`/`Bcrcpt.txt`. Ouvert par Comptabilité > Compte de résultat > Gestion
des rubriques (`Fmenu.Menu122_Click`).

## Points clés

- Préfixe du numéro = édition (`B` bilan, `R` compte de résultat, `S` SIG) ; le `type` pilote la
  mise en page des éditions.
- GUI avec SQL direct ; noms de tables en dur.
- Import destructif : `Truncate` + `DROP` + `CREATE` des deux tables, puis chargement ligne à ligne,
  sans transaction.
- Format de fichier partagé avec `Exprub` (export) ; squelette d'écran partagé avec `Rubcompt`.
- `Button3_Click` : handler nominal inactif (code mort).

## Dépendances principales

- Appelé par : `Fmenu` (menu 122).
- Utilise : `Utils.db` (`Exec`, `Engine`), `Utils.Remplace`, `Utils.SetEditColor`,
  `Utils.Observers`, `Doc.Open`, `Start.Son`/`Musique`.
- Données lues par `Imp_Bilan`, `Imp_Sig`, `RubImp` (éditions).

## Risques

- **Perte de données** à l'import si `Bcrcpt.txt` manque (contrôle erroné, A01) ou si une ligne
  provoque une erreur (A02).
- Import impossible sous SQLite (`Truncate`, A03, à confirmer).
- Suppression de rubrique laissant des plages orphelines (A04) ; champ `Prod` inaccessible au
  clavier et non vidé (A05).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 290 |
| Lignes de commentaire | 39 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 63 |
| Complexité max (fonction) | 21 (`BcrSelect_Activate`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests (RUBRESULT-T01 à T08) : 7 replays (création, modification, suppression, import complet en
aller-retour avec `Exprub`, import incomplet, import SQLite, lignes mal formées) comparant le dump
des deux tables (structure comprise), 1 gbtest sur le découpage de ligne après extraction.

## Rework

7 étapes (RUBRESULT-001 à 007) : documentation, code mort, réduction de portée, séparation
traitement/GUI, simplification de l'import, module commun d'export/import avec `Exprub`, clés
`Cbase`. 6 anomalies (A01 à A06).
