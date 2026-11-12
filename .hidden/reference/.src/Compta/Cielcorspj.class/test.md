# Cielcorspj — Tests

> Source : `.src/Compta/Cielcorspj.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Replays sur MariaDB Docker, critère = dump normalisé de `Ciel_Lrx_Jo`. Scénarios parallèles à
ceux de `Cielcorsp` (même outillage `gen_input.py`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CIELCORSPJ-T01 | replay | Première ouverture | base sans tables Ciel | tables créées ; liste vide | `tests/premiere_ouverture/` | implémenté (gb.test `.src/Tests/Compta/CielcorspjTest.test`, écran instancié sans affichage) |
| CIELCORSPJ-T02 | replay | Ajout d'une correspondance | F1, journal `VT`, Ciel `VE`, Ajouter | ligne `Ciel_Lrx_Jo` (`VE`, `VT`, libellé du journal) | `tests/ajout_journal/` | implémenté (gb.test `.src/Tests/Compta/CielcorspjTest.test`, écran instancié sans affichage) (journal 70 au lieu de VT) |
| CIELCORSPJ-T03 | replay | Deux journaux Ciel vers un même journal Laurux | `VE`→`VT` puis `V2`→`VT` | deux lignes acceptées | `tests/meme_journal_laurux/` | implémenté (gb.test `.src/Tests/Compta/CielcorspjTest.test`, écran instancié sans affichage) |
| CIELCORSPJ-T04 | replay | Doublon Ciel | `VE` deux fois | message, base inchangée | `tests/doublon_ciel/` | à faire : Message.Error bloquant en gb.test ; replay à synthétiser |
| CIELCORSPJ-T05 | replay | Journal Laurux inexistant ou vide | `ZZ`, puis vide | avertissement, base inchangée | `tests/journal_inconnu/` | à faire : Message.Warning bloquant en gb.test ; replay à synthétiser |
| CIELCORSPJ-T06 | replay | Suppression | `Suppr` ; double-clic puis Quitter | correspondances supprimées (CIELCORSPJ-A01 figée) | `tests/suppression/` | implémenté (gb.test `.src/Tests/Compta/CielcorspjTest.test`, écran instancié sans affichage) (Suppr : Compte_delete appelé directement) |

## Détail des tests

- **Génération des valeurs attendues** : capture dans le clone **Laurux non modifié**, rejeu dans
  les deux clones, comparaison des dumps.
- **Données** : `Laurux01.sql` (journaux existants dans `Fiches_Journaux`).
- **Non testable automatiquement** : documentation HTML.
- **Implémentation (phase 2)** : T01, T02, T03, T06 en gb.test (`CielcorspjTest`), comme `CielcorspTest` : fenêtre
  instanciée sans affichage, `Button1_Click` (F1), `Colcpt_Click`, `Button2_Click`, `Compte_delete` (corps de la touche
  Suppr) et `Listecompte_Activate` appelés directement. Les journaux de Laurux01 sont `10, 50, 53, 60, 70, 90` : le
  journal `VT` du tableau est remplacé par `70` (Ventes).
