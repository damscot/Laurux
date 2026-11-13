# EdClient — Tests

> Source : `.src/Gestion/Impressions/EdClient.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` (texte de `~/tmp/Clients.pdf` par `pdftotext -layout`, pied de page masqué ;
lignes `Exec_SQL`, utiles ici pour figer la clause `WHERE` construite ; dump inchangé). Valeurs
attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDCLIENT-T01 | replay | Plage de codes | bornes par défaut, tri par code | texte du PDF ; SQL `CAST … BETWEEN` | `tests/plage_codes/` | implémenté (`Gestion/edclient_plage_codes`) |
| EDCLIENT-T02 | replay | Statut et type | `Stat1`/`Stat2`, `Type1`/`Type2` renseignés, tri par nom | filtres combinés dans le SQL | `tests/statut_type/` | implémenté (`Gestion/edclient_statut_type`) |
| EDCLIENT-T03 | replay | Mode de règlement | `Mreg` = « Chèque » + plage de codes restreinte | SQL limité à `cli_reg` (A01 figée), titre « Liste des clients Chèque » | `tests/mode_reglement/` | implémenté (`Gestion/edclient_mode_reglement`) |
| EDCLIENT-T04 | replay | Tous les champs vides | effacer `Cli`/`Cli2` | erreur SQL `WHERE  ORDER BY` (A02 figée) | `tests/champs_vides/` | implémenté (`Gestion/edclient_champs_vides`, `code_sortie` 125 : Query failed, A02 figée) |
| EDCLIENT-T05 | replay | Listes de sélection | `ToggleButton1`…`6`, clic/Entrée dans `Colcli` | champs remplis selon `Org`, enchaînement du focus | `tests/listes/` | implémenté (`Gestion/edclient_listes` : clics ; Entrée dans `Colcli` non rejouée) |
| EDCLIENT-T06 | replay | Saut de page | > 21 clients avec `Mreg` | page 2 sans le mode dans le titre (A03 figée) | `tests/saut_page/` | implémenté (`Gestion/edclient_saut_page`) |

## Détail des tests

- **Implémentation (phase 2, vague 5)** : jeu `.hidden/Tests/Gestion/assets/edclient_shared/clients.sql` (statuts P1/P2, 25 clients 411100 à 411124, 23 en Chèque) au lieu de `editions_gestion` (non créé) ; scénarios `.hidden/Tests/Gestion/assets/edclient_*` ; texte du PDF par `/Soc01/caisse/CmdVis` → `edition.txt`.

- **Données** : `Laurux01.sql` (clients `411001…`, `Fiches_Typec`) complété par le jeu
  `editions_gestion` (voir [Edbr](../Edbr.module/test.md)) : statuts, types, modes de règlement
  variés, codes de longueurs différentes (comparaison lexicale).
- **Évolution possible** : après EDCLIENT-005, `FiltreClients` devient testable en `gbtest`
  (texte SQL attendu par combinaison de champs).
- **Non testable automatiquement** : aide HTML, son.
