# RazArt — Tests

> Source : `.src/Utils/RazArt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZART-T01 | replay | `Chk1` | `Laurux01.sql` ; `Chk1` coché, « Oui » | diff `Fiches_Art` : `art_stocke`, `art_com`, `art_stkdep` à 0, `art_qte` inchangé | `tests/raz_stocks/` | à faire |
| RAZART-T02 | replay | `Chk2` | `Chk2` coché | `art_pmp` = `art_prvt` pour tous les articles | `tests/pmp_prvt/` | à faire |
| RAZART-T03 | replay | `Stk1` puis `Stk2` | chaque bouton radio | `art_stocke` = 0 / 1 partout | `tests/stocke/` | à faire |
| RAZART-T04 | replay | `Chk3` avec texte | `TextBox1` = `"30"` ; jeu dérivé avec codes contenant `30` au début et au milieu | figer : `art_cbarre = " "` et suppression dans `Fiches_CdBarre` pour **tous** les codes contenant `30` | `tests/raz_cbarre_filtre/` | à faire |
| RAZART-T05 | replay | `Chk3` sans texte | `TextBox1` vide | `art_cbarre = ""`, `Fiches_CdBarre` vide (MySQL) | `tests/raz_cbarre_tout/` | à faire |
| RAZART-T06 | replay | Refus | « Non » à la 1ʳᵉ question ; « Non » à la question code-barres | aucune modification ; figer message final et curseur | `tests/refus/` | à faire |
| RAZART-T07 | replay | SQLite | T05 sur `Laurux01.sqlite` | figer l'erreur `Truncate` | `tests/sqlite_truncate/` | à faire |

## Détail des tests

- Capture dans le clone **Laurux non modifié** (menu « RAZ zones article »). Comparaison du dump de
  `Fiches_Art` et `Fiches_CdBarre` ; pour les reworks qui changent le nombre de requêtes (boucle →
  `UPDATE` unique), la comparaison porte sur le **dump** et non sur les lignes `Exec_SQL`.
- Jeux dérivés (T04) générés par `gen_input.py`.
