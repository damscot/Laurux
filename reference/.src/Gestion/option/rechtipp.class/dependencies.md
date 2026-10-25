# rechtipp — Dépendances

> Source : `.src/Gestion/option/rechtipp.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/rechtipp.class` — classe, formulaire associé `rechtipp.form`
- Handlers GUI détectés : 4
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `GridView1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/Facture.class` | `<type>` |
| `.src/Gestion/Tables/FClient.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_region`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants (vérifiés par `grep`) : `Facture.class:12228-12237` (`New Rechtipp("N") As "tr1"`,
  `tr1_trouve` → `Texttr1`) ; `FClient.class:3282-3291` et `:3330-3339` (`As "Buttr1"`/`"Buttr2"`,
  `Buttr1_trouve`/`Buttr2_trouve`). Le mode `"T"` n'est jamais utilisé.
- `replay_missing` : `GridView1` sans `GridView1_Click` ; pas d'`Utils.Observers` non plus.
- Colonnes alimentées par les appelants : `cli_tipp`, `Fiches_AdrlivC.tipp`, `tipp_ligbl`
  (ajoutées par `modfichier.fichiercarbu`, absentes de `db_control.csv`).
- Aucun appel dynamique.
