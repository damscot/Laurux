# Ecarts — Tests

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ECARTS-T01 | replay | Édition nominale | `inv_saisi.sql` (écarts positifs, négatifs, nuls ; lignes non comptées) ; « Imprimer » | texte du PDF (`pdftotext`) : lignes comptées seulement, écarts, valeurs PA/PMP, totaux ; ordre des lignes figé | `tests/edition/` | implémenté (`Gestion/ecarts_edition`, jeu `validinv_shared/inv_fin_partiel`) |
| ECARTS-T02 | replay | Aucune ligne comptée | inventaire généré sans saisie | « Aucun article pour cette demande » | `tests/aucune_ligne/` | implémenté (`Gestion/ecarts_aucune_ligne`, jeu `ecarts_shared/inv_non_compte`) |
| ECARTS-T03 | replay | Sans inventaire | `Fiches_Inv` absente | message « aucun inventaire » et fermeture | `tests/sans_inventaire/` | implémenté (`Gestion/ecarts_sans_inventaire`, jeu `Laurux01 seul`) |
| ECARTS-T04 | replay | Pagination | jeu dérivé > 45 lignes comptées | sauts de page et en-têtes répétés | `tests/pagination/` | implémenté (`Gestion/ecarts_pagination`, jeu `ecarts_shared/inv_pagination`) |
| ECARTS-T05 | replay | Article supprimé | ligne comptée dont l'article n'existe plus | erreur non gérée (figé A01) | `tests/article_supprime/` | implémenté (`Gestion/ecarts_article_supprime`, jeu `ecarts_shared/inv_compte_supprime` ; code 125 figé) |
| ECARTS-T06 | replay | Quantités décimales | articles `art_dec` 0/2/3, PA à 3 décimales | valeurs arrondies à 2 décimales | `tests/decimales/` | implémenté (`Gestion/ecarts_decimales`, jeu `ecarts_shared/inv_decimales`) |

## Détail des tests

- Aucune écriture en base : le critère est le **texte du PDF** produit dans le clone Laurux non
  modifié (`pdftotext -layout`, date d'impression masquée par `check_output.py`) et le dump
  inchangé.
- Données : `Laurux01.sql` + inventaire saisi (`GENINV-T01 + SAISIEINV-T02`), jeux dérivés pour T04-T06.
- Visualiseur PDF neutralisé par la configuration de test ; écran instrumenté par
  `Utils.Observers`.
- Mise en œuvre (vague 9) : scénarios `Gestion/ecarts_*` (texte du PDF par `pdftotext`, `edition.txt`) ; jeux dérivés `.hidden/Tests/Gestion/assets/ecarts_shared/` (`inv_non_compte`, `inv_pagination`, `inv_compte_supprime`, `inv_decimales`), générés par `ecarts_shared/gen_editions_inv.py` ; jeu `validinv_shared/inv_fin_partiel` (lecture seule) pour T01.
