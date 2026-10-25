# EdMat — Tests

> Source : `.src/Gestion/Impressions/EdMat.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` depuis le menu « Matériels » : texte `pdftotext -layout` de `~/tmp/Tarif2.pdf`
(dates et utilisateur normalisés), lignes `Exec_SQL`, dump inchangé. Valeurs attendues produites
dans le clone **non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDMAT-T01 | replay | Tous les matériels | défauts (`Vendus`, `Vendus2`, tri n° de série), **Imprimer** | titre « tous les matériels », vendus du client dans la plage + stock | `tests/edmat_tous/` | à faire |
| EDMAT-T02 | replay | Vendus seuls / stock seul | décocher `Vendus2`, puis seulement `Vendus2` | requêtes et titres correspondants ; stock = `mat_cli` nul et `mat_vendu` = 0 | `tests/edmat_vendus_stock/` | à faire |
| EDMAT-T03 | replay | Aucune case | décocher les deux | « Votre demande n'est pas cohérente » | `tests/edmat_incoherent/` | à faire |
| EDMAT-T04 | replay | Tris et marques | `RadioButton1..3` ; plage de marques par `ColMarque` | ordre des lignes ; `Marque` = intitulé | `tests/edmat_tris_marques/` | à faire |
| EDMAT-T05 | replay | Pagination | > 1 page | pages suivantes titrées « Liste des marériels » (figé) | `tests/edmat_pagination/` | à faire |
| EDMAT-T06 | replay | Sélection du propriétaire | `ToggleButton3`, choix d'un client | `Cli` vidé (A01 figée) | `tests/edmat_proprietaire/` | à faire |
| EDMAT-T07 | replay | Sélection de matériel | `ToggleButton1` (`TriMat`), choix | `Mat` ← `CodeMat` | `tests/edmat_trimat/` | à faire |
| EDMAT-T08 | replay | Saisie manuelle | `Mat` = code existant (Entrée) ; code inconnu (Entrée) | focus suivant ; erreur SQL `mat_refcentrale` (A02 figée) | `tests/edmat_mat_man/` | à faire |

## Détail des tests

- **Données** : jeu `editions_articles` ([EdArt1/test.md](../EdArt1.class/test.md#détail-des-tests)) :
  une dizaine de matériels (vendus avec `mat_cli`, en stock sans client, `mat_vendu` 0/1), 3 marques
  dans `Fiches_Marques`, plus de 51 matériels pour T05.
- **T08** : le rejeu doit tolérer l'erreur non interceptée (fin anormale de l'écran) : le résultat
  attendu est le message d'erreur journalisé.
- **Non testable automatiquement** : son, couleur du focus, aide F1.
