# DB_Log — Dépendances

> Source : `.src/Utils/DB_Log.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/DB_Log.class` — classe, formulaire associé `DB_Log.form`
- Handlers GUI détectés : 13
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `GridView1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Cmenu.class` | `<type>` |
| `.src/Communs/Fmenu.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `<type>`, `Clear`, `Get_Filter`, `Get_Filter_Error`, `Get_Localfile_Path`, `Get_Log`, `Get_Remotefile_Path`, `Refresh`, `Set_Filter`, `Set_Log` |
| `LLog` | `<type>`, `Critical`, `Max`, `console`, `file` |
| `Start` | `LLogColl` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Refresh`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants** (constructeur uniquement) : `Communs/Fmenu.class:2487` (`Menu330_Click`) et
  `Caisse/Cmenu.class:319` (`mdp_admin3`). Les deux passent `Utils.db`.
- **`.form` associé** : `DB_Log.form` (contrôles `DebugView`, `FiltreInfos`, `FiltresStatus`,
  `FiltresEval`, `DirChooser1`, `Filename`, `Remote`, `Savename`, `GridView1`, `Enable`, `Niveau`,
  `Filtres`, `MAJ`, `Vider`, `Sauvegarder`, `Quitter`, `Enregistrer`, `RemoteInfo`…). Handlers
  intouchables.
- **Appels non résolus par `deps.py`** : `Start.LLogColl[...]` est une `Collection` non typée ; les
  appels `.Enabled`, `.Handlers[...]`, `.Level_Name`, `.Level_Id` visent des objets `LLog`. C'est pour
  cela que `deps.py` propose à tort `LLog.Level_Id`/`Level_Name` en portée réductible.
- **Portée réductible confirmée** : `Refresh`.
- **Couplage fort** avec le format de ligne de `DB_Connection` (9 champs) : tout changement du format
  du log impose de modifier `DB_Log` dans le même commit.
- **Ordre de rework** : après `DB_Connection` et `LLog` (lot log/replay).
