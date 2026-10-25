# MajTarifM — Tests

> Source : `.src/Gestion/Stock/Tarifs/MajTarifM.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> **Module complexe** : la liste des scénarios ci-dessous est **à faire valider par
> l'utilisateur avant la phase 2** (périmètre, jeux de données, cas d'anomalie à figer).

La cascade de calcul vit dans les contrôles : tests par **replay** (dump de `Fiches_Art`,
`Fiches_EtiProd`, `Fiches_EtiGond` ; valeurs affichées capturées dans le log). Les gb.test ne sont
possibles qu'après extraction des fonctions pures (ARTICLES-011). Jeu dérivé de `Laurux01.sql` :
fournisseur numérique `100` et fournisseur alphanumérique `FA`, ~10 articles (arrondis `0,01`,
`0,05`, `0,10`, `0,50`, `1,00`, `art_nbd` 0/2/3, stock nul/positif, `art_etiq`, remises en cascade).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MAJTARIFM-T01 | replay | Liste et recherche | fournisseur `100` par la liste ; recherche par code, intitulé, famille, `Cb1` = Barre ; double-clic (tri descendant) | contenu de la grille (log) | `tests/recherche/` | à faire |
| MAJTARIFM-T02 | replay | Fournisseur alphanumérique (A01) | fournisseur `FA` saisi puis recherche | erreur SQL (caractérisation) | `tests/fournisseur_alpha/` | à faire |
| MAJTARIFM-T03 | replay | Modification du prix de base | article, `PbHt2` +10 %, Entrée sur chaque champ jusqu'à `PvTTc2`, Enregistrer | dump `Fiches_Art`, étiquettes | `tests/prix_base/` | à faire |
| MAJTARIFM-T04 | replay | Remise et remises en cascade | `Tr2` 10 %, double-clic → `Rem4`-`Rem6` 5/3/2 %, Enregistrer | dump `Fiches_Art` (`art_remcas1-3`) | `tests/remises_cascade/` | à faire |
| MAJTARIFM-T05 | replay | Prix net modifié (question 1/2) | `PaUA2` modifié, réponse 1 puis (autre article) réponse 2 | dump `Fiches_Art` | `tests/prix_net/` | à faire |
| MAJTARIFM-T06 | replay | Coefficient, taux de marque, PV HT, PV TTC | saisie directe de `Coef2`, `Percent2`, `PvHt2` (dont < prix d'achat), `PvTTc2`, arrondis `0,05` et `0,50` | dump `Fiches_Art`, avertissements | `tests/pv_coef/` | à faire |
| MAJTARIFM-T07 | replay | Étiquettes et exports (A03) | article stocké `art_etiq = 1`, stock décimal `12,5` (`art_dec = 3`), drapeaux d'export actifs | dump étiquettes, `Art_Serveur.txt` (fige le double export) | `tests/etiquettes_export/` | à faire |
| MAJTARIFM-T08 | replay | Enchaînement de deux articles (A05) | deux articles successifs sans fermer l'écran | marges affichées (log) ; dump | `tests/deux_articles/` | à faire |
| MAJTARIFM-T09 | gbtest | Écart avec `PrixVente` | jeu VARMAJTAR-T03 (`pxrev`, coefficient, TVA, arrondi) passé à la chaîne `PvHt = Prvt × Coef` + TVA + arrondi par chaîne (après extraction ARTICLES-011) et à `PrixVente` | tableau d'écarts (documentaire, pas d'équivalence attendue) | `tests/ecart_prixvente/` | à faire |
| MAJTARIFM-T10 | replay | Taux de conversion et décimales | article à stock nul : `Txconv2` modifié ; article stocké : refus ; `Nbd2` changé | dump ; `Balloon` | `tests/conversion_decimales/` | à faire |
| MAJTARIFM-T11 | replay | SQLite | T01 et T03 sur base SQLite (`lpad` traduit) | dump de référence | `tests/sqlite/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; `art_ddatefbt` masqué.
- **Rejeu** : `Utils.Observers(Me)` appelé une fois dans `_new` ; `colarts_Click` et
  `fourList_Click` sont appelés dynamiquement (`replay_dynamic`). Les questions
  (`Message.Question` du prix net, impression des étiquettes) font partie du scénario.
- **`bModif`** : l'enregistrement n'a lieu que si `PvTTc2` a changé (`Cmpt_Change`) ; chaque
  scénario d'enregistrement doit le vérifier (T03 à T07).
- **Code mort** non couvert : `Deb2`, `Deb3`, `Deb4`, `Dbclk`, `Calc_coeff`.
