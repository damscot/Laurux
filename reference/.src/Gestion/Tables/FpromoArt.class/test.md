# FpromoArt — Tests

> Source : `.src/Gestion/Tables/FpromoArt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_ArtPromo` ; les calculs HT/TTC deviendront testables en `gbtest`
après la séparation traitement/GUI (FPROMOART-005). Valeurs attendues produites dans le clone
**Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FPROMOART-T01 | replay | Ajout par prix HT | promo `ETE26` ; article stocké ; HT `10` | TTC calculé (TVA de l'article), INSERT | `tests/ajout_ht/` | à faire |
| FPROMOART-T02 | replay | Ajout par prix TTC supérieur au prix normal | TTC élevé ; question « Non » | prix effacés, aucune écriture | `tests/ajout_ttc_refus/` | à faire |
| FPROMOART-T03 | replay | Marge négative puis HT | TTC → marge ≤ 0 ; puis HT positif | message ; calcul TTC sauté une fois (A03 figée) | `tests/drapeau_marge/` | à faire |
| FPROMOART-T04 | replay | Modification d'un article existant | même article ; Oui | UPDATE `libelle, pht, pttc` | `tests/modification/` | à faire |
| FPROMOART-T05 | replay | Suppression d'un article présent en BL | Suppr sur la grille ; Oui | DELETE | `tests/suppression_bl/` | à faire |
| FPROMOART-T06 | replay | Article non stocké / code-barres | code d'article non stocké ; `*<code-barres>` | avertissement ; article retrouvé par code-barres | `tests/recherche_article/` | à faire |
| FPROMOART-T07 | gbtest | Calcul HT/TTC (après FPROMOART-005) | HT 10 / 12,50 ; TVA 20 % et 5,5 % | TTC et HT de référence | `tests/calcul_ht_ttc/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé (promotion `ETE26`, articles stockés et non stockés,
  une ligne de BL pour T05).
- **Comparaison** : dump normalisé de `Fiches_ArtPromo`.
- **Ordre de la grille** : le tri effectif dépend de l'ordre naturel de la table (A01) : comparer
  les lignes triées dans le dump, pas l'ordre affiché.
