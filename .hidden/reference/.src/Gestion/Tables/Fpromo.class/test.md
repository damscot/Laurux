# Fpromo — Tests

> Source : `.src/Gestion/Tables/Fpromo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_Promo` et `Fiches_ArtPromo`. Valeurs attendues produites dans le
clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FPROMO-T01 | replay | Création | menu Promotions ; `ETE26`, `Promo été`, `01.06.2026`, `31.08.2026` (calendrier pour la fin) ; Enregistrer | INSERT | `tests/creation/` | implémenté (`Gestion/fpromo_creation`, fin saisie au clavier : DateChooser non rejouable) |
| FPROMO-T02 | replay | Modification | clic `ETE26` ; fin `15.09.2026` ; Enregistrer | UPDATE | `tests/modification/` | implémenté (`Gestion/fpromo_modification`) |
| FPROMO-T03 | replay | Dates incohérentes ou vides | début > fin ; puis fin vide | enregistré tel quel / erreur selon `sql_mode` (A01 figée) | `tests/dates_incoherentes/` | implémenté (`Gestion/fpromo_dates_incoherentes`, code de sortie 125 figé : Fpromo.ColPromo_Data.77 sur datefin NULL) |
| FPROMO-T04 | replay | Suppression en cascade | promotion avec 2 articles ; Supprimer, Oui | promotion et lignes `Fiches_ArtPromo` supprimées | `tests/suppression_cascade/` | implémenté (`Gestion/fpromo_suppression_cascade`) |
| FPROMO-T05 | replay | Suppression refusée | Supprimer, Non | aucune écriture, zones vidées | `tests/suppression_non/` | implémenté (`Gestion/fpromo_suppression_non`) |

## Détail des tests

- **Données** : `Laurux01.sql` (tables vides) ; jeu dérivé `.hidden/Tests/Gestion/assets/fpromo_shared/fpromo_ete26.sql` (promotion ETE26 et deux articles).
- **Comparaison** : dump normalisé de `Fiches_Promo` et `Fiches_ArtPromo`.
- **Mode SQL** : T03 dépend du `sql_mode` MariaDB fixé dans `.hidden/reference/tools/db/`.
