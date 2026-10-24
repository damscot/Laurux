# ImptartypeC — Tests

> Source : `.src/Utils/Exports-Imports/ImptartypeC.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPTARTYPEC-T01 | replay | Insertion et mise à jour | type `01` ; fichier 13 colonnes : 2 articles nouveaux, 1 existant | diff `Fiches_TarTypcli` | `tests/upsert_nominal/` | à faire |
| IMPTARTYPEC-T02 | replay | Coefficient décimal | `1,25` et `1.25` et `abc` | `coef` = 1.25, 1.25, NULL (figé) | `tests/coef_formats/` | à faire |
| IMPTARTYPEC-T03 | replay | Ligne courte | ligne de 5 colonnes en 2ᵉ position | figer : erreur, seule la 1ʳᵉ ligne importée | `tests/ligne_courte/` | à faire |
| IMPTARTYPEC-T04 | replay | Remplissage `Coltype` | ouverture de la fenêtre | liste des types de `Fiches_Typec` (log GUI) | `tests/liste_types/` | à faire |

## Détail des tests

- Capture dans le clone **Laurux non modifié** via « Appel programme » → `ImptartypeC`.
  Comparaison du dump trié de `Fiches_TarTypcli`.
- Données : `Laurux01.sql` (types clients existants) ; fichiers générés par `gen_input.py`.
