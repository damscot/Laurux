# Ednsaisis — Tests

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDNSAISIS-T01 | replay | Édition nominale | `inv_saisi.sql` (lignes comptées et non comptées) ; « Imprimer » | texte du PDF : seules les lignes non comptées, valeurs PA/PMP, totaux | `tests/edition/` | implémenté (`Gestion/ednsaisis_edition`, jeu `validinv_shared/inv_fin_partiel`) |
| EDNSAISIS-T02 | replay | Tout compté | inventaire entièrement saisi | « Aucun article pour cette demande » | `tests/aucune_ligne/` | implémenté (`Gestion/ednsaisis_aucune_ligne`, jeu `validinv_shared/inv_fin_compte`) |
| EDNSAISIS-T03 | replay | Sans inventaire | `Fiches_Inv` absente | message et fermeture | `tests/sans_inventaire/` | implémenté (`Gestion/ednsaisis_sans_inventaire`, jeu `Laurux01 seul`) |
| EDNSAISIS-T04 | replay | Pagination | > 45 lignes non comptées | sauts de page | `tests/pagination/` | implémenté (`Gestion/ednsaisis_pagination`, jeu `ecarts_shared/inv_pagination`) |
| EDNSAISIS-T05 | replay | Décimales et alignement | `art_dec` 0/2/3, stocks décimaux | valorisation identique au calcul attendu (figer l'effet des espaces de remplissage) | `tests/decimales/` | implémenté (`Gestion/ednsaisis_decimales`, jeu `ecarts_shared/inv_decimales`) |
| EDNSAISIS-T06 | replay | Article supprimé | ligne non comptée dont l'article n'existe plus | erreur non gérée (figé) | `tests/article_supprime/` | implémenté (`Gestion/ednsaisis_article_supprime`, jeu `ecarts_shared/inv_non_compte_supprime` ; code 125 figé) |

## Détail des tests

- Lecture seule : critère = texte du PDF (`pdftotext -layout`, dates masquées) produit dans le
  clone Laurux non modifié, et dump inchangé.
- Données : `Laurux01.sql` + inventaire saisi ; jeux dérivés pour T04-T06.
- Mise en œuvre (vague 9) : scénarios `Gestion/ednsaisis_*` (texte du PDF, `edition.txt`) ; jeux `validinv_shared/inv_fin_partiel` et `inv_fin_compte` (lecture seule), `ecarts_shared/inv_pagination`, `inv_decimales`, `inv_non_compte_supprime` (générateur `ecarts_shared/gen_editions_inv.py`).
