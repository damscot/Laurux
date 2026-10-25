# Clavier — Dépendances

> Source : `.src/Caisse/Clavier.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Clavier.class` — classe, formulaire associé `Clavier.form`
- Handlers GUI détectés : 3
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Numerique`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Ouverture.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Ouverture` | `Button1_Click` |
| `Utils` | `Observers` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Numerique`, `Alpha`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Dépendance circulaire** `Clavier` ↔ `Ouverture` : Ouverture crée et ferme le clavier,
  le clavier écrit `Ouverture.Mdp` (contrôle de l'auto-instance, vu par `deps.py` comme
  `<hérité:mdp>`) et appelle `Ouverture.Button1_Click`. Rework à mener avec `Ouverture` (même
  lot) ; `Button1_Click` doit rester `Public` (appel externe et handler).
- **Instances** : le clavier affiché est un `New Clavier` (`Ouverture.class:265-268`), mais
  `Ouverture.Button1_Click` appelle `Clavier.Close()` sur l'**auto-instance** (`Ouverture.class:157`
  et `198`) : cet appel crée une instance cachée (avec `Utils.Observers`) et ne ferme pas le
  clavier affiché. Défaut d'`Ouverture`, à documenter dans son lot ; il explique pourquoi
  `Fermer_Click` ferme lui-même la fenêtre.
- `unused` = `Numerique` : confirmé (homonyme dans `Caisse`). `scope_reducible` = `Numerique`,
  `Alpha` : confirmé.
- `Etoile` (bouton hors groupe, sans `Etoile_Click`) : bouton sans handler, non détecté par
  `deps.py` (limite connue « boutons sans handler »).
- Aucun SQL, aucun appel dynamique.
