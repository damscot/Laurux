# Fusers — Dépendances

> Source : `.src/Communs/Fusers.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/Fusers.class` — classe, formulaire associé `Fusers.form`
- Handlers GUI détectés : 5
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coluser_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Start` | `LocalSettings`, `Musique`, `son` |
| `Utils` | `Fcolr`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Users`

### Membres Public sans usage externe détecté (portée réductible ?)

`MajZones`, `Refresh`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.Menu50_Click` (`Fusers.Show`, auto-instance). Aucune méthode
  appelée de l'extérieur.
- **Dépendance par la base** (non vue par `deps.py`) : `Facture` (l.355) lit `Fiches_Users`
  (`nom@poste`) pour la liste des destinataires de tâches ; `LauruxMaj` (l.4398) crée la table.
- **Table en dur** : `Fiches_Users` n'a pas d'entrée dans `Cbase.module` (aucun `TabUsers`) ;
  l'ajouter serait une modification de `Cbase` à faire dans un rework de `Cbase`.
- **`Utils.Observers` appelé deux fois** : double enregistrement des observateurs, y compris le
  `ReplayObserver` du harnais de replay (événements potentiellement journalisés deux fois : à
  vérifier lors de la capture des scénarios).
- **Ordre de rework** : indépendant ; à faire avant un éventuel rework de la gestion des tâches de
  `Facture`.

