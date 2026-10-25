# Statcai — Dépendances

> Source : `.src/Caisse/Statcai.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Statcai.class` — classe, formulaire associé `Statcai.form`
- Handlers GUI détectés : 1
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Liste`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `LDate` | `_call` |
| `Start` | `son` |
| `Utils` | `Observers`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Caisses`, `Fiches_EntTicketz`, `Fiches_HisEntTickets`

### Membres Public sans usage externe détecté (portée réductible ?)

`Recup_ca`, `Traitement`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Appelant unique : `Fmenu.Menu204_Click` → `Statcai.Showmodal()` (auto-instance, [Fmenu.class:1909](../../../../.src/Communs/Fmenu.class#L1909)).
- `replay_missing` : la grille `Liste` n'a pas de `Liste_Click` ; un clic rejoué ferait
  `Object.Call` d'une méthode absente (REPLAYOBSERVER-A06) : les scénarios ne doivent pas cliquer
  dans la grille.
- Table de travail `Total` (non détectée par `deps.py`, qui ne suit que `Fiches_*`/`Docs_*`…) :
  créée aussi, avec d'autres colonnes, par `StatTypCli` ([StatTypCli.class:188](../../../../.src/Statistiques/StatTypCli.class#L188)) et
  d'autres écrans de `.src/Statistiques` ; absente de `db_control.csv`.
- `statut IN(&2)` : `deps.py` (`sql_params`) ne signale rien car le nombre de marqueurs et
  d'arguments est cohérent ; le défaut vient du contenu de l'argument (STATCAI-A01).
- Ordre de rework : indépendant ; à coordonner avec le lot `.src/Statistiques` pour la table de
  travail commune.
