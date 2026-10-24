# Journaux — Synthèse

> Source : `.src/Compta/Impressions/Journaux.class` · Synthèse des autres documents.

## Rôle

Écran « Impression des journaux » (menu Compta). L'utilisateur choisit un exercice (table
`Fiches_Mvt` … `Fiches_Mvt5`), une période, un intervalle de journaux, un tri et l'option des
totaux. Deux sorties : l'impression PDF, déléguée à `JournauxM.Imprime`, et un export texte
`~/tmp/journaux.txt` (champs `;`) dont l'ordre des colonnes est configuré par `journauxSetting`.

## Points clés

- Sélection d'exercice (`Ex1`, `Exo`…`Exo5`), contrôle des dates, listes de journaux et
  navigation clavier recopiés à l'identique dans `Jourcent` (78 % de lignes communes),
  `JournauxA` (59 %), et en partie dans `EcrM`, `Balance`, `Editcompte`, `EditcompteA`, `RubImp`.
- L'export (`Button4_Click`, CC 22) lit tout l'exercice et filtre la période en Gambas, relit la
  configuration 32 fois par ligne et recrée inutilement la table `centralisation`.
- Code mort : `Createtable`, `donnees1`/`donnees2`, `Janx`, cumuls jamais exportés.
- L'auto-instance est lue par `JournauxM`, `EcrM` et `Extrait`, ce qui peut l'instancier
  cachée.

## Dépendances principales

- Ouvert par `Fmenu.Menu32_Click` ; appelle `JournauxM.Imprime` (dépendance circulaire par
  `Journaux.Mouse`) et `journauxSetting.ShowModal`.
- `Utils` (dates, `cpoint`, `db`), `Start.LocalSettings` (`/ExportJournal<soc>/…`),
  `Editeur.Prog_Editeur`, `Doc.Open`.
- Tables : `Fiches_Parametres`, `Fiches_Journaux`, `Fiches_Comptes`, `Fiches_Mvt*` (en dur),
  `centralisation` (DDL).

## Risques

- Le tri « numéro/date/compte » n'est jamais appliqué à l'impression : la commande
  `RadioButton1` est passée au lieu de sa valeur (A01).
- Export : solde jamais remis à zéro, même entre deux exports (A02) ; colonnes résiduelles après
  changement de configuration (A03) ; dépassement d'indice si la configuration est modifiée à la
  main (A06).
- Correction d'une date invalide : la période de l'exercice précédent est rechargée, quel que soit
  l'exercice choisi (A07, comportement exact à confirmer).
- DDL inutile sur `centralisation` dans l'export (A04) ; PDF non supprimé en quittant (A05).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 621 |
| Lignes de commentaire | 33 |
| Fonctions | 45 |
| Fonctions Public | 45 |
| Complexité cyclomatique totale | 129 |
| Complexité max (fonction) | 22 (`Button4_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests `replay` (JOURNAUX-T01 à T10) : ouverture, choix d'exercice, contrôles de dates, listes
de journaux, tri, export (configuré, sans configuration, successifs, période partielle),
fermeture. L'impression elle-même est couverte par JOURNAUXM-T01 à T12. Jeu de données dérivé
nécessaire (`Laurux01.sql` sans écriture) et date système figée pour `Ex1`.

## Rework

9 étapes sans changement de comportement (JOURNAUX-001 à 009) : documentation, code mort, création
des helpers communs (bornes d'exercice et contrôle de date de BALANCE-004/005 ; table d'exercice
et liste des journaux du module `ImpCompta`)
repris par les autres éditions comptables, optimisation et extraction de l'export, réduction de
portée. 7 anomalies (JOURNAUX-A01 à A07) soumises à validation utilisateur.
