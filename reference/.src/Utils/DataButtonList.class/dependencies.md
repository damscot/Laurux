# DataButtonList — Dépendances

> Source : `.src/Utils/DataButtonList.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/DataButtonList.class` — classe
- Handlers GUI détectés : 10
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Toggle`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [64](../../../../.src/Utils/DataButtonList.class#L64)

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings`, `Societe` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Toggle`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant**, confirmé par `grep -rni 'DataButtonList' .src` (y compris les `.form` :
  ce n'est pas un `UserControl` et aucun formulaire ne l'instancie) et par l'absence du nom en
  chaîne littérale.
- `deps.py` ne voit pas `DB.Find` (classe gb.db) : dépendance implicite à la connexion courante.
- Appels dynamiques signalés (ligne 64, `Object.Attach`) : attache la `Form` interne, sans effet
  externe.
- Pas de dépendance circulaire. Suppression indépendante des autres fichiers.
