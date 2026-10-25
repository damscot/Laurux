# MyStyle — Tests

> Source : `.src/Caisse/MyStyle.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MYSTYLE-T01 | gbtest | `DrawButton` hors écran | `Paint.Begin` sur une `Image` 80 × 40 ; `Pressed` ∈ {False, True} × `Flag` ∈ {0, 1, 2, 3, 4, 6, 7} × 2 couleurs | somme de contrôle des pixels identique à la référence (A01 figée : 3/7 sans cadre) | `tests/mystyle_drawbutton/` | à faire |
| MYSTYLE-T02 | gbtest | Constantes | lecture de `Disabled`, `HasFocus`, `Hovered` | 1, 2, 4 | `tests/mystyle_constantes/` | à faire |

## Détail des tests

- Le dessin sur `Image` ne nécessite pas de fenêtre, mais le composant graphique (Qt) doit être
  chargé : exécution sous Xvfb dans le conteneur. Les sommes de contrôle de référence sont
  produites dans le clone Laurux non modifié, dans la même image Docker (anticrénelage et
  version de Qt identiques).
- Si MYSTYLE-003 est exécuté, T01/T02 deviennent des tests d'`ImageButton` (rendu identique,
  IMAGEBUTTON-T03).
