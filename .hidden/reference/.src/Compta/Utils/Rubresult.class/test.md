# Rubresult — Tests

> Source : `.src/Compta/Utils/Rubresult.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie : les scénarios partent de `Fmenu` (Comptabilité > Compte de résultat > Gestion des
rubriques). Le critère est le dump normalisé de `Fiches_Rubriques` et `Fiches_RubCompt` (structure
**et** contenu, l'import recréant les tables).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RUBRESULT-T01 | replay | Création d'une rubrique | `R9990`, intitulé avec apostrophe, type `l`, détail `n`, `P` saisi à la souris | ligne en majuscules, intitulé passé par `Utils.Remplace` ; dump | `tests/creation/` | à faire |
| RUBRESULT-T02 | replay | Modification | clic sur `B0050`, intitulé modifié, Entrée jusqu'à Enregistrer | dump : intitulé modifié, `num` inchangé (`Prod` sauté au clavier, A05 figée) | `tests/modification/` | à faire |
| RUBRESULT-T03 | replay | Suppression | sélection `B0050` ; Supprimer (Non puis Oui) | rubrique supprimée, plages `Fiches_RubCompt` de `B0050` conservées (A04 figée) | `tests/suppression/` | à faire |
| RUBRESULT-T04 | replay | Import complet | répertoire contenant `Bcr.txt`/`Bcrcpt.txt` produits par EXPRUB-T01 sur `Laurux01.sql` ; base modifiée au préalable | dump des deux tables identique à `Laurux01.sql` (aller-retour) ; `Message.Info` | `tests/import_complet/` | à faire |
| RUBRESULT-T05 | replay | Import sans `Bcrcpt.txt` (A01 figée) | répertoire avec `Bcr.txt` seul | `Fiches_Rubriques` rechargée, `Fiches_RubCompt` recréée vide, erreur d'exécution figée | `tests/import_incomplet/` | à faire |
| RUBRESULT-T06 | replay | Import sous SQLite (A03 figée) | base `Laurux01.sqlite`, même répertoire que T04 | erreur SQL sur `Truncate`, tables inchangées (à confirmer) | `tests/import_sqlite/` | à faire |
| RUBRESULT-T07 | replay | Import annulé et lignes mal formées | Importer → Non ; puis fichier avec une ligne sans `;` final et un intitulé contenant `;` | dump inchangé (Non) ; découpage figé | `tests/import_lignes/` | à faire |
| RUBRESULT-T08 | gbtest | Découpage d'une ligne (après RUBRESULT-005) | `"B0010;Actif;T;N;;"`, `"B0050;Frais;L"`, `"a;b;c;d;e;f"` | tableaux de champs identiques à l'algorithme actuel | `tests/decoupage_ligne/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié ; T04 utilise les fichiers
  produits par EXPRUB-T01 (même `HOME` isolé), ce qui teste aussi le format commun.
- **Dump** : inclure la définition des tables (`SHOW CREATE TABLE`) pour T04-T06, l'import faisant
  `DROP`/`CREATE`.
- **Non testable automatiquement** : sélection de répertoire dans `DirChooser` si l'observateur
  ne rejoue pas `Activate` (à confirmer en phase 2, sinon test manuel), son.
