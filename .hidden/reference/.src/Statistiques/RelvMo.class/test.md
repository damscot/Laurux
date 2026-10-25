# RelvMo — Tests

> Source : `.src/Statistiques/RelvMo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` lancés depuis le menu (Statistiques > Relevé de MO par client). On compare
le **dump de `Fiches_Stat`** (table de travail restée en base), les lignes `Exec_SQL` du log et le texte
du PDF `~/tmp/Relmo.pdf` (capturé par le script de `/Soc01/caisse/CmdVis`, `pdftotext -layout`, date
du jour normalisée). Les valeurs attendues sont produites dans le clone **Laurux non modifié**
(anomalies comprises). `Utils.Observers(Me)` est appelé une fois : rejouable.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RELVMO-T01 | replay | Traitement sur la période par défaut | `statistiques_ventes` ; **Traitement** | dump de `Fiches_Stat` (qté cumulée, montant de la 1ʳᵉ ligne : A02 figée) ; requêtes par MO | `tests/relvmo_traitement/` | à faire |
| RELVMO-T02 | replay | Bornes de période | `dteN0`/`dteN1` couvrant un seul mois ; documents le jour de début et de fin | documents des deux bornes inclus (filtre `Cdate_Comp` côté Gambas) | `tests/relvmo_bornes/` | à faire |
| RELVMO-T03 | replay | Date invalide | `dteN0` = `3202`, **Traitement** | message « Veuillez saisir votre date SVP », `Fiches_Stat` non recréée | `tests/relvmo_date_invalide/` | à faire |
| RELVMO-T04 | replay | Suppression d'une ligne | après T01, clic sur une ligne puis Suppr, **Oui** ; puis une autre, **Non** | ligne supprimée de `Fiches_Stat` ; ligne refusée toujours présente | `tests/relvmo_suppression/` | à faire |
| RELVMO-T05 | replay | Impression de la sélection | après T01, clic sur 2 lignes de clients différents (`RB2`), **Imprimer** | texte PDF : un en-tête par client, mentions société, lignes MO | `tests/relvmo_impression_selection/` | à faire |
| RELVMO-T06 | replay | Impression de tout, saut de page | `RB1`, un client avec plus de 34 lignes MO | erreur « Not enough arguments » au saut de page (A01 figée), pas de PDF | `tests/relvmo_saut_page/` | à faire |
| RELVMO-T07 | replay | Impression sans sélection | `RB2` sans ligne sélectionnée | « Veuillez faire une sélection SVP ! » | `tests/relvmo_sans_selection/` | à faire |
| RELVMO-T08 | gbtest | Remplissage (après RELVMO-005) | `RemplitReleve(d0, d1)` sur le jeu de T01 | contenu de `Fiches_Stat` identique à T01 | `tests/relvmo_remplissage/` | à faire |

## Détail des tests

- **Exécution en série** : la table `Fiches_Stat` est partagée avec `RelvMo`, `RelMoprod` et `TriHistos` ;
  ces replays ne tournent pas en parallèle sur la même base.

- **Données** : `statistiques_ventes` (voir [`TBord/test.md`](../TBord.class/test.md)) avec, en plus,
  pour 3 mains-d'oeuvre : des lignes `typel = 'M'` dans `Fiches_Ligbl` (factures `F` imprimées et non
  imprimées), `Fiches_HistoLigfac` et `Fiches_HistoLigfacM`, plusieurs lignes du même couple (MO,
  client) pour voir le cumul de quantité, une `qte_ligfac` vide, un client avec plus de 34 couples
  (MO) pour le saut de page, la société `01` avec toutes les mentions renseignées.
- **Normalisation** : date du jour dans le PDF (« <ville> le jj.mm.aaaa ») et période ; horloge fixée.
- **Non testable automatiquement** : son, couleurs de fond des dates, logo (non transmis).
