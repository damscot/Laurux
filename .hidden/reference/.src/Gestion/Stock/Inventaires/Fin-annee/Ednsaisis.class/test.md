# Ednsaisis — Tests

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDNSAISIS-T01 | replay | Édition nominale | `inv_saisi.sql` (lignes comptées et non comptées) ; « Imprimer » | texte du PDF : seules les lignes non comptées, valeurs PA/PMP, totaux | `tests/edition/` | à faire |
| EDNSAISIS-T02 | replay | Tout compté | inventaire entièrement saisi | « Aucun article pour cette demande » | `tests/aucune_ligne/` | à faire |
| EDNSAISIS-T03 | replay | Sans inventaire | `Fiches_Inv` absente | message et fermeture | `tests/sans_inventaire/` | à faire |
| EDNSAISIS-T04 | replay | Pagination | > 45 lignes non comptées | sauts de page | `tests/pagination/` | à faire |
| EDNSAISIS-T05 | replay | Décimales et alignement | `art_dec` 0/2/3, stocks décimaux | valorisation identique au calcul attendu (figer l'effet des espaces de remplissage) | `tests/decimales/` | à faire |
| EDNSAISIS-T06 | replay | Article supprimé | ligne non comptée dont l'article n'existe plus | erreur non gérée (figé) | `tests/article_supprime/` | à faire |

## Détail des tests

- Lecture seule : critère = texte du PDF (`pdftotext -layout`, dates masquées) produit dans le
  clone Laurux non modifié, et dump inchangé.
- Données : `Laurux01.sql` + inventaire saisi ; jeux dérivés pour T04-T06.
