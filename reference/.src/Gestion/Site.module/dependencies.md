# Site — Dépendances

> Source : `.src/Gestion/Site.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Site.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `connect_site`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings` |
| `hexdblKey` | `Crypt` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`connect_site`, `ServeurB`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Code mort vérifié** : `grep -rnw "connect_site\|ServeurB" .src` ne renvoie que ce module ;
  `deps.py` le classe aussi dans `unused` (`connect_site`) et `scope_reducible` (`connect_site`,
  `ServeurB`).
- **Faux appelant à écarter** : `Fsoc.class:355-356` (`Site.SetFocus`, `Site.Select`) désigne le
  contrôle `Site` de `Fsoc.form:221`, pas ce module. Un outil qui résout par nom de classe pourrait
  le compter à tort comme un usage.
- Pas d'appel dynamique (`Object.Call`, `Class.Load`) ni de chaîne `"Site"` citée.
- Aucune contrainte d'ordre de rework : la suppression est indépendante des autres fichiers.
