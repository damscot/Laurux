# menuopt — Dépendances

> Source : `.src/Gestion/option/menuopt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/menuopt.class` — classe
- Handlers GUI détectés : 13

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Caleditcmat` | `<hérité>` |
| `Edconsigne` | `<hérité>` |
| `Edittipp` | `<type>` |
| `Saisiedecons` | `<hérité>` |
| `Start` | `LocalSettings`, `Societe` |
| `Tconsigne` | `<hérité>` |
| `TextReg` | `<type>`, `EstNum`, `Text`, `Type`, `reg` |
| `Tregie` | `<hérité>` |
| `Tregion` | `<hérité>` |
| `Ttarfioul` | `<hérité>` |
| `Visualiseur` | `Prog` |
| `atribvignette` | `<hérité>` |
| `chainage` | `<type>`, `add` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Instanciation** : `Fmenu:108` (`$mopt = New Menuopt(menu69, menu35, menu77, menu306)`).
- **Écrans ouverts** (auto-instances, non vus comme dépendances d'appel par `deps.py` quand le
  groupe porte le nom de la classe) : `Tconsigne`, `Tregie`, `Saisiedecons`, `Tregion`,
  `Ttarfioul`, `Caleditcmat`, `Edconsigne`, `atribvignette`, `Edittipp` ; `Visualiseur`.
- **Homonymes** groupe/classe : `Tconsigne`, `Tregie` (handlers `Tconsigne_click`,
  `Tregie_click`).
- **Événements** : 13 groupes (menus, `mois`, `annee`, `btn`, `win`), tous les handlers `Public`.
- Aucune table, aucun appel dynamique.

