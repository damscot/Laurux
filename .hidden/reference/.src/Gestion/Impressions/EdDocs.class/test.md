# EdDocs — Tests

> Source : `.src/Gestion/Impressions/EdDocs.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` : texte de `~/tmp/ListeDocs.pdf` (`pdftotext -layout`, pied de page masqué),
lignes `Exec_SQL` (clause construite) ; dump inchangé. Valeurs attendues produites dans le clone
**Laurux non modifié**, sous MySQL **et** SQLite (A04).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDDOCS-T01 | replay | Tous les documents | défauts, Imprimer | texte du PDF, total général | `tests/tous/` | à faire |
| EDDOCS-T02 | replay | Par type | `RadioButton2`, puis `4`, `3`, `5` | filtre `type` ; titres inversés commandes/devis (A01 figée) | `tests/par_type/` | à faire |
| EDDOCS-T03 | replay | Tri par commentaire | `RadioButton12`, Imprimer | erreur SQL `order by` (A02 figée) | `tests/tri_commentaire/` | à faire |
| EDDOCS-T04 | replay | Tri par compte | `RadioButton10`, 3 clients | totaux par client, dernier absent (A03 figée) | `tests/tri_compte/` | à faire |
| EDDOCS-T05 | replay | Période et clients | dates par calendrier (double-clic, F2) et plage par `Colcli` | bornes dans le SQL ; documents du dernier jour (heure ≠ 00:00) | `tests/periode_clients/` | à faire |
| EDDOCS-T06 | replay | Détail des lignes | `RadioButton7` avec commandes (commentaires `YY`) et BL | détail ; commentaires seulement pour les commandes | `tests/detail/` | à faire |
| EDDOCS-T07 | replay | Facture imprimée | facture `F` `imp = 1` | numéro et date de facture au lieu du BL | `tests/facture_imprimee/` | à faire |

## Détail des tests

- **Données** : jeu `editions_gestion` (voir [Edbr](../Edbr.module/test.md)) : documents `Fiches_Bl`
  de types D, C, B, F (dont `imp = 1`), sur trois clients, dates réparties dont une avec heure le
  dernier jour de la période ; lignes article et commentaires.
- **SQLite** : rejouer T05 sur `Laurux01.sqlite` + jeu converti pour caractériser A04.
- **Non testable automatiquement** : son.
