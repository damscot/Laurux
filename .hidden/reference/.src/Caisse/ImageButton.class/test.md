# ImageButton — Tests

> Source : `.src/Caisse/ImageButton.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Contrôle graphique : les tests `gbtest` créent une fenêtre hors écran (Xvfb) contenant un
`ImageButton`, appellent ses handlers publics et comparent l'état et un rendu capturé. Les
valeurs et images attendues sont produites par le même test dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMAGEBUTTON-T01 | gbtest | Propriétés | `Text`, `BackGround`, `Picture` (PNG d'`Icones/`), puis `Picture = Null` | valeurs relues ; erreur figée pour `Null` | `tests/imagebutton_proprietes/` | à faire |
| IMAGEBUTTON-T02 | gbtest | Événement `Click` | `View_MouseDown()` puis `View_MouseUp()` ; `View_MouseUp()` seul | un `Click` par `View_MouseUp` (A01 figée) | `tests/imagebutton_click/` | à faire |
| IMAGEBUTTON-T03 | gbtest | Rendu | états normal, survol, focus, enfoncé, désactivé ; avec et sans image | captures (`Grab` de la fenêtre) identiques au pixel près aux références | `tests/imagebutton_rendu/` | à faire |
| IMAGEBUTTON-T04 | replay | Touches de la caisse | `./Laurux -p`, clic sur une touche de famille (`Clav2`) puis de sous-famille (`Clav3`) | **bloqué** : clics non journalisés (voir détail) ; à défaut, vérification manuelle des lignes de ticket créées | `tests/imagebutton_caisse/` | à faire |

## Détail des tests

- **T03** : la capture dépend du thème Qt et des polices du conteneur ; elle doit être produite
  et rejouée dans la même image Docker. À confirmer en phase 2 (sinon : comparaison tolérante ou
  test manuel).
- **Rejeu (T04)** : `Utils.Recursive_Observers` n'observe pas les `UserControl` ; un clic sur
  une touche de caisse n'est ni journalisé ni rejouable. Ajouter `ImageButton` aux classes
  observées (et à `ReplayObserver.Replay_Click`, qui ne connaît pas ce type) est une évolution du
  harnais à valider par l'utilisateur (même famille que REPLAYOBSERVER-A06), hors de ce fichier.
- **Non testable automatiquement** : l'ergonomie tactile réelle (écran tactile, relâchement hors
  du bouton).
