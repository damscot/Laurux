# rechcons — Dépendances

> Source : `.src/Gestion/option/rechcons.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/rechcons.class` — classe, formulaire associé `rechcons.form`
- Handlers GUI détectés : 5
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `rechcons_KeyPress`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `GridView1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/Tconsigne.class` | `<type>` |
| `.src/Gestion/option/facopt.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_consigne`

### Membres Public sans usage externe détecté (portée réductible ?)

`rechcons_KeyPress`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants (vérifiés par `grep`) : `Tconsigne.class:138-141` (`New Rechcons("T") As "rech"`,
  handler `rech_trouver`) et `facopt.class:362-365` (handler `rechcons_trouver`).
- `rechcons_KeyPress` : `unused` et `scope_reducible` confirmés ; un formulaire lève ses propres
  événements sous `Form_…` (ou le nom d'événement donné par l'appelant, ici `rech`/`rechcons` côté
  appelant), jamais sous le nom de sa classe dans sa propre classe.
- `replay_missing` : `GridView1` sans `GridView1_Click` (sélection par `GridView1_Activate`) ;
  de plus la fenêtre n'appelle pas `Utils.Observers` : aucun clic n'y est journalisé.
- Aucun appel dynamique.
