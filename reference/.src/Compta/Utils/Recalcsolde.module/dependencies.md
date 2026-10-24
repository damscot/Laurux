# Recalcsolde — Dépendances

> Source : `.src/Compta/Utils/Recalcsolde.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/Recalcsolde.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Calc`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `PointBase`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`

### Membres Public sans usage externe détecté (portée réductible ?)

`Calc`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Code mort confirmé** : `grep -rn Recalcsolde .src` ne renvoie que la définition ; aucun nom
  `"Recalcsolde"` en chaîne (pas de lancement par `Prgm` ni `Object.Call`). Le `Calcsolde` lancé par
  `Prgm` est la classe `Utils/Calcsolde.class`, distincte.
- Copie de `Csolde.module` (voir CSOLDE-004, qui prévoit la suppression si le module est confirmé
  mort).
- Aucune dépendance circulaire. **Ordre de rework** : indépendant (à faire avec ou après CSOLDE-004).
