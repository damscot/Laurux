# MvtDepots — Dépendances

> Source : `.src/Gestion/Depots/MvtDepots.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Depots/MvtDepots.class` — classe, formulaire associé `MvtDepots.form`
- Handlers GUI détectés : 16
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Button2_Click`
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
| `TriArticles` | `<type>` |
| `Utils` | `CDec`, `Cdate_Dbase`, `ObsGotf`, `ObsLstf`, `Observers`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Depots`, `Fiches_Sdepots`, `Fiches_StkDepots`

### Membres Public sans usage externe détecté (portée réductible ?)

`aff_Depot`, `Cman`, `Button2_Click`, `art_man`, `Maj_Colrcp`, `Maj_QteArt`, `Maj_Qtedep`, `Maj_Qtearr`, `Maj_Sdepots`, `B`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.class:2158` (`MvtDepots.Show()`).
- **Non détecté par `deps.py`** : `db.Exec` (ligne 277) appelle la classe statique `DB` de gb.db
  (connexion courante), pas `Utils.db` ; même cas que `RichDataGrid` (RICHDATAGRID-A02).
- `TriArticles` (ouvert avec `Me`) écrit `Bsel`/`Bval` par `Object.SetProperty`.
- Écritures : `Fiches_Art.art_qte`, `Fiches_StkDepots`, `Fiches_Sdepots` ; lecteurs impactés :
  `Articles`, `Facture`, `Caisse` (stocks de dépôts), `Cstock.module:98` (recalcul du stock `01`
  depuis `Fiches_Sdepots`), `Edsdepots`.
- `Coldep_Click` et `Coldepa_Click` rejoués par `ReplayObserver.Replay_Click` : doivent rester `Public`.
- `Button2_Click` : jamais appelée, aucun `Button2` dans le `.form` (`unused`).
- Ordre de rework : avec Sdepots (module `Depot`) ; la correction de A01 précède toute
  reprise des stocks de dépôts.
