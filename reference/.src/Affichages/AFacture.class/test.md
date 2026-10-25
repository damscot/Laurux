# AFacture — Tests

> Source : `.src/Affichages/AFacture.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre de consultation (aucune écriture) : comparaison des lignes `Exec_SQL` et, une fois l'écran
instrumenté, du contenu de `Colrcp3`, de `Totalfac` et de `Nlgf`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| AFACTURE-T01 | replay | Détail d'un BL en cours | `Facturergbl` (ou `Facture.AffDoc`) : activation d'un BL avec lignes article, ligne commentaire multi-ligne, article supprimé | lignes, total HT et nombre de lignes de référence ; figer la quantité brute (A02) | `tests/detail_bl/` | à faire |
| AFACTURE-T02 | replay | Détail depuis l'archive | document présent seulement dans `Fiches_LigblM` (depuis `Facturefm`, qui gère `Fiches_BlM`/`Fiches_LigblM` : à confirmer) | lignes de l'archive | `tests/detail_archive/` | à faire |
| AFACTURE-T03 | replay | Document sans ligne | numéro absent des deux tables | figer l'erreur et la fenêtre fermée (A01) | `tests/document_vide/` | à faire |
| AFACTURE-T04 | replay | Ouverture depuis `Articles` | liste des ventes d'un article, activation d'une ligne | même détail que T01 | `tests/depuis_articles/` | à faire |
| AFACTURE-T05 | gbtest | `LignesDocument` / `TotalLignes` (après AFACTURE-004) | numéro en cours, archivé, inconnu ; montants `"12,50"` | lignes et total de référence (locale `fr_FR` fixée) | `tests/lignes_document/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; A01 et A02 figées.
- **Locale** : fixer `LANG=fr_FR.UTF-8` (le total repose sur `Val()` localisé).
- **Données** : jeu dérivé `factures_base` (commun avec `TriFac`, `TriFac2`) complété d'un document
  archivé dans `Fiches_BlM`/`Fiches_LigblM`.
- **Instrumentation** : pas de `Utils.Observers(Me)`, `Colrcp3` sans `_Click` (`replay_missing`) :
  replays possibles seulement après instrumentation (phase 2) et sans clic dans la vue.
