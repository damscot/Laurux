# Edittipp — Tests

> Source : `.src/Gestion/option/Edittipp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

État en lecture seule : comparaison du texte du PDF produit (`pdftotext`) dans le clone **Laurux
non modifié**, et `gbtest` du jeu de lignes après EDITTIPP-002.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDITTIPP-T01 | replay | Édition du mois | Option → Édition de la TIPP ; mois/année avec BL et factures TIPP | texte du PDF de référence | `tests/edition_mois/` | implémenté (gb.test EdittippTest.T01EditionMois : libellés du rapport par parcours de Children et valeurs des 6 lignes) |
| EDITTIPP-T02 | replay | Mois sans ligne | mois vide | PDF sans ligne de détail | `tests/mois_vide/` | implémenté (gb.test EdittippTest.T02MoisVide : DataCount 1 et « Result is not available » à la lecture de la ligne, figé) |
| EDITTIPP-T03 | gbtest | Jeu de lignes | `New Edittipp("03", "2026")` ; article présent dans 2 régions ; BL facturé présent aussi en historique | nombre de lignes et valeurs (duplications figées, A01/A02) | `tests/lignes_mois/` | implémenté |

## Détail des tests

- **Données** : jeu `option_carbu` (`modfichier.fichiercarbu`) + 2 régions, 2 articles carburant,
  clients avec `cli_siret`/`cli_dfin`, BL et factures avec `tipp_ligbl`/`tipp_ligfac`.
- **gbtest** : la classe hérite de `Report` ; T03 lit `ligne.DataCount` et appelle les `*_Data`
  (ou `RequeteMois()` après EDITTIPP-002).
- Base inchangée (dump identique) dans tous les cas.
- **Implémentation (phase 2)** : `.src/Tests/Gestion/EdittippTest.test` (T03), jeu `edittipp_shared/edittipp_lignes`
  (article 001 dans deux régions, BL facturé présent aussi en historique, BL non facturé, BL hors période). Les
  contrôles du rapport sont privés : les champs Data sont repérés par parcours de `Children`, après appel des
  méthodes publiques `<champ>_Data(i)`. Résultat figé : 6 lignes (duplications par région et BL/historique, A01/A02).
