# Pointage — Tests

> Source : `.src/Compta/Pointage.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI sans API publique de calcul : tous les tests sont des **replays**. Le critère est le dump
normalisé de `Fiches_Rappro`, `Fiches_Comptes` (`solde`, `soldep`) et des 6 tables `Fiches_Mvt` …
`Fiches_Mvt5` (colonnes `pointee`, `nrlv`) ; les valeurs affichées (totaux, solde théorique,
écart, `Selcnt`) sont comparées dans le log GUI.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| POINTAGE-T01 | replay | Choix du compte | saisie `512000` + Entrée ; puis via `ToggleButton3` (TriCpt) ; puis compte inexistant | intitulé, solde, solde pointé, grille remplie ; message « n'existe pas » ; aucune écriture en base | `.hidden/Tests/Compta/assets/pointage_choix_compte/` | implémenté (sans ToggleButton3/TriCpt) |
| POINTAGE-T02 | replay | Création d'un relevé | compte avec un relevé antérieur, `Nrel` nouveau + Entrée, « Oui » | ligne `Fiches_Rappro` créée (date = fin du mois suivant, solde = `soldep`) ; solde de départ = relevé précédent | `.hidden/Tests/Compta/assets/pointage_creation_releve/` | implémenté |
| POINTAGE-T03 | replay | Pointage | relevé ouvert, sélection de 3 écritures (clic), solde final saisi, Pointer | `pointee = 1`, `nrlv` = relevé sur les 3 écritures ; `soldep` mis à jour (dernier relevé) ; totaux/écart affichés | `.hidden/Tests/Compta/assets/pointage_pointage/` | implémenté (« Tout sélectionner » au lieu de 3 clics : grille TriGen non rejouable) |
| POINTAGE-T04 | replay | Dépointage | relevé de T03, filtre « pointées », sélection d'une écriture, Dépointer | `pointee = 0`, `nrlv` NULL sur l'écriture ; `soldep` réécrit (figé) | `.hidden/Tests/Compta/assets/pointage_depointage/` | implémenté (tout le relevé 2 dépointé : sélection individuelle non rejouable) |
| POINTAGE-T05 | replay | Rappel d'un relevé existant | `ToggleButton1`, choix d'un relevé intermédiaire puis du dernier | soldes de départ/final, filtre « pointées du relevé », `IsLast` (dernier seulement) | `.hidden/Tests/Compta/assets/pointage_rappel_releve/` | implémenté (relevé intermédiaire 2 après création du 3 ; rappel du relevé 1 sans précédent non rejouable, voir Détail) |
| POINTAGE-T06 | replay | Suppression d'un relevé (« Oui ») | relevé pointé, Supprimer, « Oui » | relevé supprimé ; `Fiches_Mvt` dépointé (`nrlv = ''`) ; `Fiches_Mvt1-5` inchangées (A02 figée) ; `solde` recalculé, `soldep` inchangé (A03 figée) | `.hidden/Tests/Compta/assets/pointage_suppression_oui/` | implémenté |
| POINTAGE-T07 | replay | Suppression d'un relevé (« Non ») | même départ, réponse « Non » | relevé **supprimé quand même** (A01 figée) | `.hidden/Tests/Compta/assets/pointage_suppression_non/` | implémenté (A01 figée : relevé supprimé) |
| POINTAGE-T08 | replay | Tout sélectionner / désélectionner | filtre « non pointées » puis `SelectAllFil`, `DeSelectAllFil` | `Selcnt` et totaux attendus ; aucune écriture en base | `.hidden/Tests/Compta/assets/pointage_selection_filtre/` | implémenté (totaux non comparés ; requêtes totalpointe comparées) |
| POINTAGE-T09 | replay | Filtres d'affichage | Toutes / Pointées / Non pointées / Relevé unique, période `dtinf`–`dtsup` | contenu de la grille (log) | `.hidden/Tests/Compta/assets/pointage_filtres/` | implémenté (requêtes de la grille comparées) |
| POINTAGE-T10 | replay | Pointage multi-exercices | base avec `Fiches_Mvt1` (exercice précédent), écritures non pointées sur les deux exercices | `enregistrepointage` met à jour `Mvt` et `Mvt1` ; totaux corrects | `tests/multi_exercices/` | à faire : après création d'un relevé, la période modifiée (dtinf 2017) n'est pas reprise par « Tout sélectionner » au rejeu (seules les écritures 2018 sont pointées) ; à analyser |
| POINTAGE-T11 | replay | Impression | trois modes (relevé, pointées sans relevé, non pointées) | PDF `~/tmp/Pointage.pdf` converti en texte (`pdftotext`) identique ; filtre de date partiel figé (A06) | `tests/impression/` | à faire : sortie non comparée (~/tmp/Pointage.pdf) |
| POINTAGE-T12 | replay | Modification des dates et soldes du relevé | changer `Dte`, `Dterappro`, `Sldfinal` (LostFocus) | `Fiches_Rappro` mis à jour ; écart recalculé | `.hidden/Tests/Compta/assets/pointage_maj_releve/` | implémenté |
| POINTAGE-T13 | replay | SQLite | T01 + T03 sur `Laurux01.sqlite` | comportement à établir (`IF()` MySQL, A05) ; figer le résultat actuel | `tests/sqlite/` | à faire : le runner ne rejoue que sur MariaDB (pas de base SQLite de test) |

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

### Implémentation (phase 2, agent 5)

- Scénarios `.hidden/Tests/Compta/assets/pointage_*/`, date figée **2018-06-15**, jeu `.hidden/Tests/Compta/assets/pointage_shared/pointage_rappro.sql`
  (512000 : relevés 1 et 2, report à nouveau journal 90, écritures 2018 pointées sur le relevé 2 et non pointées,
  2 écritures 2017 non pointées dans `Fiches_Mvt1` ; `solde` 1345, `soldep` 1100). Menu `Fmenu#Menu67#Menu7#Menu61`.
- La grille `TriGen` est construite après la pose des observateurs : aucune sélection ligne à ligne ; les scénarios
  passent par `SelectAllFil`/`DeSelectAllFil` (sélection de toutes les lignes filtrées).
- T05 : le rappel du relevé 1 (aucun relevé précédent) appelle `Message.Error` depuis `Colrlv_Man` ; la boîte n'est
  pas la fenêtre active pour le rejeu (code 3), vraisemblablement à cause de la relance de `Colrlv_Man` par
  `Nrel_LostFocus` pendant l'ouverture de la boîte. Non rejoué.
- T09 : la saisie de `dtinf`/`dtsup` (groupe `Dte`) exécute `Update_Rappro` sans relevé saisi :
  `UPdate Fiches_Rappro … where cpt = '512000' and nreleve = NULL` (sans effet, candidat anomalie mineure).
- T03 : `enregistrepointage` exécute aussi l'`UPDATE` sur `Fiches_Mvt1` avec les numéros de `Fiches_Mvt`
  (`numero in (9,12,13)`) : sans effet ici, mais une collision de numéros entre exercices pointerait une écriture
  de l'exercice précédent (candidat anomalie).
