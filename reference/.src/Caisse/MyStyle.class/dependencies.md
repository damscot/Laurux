# MyStyle — Dépendances

> Source : `.src/Caisse/MyStyle.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/MyStyle.class` — classe, Create Static
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/ImageButton.class` | `Disabled`, `DrawButton`, `HasFocus`, `Hovered` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul utilisateur confirmé par `grep` : `ImageButton.View_Draw` (`Hovered`, `HasFocus`,
  `Disabled`, `DrawButton`). `Normal` et `Active` ne sont référencées nulle part (constantes non
  contrôlées par `deps.py`).
- Contrainte d'ordre : MYSTYLE-003 (intégration dans `ImageButton`) après IMAGEBUTTON-002, dans
  le même lot.
- Aucun SQL, aucun appel dynamique.
