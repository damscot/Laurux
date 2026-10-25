# TriMat — Tests

> Source : `.src/Affichages/TriMat.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre ouverte depuis l'édition des matériels (`EdMat`, menu Gestion) : scénarios `replay`
capturés dans le clone **Laurux non modifié**. Base `Laurux01.sql` + jeu dérivé `materiels` :
≥ 3 pages de matériels, vendus et en stock, avec propriétaires, numéros de série, marques et types
variés, codes numériques de longueurs différentes (tri `lpad`). Comparaison : code repris dans
`EdMat` (`mat`/`mat2`), lignes `Exec_SQL` à titre informatif.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIMAT-T01 | replay | Sélection d'un matériel | `EdMat` : bouton de choix, clic sur une ligne ; idem pour le 2ᵉ matériel | codes repris dans `mat` et `mat2` | `tests/selection/` | à faire |
| TRIMAT-T02 | replay | Filtres et tri | saisie dans `IT` (contient), `CO` (commence par), `CB1` = `Marque` puis saisie ; double-clic d'en-tête | requêtes de référence (dont `lpad`) | `tests/filtre_tri/` | à faire |
| TRIMAT-T03 | replay | Vendus / en stock | boutons radio 2 puis 3 puis 1, depuis la page 2 | figer : page conservée (A03), filtre `mat_vendu like` | `tests/vendus_stock/` | à faire |
| TRIMAT-T04 | replay | Pagination et clavier (A01) | PageDown, PageUp, flèches en bord de page, molette, boutons | figer : sens des touches inversé | `tests/pagination/` | à faire |
| TRIMAT-T05 | replay | Annulation après sélection (A02) | sélection d'un matériel, réouverture, Échap | figer : l'ancien code est réappliqué | `tests/annulation/` | à faire |
| TRIMAT-T06 | gbtest | `RequeteMateriels` (après TRIMAT-004) | 6 champs de tri × filtre vide/`AB` × vendu ``/`1`/`0` × sens | texte SQL identique au clone non modifié | `tests/requete_materiels/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié ; A01 à A03 figées.
- **Rejeu** : `_new` appelle `Utils.Observers(Me)` ; `ColMat_Click` est rejoué par `Object.Call`.
  Pas de `replay_missing`.
- **SQLite** : la traduction de `lpad` par `DB_Connection` est à couvrir en rejouant T02 sur une
  base SQLite (même ordre attendu).
- **Géométrie** : `lg` dépend de la hauteur de la grille (police et facteur d'échelle fixés).
