# Expclient — Tests

> Source : `.src/Utils/Exports-Imports/Expclient.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EXPCLIENT-T01 | replay | Export nominal | `Laurux01.sql`, répertoire de sortie de test, `Button2` | `Liste_clients.csv` identique à la référence (comparaison après tri des lignes) | `tests/export_nominal/` | à faire |
| EXPCLIENT-T02 | replay | Champs `Null` et `;` | client dérivé avec champs NULL et `;` dans la raison sociale | lignes figées | `tests/champs_speciaux/` | à faire |
| EXPCLIENT-T03 | replay | Table vide | `Fiches_Cli` vide | fichier vide + `Message.Error` | `tests/table_vide/` | à faire |

## Détail des tests

- Capture dans le clone **Laurux non modifié** ; comparaison du fichier produit, **lignes triées**
  car l'ordre du `SELECT` n'est pas garanti ; diff BDD vide.
- Jeux dérivés T02-T03 générés par `gen_input.py`.
