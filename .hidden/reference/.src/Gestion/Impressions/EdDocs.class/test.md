# EdDocs — Tests

> Source : `.src/Gestion/Impressions/EdDocs.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` : texte de `~/tmp/ListeDocs.pdf` (`pdftotext -layout`, pied de page masqué),
lignes `Exec_SQL` (clause construite) ; dump inchangé. Valeurs attendues produites dans le clone
**Laurux non modifié**, sous MySQL **et** SQLite (A04).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDDOCS-T01 | replay | Tous les documents | défauts, Imprimer | texte du PDF, total général | `tests/tous/` | implémenté (`Gestion/eddocs_tous`) |
| EDDOCS-T02 | replay | Par type | `RadioButton2`, puis `4`, `3`, `5` | filtre `type` ; titres inversés commandes/devis (A01 figée) | `tests/par_type/` | implémenté (`Gestion/eddocs_par_type`) |
| EDDOCS-T03 | replay | Tri par commentaire | `RadioButton12`, Imprimer | erreur SQL `order by` (A02 figée) | `tests/tri_commentaire/` | implémenté (`Gestion/eddocs_tri_commentaire`, `code_sortie` 125 : Query failed, A02 figée) |
| EDDOCS-T04 | replay | Tri par compte | `RadioButton10`, 3 clients | totaux par client, dernier absent (A03 figée) | `tests/tri_compte/` | implémenté (`Gestion/eddocs_tri_compte`) |
| EDDOCS-T05 | replay | Période et clients | dates par calendrier (double-clic, F2) et plage par `Colcli` | bornes dans le SQL ; documents du dernier jour (heure ≠ 00:00) | `tests/periode_clients/` | implémenté (`Gestion/eddocs_periode_clients` : dates tapées, calendrier (double-clic, F2) non rejoué ; plage par `Colcli`) |
| EDDOCS-T06 | replay | Détail des lignes | `RadioButton7` avec commandes (commentaires `YY`) et BL | détail ; commentaires seulement pour les commandes | `tests/detail/` | implémenté (`Gestion/eddocs_detail`) |
| EDDOCS-T07 | replay | Facture imprimée | facture `F` `imp = 1` | numéro et date de facture au lieu du BL | `tests/facture_imprimee/` | xfail : `imp` (tinyint lu en Booléen) comparé à 1, la facture imprimée garde numéro et date de BL (`Gestion/eddocs_facture_imprimee`) |

## Détail des tests

- **Implémentation (phase 2, vague 5)** : jeu `.hidden/Tests/Gestion/assets/eddocs_shared/documents.sql` (3 clients 411801 à 411803, 8 documents D/C/B/F de juin 2018, C00002 le 15/06 à 10:30, F00001 `imp = 1`, commentaire `YY` sur C00001) au lieu de `editions_gestion` (non créé) ; scénarios `.hidden/Tests/Gestion/assets/eddocs_*` ; texte du PDF par `/Soc01/caisse/CmdVis` → `edition.txt`.

- **Données** : jeu `editions_gestion` (voir [Edbr](../Edbr.module/test.md)) : documents `Fiches_Bl`
  de types D, C, B, F (dont `imp = 1`), sur trois clients, dates réparties dont une avec heure le
  dernier jour de la période ; lignes article et commentaires.
- **SQLite** : rejouer T05 sur `Laurux01.sqlite` + jeu converti pour caractériser A04.
- **Non testable automatiquement** : son.
