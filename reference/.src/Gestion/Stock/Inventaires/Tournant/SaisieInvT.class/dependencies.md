# SaisieInvT — Dépendances

> Source : `.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class` — classe, formulaire associé `SaisieInvT.form`
- Handlers GUI détectés : 12
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Button3_Click`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Button3_Click`
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

`Fiches_Art`, `Fiches_InvT`

### Membres Public sans usage externe détecté (portée réductible ?)

`Saisie_Inv`, `Nseq_LostFocus`, `Cart_LostFocus`, `Art_man`, `Valigne`, `Button3_Click`, `Import_Portable`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu96_Click` (`Fmenu.class:1097`, `SaisieinvT.Show`).
- `unused` / `handlers_inactifs` = `Button3_Click` : confirmé (le `.form` place `Button3` dans le
  groupe `btn`, Tag 4 → `Btn_Click`). Code mort.
- `scope_reducible` : `Saisie_Inv`, `Nseq_LostFocus`, `Cart_LostFocus`, `Art_man`, `Valigne`,
  `Import_Portable` confirmés ; `Button3_Click` est du code mort (suppression, pas réduction).
- `replay_missing` : `Colinv` sans `Colinv_Click` → scénarios au clavier ; ici Entrée ne rappelle
  pas la ligne, le rappel nécessite un double-clic (non rejouable sans REPLAYOBSERVER-A06).
- Tables : `Fiches_InvT` (`Cbase` et littéral), `Fiches_Art`.
- À reworker avec `SaisieInv`, après le module `Inventaire`.
