# TestCaisses — Tests

> Source : `.src/Caisse/TestCaisses.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`TestCai` lit des fichiers de `User.home` et affiche un `Message.Warning` modal en cas de
conflit : en gb.test, seuls les cas **sans conflit** sont exécutables avant TESTCAISSES-002 ; le
cas de conflit passe par un replay de l'écran `Ouverture`. Les tests s'exécutent dans le
conteneur (répertoire personnel jetable), jamais sur un poste réel.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TESTCAISSES-T01 | gbtest | Sans conflit | aucun verrou ; verrou `Caisse1.lock` = `"12 Paul O"` avec `Cai = "1"`, `Vdr = "1"` (même caisse) ; verrou d'un autre vendeur (`"23 Anne O"`) | `"0"` | `tests/testcaisses_libre/` | à faire |
| TESTCAISSES-T02 | replay | Conflit | vendeur `12` connecté sur la caisse 2 (`~/Caisse2.lock`) ; connexion du même vendeur sur la caisse 1 dans `Ouverture` | avertissement « … sur la caisse 1 » alors que la caisse occupée est la 2 (premier caractère du vendeur, A01), focus sur `Caissiere`, pas de `~/Caisse1.lock` | `tests/testcaisses_conflit/` | à faire |
| TESTCAISSES-T03 | replay | Faux conflit (A02) | vendeur `10` connecté sur la caisse 2 ; connexion du vendeur `11` sur la caisse 1 | avertissement affiché (comportement actuel figé) | `tests/testcaisses_premier_caractere/` | à faire |
| TESTCAISSES-T04 | gbtest | `CaisseDuVendeur` (après TESTCAISSES-002) | cas de T01-T03 et verrous 1 à 10 | numéro de caisse attendu, cohérent avec T01-T03 | `tests/testcaisses_pur/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites dans le clone Laurux non modifié (retour de `TestCai`, texte
  du message capturé par le journal, fichiers de verrou présents après le scénario).
- **Données** : `Laurux01.sql` + jeu `caisse_base` (vendeurs `10`, `11`, `12`, caisses 1 et 2 sur
  le poste du conteneur), partagé avec `Ouverture` et `Clavier`.
- **Non testable automatiquement** : plusieurs postes (les verrous sont locaux au poste).
