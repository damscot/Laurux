# Ecarts — Tests

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ECARTS-T01 | replay | Édition nominale | `inv_saisi.sql` (écarts positifs, négatifs, nuls ; lignes non comptées) ; « Imprimer » | texte du PDF (`pdftotext`) : lignes comptées seulement, écarts, valeurs PA/PMP, totaux ; ordre des lignes figé | `tests/edition/` | à faire |
| ECARTS-T02 | replay | Aucune ligne comptée | inventaire généré sans saisie | « Aucun article pour cette demande » | `tests/aucune_ligne/` | à faire |
| ECARTS-T03 | replay | Sans inventaire | `Fiches_Inv` absente | message « aucun inventaire » et fermeture | `tests/sans_inventaire/` | à faire |
| ECARTS-T04 | replay | Pagination | jeu dérivé > 45 lignes comptées | sauts de page et en-têtes répétés | `tests/pagination/` | à faire |
| ECARTS-T05 | replay | Article supprimé | ligne comptée dont l'article n'existe plus | erreur non gérée (figé A01) | `tests/article_supprime/` | à faire |
| ECARTS-T06 | replay | Quantités décimales | articles `art_dec` 0/2/3, PA à 3 décimales | valeurs arrondies à 2 décimales | `tests/decimales/` | à faire |

## Détail des tests

- Aucune écriture en base : le critère est le **texte du PDF** produit dans le clone Laurux non
  modifié (`pdftotext -layout`, date d'impression masquée par `check_output.py`) et le dump
  inchangé.
- Données : `Laurux01.sql` + inventaire saisi (`GENINV-T01 + SAISIEINV-T02`), jeux dérivés pour T04-T06.
- Visualiseur PDF neutralisé par la configuration de test ; écran instrumenté par
  `Utils.Observers`.
