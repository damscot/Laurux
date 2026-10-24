# ReplayObserver — Dépendances

> Source : `.src/Utils/ReplayObserver.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/ReplayObserver.class` — classe
- Handlers GUI détectés : 7
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [17](../../../../.src/Utils/ReplayObserver.class#L17), [21](../../../../.src/Utils/ReplayObserver.class#L21), [23](../../../../.src/Utils/ReplayObserver.class#L23), [25](../../../../.src/Utils/ReplayObserver.class#L25), [27](../../../../.src/Utils/ReplayObserver.class#L27), [29](../../../../.src/Utils/ReplayObserver.class#L29), [31](../../../../.src/Utils/ReplayObserver.class#L31), [33](../../../../.src/Utils/ReplayObserver.class#L33) … (+6)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Start.module` | `Replay_Event` |
| `.src/Utils/Utils.module` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `GUI_Event` |
| `DB_Desktop` | `wayland` |
| `Utils` | `db`, `de` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Object`, `Source`, `Replay_Click`, `Replay_Keypress`, `Replay_Close`, `Replay_Focus`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Instanciation** : `Utils/Utils.module:885-936` (`Recursive_Observers`, 13 blocs, un par classe de
  contrôle : `Menu`, `Panel`, `Form`, `TabStrip`, `Button`, `ToggleButton`, `RadioButton`, `ToolButton`,
  `CheckBox`, `GridView`, `ColumnView`, `TreeView`, `ListView`…), stockage dans `Utils.ROArray`.
  Le `<inconnu:add>` signalé par `deps.py` est `ROArray.Add(RO)`.
- **Rejeu** : `Start.module:397` (`ReplayTimer_Timer` → `Replay_Event`), alimenté par
  `Start.module:333-360` (lecture des lignes `*;GUI;*`).
  Remarque hors de ce fichier : dans `ReplayTimer_Timer`, `If Evc <= Evl Then Inc Evc … Evens[Evc - 1]`
  lit `Evens[Evl]` au dernier tour (dépassement d'indice probable, à confirmer et à documenter dans
  `Start.module`).
- **Handlers** `Observer_*` : événements de l'objet `Observer` nommé `"Observer"` ; ils sont
  appelés par le framework et ne doivent pas être renommés.
- **Appels dynamiques** (lignes 17-35, 48, 149, 158, 163, 310) : `Object.GetProperty` (propriétés des
  contrôles) et `Object.Call(ctx.Window, ctx.Name & "_Click")` : appelle les handlers `<Contrôle>_Click`
  **de n'importe quelle fenêtre** du projet. Aucun handler de fenêtre ne doit donc être renommé (déjà
  interdit par PLAN.md) ; un handler `_Click` passé en `Private` casserait le rejeu des `GridView`,
  `ColumnView` et `ListBox`.
- **Portée réductible confirmée** : `Object`, `Source` (code mort), `Replay_Click`, `Replay_Keypress`,
  `Replay_Close`, `Replay_Focus`.
- **Méthodes héritées non vues par `deps.py`** : `Utils.De.SendKeys` (`Desktop.SendKeys`, ligne 210).
- **Dépendances circulaires** : `ReplayObserver` → `DB_Connection` (`GUI_Event`) → `Start` → `Utils` →
  `ReplayObserver`.
- **Ordre de rework** : lot log/replay avec `DB_Connection`, `DB_Log`, `LLog` ; à reworker **après**
  la mise en place du harnais replay de la phase 2, sur lequel il repose lui-même (les tests
  REPLAYOBSERVER-T0x sont joués avec la version de référence du rejeu).
