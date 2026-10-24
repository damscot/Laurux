# JournauxA — Synthèse

> Source : `.src/Compta/Impressions/JournauxA.class` · Synthèse des autres documents.

## Rôle

Écran « Impression des journaux analytiques » (menu Compta, modal). Imprime en PDF les écritures
analytiques (`Fiches_MvtA`) entre deux postes, groupées par poste puis journal ou par journal puis
poste, suivies d'une page de centralisation par compte.

## Points clés

- Copie de `Journaux` (55 % de lignes communes) qui embarque sa propre copie de
  `JournauxM.Imprime` dans `Button1_click` (CC 24).
- Le choix d'exercice ne règle que les dates : `Tab0` est renseigné mais jamais lu.
- La saisie de date accepte une forme courte (jour, ou jour.mois) complétée avec le mois et
  l'année courants : seule variante par rapport à `Journaux`.
- Beaucoup de code mort : `donnees1..3`, `ordre`, `Datep`, `Shell "cd"`, lecture de `dtepc`.

## Dépendances principales

- Ouvert par `Fmenu.Menu292_Click` ; aucun autre appelant.
- `Ccompta` (rendu PDF), `Visualiseur`, `Utils` (dates, `db`), `Cbase.Table` (`TabMvtA`,
  `TabPostes`, `TabJour`, `TabSoc`, `TabComptes`), table de travail `centralisation`.

## Risques

- Le chemin nominal semble ne pas pouvoir aboutir (à confirmer par replay) : `level2J` appelé
  avec un argument manquant (A01), colonne `intitule` inexistante dans `Fiches_Postes` (A02),
  compte écrit dans `njournal Char(2)` (A04).
- Libellés lus avec `>=` sans tri (A03) ; exercice ignoré et ruptures imprimées hors période
  (A05) ; en-tête de saut de page incohérent (A06).
- Toute correction de `Ccompta.level2J` (paramètre `Nlot` optionnel) change ce comportement.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 664 |
| Lignes de commentaire | 24 |
| Fonctions | 40 |
| Fonctions Public | 40 |
| Complexité cyclomatique totale | 128 |
| Complexité max (fonction) | 24 (`Button1_click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests `replay` (JOURNAUXA-T01 à T08) : liste des postes, deux ordres de tri, écritures hors
période, aucune écriture, complétion de date, choix d'exercice, fermeture. Plusieurs figent une
erreur actuelle. Le jeu de données dérivé doit fournir des postes et des écritures analytiques
(`Laurux01.sql` n'en a pas) ; `sql_mode` MariaDB à fixer.

## Rework

7 étapes sans changement de comportement (JOURNAUXA-001 à 007) : documentation, code mort,
adoption du socle `ImpCompta` (exercice, contrôle de date avec complétion, centralisation),
extraction des ruptures, réduction de portée. 6 anomalies (JOURNAUXA-A01 à A06), à arbitrer avant
toute séparation traitement/GUI de l'impression.
