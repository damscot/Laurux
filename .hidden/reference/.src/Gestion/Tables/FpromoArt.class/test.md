# FpromoArt — Tests

> Source : `.src/Gestion/Tables/FpromoArt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_ArtPromo` ; les calculs HT/TTC deviendront testables en `gbtest`
après la séparation traitement/GUI (FPROMOART-005). Valeurs attendues produites dans le clone
**Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FPROMOART-T01 | replay | Ajout par prix HT | promo `ETE26` ; article stocké ; HT `10` | TTC calculé (TVA de l'article), INSERT | `tests/ajout_ht/` | implémenté (`Gestion/fpromoart_ajout_ht`) |
| FPROMOART-T02 | replay | Ajout par prix TTC supérieur au prix normal | TTC élevé ; question « Non » | prix effacés, aucune écriture | `tests/ajout_ttc_refus/` | implémenté (`Gestion/fpromoart_ajout_ttc_refus`) |
| FPROMOART-T03 | replay | Marge négative puis HT | TTC → marge ≤ 0 ; puis HT positif | message ; calcul TTC sauté une fois (A03 figée) | `tests/drapeau_marge/` | implémenté (`Gestion/fpromoart_drapeau_marge`, A03 figée : pttc 5 avec pht 15) |
| FPROMOART-T04 | replay | Modification d'un article existant | même article ; Oui | UPDATE `libelle, pht, pttc` | `tests/modification/` | implémenté (`Gestion/fpromoart_modification`) |
| FPROMOART-T05 | replay | Suppression d'un article présent en BL | Suppr sur la grille ; Oui | DELETE | `tests/suppression_bl/` | implémenté (`Gestion/fpromoart_suppression_bl`, par Button2 : touche Suppr sur grille non rejouée) |
| FPROMOART-T06 | replay | Article non stocké / code-barres | code d'article non stocké ; `*<code-barres>` | avertissement ; article retrouvé par code-barres | `tests/recherche_article/` | implémenté (`Gestion/fpromoart_recherche_article`) |
| FPROMOART-T07 | gbtest | Calcul HT/TTC (après FPROMOART-005) | HT 10 / 12,50 ; TVA 20 % et 5,5 % | TTC et HT de référence | `tests/calcul_ht_ttc/` | à faire : après FPROMOART-005 (calculs HT/TTC non exposés en Public) |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `.hidden/Tests/Gestion/assets/fpromoart_shared/fpromoart_base.sql` (promotion `ETE26`, articles 001/002 rendus stockés, 003 non stocké,
  une ligne de BL pour T05).
- **Comparaison** : dump normalisé de `Fiches_ArtPromo`.
- **Ordre de la grille** : le tri effectif dépend de l'ordre naturel de la table (A01) : comparer
  les lignes triées dans le dump, pas l'ordre affiché.
