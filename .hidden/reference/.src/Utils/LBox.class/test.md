# LBox — Tests

> Source : `.src/Utils/LBox.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Dialogue modal : tests `replay` au travers des écrans GED.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LBOX-T01 | replay | Mode `TextReg` | `GedR` : sélection de 2 documents → Changer URL → valider la base proposée → saisir la nouvelle base → valider ; table `Docs_Ged` | colonne `url` modifiée | `tests/replay_textreg/` | à faire : jeu GED (documents + fichiers) et sélection de documents dans GedR non synthétisés ; rejeux suspendus |
| LBOX-T02 | replay | Mode `TextReg` annulé | même scénario, Annuler au 1er dialogue | `Docs_Ged` inchangée | `tests/replay_textreg_annule/` | à faire : idem T01 |
| LBOX-T03 | replay | Mode `ListView` + filtre | `GedR` → Supprimer tags → filtre `^fac` → Sélectionner, Inverser, Désélectionner, valider ; tables `Docs_Tag`, `Fiches_Tag` | tags retirés conformes à la sélection | `tests/replay_listview/` | implémenté en partie : gb.test LBoxTest.T03ListView (filtre ^fac, Sélectionner, Désélectionner, Inverser, Valider vers l'objet de sortie) ; parcours GedR et tables Docs_Tag/Fiches_Tag à faire : clic ListView non rejoué |
| LBOX-T04 | replay | Mode `ListEditor` | `GedR` → Ajouter tags → saisir 2 tags → valider ; `Docs_Tag`, `Fiches_Tag` | 2 tags ajoutés aux documents | `tests/replay_listeditor/` | implémenté en partie : gb.test LBoxTest.T04ListEditor (liste modifiée recopiée dans l'objet de sortie) ; parcours GedR à faire : jeu GED et sélection de documents |
| LBOX-T05 | replay | Mode `FileSelect` | `LGed` (édition d'un document) → Copier → choisir un fichier → Enregistrer ; `Docs_Ged` + fichier cible | `url`, `mime` et fichier copiés | `tests/replay_fileselect/` | à faire : sélection de fichier par boîte de dialogue (FileSelect) non rejouable |
| LBOX-T06 | replay | Filtre invalide | mode `ListView`, filtre `[` puis Sélectionner | message d'avertissement, sélection inchangée | `tests/replay_filtre_invalide/` | à faire : clic ListView non rejoué (comme T03) |
| LBOX-T07 | gbtest | Mode TextArea | `LBox` en mode TextArea : texte modifié puis Valider vers un TextBox ; Annuler sans recopie | texte recopié dans l'objet de sortie après Valider, inchangé après Annuler | `assets/LBoxTest` | implémenté (gb.test `LBoxTest.T07TextArea`, ajouté en phase 2 vague 6) |

## Détail des tests

- **Valeurs attendues** : capture dans le clone non modifié, rejeu sur les deux clones, diff du
  dump normalisé des tables citées (colonnes `lind` masquées si besoin).
- **Données** : `Laurux01.sql` + jeu GED dérivé (`ged.sql` : 3 documents, 5 tags, fichiers PDF
  factices sous un répertoire temporaire référencé par `url`).
- **Non testable en gb.test** : toute la classe (fenêtre modale).
- Ces scénarios servent aussi aux tests de [`GedR`](../GedR.class/test.md) et
  [`LTrans`](../LTrans.class/test.md) : à mutualiser (même répertoire de données).
- **Module gb.test** : `.src/Tests/Utils/LBoxTest.test` : boîte instanciée sans affichage (`New LBox(message, entrée, Null, objet de sortie, info-bulle, mode)`, comme GedR), contrôles lus par `Controls[…]`. `T07TextArea` est un test complémentaire sans ID dans ce tableau (mode TextArea, Annuler puis Valider). Après `Valider_Click`/`Annuler_Click`, la boîte non affichée est détruite : `L` et `T` lèvent « Invalid object » (figé).
