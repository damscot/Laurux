# VisHitCartes — Tests

> Source : `.src/Statistiques/VisHitCartes.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

L'écran est ouvert par [`HitCarte`](../HitCarte.class/test.md) : les scénarios commencent par un
traitement `HitCarte` sur le jeu `statistiques_ventes`. On compare le PDF imprimé (capturé par le script
déclaré dans `/Soc01/caisse/CmdVis`, converti par `pdftotext -layout`, date et pied de page
normalisés), les lignes `Exec_SQL` du log et le dump (inchangé : écran en lecture seule). Le contenu de
`Liste` n'est pas journalisé ; il est vérifié à travers le PDF, qui en reprend les colonnes carte, nom
et points. Les valeurs attendues sont produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VISHITCARTES-T01 | replay | Affichage et impression, tri par points | HITCARTE-T01 puis **Imprimer** | texte PDF (10 lignes classées par points) ; `SELECT * FROM Total order by points deSC LIMIT 10` | `tests/vishitcartes_points/` | à faire |
| VISHITCARTES-T02 | replay | Tri par visites, 100 lignes | HITCARTE-T03 avec 100 premiers, **Imprimer** | `LIMIT 100`, ordre par visites ; PDF sur 2 pages (saut à 283 mm, titre de la 2ᵉ page différent figé) | `tests/vishitcartes_visites/` | à faire |
| VISHITCARTES-T03 | replay | Points nuls | jeu où toutes les cartes retenues ont 0 point | comportement actuel figé (erreur de division ligne 95) (A01) | `tests/vishitcartes_zero/` | à faire |
| VISHITCARTES-T04 | replay | Quitter | **Quitter** après une impression | `~/tmp/Edhit.kud` supprimé | `tests/vishitcartes_quitter/` | à faire |
| VISHITCARTES-T05 | gbtest | Ratios (après VISHITCARTES-003) | listes de points `[10, 30, 60]`, `[0, 0]`, une seule carte | pourcentages de référence ; cas nul figé | `tests/vishitcartes_ratios/` | à faire |

## Détail des tests

- **Exécution en série** : la table `Total` est partagée avec `TBord`, `Stat*` et `Statcai` ; ces
  replays ne tournent pas en parallèle sur la même base.

- **Données** : voir `statistiques_ventes` dans [`TBord/test.md`](../TBord.class/test.md) et les cartes de
  [`HitCarte/test.md`](../HitCarte.class/test.md) (plus de 20 cartes actives pour T02).
- **Grille sans `_Click`** : `Liste` n'a pas de handler `Liste_Click` (`replay_missing`) ; un clic
  rejoué sur la liste échouerait : les scénarios ne cliquent pas dans la liste.
- **Non testable automatiquement** : l'histogramme (`drwChart`) et le contenu affiché de `Liste`
  (contrôle visuel) ; `Visualiseur.Prog` est neutralisé par la configuration (script de capture).
