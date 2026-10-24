# Cdoc — Dépendances

> Source : `.src/Utils/Cdoc.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Cdoc.class` — classe, formulaire associé `Cdoc.form`
- Handlers GUI détectés : 5
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** : ni `Cdoc.Show`, ni `New Cdoc`, ni référence dans un `.form` ou un menu
  (`grep -rni "cdoc" .src`). Classe et formulaire morts.
- **Faux positifs de portée** : `Coul_Dblclick`, `Coul_Mousedown` (groupe `Coul` des 5
  `TextLabel`) et `Btn_Click` (groupe `Btn` des 2 boutons) sont des handlers de groupes déclarés
  dans le `.form` ; `deps.py` ne reconnaît que les handlers nommés d'après un contrôle.
- Clés de configuration partagées avec `SetColors` (édition), `Start.module` (lecture) et
  `LCoul` (couleurs d'articles seulement). `/Coul/Fac` n'est lu par aucun autre fichier
  (les autres utilisent `/Coul/Facts`).
- Aucun SQL, aucun appel dynamique.
