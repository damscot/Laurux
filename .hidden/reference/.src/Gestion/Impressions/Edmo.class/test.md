# Edmo — Tests

> Source : `.src/Gestion/Impressions/Edmo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` depuis le menu « Main d'oeuvre » : texte `pdftotext -layout` de `~/tmp/MO.pdf`
(date et utilisateur du pied normalisés), lignes `Exec_SQL`, dump inchangé. Valeurs attendues
produites dans le clone **non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDMO-T01 | replay | Liste complète par code | défauts, **Imprimer** | `Level1MO`/`Level2MO` ; HT = `mo_valeurht` ou `mo_txht × mo_montant` ; TTC recalculé | `tests/edmo_code/` | à faire |
| EDMO-T02 | replay | Tri par famille et plages | `RadioButton2`, plages Mo et famille restreintes | ordre et filtrage | `tests/edmo_famille/` | à faire |
| EDMO-T03 | replay | Pagination | > 50 mains d'oeuvre | saut à 280 mm, en-tête répété | `tests/edmo_pagination/` | à faire |
| EDMO-T04 | replay | Valeur invalide | `mo_valeurht` non numérique sur une ligne | message « Veuillez verifier le taux horaire… », pas de PDF, curseur en attente (A01 figée) | `tests/edmo_valeur_invalide/` | à faire |
| EDMO-T05 | replay | Aucune ligne | plage vide | message puis erreur `Draw.End` éventuelle (A02 figée) | `tests/edmo_vide/` | à faire |
| EDMO-T06 | replay | Listes et navigation | listes Mo/famille par bouton, clic, Échap ; Entrée sur `Fam2` | champs remplis ; focus renvoyé sur `Mo` (A03 figée) | `tests/edmo_listes/` | à faire |
| EDMO-T07 | gbtest | Calcul TTC (après EDMO-003) | HT `"12,50"`, taux 20 / 5,5 / 0 ; code TVA inconnu | chaînes TTC identiques à celles de T01 | `tests/edmo_ttc/` | à faire |

## Détail des tests

- **Données** : jeu `editions_articles` ([EdArt1/test.md](../EdArt1.class/test.md#détail-des-tests)) :
  une dizaine de `Fiches_Mo` (`mo_tempmont` 0 et 1, deux codes TVA, un code TVA absent), plus de
  50 lignes pour T03, une ligne à `mo_valeurht` invalide pour T04 (jeu séparé).
- **Non testable automatiquement** : son, couleur du focus, aide F1 (`Edmo`).
