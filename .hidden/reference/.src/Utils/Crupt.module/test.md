# Crupt — Tests

> Source : `.src/Utils/Crupt.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`Rupture` est une procédure SQL sans GUI : elle se teste en gb.test en appelant
`Crupt.Rupture(...)` puis en comparant le contenu des tables `Rupture` et `RuptureC` (dump trié). Les
valeurs attendues sont produites par le clone **Laurux non modifié** sur le même jeu. Un `replay`
couvre l'impression `EdRup` de bout en bout.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CRUPT-T01 | gbtest | Cas nominal | `Laurux01.sql` ; `chk1 = False`, `chk2 = False`, bornes fournisseurs et articles complètes | dump `Rupture` (et `RuptureC`) | `tests/nominal/` | à faire |
| CRUPT-T02 | gbtest | Produits non stockés | `chk1 = True`, `chk2 = False` | dump `Rupture` | `tests/non_stockes/` | à faire |
| CRUPT-T03 | gbtest | Regroupement par client | `chk1 = False/True`, `chk2 = True` | dumps `Rupture` et `RuptureC` | `tests/par_client/` | à faire |
| CRUPT-T04 | gbtest | Bornes | un seul fournisseur (`four1 = four2`) ; plage d'articles réduite ; plage vide | dumps | `tests/bornes/` | à faire |
| CRUPT-T05 | gbtest | Articles divers `.DEP` et désignations `"~ "` | jeu dérivé : lignes `.DEP` de même code et intitulés différents ; désignations préfixées | dumps | `tests/articles_divers/` | à faire |
| CRUPT-T06 | gbtest | Cumuls multi-fournisseurs | jeu dérivé : même article commandé chez 2 fournisseurs, commandes clients multiples | dumps (figer l'effet de la mise à jour l. 117 sans `four`) | `tests/multi_fournisseurs/` | à faire |
| CRUPT-T07 | gbtest | Cas limites | `art_txconv = 0` ; `art_stkmin` NULL ; `stkmini = 0` ; branche l. 181 (`codec <> "0"`) | erreur ou dump figé | `tests/cas_limites/` | à faire |
| CRUPT-T08 | gbtest | Performance | jeu volumineux (5 000 lignes de commandes) | durée de référence (`gbx3 -p`) | `tests/perf_rupture/` | à faire |
| CRUPT-T09 | replay | Impression des ruptures | Gestion → Impressions → Ruptures (`EdRup`), cases cochées ou non | PDF généré (texte extrait) ; tables `Rupture`/`RuptureC` | `tests/edrup_impression/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` ; `derive.sql` ajoute commandes fournisseurs (`Fiches_Entcom`,
  `Fiches_Ligcom`), commandes clients (`Fiches_Bl` type `C`, `Fiches_Ligbl`), articles `.DEP`,
  articles avec seuils mini/maxi et `art_txconv` variés.
- **`gen_input.py`** : génère la matrice `chk1 × chk2 × bornes` (8 combinaisons par jeu).
- **Comparaison** : dumps triés par `(codea, four, codec, intitulea, numcom)`, Float avec tolérance
  1e-9.
- **Couverture** : les branches `Org <> "EdRup"` (code mort) ne sont couvertes que par un appel
  direct avec `Org = "Autre"`, utile pour figer leur comportement avant suppression (CRUPT-002).
