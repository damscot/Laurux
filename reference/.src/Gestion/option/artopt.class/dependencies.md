# artopt — Dépendances

> Source : `.src/Gestion/option/artopt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/artopt.class` — classe, formulaire associé `artopt.form`
- Handlers GUI détectés : 14
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Gridtarpp`, `Listcons`, `Listregie`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Entrées/Achat.class` | `<type>` |
| `.src/Gestion/Stock/commande1.class` | `<type>`, `numart` |
| `.src/Gestion/Tables/Articles.class` | `<type>`, `affmab`, `enregiste`, `numart`, `prixachat`, `prixrev` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Edit`, `Exec` |
| `Tconsigne` | `<hérité>` |
| `TextReg` | `<form>`, `EstNum`, `Name`, `Text`, `Type`, `Value`, `nbdec` |
| `Ttarfioul` | `<type>` |
| `Utils` | `ObsGotf`, `ObsLstf`, `db` |
| `calculdroit` | `<type>`, `droit`, `secu` |
| `chainage` | `<type>`, `add` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Tvaav`, `Fiches_consigne`, `Fiches_ligtarpp`, `Fiches_regie`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Événement `recalculpx`** : traité par `Articles.$opt_recalculpx` (`Articles:4615`, groupe
  `"$opt"`) ; le parseur ignore les noms commençant par `$`. `commande1` (groupe `"opt"`) ne le
  traite pas.
- **Appelants réels** : `Articles` (`numart`, `prixachat`, `prixrev`, `enregiste`, `affmab`),
  `commande1` (`numart`, `Font`). `Achat.OptAr` est déclaré mais jamais affecté (`Try
  OptAr.Delete` seulement, voir doc d'`Achat`).
- **Propriété `creer`** : aucun usage (vérifié par `grep`) → code mort ; `deps.py` ne signale pas
  les propriétés.
- **`replay_missing`** : `Gridtarpp`, `Listcons`, `Listregie` sans `_Click` (les listes ont
  `_Activate`) : ne pas rejouer de clic simple sur ces contrôles.
- **Handlers vérifiés** : `cmpt_lostfocus` (observateurs), `grpal_click`, `grcode_*` (groupes du
  `.form`), tous `Public`.
- **Utils.Observers** : non appelé ici ; `Articles` l'appelle (et le rappelle à chaque clic
  d'onglet, cumul probable d'observateurs) : couverture des contrôles incrustés à confirmer.
- **Ordre de rework** : après `Calculdroit` ; avec `Articles` pour `recalculpx`.

