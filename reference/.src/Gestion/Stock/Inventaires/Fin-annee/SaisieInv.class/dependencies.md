# SaisieInv — Dépendances

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class` — classe, formulaire associé `SaisieInv.form`
- Handlers GUI détectés : 12
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Colinv`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `Start` | `Musique`, `son` |
| `TextReg` | `<form>`, `Select`, `Text`, `reg` |
| `Utils` | `CDec`, `Find_cbarre`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Inv`

### Membres Public sans usage externe détecté (portée réductible ?)

`Saisie_Inv`, `Nseq_LostFocus`, `Cart_LostFocus`, `Art_man`, `Valigne`, `Import_Portable`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu82_Click` (`Fmenu.class:1058`, `Saisieinv.Show`, casse différente,
  auto-instance).
- `scope_reducible` (`Saisie_Inv`, `Nseq_LostFocus`, `Cart_LostFocus`, `Art_man`, `Valigne`,
  `Import_Portable`) : confirmé par grep, aucun appel externe ni dynamique.
- `replay_missing` : `Colinv` n'a pas de `Colinv_Click` ; un clic rejoué sur la grille ferait
  `Object.Call` d'une méthode inexistante → scénarios via le clavier (Entrée → `Colinv_Activate`)
  ou après REPLAYOBSERVER-A06.
- Groupe `btn` (minuscule) pour `Button3` = groupe `Btn` (noms Gambas insensibles à la casse).
- `Nseq_LostFocus`/`Cart_LostFocus` : noms de handlers mais jamais levés (contrôles du groupe
  `Rcpt`) ; `deps.py` les traite à juste titre comme des méthodes.
- `Chainage` (`.src/Utils/chainage.class`) via `New Chainage([...])`.
- Ordre de rework : après le module `Inventaire` (GENINV-006), avec `SaisieInvT`.
