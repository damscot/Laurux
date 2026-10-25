# Listecom — Dépendances

> Source : `.src/Gestion/Stock/Listecom.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Listecom.class` — classe, formulaire associé `Listecom.form`
- Handlers GUI détectés : 1
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
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_BlM`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Mo`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés** (`grep -rn Listecom .src`) :
  - `Facture.class:5364` (Ctrl+H, `New Listecom(Code.Text, "")`), `Facture.class:5371` (Ctrl+A,
    `New Listecom(Code.Text, cart.Text)`), `Facture.class:10688` (à la saisie du client), avec
    `Private $lcom/$lcart As Listecom` (l. 239-240) et `Try $lcom.Close` (l. 1263, 5362…) ;
  - `FClient.class:3364` (`Button24_Click`) : `$lcom` y est une variable **locale**, son
    `Try $lcom.Close` (l. 3363) ne ferme donc jamais une fenêtre précédente (sans effet ; à noter
    dans la doc de `FClient`).
- **Tables** : toutes en dur (pas de `Cbase.Table`) ; lecture seule. `Fiches_Art` et `Fiches_Mo`
  ne servent qu'à la désignation (`ajouart`).
- **Replay** : `replay_missing = GridView1` confirmé — la grille n'a pas de `GridView1_Click` ;
  un clic enregistré dans la grille ferait un `Object.Call` sur une méthode inexistante lors du
  rejeu (REPLAYOBSERVER-A06). Les scénarios ne doivent pas cliquer dans la grille.
- Aucun appel dynamique, aucune dépendance circulaire. Rework indépendant des autres fichiers
  (les appelants n'utilisent que le constructeur, `Y`, `Show` et `Close`).
