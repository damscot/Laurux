# EdnsaisisT — Tests

> Source : `.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDNSAISIST-T01 | replay | Édition nominale | `invt_saisi.sql` (lignes comptées et non comptées) ; « Imprimer » | texte du PDF : seules les lignes non comptées, valeurs PA/PMP, totaux | `tests/edition/` | implémenté (`Gestion/ednsaisist_edition`, jeu `validinvt_shared/invt_partiel`) |
| EDNSAISIST-T02 | replay | Tout compté | inventaire entièrement saisi | « Aucun article pour cette demande » | `tests/aucune_ligne/` | implémenté (`Gestion/ednsaisist_aucune_ligne`, jeu `validinvt_shared/invt_compte`) |
| EDNSAISIST-T03 | replay | Sans inventaire | `Fiches_InvT` absente | erreur non gérée à l’ouverture (figé A01) | `tests/sans_inventaire/` | implémenté (`Gestion/ednsaisist_sans_inventaire`, jeu `validinvt_shared/invt_absent` ; code 125 figé) |
| EDNSAISIST-T04 | replay | Pagination | > 45 lignes non comptées | sauts de page | `tests/pagination/` | implémenté (`Gestion/ednsaisist_pagination`, jeu `ecartst_shared/invt_pagination`) |
| EDNSAISIST-T05 | replay | Décimales et alignement | `art_dec` 0/2/3, stocks décimaux | valorisation identique au calcul attendu (figer l'effet des espaces de remplissage) | `tests/decimales/` | implémenté (`Gestion/ednsaisist_decimales`, jeu `ecartst_shared/invt_decimales`) |
| EDNSAISIST-T06 | replay | Article supprimé | ligne non comptée dont l'article n'existe plus | erreur non gérée (figé) | `tests/article_supprime/` | implémenté (`Gestion/ednsaisist_article_supprime`, jeu `ecartst_shared/invt_non_compte_supprime` ; code 125 figé) |

## Détail des tests

- Lecture seule : critère = texte du PDF (`pdftotext -layout`, dates masquées) produit dans le
  clone Laurux non modifié, et dump inchangé.
- Données : `Laurux01.sql` + inventaire saisi ; jeux dérivés pour T04-T06.
- Mise en œuvre (vague 9) : scénarios `Gestion/ednsaisist_*` (texte du PDF, `edition.txt`) ; jeux `validinvt_shared/invt_partiel`, `invt_compte`, `invt_absent` (lecture seule) et `ecartst_shared/*` (générateur `ecarts_shared/gen_editions_inv.py`).
