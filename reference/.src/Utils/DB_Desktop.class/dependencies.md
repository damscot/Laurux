# DB_Desktop — Dépendances

> Source : `.src/Utils/DB_Desktop.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/DB_Desktop.class` — classe, hérite de `Desktop`
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Utils/ReplayObserver.class` | `wayland` |
| `.src/Utils/TextReg.class` | `SendKey` |
| `.src/Utils/Utils.module` | `<type>` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`correspondance`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Instance unique** : `Utils.de` (`Utils.module:10`).
- **Usages réels** (grep `Utils.de`) :
  - `Utils/TextReg.class:103` : `Utils.de.SendKey("[Return]")` ;
  - `Utils/TextReg.class:186` : `Utils.de.SendKeys(("[Return]"))` — méthode **héritée** de `Desktop`,
    non vue par `deps.py` ;
  - `Utils/ReplayObserver.class:173` : `Utils.de.wayland` ;
  - `Utils/ReplayObserver.class:210` : `Utils.De.SendKeys(s)` — méthode héritée, non vue par `deps.py`.
- **Portée réductible confirmée** : `correspondance`.
- **Dépendances externes** : `ydotool`/`ydotoold` (Wayland, installés par `wayland.sh` avec
  `01-uinput-permission.rules` et `uinput.conf`), `apt`, composant `gb.desktop` (XTest sous X11).
- **Ordre de rework** : indépendant de la base ; à traiter avec `ReplayObserver` et `TextReg` si le
  routage des frappes est unifié.
