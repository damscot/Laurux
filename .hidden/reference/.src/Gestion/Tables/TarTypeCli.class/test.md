# TarTypeCli — Tests

> Source : `.src/Gestion/Tables/TarTypeCli.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran : tests `replay` (menu Tarifs par client / par type de client, et depuis les fiches client
et article). Tables comparées : `Fiches_Tarcli`, `Fiches_TarTypcli`. Valeurs attendues produites
dans le clone **Laurux non modifié** (anomalies figées).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TARTYPECLI-T01 | replay | Création d'un tarif client | mode client, client C1 (F2 `TriCpt`), article A1 (F2 `TriArticles`), coefficient `1,4`, Enregistrer | ligne `Fiches_Tarcli` (`coef = 1.4`) ; liste rafraîchie | `tests/creation_client/` | à faire |
| TARTYPECLI-T02 | replay | Création d'un tarif type | mode type, type `01` par la liste `Coltype` (clic), article A1, PV HT saisi | `Fiches_TarTypcli` (coef recalculé) ; PV TTC, remise, marge affichés | `tests/creation_type/` | à faire |
| TARTYPECLI-T03 | replay | Cascade de prix | sur A1 : coefficient, puis PV HT, PV TTC, remise % ; PV < prix de revient | valeurs des zones (relevées par le replay) ; alerte | `tests/cascade/` | à faire |
| TARTYPECLI-T04 | replay | Sélection dans la liste | C1 et C2 ont un tarif sur A1 ; afficher C2, choisir A1 dans la liste | coefficient affiché (celui du premier tarif trouvé, TARTYPECLI-A02 figée) | `tests/selection_liste/` | à faire |
| TARTYPECLI-T05 | replay | Suppression d'un tarif | Suppr dans la liste, mode client puis mode type | client : ligne supprimée ; type : erreur SQL (TARTYPECLI-A01 figée) | `tests/suppression_ligne/` | à faire |
| TARTYPECLI-T06 | replay | Supprimer tout | « supprimer tous les produits » pour le dernier client ayant des tarifs | table vide ; liste encore affichée (TARTYPECLI-A03 figée) | `tests/suppression_tout/` | à faire |
| TARTYPECLI-T07 | replay | Ouverture contextuelle | depuis `FClient` (client et type) et `Articles` (article) | zones pré-remplies, liste filtrée | `tests/ouverture/` | à faire |
| TARTYPECLI-T08 | replay | Recherche d'article | code avec `*`, code équivalent, référence centrale, code inconnu | article trouvé ou message ; sortie standard contient `artman` | `tests/recherche_article/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `tarifs_clients.sql` (clients C1/C2, types `01`/`02`,
  articles A1/A2 avec `art_cequ` et `art_refcentrale`, tarifs croisés pour T04).
- **Comparaison** : dump normalisé des deux tables ; zones de prix et contenu de la liste
  relevés par le replay (T03, T04, T06).
- **gb.test** : après TARTYPECLI-006 (fonctions pures `Calc_Remise`/`Calc_coeff`), test des
  formules sur une matrice de valeurs, et de la cascade après TARTYPECLI-007.
- **Non testable** : son de l'alerte.
