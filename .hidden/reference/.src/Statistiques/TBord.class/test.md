# TBord — Tests

> Source : `.src/Statistiques/TBord.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

L'écran calcule tout à l'ouverture et n'a qu'un bouton **Quitter**. Il n'appelle pas
`Utils.Observers(Me)` : ses contrôles ne sont ni journalisés ni rejouables. Le scénario se limite donc
à l'ouverture depuis le menu `Fmenu` (instrumenté), puis à la fermeture. Le résultat se compare :
- par le **dump de la base** : la table de travail `Total` reste en base après l'ouverture (une ligne
  par mois, colonnes `brutfac … nb`) ;
- par les lignes `Exec_SQL` du log ;
- par les libellés, uniquement après la séparation TBORD-005 (gbtest des fonctions extraites).

Les valeurs attendues sont produites dans le clone **Laurux non modifié** (anomalies comprises).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TBORD-T01 | replay | Ouverture, factures historisées seules | `statistiques_ventes`, `/Soc01/Materiel = 0`, horloge fixée ; menu Tableau de bord, puis **Quitter** | dump de `Total` (12 mois au plus) ; `SELECT … Fiches_HistoFac` sans `union` | `tests/tbord_factures/` | à faire |
| TBORD-T02 | replay | Avec matériel | même jeu, `/Soc01/Materiel = 1`, factures dans `Fiches_HistoFacM` et BL dans `Fiches_BlM` | `Total` inclut les tables `M` (requêtes `union`) | `tests/tbord_materiel/` | à faire |
| TBORD-T03 | replay | BL facturés non historisés | `Fiches_Bl` type `F`, `imp` 0 et 1, dans et hors période ; un mois sans facture historisée | seules les lignes `imp = 1` cumulées ; ordre des lignes de `Total` (A04 figée) | `tests/tbord_bl_factures/` | à faire |
| TBORD-T04 | replay | Documents en cours | `Fiches_Bl` de types `P`, `D`, `C`, `B`, `F` (2 documents au moins par type), un `totalht` NULL | log `SELECT … order by type` ; dump inchangé hors `Total` ; montants sous-évalués figés (A01) via T07 | `tests/tbord_docs_en_cours/` | à faire |
| TBORD-T05 | replay | Base sans vente | `Laurux01.sql` brut (aucune facture) | `Total` vide, aucun message, pas de dessin ; documents en cours à 0 | `tests/tbord_vide/` | à faire |
| TBORD-T06 | replay | Division par zéro | une facture de `totfac = 0` seule dans un mois, puis un BL `F` à 0 dans le même mois | comportement actuel figé (erreur Gambas ligne 168/172 ou valeurs) (A05) | `tests/tbord_zero/` | à faire |
| TBORD-T07 | gbtest | Indicateurs (après TBORD-005) | `RemplitTotal`, `LitAgregats`, `DocsEnCours` sur le jeu de T01-T04 | tableaux de valeurs identiques aux libellés relevés manuellement dans le clone de référence | `tests/tbord_indicateurs/` | à faire |
| TBORD-T08 | replay | SQLite | T01 sur la base `Laurux01.sqlite` + jeu converti | erreur `MONTH` ou résultat (A02 figée, à confirmer) | `tests/tbord_sqlite/` | à faire |

## Détail des tests

- **Jeu `statistiques_ventes`** (jeu commun défini dans [`StatComm/test.md`](../StatComm.class/test.md),
  script `tests/_donnees/statistiques_ventes.sql`) ; compléments nécessaires à `TBord`, `HitCarte`, `Histocliart`,
  `Histovmo`, `RelvMo`, `RelMoprod`, `Stat*`) : `Laurux01.sql` + script SQL de ventes réparties sur les
  13 derniers mois par rapport à la date fixée : factures historisées `Fiches_HistoFac`/`HistoLigfac`
  et `Fiches_HistoFacM`/`HistoLigfacM` avec `totfac`, `remmofac`/`remartfac` (avec virgule et vides),
  `marge_art`/`marge_mo` ; documents `Fiches_Bl`/`Ligbl` (et `BlM`/`LigblM`) de chaque type, `imp` 0/1,
  `dtefac` renseigné pour le type `F` ; lignes d'articles (`typel = 'A'`), de main-d'oeuvre (`'M'`) et de
  commentaire (`'C'`) ; 3 clients `411…` (deux types client, deux commerciaux), 3 mains-d'oeuvre, 2
  familles (arborescence), 2 fournisseurs `401…`, marques et centrales ; tickets archivés
  `Fiches_HisEntTickets`/`HisLigTickets` avec et sans carte, cartes `Fiches_Carte`. Un mois sans aucune
  vente et une facture datée du jour à 12:00 (effet du filtre `datefac <= aaaammjj`).
- **Exécution en série** : les replays qui recréent la table `Total` (TBord, HitCarte, VisHitCartes,
  `Stat*`, `Statcai`) ne doivent pas tourner en parallèle sur la même base.
- **Horloge** : la période dépend de `Now` ; fixer l'horloge (`faketime`) pour tous les tests.
- **Non testable automatiquement** : rendu de l'histogramme (`drwChart`, couleurs, échelle, décalage
  des barres TBORD-A04) et contenu des libellés tant que TBORD-005 n'est pas faite : contrôle visuel
  (capture d'écran comparée à la main).
- **Couverture visée** : toutes les branches de `Traitement` sauf la branche `Else` morte.
