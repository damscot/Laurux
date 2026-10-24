# Pointage — Tests

> Source : `.src/Compta/Pointage.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI sans API publique de calcul : tous les tests sont des **replays**. Le critère est le dump
normalisé de `Fiches_Rappro`, `Fiches_Comptes` (`solde`, `soldep`) et des 6 tables `Fiches_Mvt` …
`Fiches_Mvt5` (colonnes `pointee`, `nrlv`) ; les valeurs affichées (totaux, solde théorique,
écart, `Selcnt`) sont comparées dans le log GUI.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| POINTAGE-T01 | replay | Choix du compte | saisie `512000` + Entrée ; puis via `ToggleButton3` (TriCpt) ; puis compte inexistant | intitulé, solde, solde pointé, grille remplie ; message « n'existe pas » ; aucune écriture en base | `tests/choix_compte/` | à faire |
| POINTAGE-T02 | replay | Création d'un relevé | compte avec un relevé antérieur, `Nrel` nouveau + Entrée, « Oui » | ligne `Fiches_Rappro` créée (date = fin du mois suivant, solde = `soldep`) ; solde de départ = relevé précédent | `tests/creation_releve/` | à faire |
| POINTAGE-T03 | replay | Pointage | relevé ouvert, sélection de 3 écritures (clic), solde final saisi, Pointer | `pointee = 1`, `nrlv` = relevé sur les 3 écritures ; `soldep` mis à jour (dernier relevé) ; totaux/écart affichés | `tests/pointage/` | à faire |
| POINTAGE-T04 | replay | Dépointage | relevé de T03, filtre « pointées », sélection d'une écriture, Dépointer | `pointee = 0`, `nrlv` NULL sur l'écriture ; `soldep` réécrit (figé) | `tests/depointage/` | à faire |
| POINTAGE-T05 | replay | Rappel d'un relevé existant | `ToggleButton1`, choix d'un relevé intermédiaire puis du dernier | soldes de départ/final, filtre « pointées du relevé », `IsLast` (dernier seulement) | `tests/rappel_releve/` | à faire |
| POINTAGE-T06 | replay | Suppression d'un relevé (« Oui ») | relevé pointé, Supprimer, « Oui » | relevé supprimé ; `Fiches_Mvt` dépointé (`nrlv = ''`) ; `Fiches_Mvt1-5` inchangées (A02 figée) ; `solde` recalculé, `soldep` inchangé (A03 figée) | `tests/suppression_oui/` | à faire |
| POINTAGE-T07 | replay | Suppression d'un relevé (« Non ») | même départ, réponse « Non » | relevé **supprimé quand même** (A01 figée) | `tests/suppression_non/` | à faire |
| POINTAGE-T08 | replay | Tout sélectionner / désélectionner | filtre « non pointées » puis `SelectAllFil`, `DeSelectAllFil` | `Selcnt` et totaux attendus ; aucune écriture en base | `tests/selection_filtre/` | à faire |
| POINTAGE-T09 | replay | Filtres d'affichage | Toutes / Pointées / Non pointées / Relevé unique, période `dtinf`–`dtsup` | contenu de la grille (log) | `tests/filtres/` | à faire |
| POINTAGE-T10 | replay | Pointage multi-exercices | base avec `Fiches_Mvt1` (exercice précédent), écritures non pointées sur les deux exercices | `enregistrepointage` met à jour `Mvt` et `Mvt1` ; totaux corrects | `tests/multi_exercices/` | à faire |
| POINTAGE-T11 | replay | Impression | trois modes (relevé, pointées sans relevé, non pointées) | PDF `~/tmp/Pointage.pdf` converti en texte (`pdftotext`) identique ; filtre de date partiel figé (A06) | `tests/impression/` | à faire |
| POINTAGE-T12 | replay | Modification des dates et soldes du relevé | changer `Dte`, `Dterappro`, `Sldfinal` (LostFocus) | `Fiches_Rappro` mis à jour ; écart recalculé | `tests/maj_releve/` | à faire |
| POINTAGE-T13 | replay | SQLite | T01 + T03 sur `Laurux01.sqlite` | comportement à établir (`IF()` MySQL, A05) ; figer le résultat actuel | `tests/sqlite/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : scénarios capturés dans le clone **Laurux non modifié**
  (`./Laurux -l --logfile …`, `-c <conf de test>`), puis rejoués sur les deux clones ; dump
  normalisé des tables listées et diff. Le rework POINTAGE-007 (suppression des doubles requêtes)
  change les lignes `Exec_SQL` : seul le dump fait foi.
- **Données** : `Laurux01.sql` + jeu dérivé `rappro.sql` : un compte `512` avec 2 relevés
  (`Fiches_Rappro`), 15 écritures sur l'exercice courant et 5 dans `Fiches_Mvt1` (T10), une ligne
  de report à nouveau au journal `90`.
- **Date du jour** : `_New` et la création de relevé utilisent `Now` ; le runner fixe la date ou
  saisit les dates explicitement.
- **Impression** : comparaison du texte extrait du PDF (dates d'édition masquées), pas du binaire.
- **Non testable automatiquement** : couleur de sélection de la grille (`TriGen_Data`), sons,
  aide HTML.
