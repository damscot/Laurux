# Dup — Synthèse

> Source : `.src/Compta/Utils/Dup.class` · Synthèse des autres documents.

## Rôle

Écran « Duplication de sociétés » : copie le paramétrage comptable de la société courante
(`Laurux<XX>`) vers une autre base `Laurux<YY>` (créée si besoin par `LauruxConf.Createbase`), et en
option ses clients, fournisseurs, familles, articles, commentaires et main-d'œuvre.

## Points clés

- Tout le traitement est dans `Button1_Click` (CC 82, 205 lignes) : 20 blocs `DROP` +
  `CREATE TABLE <cible> SELECT * FROM <source>` presque identiques, plus `Fiches_Comptes` traité par
  `DELETE`/`INSERT … SELECT` et des remises à zéro (compteurs, soldes, stock).
- SQL inter-bases MySQL (`<base>.<table>`) et liste des bases par `Shell mysql` : écran
  **MySQL uniquement**.
- Ouvert depuis le menu Admin (`Fmenu`) et `Fsoc`, sous mot de passe si `Admin` est actif.

## Dépendances principales

- Utilise : `Utils.db` (`Exec`, `Databases`, `Login`, `Password`), `LauruxConf.Createbase`,
  `Start.LocalSettings`, `Doc.Open` ; 21 tables `Fiches_*` en dur.
- Utilisé par : `Fmenu` (`Menu150_Click`), `Fsoc` (choix 6).

## Risques

- **Structure de la base cible dégradée** : `CREATE TABLE … SELECT` ne recopie ni clés ni
  `AUTO_INCREMENT` (DUP-A01, grave).
- Mot de passe MySQL en clair sur la ligne de commande ; `sql_mode` de session modifié sans
  restauration.
- Aucune reprise possible en cas d'échec au milieu de la copie (DDL non transactionnels).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 230 |
| Lignes de commentaire | 25 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 89 |
| Complexité max (fonction) | 82 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `replay` (DUP-T01 à T06) sur MariaDB Docker : liste des bases, duplication vers base
neuve ou existante, combinaisons d'options sur les comptes de tiers, refus, `sql_mode`. Le dump
normalisé de la base cible, structure comprise, fait foi.

## Rework

5 étapes (DUP-001 à 005) : documentation, helper de copie à SQL identique (CC 82 → ≤ 15),
`Utils.BasesLaurux`, séparation traitement/GUI, code mort. 4 anomalies (A01 à A04) soumises à
validation utilisateur.
