# Clavier — Tests

> Source : `.src/Caisse/Clavier.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI instrumenté (`Utils.Observers(Me)` dans `_new`). La logique dépend de `Last` et d'un
contrôle d'`Ouverture` : elle n'est testable qu'en `replay` tant que CLAVIER-005 n'a pas extrait
la fonction pure.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CLAVIER-T01 | replay | Saisie au clavier virtuel | `./Laurux -p`, écran Ouverture en mode tactile (`/Soc01/caisse/tactile`), bouton clavier ; clics `A`, `c1`, `Point`, `Espace`, `Efface`, `c2` | `Mdp.Text = "A1.2"` capturé dans le journal | `tests/clavier_saisie/` | implémenté (gb.test ClavierTest.T01Saisie : touches cliquées par Value = True, Ouverture.Mdp = « A1.2 » ; deux Wait 0,1 s par touche, Click différé) |
| CLAVIER-T02 | replay | Touches ignorées (A01) | clics `Virgule`, `Poinvirgule`, `Etoile` | `Mdp.Text` inchangé | `tests/clavier_touches_ignorees/` | implémenté (gb.test ClavierTest.T02TouchesIgnorees : Virgule, Poinvirgule, Etoile sans effet, A01 figée) |
| CLAVIER-T03 | replay | `Fermer` = connexion (A02) | caisse 1, vendeur du jeu de test, mot de passe correct saisi au clavier virtuel, clic `Fermer` | connexion effectuée : `~/Caisse1.lock` créé, `/Soc01/caisse/Ncai` écrit ; mot de passe faux → message d'erreur | `tests/clavier_fermer/` | à faire : Fermer appelle Ouverture.Button1_Click (connexion caisse : verrou, configuration, ouverture de l'écran Caisse) |
| CLAVIER-T04 | gbtest | `ToucheVirtuelle` (après CLAVIER-005) | table touche × saisie précédente, dont `Efface` sur saisie vide | chaînes identiques à celles relevées par T01/T02 dans le clone non modifié | `tests/clavier_touches/` | à faire : après extraction CLAVIER-005 |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu `caisse_base` (caisse 1 sur le poste du conteneur, vendeur
  avec mot de passe connu) partagé avec `Ouverture`, `TestCaisses` et `Caisse`. Le répertoire
  personnel du conteneur doit être vierge de `~/Caisse*.lock` avant chaque replay.
- **Valeurs attendues** : capturées dans le clone Laurux non modifié (journal de rejeu et
  fichiers de verrou), y compris les anomalies.
- **Rejeu** : chaque ouverture crée un nouveau `Clavier` (et donc de nouveaux observateurs) ;
  vérifier en phase 2 que le rejeu retrouve les contrôles de la nouvelle instance.
- **Non testable automatiquement** : la position d'écran (`Me.Move(120, 280)`) et l'ergonomie
  tactile.

- **Implémentation (phase 2, vague 6)** : module gb.test `.src/Tests/Caisse/ClavierTest.test` ; attendus `.hidden/Tests/Caisse/assets/ClavierTest/expected.txt`.
