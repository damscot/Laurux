# EditStkDepart — Tests

> Source : `.src/Gestion/option/EditStkDepart.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

État d'impression en lecture seule. La sortie à comparer est le PDF produit
(`~/tmp/stockmat.pdf`), converti en texte par `pdftotext -layout` puis normalisé (date du jour
masquée), plus la suite des lignes `Exec_SQL`. Valeurs attendues produites dans le clone Laurux non
modifié, avec l'horloge figée (`faketime`) pour la date d'édition.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDITSTKDEPART-T01 | replay | Stock de fin (`fin`) | jeu `cmat_base` (2 régies, 3 degrés, 6 articles) ; Caleditcmat → « Stock » | texte PDF : en-têtes de régie, sous-totaux par degré, totaux, sauts de page | `tests/stock_fin/` | à faire |
| EDITSTKDEPART-T02 | replay | Stock de départ (`depart`) | même jeu, `art_stkdep` renseigné ; « Stock de départ » | texte PDF de référence | `tests/stock_depart/` | à faire |
| EDITSTKDEPART-T03 | replay | Inventaire fin d'année (`inventaire`) | jeu + `Fiches_Inv` | texte PDF de référence | `tests/inventaire/` | à faire |
| EDITSTKDEPART-T04 | replay | Inventaire tournant (`tournant`) | jeu + `Fiches_InvT` | texte PDF de référence | `tests/inventaire_tournant/` | à faire |
| EDITSTKDEPART-T05 | replay | Article avec `art_dra = ''` (A01) | un article à code régie vide | figer : article imprimé sous une régie sans libellé | `tests/regie_vide/` | à faire |
| EDITSTKDEPART-T06 | replay | Aucun article soumis à régie | `cmat_base` sans `art_dra` | PDF vide (en-tête seul) ; `Busy` revenu à 0 | `tests/aucun_article/` | à faire |

## Détail des tests

- **Jeu `cmat_base`** : voir [atribvignette](../atribvignette.class/test.md) ; ajouter
  `Fiches_Inv`/`Fiches_InvT` pour T03/T04.
- **Comparaison** : `check_output.py` compare le texte extrait du PDF (mise en page conservée) ;
  les montants dépendent de `Calculdroit` (taux de la régie, TVA) : toute différence doit être
  analysée avec les tests de [calculdroit](../calculdroit.class/test.md).
- **Rendu de police** (A02) : non comparable par le texte ; vérification visuelle seulement.
