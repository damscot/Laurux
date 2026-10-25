# EdRup — Tests

> Source : `.src/Gestion/Impressions/EdRup.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` depuis « Impression des produits a commander ». Comparaison : texte
`pdftotext -layout` de `~/tmp/Pcommande.pdf` (dates et utilisateur normalisés), lignes `Exec_SQL`,
**contenu des tables de travail `Rupture` et `RuptureC`** après impression (dump ciblé), dump du
reste de la base (inchangé) et `Laurux.conf` (clés `/Soc01/Edrupt/*`). Valeurs attendues produites
dans le clone **non modifié**. Scénarios à valider avec ceux de [Crupt/test.md](../../../Utils/Crupt.module/test.md)
(même chaîne de traitement).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDRUP-T01 | replay | Ruptures simples | plages par défaut, cases décochées, **Imprimer** | `Level13` ; articles stockés avec mini/maxi et quantité à commander > 0 ; tables `Rupture`/`RuptureC` | `tests/edrup_simple/` | à faire |
| EDRUP-T02 | replay | Non stockés | `CheckBox1` coché | articles non stockés inclus | `tests/edrup_non_stockes/` | à faire |
| EDRUP-T03 | replay | Détail commandes clients | `CheckBox2` coché | `Level13R`, groupes « Commande(s) client », section « Dont commande(s) client » ; `UPdate RuptureC` sans effet (A01 figée) | `tests/edrup_clients/` | à faire |
| EDRUP-T04 | replay | Un seul fournisseur | `Four = Four2` | filtre `four = &1` | `tests/edrup_un_fournisseur/` | à faire |
| EDRUP-T05 | replay | Ventes en caisse | `CheckBox3`, `Jours` = 10, avec et sans `CheckBox2` | erreur SQL « date ambiguë » ou page de ventes : comportement réel figé (A03) | `tests/edrup_ventes/` | à faire |
| EDRUP-T06 | replay | Aucune donnée | plage fournisseur sans commande | message « Aucun article pour cette demande » | `tests/edrup_vide/` | à faire |
| EDRUP-T07 | replay | Fournisseur inconnu | `Four` = code absent par `TriCpt` annulé puis saisie | aucun message (A02 figée) | `tests/edrup_four_inconnu/` | à faire |
| EDRUP-T08 | replay | Mémorisation des options | cocher `CheckBox1`/`CheckBox2`, **Fermer**, rouvrir | clés `/Soc01/Edrupt/Nstock`, `/Rclient` écrites et relues | `tests/edrup_options/` | à faire |
| EDRUP-T09 | replay | Pagination | > 1 page de ruptures | saut à 275 mm avec en-tête répété | `tests/edrup_pagination/` | à faire |
| EDRUP-T10 | gbtest | Quantité à commander (après EDRUP-005) | stocké/non stocké, mini/maxi, `art_mincom`, `CheckBox1` | quantité et décision d'impression identiques à T01/T02 | `tests/edrup_qte_commande/` | à faire |

## Détail des tests

- **Données** : jeu `editions_articles` ([EdArt1/test.md](../EdArt1.class/test.md#détail-des-tests)) :
  commandes fournisseurs ouvertes, commandes clients (BL type `C`, lignes `A`) dont une sur un
  article `.DEP` (divers), articles avec `art_stkmin`/`art_stkmax`/`art_mincom`, tickets des
  10 derniers jours (horloge fixée par `faketime`).
- **Module complexe** (chaîne `EdRup` + `Crupt` qui écrit des tables) : faire valider la liste des
  scénarios par l'utilisateur avant la phase 2.
- **Non testable automatiquement** : son, couleur du focus, aide F1 (`Prodcom`) ; la collision
  multi-poste (CRUPT-A05) demande deux instances simultanées.
