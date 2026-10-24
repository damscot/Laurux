# Fpromo — Tests

> Source : `.src/Gestion/Tables/Fpromo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_Promo` et `Fiches_ArtPromo`. Valeurs attendues produites dans le
clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FPROMO-T01 | replay | Création | menu Promotions ; `ETE26`, `Promo été`, `01.06.2026`, `31.08.2026` (calendrier pour la fin) ; Enregistrer | INSERT | `tests/creation/` | à faire |
| FPROMO-T02 | replay | Modification | clic `ETE26` ; fin `15.09.2026` ; Enregistrer | UPDATE | `tests/modification/` | à faire |
| FPROMO-T03 | replay | Dates incohérentes ou vides | début > fin ; puis fin vide | enregistré tel quel / erreur selon `sql_mode` (A01 figée) | `tests/dates_incoherentes/` | à faire |
| FPROMO-T04 | replay | Suppression en cascade | promotion avec 2 articles ; Supprimer, Oui | promotion et lignes `Fiches_ArtPromo` supprimées | `tests/suppression_cascade/` | à faire |
| FPROMO-T05 | replay | Suppression refusée | Supprimer, Non | aucune écriture, zones vidées | `tests/suppression_non/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (tables vides) ; jeu dérivé avec une promotion et deux articles.
- **Comparaison** : dump normalisé de `Fiches_Promo` et `Fiches_ArtPromo`.
- **Mode SQL** : T03 dépend du `sql_mode` MariaDB fixé dans `reference/tools/db/`.
