# StatPromo — Dépendances

> Source : `.src/Statistiques/StatPromo.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/StatPromo.class` — classe, formulaire associé `StatPromo.form`
- Handlers GUI détectés : 7
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColPromo_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Liste`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Start` | `LocalSettings`, `Musique` |
| `Utils` | `Fcolr`, `Observers`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_ArtPromo`, `Fiches_Promo`

### Membres Public sans usage externe détecté (portée réductible ?)

`Affichage`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `Fmenu.Menu223_Click` (`Fmenu.class:1933`, `StatPromo.ShowModal()`).
- **`replay_dynamic` : `ColPromo_Click`** — appelé par `ReplayObserver.Replay_Click` via
  `Object.Call` lors d'un clic rejoué sur la liste : doit rester `Public` (REPLAYOBSERVER-A06).
- **`replay_missing` : `Liste`** — la grille de résultats n'a pas de `Liste_Click` : un clic
  rejoué y échouerait ; les scénarios ne cliquent pas dans `Liste`.
- Données : `Fiches_ArtPromo.qte` est écrite par `ArtPromo.Maj_qteplus` depuis `Caisse`
  (`Caisse.class` ~7418) et les prix par `FpromoArt` ; `StatPromo` ne fait que lire.
- « Portée réductible » de `Affichage` confirmée par `grep` ; aucun `arity_errors`, `unused`,
  `handlers_inactifs`.
