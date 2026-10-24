# Sdepots — Dépendances

> Source : `.src/Gestion/Depots/Sdepots.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Depots/Sdepots.class` — classe, formulaire associé `Sdepots.form`
- Handlers GUI détectés : 11
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Code_KeyPress`, `Code_GotFocus`, `Code_LostFocus`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Code_KeyPress`, `Code_GotFocus`, `Code_LostFocus`, `Dep_KeyPress`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coldep_Click`, `Coldepa_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Colrcp`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Start` | `son` |
| `Utils` | `CDec`, `Cdate_Dbase`, `Coulfd`, `ObsGotf`, `ObsLstf`, `SetEditColor`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Depots`, `Fiches_Sdepots`, `Fiches_StkDepots`

### Membres Public sans usage externe détecté (portée réductible ?)

`aff_Depot`, `Code_KeyPress`, `Code_GotFocus`, `Code_LostFocus`, `Cman`, `art_man`, `Dep_KeyPress`, `Maj_Colrcp`, `Maj_Qtedep`, `B`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.class:2164` (`Sdepots.show()`).
- **`Start.Soc` n'existe pas** (`Start.module` ne déclare aucun membre `Soc`) : la ligne 218 lève
  une erreur à chaque appel de `ToggleButton2_Click` ; même défaut dans `Bordrx.class:383`
  (IMPRESSION-A03). `deps.py` ne le signale pas (membre inconnu non contrôlé).
- **Non détecté par `deps.py`** : `db.Exec` (lignes 226, 262) appelle la classe `DB` de gb.db.
- Handlers inactifs : `Code_KeyPress`, `Code_GotFocus`, `Code_LostFocus` (`Code` est dans le groupe
  `Rcpt`) ; `Dep_KeyPress` vise un groupe `Dep` absent du `.form` (copie de MvtDepots).
- **Phase 2** : pas d'appel à `Utils.Observers` → écran non instrumenté pour la capture des
  scénarios (voir aussi ImpDepots).
- `Coldep_Click` et `Coldepa_Click` rejoués par `ReplayObserver.Replay_Click` : doivent rester `Public`.
- Écritures : `Fiches_StkDepots`, `Fiches_Sdepots` (relues par `Articles`, `Facture`, `Caisse`,
  `Edsdepots`).
- Ordre de rework : avec MvtDepots.
