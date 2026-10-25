# RelMoprod — Tests

> Source : `.src/Statistiques/RelMoprod.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` lancés depuis le menu (Statistiques > Historique MO/produits par client).
On compare le **dump de `Fiches_Stat`** (table de travail restée en base), les lignes `Exec_SQL` du log
et le texte du PDF `~/tmp/HistoMoArt.pdf` (script de `/Soc01/caisse/CmdVis`, `pdftotext -layout`,
normalisation des dates). L'arbre `Rlcli` et le détail `Colrcp3` ne sont pas journalisés : ils sont
vérifiés indirectement (PDF, requêtes du clic) ou visuellement. Les valeurs attendues sont produites
dans le clone **Laurux non modifié**.

`Utils.Observers(Me)` est appelé **deux fois** dans `Form_Open` : les observateurs sont probablement
cumulés et chaque événement journalisé deux fois ; la capture et le rejeu doivent le tolérer
(anomalie RELMOPROD-A05).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RELMOPROD-T01 | replay | Traitement tous clients | `statistiques_ventes` ; `RB1`, **Traitement** | dump de `Fiches_Stat` (ligne répétée d'une même facture ignorée : A01 figée) | `tests/relmoprod_tous/` | à faire |
| RELMOPROD-T02 | replay | Traitement d'un client | `RB2`, recherche par nom dans `Colcli` (saisie dans `N1`), clic sur un client, **Traitement** | `Code` rempli ; `Fiches_Stat` limitée au client | `tests/relmoprod_un_client/` | à faire |
| RELMOPROD-T03 | replay | Client sans donnée | `RB2`, client sans facture | « Il n'y a aucune donnée pour ce client » | `tests/relmoprod_sans_donnee/` | à faire |
| RELMOPROD-T04 | replay | Impression par client | après T01, `RB3`, **Traitement**, **Imprimer** | texte PDF (client, MO, articles, factures) ; saut de page à 273 | `tests/relmoprod_impr_client/` | à faire |
| RELMOPROD-T05 | replay | Impression par produit | `RB4`, **Traitement**, **Imprimer** | texte PDF par type puis code ; page de garde issue du `Baspage` initial (figée) | `tests/relmoprod_impr_produit/` | à faire |
| RELMOPROD-T06 | replay | Détail d'une facture | après T04, clic sur un nœud « Facture numéro … » historisé, puis sur une facture en cours ; **Fermer** | requêtes `Fiches_HistoFac`/`HistoLigfac` puis `Fiches_Bl`/`Ligbl` ; total affiché (contrôle visuel) | `tests/relmoprod_detail/` | à faire |
| RELMOPROD-T07 | replay | Impression sans traitement | ouverture, **Imprimer** | « Veuillez lancer le traitement avant l'impression SVP ! » | `tests/relmoprod_impr_vide/` | à faire |
| RELMOPROD-T08 | replay | Tri de la grille client | clic `C1`, double-clic `N1`, saisie dans `Cp1`, Échap | requêtes `like "%…%"` avec tri ascendant/descendant | `tests/relmoprod_recherche/` | à faire |
| RELMOPROD-T09 | gbtest | Remplissage (après RELMOPROD-006) | `RemplitStat(d0, d1, "")` et `(d0, d1, client)` sur le jeu de T01/T02 | contenu de `Fiches_Stat` identique à T01/T02 | `tests/relmoprod_remplissage/` | à faire |

## Détail des tests

- **Exécution en série** : la table `Fiches_Stat` est partagée avec `RelvMo`, `RelMoprod` et `TriHistos` ;
  ces replays ne tournent pas en parallèle sur la même base.

- **Données** : `statistiques_ventes` (voir [`TBord/test.md`](../TBord.class/test.md)) avec des factures
  contenant des lignes MO (`M`), articles (`A`) et commentaires (`C`), une facture avec deux lignes du
  même code (révèle A01), des factures en cours `F` imprimées et non imprimées, des factures matériel
  historisées, plus de 50 lignes pour un client (saut de page), un client sans facture.
- **Horloge** fixée (période par défaut et pied de page).
- **Grille sans `_Click`** : `Colrcp3` (`replay_missing`) : pas de clic dans le détail.
- **Non testable automatiquement** : contenu de l'arbre et du détail (contrôle visuel), son, couleurs.
