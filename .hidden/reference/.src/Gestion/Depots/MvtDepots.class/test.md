# MvtDepots — Tests

> Source : `.src/Gestion/Depots/MvtDepots.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_Art` (`art_qte`), `Fiches_StkDepots` et `Fiches_Sdepots`. Les tests
figent le comportement actuel, défauts compris. Valeurs attendues produites dans le clone
**Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MVTDEPOTS-T01 | replay | Transfert magasin → dépôt | départ `01`, arrivée `02` ; article stocké, qté 2 ; Valider | `art_qte` −2 ; stock `02` +2 ; ligne `01` à −2 créée dans `StkDepots` ; 2 lignes `Sdepots` | `tests/magasin_vers_depot/` | implémenté (`Gestion/mvtdepots_magasin_vers_depot`) |
| MVTDEPOTS-T02 | replay | Transfert dépôt → magasin | départ `02` (stock 5), arrivée `01` ; qté 2 | `art_qte` +2 ; ligne de stock `02` **supprimée** (A01 figée) | `tests/depot_vers_magasin/` | implémenté (`Gestion/mvtdepots_depot_vers_magasin`) |
| MVTDEPOTS-T03 | replay | Libellé du dépôt d'arrivée | saisie `02` puis `03` au clavier | libellé d'arrivée = libellé du départ (A02 figée, log) | `tests/libelle_arrivee/` | implémenté (gb.test `MvtDepotsTest.T03LibelleArrivee` : libellé d'arrivée « Dépot 1 » pour 03 et 01) |
| MVTDEPOTS-T04 | replay | Article introuvable | départ `01`, code inconnu ; Valider | message puis transfert exécuté quand même (A04 figée) | `tests/article_inconnu/` | implémenté (`Gestion/mvtdepots_article_inconnu`) |
| MVTDEPOTS-T05 | replay | Code-barres au magasin | départ `01`, code-barres d'un article | « Cette référence n'existe pas » (A03 figée) | `tests/code_barres/` | implémenté (`Gestion/mvtdepots_code_barres`) |
| MVTDEPOTS-T06 | replay | Doublon dans la saisie | même article deux fois ; « 1-Cumuler » | quantité cumulée dans la grille, mouvements doublés en base | `tests/cumul/` | implémenté (`Gestion/mvtdepots_cumul`) |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé (stock du dépôt `02` initialisé, articles avec code
  fournisseur et code-barres).
- **Comparaison** : dump normalisé des trois tables (`mind` de `Fiches_Sdepots` masqué).
- **SQLite** : `art_man` utilise `db.Exec` (classe `DB`) : à rejouer sur `Laurux01.sqlite` pour
  figer le comportement de la connexion courante (A05).
- Module complexe pour le stock : Décision utilisateur du 2026-11-18 : hors des 10 classes à revue manuelle,
  tests implémentés sans validation individuelle (jeu `mvtdepots_shared/stock`, générateur `gen_mvtdepots.py`).
