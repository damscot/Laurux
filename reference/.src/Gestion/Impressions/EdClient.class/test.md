# EdClient — Tests

> Source : `.src/Gestion/Impressions/EdClient.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` (texte de `~/tmp/Clients.pdf` par `pdftotext -layout`, pied de page masqué ;
lignes `Exec_SQL`, utiles ici pour figer la clause `WHERE` construite ; dump inchangé). Valeurs
attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDCLIENT-T01 | replay | Plage de codes | bornes par défaut, tri par code | texte du PDF ; SQL `CAST … BETWEEN` | `tests/plage_codes/` | à faire |
| EDCLIENT-T02 | replay | Statut et type | `Stat1`/`Stat2`, `Type1`/`Type2` renseignés, tri par nom | filtres combinés dans le SQL | `tests/statut_type/` | à faire |
| EDCLIENT-T03 | replay | Mode de règlement | `Mreg` = « Chèque » + plage de codes restreinte | SQL limité à `cli_reg` (A01 figée), titre « Liste des clients Chèque » | `tests/mode_reglement/` | à faire |
| EDCLIENT-T04 | replay | Tous les champs vides | effacer `Cli`/`Cli2` | erreur SQL `WHERE  ORDER BY` (A02 figée) | `tests/champs_vides/` | à faire |
| EDCLIENT-T05 | replay | Listes de sélection | `ToggleButton1`…`6`, clic/Entrée dans `Colcli` | champs remplis selon `Org`, enchaînement du focus | `tests/listes/` | à faire |
| EDCLIENT-T06 | replay | Saut de page | > 21 clients avec `Mreg` | page 2 sans le mode dans le titre (A03 figée) | `tests/saut_page/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (clients `411001…`, `Fiches_Typec`) complété par le jeu
  `editions_gestion` (voir [Edbr](../Edbr.module/test.md)) : statuts, types, modes de règlement
  variés, codes de longueurs différentes (comparaison lexicale).
- **Évolution possible** : après EDCLIENT-005, `FiltreClients` devient testable en `gbtest`
  (texte SQL attendu par combinaison de champs).
- **Non testable automatiquement** : aide HTML, son.
