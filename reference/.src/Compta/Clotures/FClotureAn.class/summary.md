# FClotureAn — Synthèse

> Source : `.src/Compta/Clotures/FClotureAn.class` · Synthèse des autres documents.

## Rôle

Écran de clôture annuelle : contrôle de la balance, sauvegarde `mysqldump`, rotation des 18
tables d'exercice (`Fiches_Mvt*`, `MvtA*`, `MvtM*`), report des écritures postérieures,
génération des à-nouveaux (dont le résultat sur `cptrsplus`/`cptrsmoins`), recalcul des soldes,
décalage des dates d'exercice et recalcul des clés SHA-1.

## Points clés

- Tout le traitement est dans `Button1_Click` (CC 74, ~530 lignes), sans transaction.
- `RENAME`/`DROP` en cascade puis `CopieTable` (structure seule) : un échec laisse une base
  intermédiaire.
- Recalculs de soldes dupliquant `Csolde` ; dates traitées par découpage de chaîne.
- Fenêtre non modale ouverte par `Fmenu.Menu60_Click`.
- Code mort notable : 15 cumuls de balance jamais lus, deux `UPDATE` sur une variable périmée,
  une purge sans effet, la table `ReportM`.

## Dépendances principales

- Utilise : `Utils.db` (`Exec`, `CopieTable`, `AutoIncrement`, `Engine`), `Utils.Cdate_*`,
  `Sha1Calc.CalcSha1_all`, `ProgBar`, `LDate`, `mysqldump`.
- Utilisé par : `Fmenu` (1 appel).
- Lien fort avec `DB_Connection.CopieTable` (DB_CONNECTION-A04), `Csolde`, `FCloture`.

## Risques

- **Sauvegarde ratée mais clôture poursuivie** (A01) ; sous SQLite, destruction de la base (A03).
- Report incomplet des écritures postérieures (colonnes perdues, comptes inconnus ignorés).
- Validation forcée de toutes les écritures du nouvel exercice (A06).
- Aucune pré-condition (caisse, ticket Z, moulinage, autres postes).
- Tests lourds : jeu d'exercice complet, horloge figée, diff de 18 tables.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 583 |
| Lignes de commentaire | 39 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 88 |
| Complexité max (fonction) | 74 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

12 replays (FCLOTUREAN-T01 à T12 : nominal, balance, périodes ouvertes, postérieures,
analytique/modifiées, deux clôtures, compte inconnu, provisoires, sauvegarde et son échec,
SHA-1, SQLite) avec diff complet des tables `Fiches_Mvt*`/`MvtM*`/`MvtA*`, `Fiches_Comptes`,
`Fiches_Parametres`, et 1 gbtest (T13) sur les dates. Liste à valider par l'utilisateur
(module complexe).

## Rework

14 étapes (FCLOTUREAN-001 à 014) : documentation, code mort, commonalisation avec `Csolde`,
`Utils.DumpBase`, `LDate`, `Cbase`, helpers de rotation/DDL/report, extraction du contrôle de
balance, séparation traitement/GUI, réduction de portée. 10 anomalies (FCLOTUREAN-A01 à A10),
dont A01 et A03 critiques.
