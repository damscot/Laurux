# Cielcorspj — Tests

> Source : `.src/Compta/Cielcorspj.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Replays sur MariaDB Docker, critère = dump normalisé de `Ciel_Lrx_Jo`. Scénarios parallèles à
ceux de `Cielcorsp` (même outillage `gen_input.py`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CIELCORSPJ-T01 | replay | Première ouverture | base sans tables Ciel | tables créées ; liste vide | `tests/premiere_ouverture/` | à faire |
| CIELCORSPJ-T02 | replay | Ajout d'une correspondance | F1, journal `VT`, Ciel `VE`, Ajouter | ligne `Ciel_Lrx_Jo` (`VE`, `VT`, libellé du journal) | `tests/ajout_journal/` | à faire |
| CIELCORSPJ-T03 | replay | Deux journaux Ciel vers un même journal Laurux | `VE`→`VT` puis `V2`→`VT` | deux lignes acceptées | `tests/meme_journal_laurux/` | à faire |
| CIELCORSPJ-T04 | replay | Doublon Ciel | `VE` deux fois | message, base inchangée | `tests/doublon_ciel/` | à faire |
| CIELCORSPJ-T05 | replay | Journal Laurux inexistant ou vide | `ZZ`, puis vide | avertissement, base inchangée | `tests/journal_inconnu/` | à faire |
| CIELCORSPJ-T06 | replay | Suppression | `Suppr` ; double-clic puis Quitter | correspondances supprimées (CIELCORSPJ-A01 figée) | `tests/suppression/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : capture dans le clone **Laurux non modifié**, rejeu dans
  les deux clones, comparaison des dumps.
- **Données** : `Laurux01.sql` (journaux existants dans `Fiches_Journaux`).
- **Non testable automatiquement** : documentation HTML.
