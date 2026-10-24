# LBox — Tests

> Source : `.src/Utils/LBox.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Dialogue modal : tests `replay` au travers des écrans GED.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LBOX-T01 | replay | Mode `TextReg` | `GedR` : sélection de 2 documents → Changer URL → valider la base proposée → saisir la nouvelle base → valider ; table `Docs_Ged` | colonne `url` modifiée | `tests/replay_textreg/` | à faire |
| LBOX-T02 | replay | Mode `TextReg` annulé | même scénario, Annuler au 1er dialogue | `Docs_Ged` inchangée | `tests/replay_textreg_annule/` | à faire |
| LBOX-T03 | replay | Mode `ListView` + filtre | `GedR` → Supprimer tags → filtre `^fac` → Sélectionner, Inverser, Désélectionner, valider ; tables `Docs_Tag`, `Fiches_Tag` | tags retirés conformes à la sélection | `tests/replay_listview/` | à faire |
| LBOX-T04 | replay | Mode `ListEditor` | `GedR` → Ajouter tags → saisir 2 tags → valider ; `Docs_Tag`, `Fiches_Tag` | 2 tags ajoutés aux documents | `tests/replay_listeditor/` | à faire |
| LBOX-T05 | replay | Mode `FileSelect` | `LGed` (édition d'un document) → Copier → choisir un fichier → Enregistrer ; `Docs_Ged` + fichier cible | `url`, `mime` et fichier copiés | `tests/replay_fileselect/` | à faire |
| LBOX-T06 | replay | Filtre invalide | mode `ListView`, filtre `[` puis Sélectionner | message d'avertissement, sélection inchangée | `tests/replay_filtre_invalide/` | à faire |

## Détail des tests

- **Valeurs attendues** : capture dans le clone non modifié, rejeu sur les deux clones, diff du
  dump normalisé des tables citées (colonnes `lind` masquées si besoin).
- **Données** : `Laurux01.sql` + jeu GED dérivé (`ged.sql` : 3 documents, 5 tags, fichiers PDF
  factices sous un répertoire temporaire référencé par `url`).
- **Non testable en gb.test** : toute la classe (fenêtre modale).
- Ces scénarios servent aussi aux tests de [`GedR`](../GedR.class/test.md) et
  [`LTrans`](../LTrans.class/test.md) : à mutualiser (même répertoire de données).
