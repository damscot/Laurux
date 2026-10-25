# EdPrep — Tests

> Source : `.src/Gestion/Impressions/EdPrep.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` : comparaison du texte de `~/tmp/ListeDocs.pdf` et `~/tmp/Liste2Docs.pdf`
(`pdftotext -layout`), du CSV `~/tmp/Expedition.csv`, des lignes `Exec_SQL` ; dump inchangé.
`Impression.Facture` est neutralisée (`/CmdImp` = script de capture, `/FACpdf` = 0),
`Visualiseur.Prog` et `Editeur.Prog_Editeur` (`/CmdEditor0`) aussi. Valeurs attendues produites
dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDPREP-T01 | replay | Impression sans détail | 3 commandes `C` (dont une avec `Fiches_AdrlivC`, une avec `Fiches_AdrlivBL`), tri par numéro | texte des deux PDF ; impression capturée | `tests/sans_detail/` | à faire |
| EDPREP-T02 | replay | Impression avec détail | `RadioButton7`, commandes avec lignes `A` et commentaires `YY` | détail des lignes et commentaires | `tests/avec_detail/` | à faire |
| EDPREP-T03 | replay | Adresse de livraison | commande avec `Fiches_AdrlivBL` de ville différente | bon : ville de facturation dans le bloc livraison (A01 figée) | `tests/adresse_livraison/` | à faire |
| EDPREP-T04 | replay | Ordres de tri | `RadioButton9`, `10`, `11` | ordre des documents | `tests/ordres_tri/` | à faire |
| EDPREP-T05 | replay | Saut de page des bons | commande de 50 lignes et longs commentaires | date brute sur les pages suivantes (A02 figée) | `tests/saut_page/` | à faire |
| EDPREP-T06 | replay | Export expédition | `RadioButton6`, Exporter, « Non » | CSV : véhicule complet, incomplet (repli), reliquat | `tests/export_expedition/` | à faire |
| EDPREP-T07 | replay | Aucune commande | pas de document `C` ; Imprimer puis Exporter | messages « Aucun document… » | `tests/aucune_commande/` | à faire |

## Détail des tests

- **Données** : jeu `editions_gestion` (voir [Edbr](../Edbr.module/test.md)) : commandes `C` avec
  clients, adresses de livraison client et document, lignes article (fournisseur différent de
  `art_four` sur une ligne), commentaires `YY`, commentaires véhicule `XX` (complet / incomplet),
  ligne « Reliquat ».
- **Clé globale** : `/intitule` fixée dans le `Laurux.conf` de test.
- **Non testable automatiquement** : impression papier réelle (capturée), son.
