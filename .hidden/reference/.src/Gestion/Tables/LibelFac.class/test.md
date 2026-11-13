# LibelFac — Tests

> Source : `.src/Gestion/Tables/LibelFac.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_LibelFac`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LIBELFAC-T01 | replay | Modification | menu Bas de facture ; texte avec `&` ; Enregistrer | UPDATE de toutes les lignes, `&` → `et` | `tests/modification/` | implémenté (Gestion/libelfac_modification) |
| LIBELFAC-T02 | replay | Table vide | jeu dérivé sans ligne ; texte ; Enregistrer | INSERT | `tests/table_vide/` | implémenté (Gestion/libelfac_table_vide, jeu libelfac_vide) |
| LIBELFAC-T03 | replay | Texte long | 300 caractères ; Enregistrer | troncature ou erreur selon `sql_mode` (figé) | `tests/texte_long/` | implémenté (Gestion/libelfac_texte_long : 255 caractères, tronqué à 250 en base) |

## Détail des tests

- **Données** : `Laurux01.sql` (une ligne `"\n"`) ; jeu dérivé pour T02.
- **Comparaison** : dump normalisé de `Fiches_LibelFac`.
- **Mode SQL** : T03 dépend du `sql_mode` MariaDB fixé dans `.hidden/reference/tools/db/`.
