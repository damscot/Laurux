# EdStk — Tests

> Source : `.src/Gestion/Impressions/EdStk.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` depuis le menu Stock : PDF `~/tmp/rStock.pdf` capturé (`/Soc01/caisse/CmdVis`),
`pdftotext -layout`, normalisation de la date du titre ; comparaison du texte, des lignes
`Exec_SQL` et du dump (inchangé). Valeurs attendues produites dans le clone **non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDSTK-T01 | replay | Stock chiffré, tri par code | défauts (`Ch1`, `Ch3`, `RadioButton1`), **Imprimer** | lignes `Level3` des seuls articles stockés, totaux `Level5` (cumul arrondi à chaque ligne figé) | `tests/edstk_chiffre/` | à faire |
| EDSTK-T02 | replay | Stock non chiffré | `Ch2` | lignes `Level4`, pas de totaux | `tests/edstk_non_chiffre/` | à faire |
| EDSTK-T03 | replay | Code imprimé | `Ch4`, `Ch5`, `Ch6` successivement (articles avec et sans code fournisseur/code-barre/équivalent) | code demandé ou repli sur `art_code` | `tests/edstk_codes/` | à faire |
| EDSTK-T04 | replay | Tris et plages | `RadioButton2..4`, plages famille et fournisseur restreintes | ordre et filtrage des lignes ; 7ᵉ paramètre SQL = 1 | `tests/edstk_tris/` | à faire |
| EDSTK-T05 | replay | Pagination et totaux | > 1 page ; dernier article au-delà de 250 mm | saut à 270 mm sans pied de page ; totaux sur une nouvelle page | `tests/edstk_pagination/` | à faire |
| EDSTK-T06 | replay | Décimales | articles `art_nbd` 0/2/3, `art_dec` 0/2/3, quantité négative | formats `Find_nbdec`/`CDec` ; valorisation négative | `tests/edstk_decimales/` | à faire |
| EDSTK-T07 | replay | Aucun article / listes | plage vide ; F2 absent, bouton liste famille puis Échap et F1 | message « Aucun article… » ; liste fermée par F1 | `tests/edstk_vide_listes/` | à faire |
| EDSTK-T08 | gbtest | Valorisation (après EDSTK-004) | triplets `paht`, `pmp`, `qte`, `nbdec` | `Thtpa`, `Thtpmp`, cumuls identiques aux sorties de T01/T06 | `tests/edstk_valorisation/` | à faire |

## Détail des tests

- **Données** : jeu `editions_articles` ([EdArt1/test.md](../EdArt1.class/test.md#détail-des-tests)) :
  articles stockés et non stockés, `art_qte` positifs, nuls et négatifs, `art_paht`/`art_pmp`
  différents, au moins 60 articles stockés pour la pagination.
- **Point d'attention** : `Print code` écrit sur la sortie standard en cas d'erreur de format :
  capturer stdout du rejeu.
- **Non testable automatiquement** : son, couleur du focus (`ObsGotf`/`ObsLstf`), aide F1 (absente
  des champs).
