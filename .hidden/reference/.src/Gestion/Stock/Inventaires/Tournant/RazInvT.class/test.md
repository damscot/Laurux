# RazInvT — Tests

> Source : `.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZINVT-T01 | replay | Suppression confirmée | base avec `Fiches_InvT` (GENINVT-T01) et un historique `Fiches_HisInvT` ; « Supprimer » ; « Oui » | `Fiches_InvT` absente ; `Fiches_HisInvT` inchangée | `tests/raz_oui/` | à faire |
| RAZINVT-T02 | replay | Suppression refusée | idem, « Non » | dump identique | `tests/raz_non/` | à faire |
| RAZINVT-T03 | replay | Table absente | base sans `Fiches_InvT` (état après ValidinvT) | dump inchangé ; message de succès figé | `tests/raz_absente/` | à faire |

## Détail des tests

- Valeurs attendues générées dans le clone Laurux non modifié ; jeu dérivé `invt_genere.sql`
  (`Laurux01.sql` + `Fiches_InvT` + une ligne `Fiches_HisInvT`).
- Le dump normalisé inclut la liste des tables. Écran instrumenté (`Utils.Observers`).
