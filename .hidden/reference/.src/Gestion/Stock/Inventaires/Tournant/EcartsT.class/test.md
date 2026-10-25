# EcartsT — Tests

> Source : `.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ECARTST-T01 | replay | Édition nominale | `invt_saisi.sql` (écarts positifs, négatifs, nuls ; lignes non comptées) ; « Imprimer » | texte du PDF (`pdftotext`) : lignes comptées seulement, écarts, valeurs PA/PMP, totaux ; ordre des lignes figé | `tests/edition/` | à faire |
| ECARTST-T02 | replay | Aucune ligne comptée | inventaire généré sans saisie | « Aucun article pour cette demande » | `tests/aucune_ligne/` | à faire |
| ECARTST-T03 | replay | Sans inventaire | `Fiches_InvT` absente | erreur non gérée à l’ouverture (figé A01) | `tests/sans_inventaire/` | à faire |
| ECARTST-T04 | replay | Pagination | jeu dérivé > 45 lignes comptées | sauts de page et en-têtes répétés | `tests/pagination/` | à faire |
| ECARTST-T05 | replay | Article supprimé | ligne comptée dont l'article n'existe plus | erreur non gérée (figé A02) | `tests/article_supprime/` | à faire |
| ECARTST-T06 | replay | Quantités décimales | articles `art_dec` 0/2/3, PA à 3 décimales | valeurs arrondies à 2 décimales | `tests/decimales/` | à faire |

## Détail des tests

- Aucune écriture en base : le critère est le **texte du PDF** produit dans le clone Laurux non
  modifié (`pdftotext -layout`, date d'impression masquée par `check_output.py`) et le dump
  inchangé.
- Données : `Laurux01.sql` + inventaire saisi (`GENINVT-T02 + SAISIEINVT-T02`), jeux dérivés pour T04-T06.
- Visualiseur PDF neutralisé par la configuration de test ; écran instrumenté par
  `Utils.Observers`.
