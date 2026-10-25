# Edittipp — Tests

> Source : `.src/Gestion/option/Edittipp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

État en lecture seule : comparaison du texte du PDF produit (`pdftotext`) dans le clone **Laurux
non modifié**, et `gbtest` du jeu de lignes après EDITTIPP-002.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDITTIPP-T01 | replay | Édition du mois | Option → Édition de la TIPP ; mois/année avec BL et factures TIPP | texte du PDF de référence | `tests/edition_mois/` | à faire |
| EDITTIPP-T02 | replay | Mois sans ligne | mois vide | PDF sans ligne de détail | `tests/mois_vide/` | à faire |
| EDITTIPP-T03 | gbtest | Jeu de lignes | `New Edittipp("03", "2026")` ; article présent dans 2 régions ; BL facturé présent aussi en historique | nombre de lignes et valeurs (duplications figées, A01/A02) | `tests/lignes_mois/` | à faire |

## Détail des tests

- **Données** : jeu `option_carbu` (`modfichier.fichiercarbu`) + 2 régions, 2 articles carburant,
  clients avec `cli_siret`/`cli_dfin`, BL et factures avec `tipp_ligbl`/`tipp_ligfac`.
- **gbtest** : la classe hérite de `Report` ; T03 lit `ligne.DataCount` et appelle les `*_Data`
  (ou `RequeteMois()` après EDITTIPP-002).
- Base inchangée (dump identique) dans tous les cas.
