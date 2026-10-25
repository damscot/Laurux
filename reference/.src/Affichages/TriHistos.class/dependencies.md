# TriHistos — Dépendances

> Source : `.src/Affichages/TriHistos.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/TriHistos.class` — classe, formulaire associé `TriHistos.form`
- Handlers GUI détectés : 18
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colhisto_click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Colrcp2`, `Colrcp3`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Tables/Articles.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `AutoIncrement`, `Engine`, `Exec` |
| `Start` | `Caisse` |
| `Utils` | `CDec`, `Cdate_Aff`, `ObsGotf`, `ObsLstf`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_Cli`, `Fiches_Four`, `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_Ligbl`, `Fiches_Ligrecpt`, `Fiches_Mvtexp`, `Fiches_Stat`

### Membres Public sans usage externe détecté (portée réductible ?)

`Histo_ventes`, `Aff_StatVE`, `Histo_Achat`, `Aff_StatAC`, `aff_Histo`, `DocVentes`, `DocAchat`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Seul appelant** (vérifié par `grep`) : `Articles.Btn_click` (`Articles.class:1450-1451` ventes,
  `1456-1457` achats) avec `New TriHistos(Code.text, Cfour.text, Dec.text, Tri, "V"|"A")`. Le
  2e argument (`Cfour.text`) est perdu (`Four = Four`, TRIHISTOS-A01).
- Aucun protocole de retour (consultation).
- `replay_dynamic` : `Colhisto_click` (rester `Public`). `replay_missing` : `Colrcp2` et `Colrcp3`
  (`ColumnView` des panneaux de détail, sans `_Click`) : un clic rejoué sur ces vues échouerait —
  à éviter dans les scénarios ou à traiter par REPLAYOBSERVER-A06. L'écran n'appelant pas
  `Utils.Observers(Me)`, aucun clic n'y est journalisé de toute façon.
- `deps.py` détecte bien `Fiches_Bl` et `Fiches_Ligbl` cités en dur dans `DocVentes` (ligne 561) en
  plus des clés `Cbase` ; `Fiches_Stat` est une table de travail recréée (DDL), pas une table métier.
- « Portée réductible » (7 fonctions) confirmée par `grep`.
- Pas d'`unused`, d'`arity_errors` ni de `handlers_inactifs`.
- Contrainte d'ordre : la commonalisation `DetailDocument` doit être faite avec `AFacture` et `ACom`
  (même commit ou commit préalable du module commun).
